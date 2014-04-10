#include <xs1.h>
#include <platform.h>

#define PWM_SCALE 2
#define PWM_RESOLUTION 10000
#define PWM_PERCENT(x) ( (x) * PWM_RESOLUTION / 100 )

struct distance_sensor_t {
  out port trigger;
  in port echo;
};

interface distance_sensor_i {
  unsigned read();
};

[[combinable]]
void distance_sensor(interface distance_sensor_i server i, struct distance_sensor_t &pins);

void logic(interface distance_sensor_i client left, interface distance_sensor_i client right);

int main() {
  interface distance_sensor_i front_distance, rear_distance;

  par {
    logic(front_distance, rear_distance);

    [[combine]]
    par {
      distance_sensor(front_distance);
      distance_sensor(rear_distance);
    }
  }

  return 0;
}


[[combinable]]
void distance_sensor(interface distance_sensor_i server i, struct distance_sensor_t &pins) {

  while (1) {
    select {
      case i.read() -> unsigned distance:
        distance = 0;
        break;
    }
  }

}

void logic(interface distance_sensor_i client left, interface distance_sensor_i client right) {

}
