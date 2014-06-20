#include "../../platform.h"

#define DEBUG_PRINT_ENABLE 1

#include <debug_print.h>


void logic(motors_client motors);

int main() {
  interface motors_i motors_interface;

  par {
    logic(motors_interface);
    motors(motors_interface, motors_bridge);
  }

  return 0;
}

void logic(motors_client motors) {
  timer t; unsigned time;

  signed speed = -100;
  unsigned step = -10;

  motors.left(0);
  motors.right(0);

  while (1) {
    debug_printf("SPEED %d%%\n\n", speed);

    time += 500 * XS1_TIMER_KHZ;
    t when timerafter(time) :> void;

    if (speed == 100 || speed == -100)
      step = -step;

    speed += step;

    motors.left(PWM_PERCENT(speed));
    motors.right(PWM_PERCENT(speed));

    time += 5000 * XS1_TIMER_KHZ;
    t when timerafter(time) :> void;

    motors.left(0);
    motors.right(0);
  }

}
