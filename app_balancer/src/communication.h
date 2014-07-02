#ifndef APP_BALANCER_COMMUNICATION_H_
#define APP_BALANCER_COMMUNICATION_H_

#include "balancer.h"
#include "bluetooth.h"

[[combinable]]
void balancer_communication(balancer_client balancer, bluetooth_client bluetooth);

#endif

/* vim: set ft=xc: */
