#include <xs1.h>
#include <platform.h>

#include <distance_sensor.h>

struct distance_sensor_t distance_sensors[2] = {
  { XS1_PORT_1P, XS1_PORT_1O },
  { XS1_PORT_1M, XS1_PORT_1L }
};

void logic(interface distance_sensor_i client left, interface distance_sensor_i client right);

int main() {
  interface distance_sensor_i front_distance, rear_distance;

  par {
    logic(front_distance, rear_distance);

    [[combine]]
    par {
      distance_sensor(front_distance, distance_sensors[0]);
      distance_sensor(rear_distance, distance_sensors[1]);
    }
  }

  return 0;
}

void logic(interface distance_sensor_i client left, interface distance_sensor_i client right) {

}
