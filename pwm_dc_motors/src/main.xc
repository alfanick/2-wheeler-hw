#include <xs1.h>
#include <platform.h>

#define PWM_SCALE 2
#define PWM_RESOLUTION 8192
#define PWM_PERCENT(x) ( (x) * PWM_RESOLUTION / 100 )

struct motor_pins {
  out port enable;
  out port a;
  out port b;
};

void logic(chanend left_motor, chanend right_motor);

[[combinable]]
void motor(chanend velocity, struct motor_pins &pins);


struct motor_pins motors[2] = {
  { XS1_PORT_1P, XS1_PORT_1O, XS1_PORT_1N },
  { XS1_PORT_1M, XS1_PORT_1L, XS1_PORT_1K }
};

int main() {
  chan left_motor, right_motor;

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

[[combinable]]
void motor(chanend velocity, struct motor_pins &pins) {
  timer t;
  unsigned duty = 0, state = 0, time;

  t :> time;

  while (1) {
    select {
      case velocity :> signed speed:
        if (speed > 0) {
          duty = speed;
          pins.b <: 0;
          pins.a <: 1;
        } else
        if (speed < 0) {
          duty = -speed;
          pins.a <: 0;
          pins.b <: 1;
        } else {
          duty = 0;
          pins.enable <: 0;
          pins.a <: 0;
          pins.b <: 0;
        }
        break;

      case duty != 0 => t when timerafter(time) :> void:
        time += PWM_SCALE*(state ? duty : (PWM_RESOLUTION-duty));
        pins.enable <: state;
        state = !state;

        break;
    }
  }
}

void logic(chanend left_motor, chanend right_motor) {
  left_motor <: -PWM_PERCENT(25);
  right_motor <: PWM_PERCENT(50);

  timer t;
  unsigned time;

  t :> time;

  unsigned state = 0;

  while (1) {
    t when timerafter(time) :> void;
    time += 1000 * XS1_TIMER_KHZ;

    left_motor <: PWM_PERCENT(state ? 25 : 0);
    state = !state;
  }
}

