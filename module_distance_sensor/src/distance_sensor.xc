#include "distance_sensor.h"

[[combinable]]
void distance_sensor(interface distance_sensor_i server i, struct distance_sensor_t &pin) {
  while (1) {
    select {
      case i.read() -> unsigned distance:
        distance = 0;
        break;
    }
  }
}
