#include "logic.h"

void logic(motors_client motors) {
  motors.left(PWM_PERCENT(30));
  motors.right(PWM_PERCENT(30));
}
