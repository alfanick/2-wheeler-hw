#include "distance_sensor.h"

#include <print.h>

[[combinable]]
void distance_sensor(interface distance_sensor_i server i, struct distance_sensor_t &pin) {
  timer t;
  unsigned time;
  unsigned delta = -1;
  unsigned last_raw = -1;
  unsigned current_time;
  unsigned state = 0;
  unsigned measure = 0;

  set_port_pull_down(pin.echo);

  t :> time;
  while (1) {
    select {
      case i.frequency(unsigned freq):
        delta = freq == 0 ? -1 : (1000 * XS1_TIMER_KHZ / freq);
        break;

      case i.read() -> unsigned distance:
        distance = (last_raw / (XS1_TIMER_MHZ / 10)) * 34 / 500;
        break;

      case i.read_raw() -> unsigned time:
        time = last_raw;
        break;

      case (delta != -1) => t when timerafter(time) :> void:
        // send trigger pulse
        measure = 0;
        pin.trigger <: 1;
        time += 100 * XS1_TIMER_MHZ;
        t when timerafter(time) :> void;
        pin.trigger <: 0;

        // wait for response
        state = 0;
        measure = 1;

        // next measurement
        time += delta;
        break;

      case measure => pin.echo when pinsneq(state) :> state:
        // end of wave
        if (!state) {
          t :> current_time;
          last_raw = current_time - measure;
          measure = 0;
        } else {
          t :> measure;
        }
        break;
    }
  }
}
