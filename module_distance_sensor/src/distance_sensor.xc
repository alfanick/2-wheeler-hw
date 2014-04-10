#include "distance_sensor.h"

#include <print.h>

void distance_sensor(interface distance_sensor_i server i, struct distance_sensor_t &pin) {
  timer t;
  unsigned time;
  signed delta = 1000 * XS1_TIMER_KHZ;
  unsigned last_distance = -1;
  unsigned current_time;
  unsigned state = 0;
  unsigned measure = 0;

  set_port_pull_down(pin.echo);

  t :> time;
  while (1) {
    select {
      case i.frequency(unsigned freq):
        delta = 1000 * XS1_TIMER_KHZ / freq;

        break;

      case i.read() -> unsigned distance:
        distance = last_distance;
        break;

      case t when timerafter(time) :> void:
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

      case measure => pin.echo :> unsigned new_state:
        // end of wave
        if (!new_state && state) {
          t :> current_time;
          last_distance = ((current_time - measure) / (XS1_TIMER_MHZ / 10)) * 34 / 500;
          measure = 0;
        } else
        // start
        if (new_state && !state) {
          t :> measure;
        }

        state = new_state;
        break;
    }
  }
}
