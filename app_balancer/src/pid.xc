#include "pid.h"

#define DEBUG_PRINT_ENABLE 1
#include <debug_print.h>

[[combinable]]
void balancer_pid(interface balancer_i server i[2], lsm303d_client motion, motors_client motors) {
  timer t; unsigned time;
  vector3d acc;

  motors.left(-PWM_PERCENT(15));
  motors.right(PWM_PERCENT(15));

  t :> time;
  time += 500*XS1_TIMER_KHZ;

  while (1) {
    select {
      case t when timerafter(time) :> void:
        motion.accelerometer(acc);
        debug_printf("ACC: %d %d %d\n", acc.x, acc.y, acc.z);

        t :> time;
        break;
    }
  }
}

