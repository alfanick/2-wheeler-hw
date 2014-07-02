#include "communication.h"

#define DEBUG_PRINT_ENABLE 1
#include <debug_print.h>

[[combinable]]
void balancer_communication(balancer_client balancer, bluetooth_client bluetooth) {
  unsigned char command[128];
  int command_length;

  bluetooth.send("hello\r", 6);
  bluetooth.send_number(123);
  bluetooth.send_number(1234542348);
  bluetooth.send_number(-100);
  balancer.balance();
  while (1) {
    select {
      case bluetooth.incoming():
        bluetooth.read(command, command_length);
        bluetooth.send(command, command_length);
        bluetooth.send("\r", 1);

        debug_printf("RECEIVED '%s' (%d)\n", command, command_length);
        break;
    }
  }
}
