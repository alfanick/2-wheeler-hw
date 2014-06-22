#ifndef APP_BALANCER_PID_H_
#define APP_BALANCER_PID_H_

#include <lsm303d.h>
#include <motors.h>

#include "balancer.h"

[[combinable]]
void balancer_pid(interface balancer_i server i[2], lsm303d_client motion, motors_client motors);

#endif

/* vim: set ft=xc: */
