#include "pid.h"

#define DEBUG_PRINT_ENABLE 0
#include <debug_print.h>
#include <math.h>

#define ABS(x) ((x) > 0 ? (x) : -(x))

[[combinable]]
void balancer_pid(interface balancer_i server i[2], lsm303d_client motion, motors_client motors) {
  timer t; unsigned time;
  vector3d acc;
  unsigned balancing = 0;
  int speed;

  float correction, error, total_error = 0, last_error = 0;
  const float Kp = 1500.0, Ki = 3, Kd = 0.3;

  motors.left(0);
  motors.right(0);

  t :> time;
  time += 5*XS1_TIMER_KHZ;

  while (1) {
    select {
      case i[int _].stop():
        balancing = 0;
        motors.left(0);
        motors.right(0);
        break;

      case i[int _].balance():
        balancing = 1;
        break;

      case i[int _].move_start(unsigned left, unsigned right):
        break;

      case i[int _].move_stop():
        break;

      case balancing => t when timerafter(time) :> void:
        motion.accelerometer(acc);

        debug_printf("%d %d %d\n", acc.x, acc.y, acc.z);

        error = sqrt(acc.y * acc.y + acc.x * acc.x);
        error = acc.z / error;
        error = atan(error);

        if (ABS(error * (180.0 / M_PI)) > 43) {
          motors.left(0);
          motors.right(0);
          break;
        }

        correction = Kp * error +
                     Ki * total_error +
                     Kd * (error - last_error);
        total_error += error;
        last_error = error;

        debug_printf("%d\n", (int)(error));

        speed = (correction > PWM_RESOLUTION) ? PWM_RESOLUTION :
                (correction < -PWM_RESOLUTION) ? -PWM_RESOLUTION :
                correction;
        debug_printf("%d\n", speed);

        motors.left(speed);
        motors.right(speed);

        time += 5 * XS1_TIMER_KHZ;
        break;
    }
  }
}

