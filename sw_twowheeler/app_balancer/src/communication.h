#ifndef APP_BALANCER_COMMUNICATION_H_
#define APP_BALANCER_COMMUNICATION_H_

#include "balancer.h"
#include "bluetooth.h"
#include "safety.h"

enum config_properties {
  BALANCER_SPEED_BOOST = 0,
  BALANCER_SPEED_THRESHOLD = 1,
  BALANCER_TARGET = 2,
  BALANCER_PID = 3,
  BALANCER_PID_LOWPASS = 6,
  BALANCER_ANGLE_LOWPASS = 7,
  BALANCER_LOOPDELAY = 8,
  EOF = 9
};


void parse_numbers(unsigned char where[], int length, int offset, int numbers[], const static int size);

[[combinable]]
void balancer_communication(balancer_client balancer, bluetooth_client bluetooth, balancer_sensors_client sensors);

#endif

/* vim: set ft=xc: */
