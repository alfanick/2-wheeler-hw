#include "pid.h"

#define DEBUG_PRINT_ENABLE 0
#include <debug_print.h>
#include <math.h>

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
               - Kd * (angle - last_angle);

  last_error = error;
  last_angle = angle;

  return CLAMP((int)correction, PWM_RESOLUTION);
}

[[combinable]]
void balancer_pid(interface balancer_i server i[2], lsm303d_client motion, motors_client motors) {
  timer t; unsigned time,end,start;
  int balancing = 2;
  int speed;

  const static int sample_time = 10;
  unsigned loop_time = 0;
  float angle = 0, target = 0;
  float Kp = 50.0, Ki = 30.0 * ((float)sample_time/1000.0), Kd = 0.0 / ((float)sample_time/1000.0);

  motors.left(0);
  motors.right(0);

  //motion.set_lowpass(40);

  t :> time;
  // 1 second delay for start
  time += 1000*XS1_TIMER_KHZ;

  while (1) {
    select {
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
        K[1] = (int)(Ki * 1000 / (((float)sample_time) / 1000.0));
        K[2] = (int)(Kd * 1000 * (((float)sample_time) / 1000.0));
        break;

      case i[int _].set_pid(int K[3]):
        Kp = (float)K[0] / 1000.0;
        Ki = (float)K[1] / 1000.0 * (((float)sample_time) / 1000.0);
        Kd = (float)K[2] / 1000.0 / (((float)sample_time) / 1000.0);
        pid(0, 0, 0, 0, 0);
        break;

      case i[int _].get_rpm(int r[2]):
        r[0] = motors.left_rpm();
        r[1] = motors.right_rpm();
        break;

      case i[int _].get_angle() -> int a:
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

      case t when timerafter(time) :> void:
        t :> start;

        angle = motion.get_pitch();

        i[0].next();

        if (balancing < 1) {
          time += sample_time * XS1_TIMER_KHZ;
          break;
        }

        speed = pid(angle, target, Kp, Ki, Kd);

        motors.left(speed);
        motors.right(speed);

        t :> end;
        loop_time = end - start;
        time += sample_time * XS1_TIMER_KHZ;
        break;
    }
  }
}

