#ifndef ALJ_MOTOR_H
#define ALJ_MOTOR_H

#include <xs1.h>
#include <platform.h>

#define PWM_SCALE 2
#define PWM_RESOLUTION 10000
#define PWM_PERCENT(x) ( (x) * PWM_RESOLUTION / 100 )

struct motor_t {
  out port enable;
  out port a;
  out port b;
};

interface motor_i {
  void set(signed speed);
};

typedef interface motor_i client motor_client;

[[combinable]]
void motor(interface motor_i server i, struct motor_t &pin);


#endif
