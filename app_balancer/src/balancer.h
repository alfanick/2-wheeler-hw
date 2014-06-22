#ifndef APP_BALANCER_BALANCER_H_
#define APP_BALANCER_BALANCER_H_

interface balancer_i {
  void foo();
};
typedef interface balancer_i client balancer_client;

#endif

/* vim: set ft=xc: */
