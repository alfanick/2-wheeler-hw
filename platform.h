#ifndef TWO_WHEELER_PLATFORM_H_
#define TWO_WHEELER_PLATFORM_H_

#define   FRONT_DISTANCE_SENSOR_TRIGGER            XS1_PORT_1I
#define      FRONT_DISTANCE_SENSOR_ECHO            XS1_PORT_1J

#define    REAR_DISTANCE_SENSOR_TRIGGER            XS1_PORT_1K
#define       REAR_DISTANCE_SENSOR_ECHO            XS1_PORT_1L

#define             MOTION_SENSOR_CLOCK            XS1_PORT_1G
#define              MOTION_SENSOR_DATA            XS1_PORT_1H

#define              BLUETOOTH_TRANSMIT            XS1_PORT_1P
#define               BLUETOOTH_RECEIVE            XS1_PORT_1O

#define              LEFT_MOTOR_DISABLE            XS1_PORT_1E
#define               LEFT_MOTOR_STATUS            XS1_PORT_1M

#define             RIGHT_MOTOR_DISABLE            XS1_PORT_1F
#define              RIGHT_MOTOR_STATUS            XS1_PORT_1N

#define               MOTORS_DIRECTIONS            XS1_PORT_4D
#define                  MOTORS_SENSORS            XS1_PORT_4C

#include <platform.h>
#include <xs1.h>

#include <distance_sensor.h>
#include <lsm303d.h>
#include <motors.h>

distance_sensor_t distance_sensors[2] = {
  { FRONT_DISTANCE_SENSOR_TRIGGER, FRONT_DISTANCE_SENSOR_ECHO },
  {  REAR_DISTANCE_SENSOR_TRIGGER,  REAR_DISTANCE_SENSOR_ECHO }
};

lsm303d_t motion_sensor = {
  MOTION_SENSOR_CLOCK,
  MOTION_SENSOR_DATA,
  250
};

motors_t motors_bridge = {
  {  LEFT_MOTOR_DISABLE,   LEFT_MOTOR_STATUS },
  { RIGHT_MOTOR_DISABLE,  RIGHT_MOTOR_STATUS },
  MOTORS_DIRECTIONS,
  MOTORS_SENSORS
};

#endif
