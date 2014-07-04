#include "../../platform.h"

#define DEBUG_PRINT_ENABLE 1

#include <math.h>
#include <debug_print.h>
#include <startkit_adc.h>


[[combinable]]
void logic(lsm303d_client lsm, distance_sensor_client front, distance_sensor_client rear, startkit_adc_if client adc, motors_client motors, motors_status_client status);

int main() {
  interface distance_sensor_i front_distance, rear_distance;
  interface lsm303d_i motion;
  interface motors_i motors_interface;
  interface motors_status_i motors_status_interface;
  interface motor_i left_motor, right_motor;
  chan adc_chan;
  startkit_adc_if adc_i;

  par {
    on tile[0] : logic(motion, front_distance, rear_distance, adc_i, motors_interface, motors_status_interface);

    startkit_adc(adc_chan);
    on tile[0] : adc_task(adc_i, adc_chan, 0);

    on tile[0].core[6] : motors_logic(motors_interface, motors_status_interface,
                                      left_motor, right_motor,
                                      motors_bridge.directions,
                                      motors_bridge.sensors);

    par {
      on tile[0].core[6] : motor(left_motor, motors_bridge.left);
      on tile[0].core[6] : motor(right_motor, motors_bridge.right);
    }

    par {
      on tile[0].core[7] : lsm303d(motion, motion_sensor);
//      on tile[0].core[7] : distance_sensor(front_distance, distance_sensors[0]);
//      on tile[0].core[7] : distance_sensor(rear_distance, distance_sensors[1]);
    }
  }

  return 0;
}

[[combinable]]
void logic(lsm303d_client lsm, distance_sensor_client front, distance_sensor_client rear, startkit_adc_if client adc, motors_client motors, motors_status_client status) {
  timer t; unsigned time;
  vector3d acc, mag;
  unsigned short adc_val[4] = {0, 0, 0, 0};
  unsigned int battery_voltage = 0;
  unsigned int left_current = 0, right_current = 0;

  float pitch = 0.0f;

  const static int dt = 5;

  int k = 0;
//  motors.left(PWM_PERCENT(0));
// motors.right(PWM_PERCENT(90));
  t :> time;
  time += dt * XS1_TIMER_KHZ;

  t when timerafter(time) :> void;
//  motors.right(PWM_PERCENT(10));

  while (1) {
    select {
      case t when timerafter(time) :> void:
//        debug_printf("BATTERY: %dmV\n", battery_voltage);
//        debug_printf("LEFT CURRENT: %dmA\n", left_current);
//        debug_printf("RIGHT CURRENT: %dmA\n", right_current);

//        motors.right(PWM_PERCENT(10));
//        motors.right(PWM_PERCENT((k += 10) % 100));
        lsm.accelerometer_raw(acc);
        lsm.magnetometer_raw(mag);


        float angle_acc = sqrt(acc.y * acc.y + acc.x * acc.x);
        angle_acc = acc.z / angle_acc;
        angle_acc = atan(angle_acc);

        float angle_mag = sqrt(mag.y * mag.y + mag.x * mag.x);
        angle_mag = mag.z / angle_mag;
        angle_mag = -atan(angle_mag);

        pitch += angle_mag * ((float)dt / 1000.0);

        pitch = pitch * 0.85 + angle_acc * 0.15;

        if (k++ == 1000/dt) {
          debug_printf("ACC_RAW: %d %d %d\n", acc.x, acc.y, acc.z);
          debug_printf("ACC:     %d %d %d\n", acc.x, acc.y, acc.z);

          debug_printf("MAG_RAW: %d %d %d\n", mag.x, mag.y, mag.z);
          debug_printf("MAG:     %d %d %d\n", mag.x, mag.y, mag.z);

          debug_printf("AD: %d\tMD: %d\n", (int)(angle_acc * 1000.0 * 180.0 / M_PI), (int)(angle_mag * 1000.0 * 180.0 / M_PI));
          debug_printf("PITCH: %d\n", (int)(pitch * 1000.0 * 180.0 / M_PI));

          k=0;
        }

//        debug_printf("FRONT:   %d\n", front.read());
//        debug_printf("REAR:    %d\n\n", rear.read());

//        debug_printf("LEFT: %dRPM\n", motors.left_rpm());
//        debug_printf("RIGHT: %dRPM\n", motors.right_rpm());

        time += dt * XS1_TIMER_KHZ;
        break;

      case status.changed():
        int l, r;
        { l, r } = status.get();

        debug_printf("L %d R %d\n", l, r);
        break;

      case adc.complete():
        adc.read(adc_val);
        battery_voltage = adc_val[3] * 15350 / 65535;
        left_current = adc_val[0]  * 6255 / 65535;
        right_current = adc_val[1] * 6255 / 65535;
        break;
    }
  }
}
