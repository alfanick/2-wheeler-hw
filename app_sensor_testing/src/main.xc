#include "../../platform.h"

#define DEBUG_PRINT_ENABLE 1

#include <debug_print.h>

#include <distance_sensor.h>


struct distance_sensor_t distance_sensors[2] = {
  { FRONT_DISTANCE_SENSOR_TRIGGER, FRONT_DISTANCE_SENSOR_ECHO },
  {  REAR_DISTANCE_SENSOR_TRIGGER,  REAR_DISTANCE_SENSOR_ECHO }
};

void logic(distance_sensor_client front, distance_sensor_client rear);

int main() {
  interface distance_sensor_i front_distance, rear_distance;

  par {
    logic(front_distance, rear_distance);


    [[combine]]
    par {
      distance_sensor(front_distance, distance_sensors[0]);
      distance_sensor(rear_distance, distance_sensors[1]);
    }
  }

  return 0;
}

void logic(distance_sensor_client front, distance_sensor_client rear) {
  timer t; unsigned time;

  front.frequency(13);
  rear.frequency(17);

  t :> time;
  while (1) {
    select {
      case t when timerafter(time) :> void:
        debug_printf("FRONT:   %d\n", front.read());
        debug_printf("REAR:    %d\n\n", rear.read());

        time += 500 * XS1_TIMER_KHZ;
        break;
    }
  }
}
