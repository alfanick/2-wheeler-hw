#include "pid.h"

#define DEBUG_PRINT_ENABLE 0
#include <debug_print.h>

#define ABS(x) ((x) > 0 ? (x) : -(x))

[[combinable]]
void balancer_pid(interface balancer_i server i[2], lsm303d_client motion, motors_client motors) {
  timer t; unsigned time;
  vector3d acc;
  unsigned balancing = 0;

  motors.left(0);
  motors.right(0);

  t :> time;
  time += 4*XS1_TIMER_KHZ;

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

        const unsigned ds = ABS(acc.z) > 3000 ? 50 : 25;

        if (acc.x > -16340) {
          if (acc.z > 8000 || acc.z < -8000) {
            motors.left(0);
            motors.right(0);
          } else
          if (acc.z > 0) {
            motors.left(PWM_PERCENT(ds));
            motors.right(PWM_PERCENT(ds));
          } else
          if (acc.z < 0) {
            motors.left(-PWM_PERCENT(ds));
            motors.right(-PWM_PERCENT(ds));
          }
        } else {
          motors.left(0);
          motors.right(0);
        }

        t :> time;
        break;
    }
  }
}

