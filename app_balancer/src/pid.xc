#include "pid.h"

[[combinable]]
void balancer_pid(interface balancer_i server i[2], lsm303d_client motion, motors_client motors) {
  motors.left(-PWM_PERCENT(15));
  motors.right(PWM_PERCENT(15));

  while (1) {
    select {

    }
  }
}

