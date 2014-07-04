#include "../../platform.h"

#define DEBUG_PRINT_ENABLE 0

#include <debug_print.h>


void logic(motors_client motors);

int main() {
  interface motors_i motors_interface;
  interface motors_status_i motors_status;
  interface motor_i left_motor, right_motor;

  par {
    logic(motors_interface);
    motors_logic(motors_interface, motors_status, left_motor, right_motor, motors_bridge.directions, motors_bridge.sensors);
    motor(left_motor, motors_bridge.left);
    motor(right_motor, motors_bridge.right);
  }

  return 0;
}

void logic(motors_client motors) {
  motors.left(PWM_PERCENT(10));
  motors.right(PWM_PERCENT(10));


  while(1) {}

}
