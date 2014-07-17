#include "communication.h"

#define DEBUG_PRINT_ENABLE 0
#include <debug_print.h>
#include <safestring.h>
#include <flashlib.h>
#include <xassert.h>
config_flash_port flash_memory = {
  PORT_SPI_MISO,
  PORT_SPI_SS,
  PORT_SPI_CLK,
  PORT_SPI_MOSI,
  XS1_CLKBLK_3
};

#define SAVE(WHAT, VALUE) if (flash == 1) {\
                            config[config_balancer_##WHAT] = VALUE;\
                          } else {\
                            balancer.set_##WHAT(VALUE);\
                          }
#define SEND(WHAT) { int t; if (flash == 1) {\
                       t = config[config_balancer_##WHAT];\
                     } else {\
                       t = balancer.get_##WHAT();\
                     }\
                     bluetooth.send_number(t);\
                   }
#undef CONFIG
#define CONFIG(WHAT, DEFAULT) if (config[config_balancer_##WHAT] == -1) {\
                                balancer.set_##WHAT(DEFAULT);\
                              } else {\
                                balancer.set_##WHAT(config[config_balancer_##WHAT]);\
                              }
#define CONFIG_ARRAY(WHAT, ...) { int config_array_##WHAT[] = {__VA_ARGS__};\
                                      if (config[config_balancer_##WHAT] == -1) {\
                                        balancer.set_##WHAT(config_array_##WHAT);\
                                      } else {\
                                        balancer.set_##WHAT(config + config_balancer_##WHAT);\
                                      }\
                                    }

