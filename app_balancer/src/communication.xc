#include "communication.h"

[[combinable]]
void balancer_communication(balancer_client balancer, bluetooth_client bluetooth) {
  balancer.balance();
  while (1) {
    select {
    }
  }
}
