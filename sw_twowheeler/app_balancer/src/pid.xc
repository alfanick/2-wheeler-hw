#include "pid.h"

#define DEBUG_SAMPLES_COUNT 1000
#define DEBUG_SAMPLES_DELAY 5000
//#define DEBUG_SAMPLES_ENABLE

#define DEBUG_PRINT_ENABLE 0
#include <debug_print.h>
#include <math.h>

#define safety i[0]
#define ABS(x) ((x) > 0 ? (x) : -(x))
#define CLAMP(x, mx) (((x) > (mx)) ? (mx) :\
                      ((x) < -(mx)) ? -(mx) :\
                      (x))

int inline pid(float angle, float target, float Kp, float Ki, float Kd) {
  static float error_integral = 0,
               last_error = 0,
               last_angle = 0;

  if (Kp == 0 && Ki == 0 && Kd == 0) {
    error_integral = 0;
    last_error = 0;
    last_angle = 0;

    return 0;
  }

  float error, correction;

  error = angle - target;
  error_integral += Ki * error;
  error_integral = CLAMP(error_integral, PWM_RESOLUTION);

  correction =   Kp * error
               + error_integral
               + Kd * (error - last_error);// angle - last_angle);

  last_error = error;
  last_angle = angle;

  return CLAMP((int)correction, PWM_RESOLUTION);
}

inline int scale_speed(int speed, int boost, int threshold) {
  if (speed == 0 || (speed > -threshold && speed < threshold))
    return 0;

  return speed * (PWM_RESOLUTION - boost) / PWM_RESOLUTION +
         (speed < 0 ? -boost : boost);
}

[[combinable]]
void balancer_pid(interface balancer_i server i[2], imu10_client motion, motors_client motors) {
  timer t; unsigned time,end,start;
  int balancing = 2;
  int speed, last_speed = 0;

#ifdef DEBUG_SAMPLES_ENABLE
  float debug_samples_angle[DEBUG_SAMPLES_COUNT];
  int debug_samples_pid[DEBUG_SAMPLES_COUNT];
  int debug_samples_speed[DEBUG_SAMPLES_COUNT];
  int debug_current_sample = 0;
#endif

  int speed_boost = 500,
      speed_threshold = 0;

  int loop_delay = 10;
  unsigned loop_time = 0;
  int lowpass = 1000;

  float acc, gyro;

  float angle = 0,
        target = 0,
        raw_angle = 0;

  float Kp = 50.0,
        Ki = 30.0 * ((float)loop_delay/1000.0),
        Kd = 0.0 / ((float)loop_delay/1000.0);

  motors.left(0);
  motors.right(0);

  t :> time;

  // 1 second delay for start
  time += 1000*XS1_TIMER_KHZ;

  while (1) {
    select {
      case t when timerafter(time) :> void:
        time += loop_delay * XS1_TIMER_KHZ;
        t :> start;

        angle = motion.get_pitch();
        raw_angle = motion.accelerometer_pitch();

        safety.next();

        if (balancing > 0) {
          speed = pid(angle, target, Kp, Ki, Kd);
          speed = last_speed * (1000 - lowpass) + speed * lowpass;
          speed /= 1000;
          last_speed = speed;

#ifdef DEBUG_SAMPLES_ENABLE
          debug_samples_pid[debug_current_sample] = speed;
#endif

          speed = scale_speed(speed, speed_boost, speed_threshold);

#ifdef DEBUG_SAMPLES_ENABLE
          debug_samples_speed[debug_current_sample] = speed;
#endif

          motors.left(speed);
          motors.right(speed);
        }

#ifdef DEBUG_SAMPLES_ENABLE
          debug_samples_angle[debug_current_sample] = angle;

          if (time > DEBUG_SAMPLES_DELAY * XS1_TIMER_KHZ) {
            debug_current_sample++;
          }

          if (debug_current_sample == DEBUG_SAMPLES_COUNT) {
            for (int i = 0; i < DEBUG_SAMPLES_COUNT; i++) {
              debug_printf("%d,%d,%d\n", (int)(debug_samples_angle[i]*1000.0), debug_samples_pid[i], debug_samples_speed[i]);
            }

            debug_current_sample == 0;
          }
#endif

        t :> end;
        loop_time = end - start;
        break;

      case i[int _].use_kalman(int state):
        motion.use_kalman(state);
        break;

      case i[int _].stop(int reason):
        if (reason < balancing) {
          balancing = reason;
          motors.left(0);
          motors.right(0);
        }
        break;

      case i[int _].balance(int reason):
        if (reason == balancing || balancing == 1) {
          balancing = 2;
          angle = 0;
          last_speed = 0;
          pid(0, 0, 0, 0, 0);
        }
        break;

      case i[int _].move_start(unsigned left, unsigned right):
        break;

      case i[int _].move_stop():
        break;

      case i[int _].get_loop_time() -> unsigned lt:
        lt = loop_time;
        break;

      case i[int _].get_pid(int K[3]):
        K[0] = (int)(Kp * 1000);
        K[1] = (int)(Ki * 1000 / (((float)loop_delay) / 1000.0));
        K[2] = (int)(Kd * 1000 * (((float)loop_delay) / 1000.0));
        break;

      case i[int _].set_pid(int K[3]):
        Kp = (float)K[0] / 1000.0;
        Ki = (float)K[1] / 1000.0 * (((float)loop_delay) / 1000.0);
        Kd = (float)K[2] / 1000.0 / (((float)loop_delay) / 1000.0);
        pid(0, 0, 0, 0, 0);
        break;

      case i[int _].set_loop_delay(int t):
        if (t > 0) {
          const float ratio = (float)t / (float)loop_delay;

          Ki *= ratio;
          Kd /= ratio;

          loop_delay = t;
        }
        break;

      case i[int _].get_loop_delay() -> int t:
        t = loop_delay;
        break;

      case i[int _].get_rpm(int r[2]):
        r[0] = motors.left_rpm();
        r[1] = motors.right_rpm();
        break;

      case i[int _].get_angle(int raw) -> int a:
        if (raw == 1)
          a = (int)(raw_angle * 180.0 / M_PI * 1000);
        else
          a = (int)(angle * 180.0 / M_PI * 1000);
        break;

      case i[int _].set_target(int a):
        target = M_PI / 180.0 * ((float)a/1000);
        break;

      case i[int _].get_target() -> int a:
        a = (int)(target * 180.0 / M_PI * 1000);
        break;

      case i[int _].get_lowpass() -> int a:
        a = motion.get_lowpass();
        break;

      case i[int _].set_lowpass(int a):
        motion.set_lowpass(a);
        break;

      case i[int _].set_speed_threshold(int a):
        speed_threshold = a;
        break;

      case i[int _].get_speed_threshold() -> int a:
        a = speed_threshold;
        break;

      case i[int _].set_speed_boost(int a):
        speed_boost = a;
        break;

      case i[int _].get_speed_boost() -> int a:
        a = speed_boost;
        break;

      case i[int _].set_pid_lowpass(int a):
        lowpass = a;
        break;

      case i[int _].get_pid_lowpass() -> int a:
        a = lowpass;
        break;
    }
  }
}

