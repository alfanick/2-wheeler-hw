#include "pid.h"

#define DEBUG_PRINT_ENABLE 0
#include <debug_print.h>

[[combinable]]
void balancer_pid(interface balancer_i server i[2], lsm303d_client motion, motors_client motors) {
  timer t; unsigned time;
  vector3d acc;

  motors.left(0);
  motors.right(0);

  t :> time;
  time += 10*XS1_TIMER_KHZ;

  while (1) {
    select {
      case t when timerafter(time) :> void:
        motion.accelerometer(acc);
        debug_printf("ACC: %d %d %d\n", acc.x, acc.y, acc.z);

        if (acc.x > -16340) {
          if (acc.z > 0) {
            debug_printf("wywala sie do przodu\n");
            motors.left(PWM_PERCENT(40));
            motors.right(PWM_PERCENT(40));
          } else
          if (acc.z < 0) {
            debug_printf("wywala sie do tylu\n");
            motors.left(PWM_PERCENT(-40));
            motors.right(PWM_PERCENT(-40));
          }
        } else {
          debug_printf("stoi!\n");
          motors.left(0);
          motors.right(0);
        }

        t :> time;
        break;
    }
  }
}

