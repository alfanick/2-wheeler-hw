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

  printf("foobar\n");
  t :> time;
  while (1) {
    select {
      case t when timerafter(time) :> void:

        vector3d acc = lsm.accelerometer();
        printf("ACC: %d %d %d\n", acc.x, acc.y, acc.z);


        vector3d mag = lsm.magnetometer();
        printf("MAG: %d %d %d\n", mag.x, mag.y, mag.z);
        time += 1000 * XS1_TIMER_KHZ;
        break;
    }
  }
}
