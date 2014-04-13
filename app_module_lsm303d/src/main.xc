#include <xs1.h>
#include <platform.h>
#include <stdio.h>

#include <lsm303d.h>

lsm303d_t lsm303d_pin = {
  XS1_PORT_1I,
  XS1_PORT_1H,
  250
};


[[combinable]]
void logic(lsm303d_client lsm);

int main() {
  interface lsm303d_i lsm303d_interface;

  [[combine]]
  par {
    logic(lsm303d_interface);

    lsm303d(lsm303d_interface, lsm303d_pin);
  }

  return 0;
}

[[combinable]]
void logic(lsm303d_client lsm) {
  timer t; unsigned time;
  vector3d acc, mag;

  t :> time;
  while (1) {
    select {
      case t when timerafter(time) :> void:
        lsm.accelerometer_raw(acc);
        printf("ACC_RAW: %d %d %d\n", acc.x, acc.y, acc.z);
        lsm.accelerometer(acc);
        printf("ACC:     %d %d %d\n", acc.x, acc.y, acc.z);

        lsm.magnetometer_raw(mag);
        printf("MAG_RAW: %d %d %d\n", mag.x, mag.y, mag.z);
        lsm.magnetometer(mag);
        printf("MAG:     %d %d %d\n", mag.x, mag.y, mag.z);

        time += 500 * XS1_TIMER_KHZ;
        break;
    }
  }
}
