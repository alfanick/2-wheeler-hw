#include "communication.h"

#define DEBUG_PRINT_ENABLE 1
#include <debug_print.h>
#include <safestring.h>

[[combinable]]
void balancer_communication(balancer_client balancer, bluetooth_client bluetooth, balancer_sensors_client sensors) {
  unsigned char command[128];
  int command_length;
  int flash = 0;

  while (1) {
    select {
      case bluetooth.incoming():
        bluetooth.read(command, command_length);

        if (command_length == 0)
          break;

        if (safestrstr(command, "ERROR") == 0)
          break;

        if (safestrstr(command, "FLASH") == 0) {
          flash = 1;

          // sensors.acquire_adc();
          // config_open();

          bluetooth.send("OK\r", 3);
          break;
        }

        if (safestrstr(command, "SB?") == 0) {
          bluetooth.send("SB=", 3);
          bluetooth.send_number(balancer.get_speed_boost());
        } else
        if (safestrstr(command, "SB=") == 0) {
          int a;
          parse_numbers(command, command_length, 3, &a, 1);

          balancer.set_speed_boost(a);
          bluetooth.send("OK\r", 3);
        } else
        if (safestrstr(command, "ST?") == 0) {
          bluetooth.send("ST=", 3);
          bluetooth.send_number(balancer.get_speed_threshold());
        } else
        if (safestrstr(command, "ST=") == 0) {
          int a;
          parse_numbers(command, command_length, 3, &a, 1);

          balancer.set_speed_threshold(a);
          bluetooth.send("OK\r", 3);
        } else
        if (safestrstr(command, "A?") == 0) {
          bluetooth.send("A=", 2);
          bluetooth.send_number(balancer.get_angle());
        } else
        if (safestrstr(command, "T?") == 0) {
          bluetooth.send("T=", 2);
          bluetooth.send_number(balancer.get_target());
        } else
        if (safestrstr(command, "T=") == 0) {
          int t;
          parse_numbers(command, command_length, 2, &t, 1);

          balancer.set_target(t);
          bluetooth.send("OK\r", 3);
        } else
        if (safestrstr(command, "T") == 0) {
          balancer.set_target(balancer.get_angle());
          bluetooth.send("OK\r", 3);
        } else
        if (safestrstr(command, "S") == 0) {
          balancer.balance(-2);
          bluetooth.send("OK\r", 3);
        } else
        if (safestrstr(command, "X") == 0) {
          balancer.stop(-2);
          bluetooth.send("OK\r", 3);
        } else
        if (safestrstr(command, "V?") == 0) {
          bluetooth.send("V=", 2);
          bluetooth.send_number(sensors.battery_voltage());
        } else
        if (safestrstr(command, "C?") == 0) {
          int c[2];
          { c[0], c[1] } = sensors.motors_current();

          bluetooth.send("C=", 2);
          bluetooth.send_numbers(c, 2);
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
        if (safestrstr(command, "PIDLP?") == 0) {
          bluetooth.send("PIDLP=", 6);
          bluetooth.send_number(balancer.get_pid_lowpass());
        } else
        if (safestrstr(command, "PIDLP=") == 0) {
          int a[1];
          parse_numbers(command, command_length, 6, a, 1);

          balancer.set_pid_lowpass(a[0]);
          bluetooth.send("OK\r", 3);
        } else
        if (safestrstr(command, "ALP=") == 0) {
          int l[1];
          parse_numbers(command, command_length, 4, l, 1);

          balancer.set_lowpass(l[0]);
          bluetooth.send("OK\r", 3);
        } else
        if (safestrstr(command, "ALP?") == 0) {
          bluetooth.send("ALP=", 4);
          bluetooth.send_number(balancer.get_lowpass());
        } else
        if (safestrstr(command, "RPM?") == 0) {
          int r[2];
          balancer.get_rpm(r);

          bluetooth.send("RPM=", 4);
          bluetooth.send_numbers(r, 2);
        } else
        if (safestrstr(command, "VER?") == 0) {
          bluetooth.send("VER="APP_VERSION"\r", 12);
        } else
        if (safestrstr(command, "LOOPTIME?") == 0) {
          bluetooth.send("LOOPTIME=", 9);
          bluetooth.send_number(balancer.get_loop_time());
        } else
        if (safestrstr(command, "LOOPDELAY?") == 0) {
          bluetooth.send("LOOPDELAY=", 10);
          bluetooth.send_number(balancer.get_loop_delay());
        } else
        if (safestrstr(command, "LOOPDELAY=") == 0) {
          int t[1];
          parse_numbers(command, command_length, 10, t, 1);

          balancer.set_loop_delay(t[0]);
          bluetooth.send("OK\r", 3);
        }
        else
          bluetooth.send("ERROR\r", 6);

        if (flash) {
          flash = 0;
          // config_close();
          // sensors.release_adc();
        }

        break;
    }
  }
}

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
