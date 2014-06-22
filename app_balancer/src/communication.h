#ifndef APP_BALANCER_COMMUNICATION_H_
#define APP_BALANCER_COMMUNICATION_H_

#include "balancer.h"

interface bluetooth_i {
  void it_a_mock();
};
typedef interface bluetooth_i client bluetooth_client;

[[combinable]]
void balancer_communication(balancer_client balancer, bluetooth_client bluetooth);

#endif

/* vim: set ft=xc: */
