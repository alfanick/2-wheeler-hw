#ifndef APP_BALANCER_SAFETY_H_
#define APP_BALANCER_SAFETY_H_

#include <distance_sensor.h>
#include <motors.h>
#include <startkit_adc.h>

#include "balancer.h"

interface balancer_sensors_i {
  unsigned battery_voltage();
};
typedef interface balancer_sensors_i client balancer_sensors_client;

[[combinable]]
void balancer_safety(balancer_client balancer,
                     distance_sensor_client front,
                     distance_sensor_client rear,
                     startkit_adc_if client adc,
                     motors_status_client motors_status,
                     interface balancer_sensors_i server sensors);

#endif

/* vim: set ft=xc: */
