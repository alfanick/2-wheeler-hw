#include "communication.h"

#define DEBUG_PRINT_ENABLE 1
#include <debug_print.h>

[[combinable]]
void balancer_communication(balancer_client balancer, bluetooth_client bluetooth) {
  unsigned char command[128];
  int command_length;

  bluetooth.send("hello\r\n", 7);
  balancer.balance();
  while (1) {
    select {
      case bluetooth.incoming():
        bluetooth.read(command, command_length);

        debug_printf("RECEIVED '%s' (%d)\n", command, command_length);
        break;
    }
  }
}
