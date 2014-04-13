#include <xs1.h>
#include <platform.h>
#include <stdio.h>

#include <lsm303d.h>

lsm303d_t lsm303d_pin = {
  XS1_PORT_1I,
  XS1_PORT_1H,
  250
};

void logic(lsm303d_client lsm);

int main() {
  interface lsm303d_i lsm303d_interface;

  par {
    logic(lsm303d_interface);

    lsm303d(lsm303d_interface, lsm303d_pin);
  }

  return 0;
}

void logic(lsm303d_client lsm) {
  timer t; unsigned time;
  vector3d acc, mag;
/*
  t :> time;
  while (1) {
    select {
      case t when timerafter(time) :> void:
        lsm.accelerometer(acc);
        printf("ACC: %d %d %d\n", acc.x >> 4, acc.y >> 4, acc.z >> 4);

        lsm.magnetometer(mag);
        printf("MAG: %d %d %d\n", mag.x, mag.y, mag.z);

        time += 1000 * XS1_TIMER_KHZ;
        break;
    }
  }*/
}
