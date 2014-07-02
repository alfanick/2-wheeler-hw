#include "communication.h"

#define DEBUG_PRINT_ENABLE 0
#include <debug_print.h>

[[combinable]]
void balancer_communication(balancer_client balancer, bluetooth_client bluetooth, balancer_sensors_client sensors) {
  unsigned char command[128];
  int command_length;

  balancer.balance();
  while (1) {
    select {
      case bluetooth.incoming():
        bluetooth.read(command, command_length);

        if (command_length == 0)
          break;

        if (command[0] == 'V')
          bluetooth.send_number(sensors.battery_voltage());
        break;
    }
  }
}
