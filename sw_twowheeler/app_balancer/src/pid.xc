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
  vector3d acc;
  unsigned balancing = 1;
  int speed;

  const static int sample_time = 5;
  unsigned loop_time = 0;
  float angle = 0, target = 0;
  float Kp = 2000.0, Ki = 4000.0 * ((float)sample_time/1000.0), Kd = 2.0 / ((float)sample_time/1000.0);

  motors.left(0);
  motors.right(0);

  t :> time;
  time += sample_time*XS1_TIMER_KHZ;

  while (1) {
    select {
      case i[int _].stop():
        balancing = 0;
        motors.left(0);
        motors.right(0);
        break;

      case i[int _].balance():
        balancing = 1;
        pid(0, 0, 0, 0, 0);
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

      case t when timerafter(time) :> void:
        t :> start;
        motion.accelerometer(acc);

        angle = sqrt(acc.y * acc.y + acc.x * acc.x);
        angle = acc.z / angle;
        angle = atan(angle);
        angle = roundf(angle * 180) / 180;

        if (!balancing || ABS(angle * (180.0 / M_PI)) > 43) {
          motors.left(0);
          motors.right(0);
          time += sample_time * XS1_TIMER_KHZ;
          break;
        }

        speed = pid(angle, target, Kp, Ki, Kd);

        motors.left(speed);
        motors.right(speed);

        t :> end;
        loop_time = end - start;
        //debug_printf("<%dms\n", (end-start)/XS1_TIMER_KHZ+1);
        time += sample_time * XS1_TIMER_KHZ;
        break;
    }
  }
}

