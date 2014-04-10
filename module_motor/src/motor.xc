#include "motor.h"

[[combinable]]
void motor(interface motor_i server i, struct motor_t &pin) {
  timer t;
  unsigned duty = 0, state = 0, time;

  t :> time;

  while (1) {
    select {
      case i.set(signed speed):
        if (speed > 0) {
          duty = speed;
          pin.b <: 0;
          pin.a <: 1;
        } else
        if (speed < 0) {
          duty = -speed;
          pin.a <: 0;
          pin.b <: 1;
        } else {
          duty = 0;
          pin.enable <: 0;
          pin.a <: 0;
          pin.b <: 0;
        }
        break;

      case duty != 0 => t when timerafter(time) :> void:
        pin.enable <: state;
        time += PWM_SCALE * (state ? duty : (PWM_RESOLUTION - duty));
        state = !state;

        break;
    }
  }
}

