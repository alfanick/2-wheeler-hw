#ifndef APP_BALANCER_PID_H_
#define APP_BALANCER_PID_H_

#include <imu10.h>
#include <motors.h>

#include "balancer.h"

[[combinable]]
void balancer_pid(interface balancer_i server i[2], imu10_client motion, motors_client motors);

#endif

/* vim: set ft=xc: */