[[combinable]]
void balancer_communication(balancer_client balancer, bluetooth_client bluetooth, balancer_sensors_client sensors) {
  unsigned char buffer[256];
  int buffer_length;
  int flash = 0;


  int config[EOF];
  config_read(flash_memory, 0, config, EOF, buffer);

  CONFIG(speed_boost, 500);
  CONFIG(speed_threshold, 100);
  CONFIG(target, -900);
  CONFIG_ARRAY(pid, 2300000, 5000000, 0);
  CONFIG(pid_lowpass, 400);
  CONFIG(lowpass, 172);
  CONFIG(loop_delay, 10);

  in buffered port:8 * unsafe miso;
  unsafe {
      miso = (in buffered port:8 * unsafe) &flash_memory.spiMISO;
  }

  sensors.release_adc(miso);

  while (1) {
    select {
      case bluetooth.incoming():
        bluetooth.read(buffer, buffer_length);

        if (buffer_length == 0)
          break;

        if (safestrstr(buffer, "ERROR") == 0)
          break;

        if (safestrstr(buffer, "FLASH") == 0) {
          if (flash == 0) {
            flash = 1;

            sensors.acquire_adc();

            config_read(flash_memory, 0, config, EOF, buffer);

            bluetooth.send("OK\r", 3);
          } else {
            bluetooth.send("ERROR\r", 6);
          }
          break;
        }

        if (safestrstr(buffer, "SB?") == 0) {
          bluetooth.send("SB=", 3);
          SEND(speed_boost);
        } else
        if (safestrstr(buffer, "SB=") == 0) {
          int a;
          parse_numbers(buffer, buffer_length, 3, &a, 1);

          SAVE(speed_boost, a);
          bluetooth.send("OK\r", 3);
        } else
        if (safestrstr(buffer, "ST?") == 0) {
          bluetooth.send("ST=", 3);
          SEND(speed_threshold);
        } else
        if (safestrstr(buffer, "ST=") == 0) {
          int a;
          parse_numbers(buffer, buffer_length, 3, &a, 1);

          SAVE(speed_threshold, a);
          bluetooth.send("OK\r", 3);
        } else
        if (safestrstr(buffer, "A?") == 0) {
          bluetooth.send("A=", 2);
          bluetooth.send_number(balancer.get_angle());
        } else
        if (safestrstr(buffer, "T?") == 0) {
          bluetooth.send("T=", 2);
          SEND(target);
        } else
        if (safestrstr(buffer, "T=") == 0) {
          int t;
          parse_numbers(buffer, buffer_length, 2, &t, 1);

          SAVE(target, t);
          bluetooth.send("OK\r", 3);
        } else
        if (safestrstr(buffer, "T") == 0) {
          int t = balancer.get_angle();

          SAVE(target, t);
          bluetooth.send("OK\r", 3);
        } else
        if (safestrstr(buffer, "S") == 0) {
          balancer.balance(-2);
          bluetooth.send("OK\r", 3);
        } else
        if (safestrstr(buffer, "X") == 0) {
          balancer.stop(-2);
          bluetooth.send("OK\r", 3);
        } else
        if (safestrstr(buffer, "V?") == 0) {
          bluetooth.send("V=", 2);
          bluetooth.send_number(sensors.battery_voltage());
        } else
        if (safestrstr(buffer, "C?") == 0) {
          int c[2];
          { c[0], c[1] } = sensors.motors_current();

          bluetooth.send("C=", 2);
          bluetooth.send_numbers(c, 2);
        } else
        if (safestrstr(buffer, "PID=") == 0) {
          int K[3];
          parse_numbers(buffer, buffer_length, 4, K, 3);

          if (flash==1) {
            config[config_balancer_pid + 0] = K[0];
            config[config_balancer_pid + 1] = K[1];
            config[config_balancer_pid + 2] = K[2];
          } else {
            balancer.set_pid(K);
          }

          bluetooth.send("OK\r", 3);
        } else
        if (safestrstr(buffer, "PID?") == 0) {
          int K[3];
          if (flash==1) {
            K[0] = config[config_balancer_pid + 0];
            K[1] = config[config_balancer_pid + 1];
            K[2] = config[config_balancer_pid + 2];
          } else {
            balancer.get_pid(K);
          }

          bluetooth.send("PID=", 4);
          bluetooth.send_numbers(K, 3);
        } else
        if (safestrstr(buffer, "PIDLP?") == 0) {
          bluetooth.send("PIDLP=", 6);
          SEND(pid_lowpass);
        } else
        if (safestrstr(buffer, "PIDLP=") == 0) {
          int a[1];
          parse_numbers(buffer, buffer_length, 6, a, 1);

          SAVE(pid_lowpass, a[0]);
          bluetooth.send("OK\r", 3);
        } else
        if (safestrstr(buffer, "ALP=") == 0) {
          int l[1];
          parse_numbers(buffer, buffer_length, 4, l, 1);

          SAVE(lowpass, l[0]);
          bluetooth.send("OK\r", 3);
        } else
        if (safestrstr(buffer, "ALP?") == 0) {
          bluetooth.send("ALP=", 4);
          SEND(lowpass);
        } else
        if (safestrstr(buffer, "RPM?") == 0) {
          int r[2];
          balancer.get_rpm(r);

          bluetooth.send("RPM=", 4);
          bluetooth.send_numbers(r, 2);
        } else
        if (safestrstr(buffer, "VER?") == 0) {
          bluetooth.send("VER="APP_VERSION"\r", 12);
        } else
        if (safestrstr(buffer, "LOOPTIME?") == 0) {
          bluetooth.send("LOOPTIME=", 9);
          bluetooth.send_number(balancer.get_loop_time());
        } else
        if (safestrstr(buffer, "LOOPDELAY?") == 0) {
          bluetooth.send("LOOPDELAY=", 10);
          SEND(loop_delay);
        } else
        if (safestrstr(buffer, "LOOPDELAY=") == 0) {
          int t[1];
          parse_numbers(buffer, buffer_length, 10, t, 1);

          SAVE(loop_delay, t[0]);
          bluetooth.send("OK\r", 3);
        }
        else
          bluetooth.send("ERROR\r", 6);

        if (flash == 1) {
          flash = 0;

          config_save(flash_memory, 0, config, EOF, buffer);
          sensors.release_adc(miso);
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
