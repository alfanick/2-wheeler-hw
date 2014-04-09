#include <xs1.h>
#include <platform.h>
#include <print.h>
#include <stdio.h>

void logic(chanend left_motor, chanend right_motor);
void motor(chanend left_motor, chanend right_motor, chanend duty);
void pwm(out port pins[], unsigned pins_size, clock sync, chanend duty);

out port motor_pins[] = {
  XS1_PORT_1P, XS1_PORT_1O,
  XS1_PORT_1N, XS1_PORT_1M
};
clock pwm_sync = XS1_CLKBLK_1;

int main() {
  chan left_motor, right_motor;
  chan pwm_duty;

  par {
    logic(left_motor, right_motor);
    motor(left_motor, right_motor, pwm_duty);
    pwm(motor_pins, 4, pwm_sync, pwm_duty);
  }

  return 0;
}

void motor(chanend left_motor, chanend right_motor, chanend duty) {
  while (1) {
    select {
      case left_motor :> signed left_speed:
        printf("LEFT = %d\n", left_speed);
        break;

      case right_motor :> signed right_speed:
        printf("RIGHT = %d\n", right_speed);

        break;
    }
  }
}

void logic(chanend left_motor, chanend right_motor) {
  left_motor <: -12;
  right_motor <: 12;
}

void pwm(out port pins[], unsigned pins_size, clock sync, chanend speed) {
  configure_clock_rate(sync, 100, 1);
  start_clock(sync);

  printstrln("PWM INIT");
}
