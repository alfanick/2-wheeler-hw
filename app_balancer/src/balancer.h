#ifndef APP_BALANCER_BALANCER_H_
#define APP_BALANCER_BALANCER_H_

interface balancer_i {
  void stop();
  void balance();

  void move_start(unsigned left, unsigned right);
  void move_stop();
};
typedef interface balancer_i client balancer_client;

#endif

/* vim: set ft=xc: */
