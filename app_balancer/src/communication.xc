#include "communication.h"

#define DEBUG_PRINT_ENABLE 0
#include <debug_print.h>
#include <safestring.h>

void parse_numbers(unsigned char where[], int length, int offset, int numbers[], const static int size) {
  int j = 0;
  int sign[size];

  for (int i = 0; i < size; i++) {
    numbers[i] = 0;
    sign[i] = 1;
  }

  for (int i = offset; i < length && j < size; i++) {
    if (where[i] == ',') {
      j++;
      continue;
    } else
    if (where[i] == '-') {
      sign[j] = -1;
      continue;
    }

    int digit = where[i] - '0';

    numbers[j] *= 10;
    numbers[j] += digit;
  }

  for (int i = 0; i < size; i++)
    numbers[i] *= sign[i];
}

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

        if (safestrstr(command, "S") == 0) {
          balancer.balance();
          bluetooth.send("OK\r", 3);
        } else
        if (safestrstr(command, "X") == 0) {
          balancer.stop();
          bluetooth.send("OK\r", 3);
        } else
        if (safestrstr(command, "V?") == 0) {
          bluetooth.send("V=", 2);
          bluetooth.send_number(sensors.battery_voltage());
        } else
        if (safestrstr(command, "PID=") == 0) {
          int K[3];
          parse_numbers(command, command_length, 4, K, 3);

          balancer.set_pid(K);

          bluetooth.send("OK\r", 3);
        } else
        if (safestrstr(command, "PID?") == 0) {
          int K[3];
          balancer.get_pid(K);

          bluetooth.send("PID=", 4);
          bluetooth.send_numbers(K, 3);
        } else
        if (safestrstr(command, "VER?") == 0) {
          bluetooth.send("VER="APP_VERSION"\r", 12);
        }
        else
          bluetooth.send("ERROR\r", 6);
        break;
    }
  }
}
