#ifndef APP_BALANCER_COMMUNICATION_H_
#define APP_BALANCER_COMMUNICATION_H_

#include "balancer.h"
#include "bluetooth.h"
#include "safety.h"

[[combinable]]
void balancer_communication(balancer_client balancer, bluetooth_client bluetooth, balancer_sensors_client sensors);

#endif

/* vim: set ft=xc: */
