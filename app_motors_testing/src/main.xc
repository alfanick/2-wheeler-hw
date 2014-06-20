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

  unsigned speed = 0;
  unsigned step = +1;

  motors.left(0);
  motors.right(0);

  while (1) {
    debug_printf("SPEED %d%%\n\n", speed);

    time += 500 * XS1_TIMER_KHZ;
    t when timerafter(time) :> void;

    if (speed == 100)
      step = -1; else
    if (speed == 0)
      step = +1;

    speed += step;

    motors.left(PWM_PERCENT(speed));
    motors.right(PWM_PERCENT(speed));
  }

}
