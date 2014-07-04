#include "../../platform.h"

#define DEBUG_PRINT_ENABLE 1

#include <debug_print.h>
#include <pwm_singlebit_port.h>

void logic(motors_client motors);

int main() {
  interface motors_i motors_interface;
  interface motors_status_i motors_status;
  interface motor_i left_motor, right_motor;

  chan left_pwm, right_pwm;

  par {
    logic(motors_interface);
    motors_logic(motors_interface, motors_status, left_motor, right_motor, motors_bridge.directions, motors_bridge.sensors);
    motor(left_motor, motors_bridge.left.status, left_pwm);
    motor(right_motor, motors_bridge.right.status, right_pwm);

    pwmSingleBitPort(left_pwm, motors_bridge.left.pwm_clock, motors_bridge.left.disable, 1, 2048, 340, 1);
    pwmSingleBitPort(right_pwm, motors_bridge.right.pwm_clock, motors_bridge.right.disable, 1, 2048, 340, 1);
  }

  return 0;
}

void logic(motors_client motors) {
  //motors.left(PWM_PERCENT(10));
  //motors.right(PWM_PERCENT(10));
  motors.left(-2000);
  motors.right(0);
//  pwmSingleBitPortSetDutyCycle(l, v, 1);
//  pwmSingleBitPortSetDutyCycle(r, v, 1);


  while(1) {}

}
