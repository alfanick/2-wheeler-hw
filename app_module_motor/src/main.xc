#include <xs1.h>
#include <platform.h>

#include <motor.h>

void logic(motor_client left_motor, motor_client right_motor);

struct motor_t motors[2] = {
  { XS1_PORT_1P, XS1_PORT_1O, XS1_PORT_1N },
  { XS1_PORT_1M, XS1_PORT_1L, XS1_PORT_1K }
};

int main() {
  interface motor_i left_motor, right_motor;

  par {
    logic(left_motor, right_motor);

    [[combine]]
    par {
      motor(left_motor, motors[0]);
      motor(right_motor, motors[1]);
    }
  }

  return 0;
}

void logic(motor_client left_motor, motor_client right_motor) {
  left_motor.set(-PWM_PERCENT(25));
  right_motor.set(PWM_PERCENT(17));

  timer t;
  unsigned time;

  t :> time;

  unsigned state = 0;

  while (1) {
    t when timerafter(time) :> void;
    time += 1000 * XS1_TIMER_KHZ;

    left_motor.set(PWM_PERCENT(state ? 25 : 0));
    state = !state;
  }
}

