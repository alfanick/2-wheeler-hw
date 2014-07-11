#ifndef APP_BALANCER_COMMUNICATION_H_
#define APP_BALANCER_COMMUNICATION_H_

#include <config.h>
#include "balancer.h"
#include "bluetooth.h"
#include "safety.h"


enum config_properties {
  config_balancer_speed_boost = 0, //++
  config_balancer_speed_threshold = 1, //++
  config_balancer_target = 2, //++
  config_balancer_pid = 3, //++
  config_balancer_pid_lowpass = 6,//++
  config_balancer_lowpass = 7,//++
  config_balancer_loop_delay = 8,//++
  EOF = 9
};


void parse_numbers(unsigned char where[], int length, int offset, int numbers[], const static int size);

[[combinable]]
void balancer_communication(balancer_client balancer, bluetooth_client bluetooth, balancer_sensors_client sensors);

#endif

/* vim: set ft=xc: */
