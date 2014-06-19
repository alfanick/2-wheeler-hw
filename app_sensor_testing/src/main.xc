#include "../../platform.h"

#define DEBUG_PRINT_ENABLE 1

#include <debug_print.h>

void logic(lsm303d_client lsm, distance_sensor_client front, distance_sensor_client rear);

int main() {
  interface distance_sensor_i front_distance, rear_distance;
  interface lsm303d_i motion;

  par {
    logic(motion, front_distance, rear_distance);

    [[combine]]
    par {
      lsm303d(motion, motion_sensor);
      distance_sensor(front_distance, distance_sensors[0]);
      distance_sensor(rear_distance, distance_sensors[1]);
    }
  }

  return 0;
}

void logic(lsm303d_client lsm, distance_sensor_client front, distance_sensor_client rear) {
  timer t; unsigned time;
  vector3d acc, mag;

  front.frequency(13);
  rear.frequency(17);

  t :> time;
  while (1) {
    select {
      case t when timerafter(time) :> void:
        lsm.accelerometer_raw(acc);
        debug_printf("ACC_RAW: %d %d %d\n", acc.x, acc.y, acc.z);
        lsm.accelerometer(acc);
        debug_printf("ACC:     %d %d %d\n", acc.x, acc.y, acc.z);

        lsm.magnetometer_raw(mag);
        debug_printf("MAG_RAW: %d %d %d\n", mag.x, mag.y, mag.z);
        lsm.magnetometer(mag);
        debug_printf("MAG:     %d %d %d\n", mag.x, mag.y, mag.z);
        debug_printf("FRONT:   %d\n", front.read());
        debug_printf("REAR:    %d\n\n", rear.read());

        time += 500 * XS1_TIMER_KHZ;
        break;
    }
  }
}
