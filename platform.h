#ifndef TWO_WHEELER_PLATFORM_H_
#define TWO_WHEELER_PLATFORM_H_

#include <platform.h>
#include <xs1.h>

#include <distance_sensor.h>
#include <lsm303d.h>

#define   FRONT_DISTANCE_SENSOR_TRIGGER            XS1_PORT_1I
#define      FRONT_DISTANCE_SENSOR_ECHO            XS1_PORT_1J

#define    REAR_DISTANCE_SENSOR_TRIGGER            XS1_PORT_1K
#define       REAR_DISTANCE_SENSOR_ECHO            XS1_PORT_1L

#define             MOTION_SENSOR_CLOCK            XS1_PORT_1G
#define              MOTION_SENSOR_DATA            XS1_PORT_1H

#define              BLUETOOTH_TRANSMIT            XS1_PORT_1O
#define               BLUETOOTH_RECEIVE            XS1_PORT_1P

distance_sensor_t distance_sensors[2] = {
  { FRONT_DISTANCE_SENSOR_TRIGGER, FRONT_DISTANCE_SENSOR_ECHO },
  {  REAR_DISTANCE_SENSOR_TRIGGER,  REAR_DISTANCE_SENSOR_ECHO }
};

lsm303d_t motion_sensor = {
  MOTION_SENSOR_CLOCK,
  MOTION_SENSOR_DATA,
  250
};

#endif
