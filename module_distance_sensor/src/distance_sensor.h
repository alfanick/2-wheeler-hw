#ifndef ALJ_DISTANCE_SENSOR_H
#define ALJ_DISTANCE_SENSOR_H

#include <xs1.h>
#include <platform.h>

struct distance_sensor_t {
  out port trigger;
  in port echo;
};

interface distance_sensor_i {
  unsigned read();
  void frequency(unsigned freq);
};

typedef interface distance_sensor_i client distance_sensor_client;

[[combinable]]
void distance_sensor(interface distance_sensor_i server i, struct distance_sensor_t &pin);


#endif
