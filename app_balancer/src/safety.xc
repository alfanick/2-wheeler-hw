#include "safety.h"

#define DEBUG_PRINT_ENABLE 0
#include <debug_print.h>

[[combinable]]
void balancer_safety(balancer_client balancer,
                     distance_sensor_client front,
                     distance_sensor_client rear,
                     startkit_adc_if client adc,
                     motors_status_client motors_status) {
  while (1) {
    select {
      case motors_status.changed():
        int l, r;
        { l, r } = motors_status.get();

        debug_printf("L %d R %d\n", l, r);
        break;
    }
  }
}
