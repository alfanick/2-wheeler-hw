#include "../../platform.h"

#define DEBUG_PRINT_ENABLE 1

#include <math.h>
#include <debug_print.h>
#include <startkit_adc.h>


[[combinable]]
void logic(imu10_client lsm, distance_sensor_client front, distance_sensor_client rear, startkit_adc_if client adc, motors_client motors, motors_status_client status);

int main() {
  interface distance_sensor_i front_distance, rear_distance;
  interface imu10_i motion;
  interface motors_i motors_interface;
  interface motors_status_i motors_status_interface;
  interface motor_i left_motor, right_motor;
  chan adc_chan;
  startkit_adc_if adc_i;

  par {
    on tile[0] : logic(motion, front_distance, rear_distance, adc_i, motors_interface, motors_status_interface);

    startkit_adc(adc_chan);
    on tile[0] : adc_task(adc_i, adc_chan, 0);

    /* on tile[0].core[6] : motors_logic(motors_interface, motors_status_interface, */
                                      /* left_motor, right_motor, */
                                      /* motors_bridge.directions, */
                                      /* motors_bridge.sensors); */

    /* par { */
      /* on tile[0].core[6] : motor(left_motor, motors_bridge.left); */
      /* on tile[0].core[6] : motor(right_motor, motors_bridge.right); */
    /* } */

    par {
      on tile[0].core[7] : imu10(motion, motion_sensor);
//      on tile[0].core[7] : distance_sensor(front_distance, distance_sensors[0]);
//      on tile[0].core[7] : distance_sensor(rear_distance, distance_sensors[1]);
    }
  }

  return 0;
}

[[combinable]]
void logic(imu10_client lsm, distance_sensor_client front, distance_sensor_client rear, startkit_adc_if client adc, motors_client motors, motors_status_client status) {
  timer t; unsigned time;
  vector3d acc, mag, gyro;
  unsigned short adc_val[4] = {0, 0, 0, 0};
  unsigned int battery_voltage = 0;
  unsigned int left_current = 0, right_current = 0;

  float pitch = 0.0f;
  float p, ap, gp;

  const static int dt = 10;

  int k = 0;

  debug_printf("acc,gyro,kalman\n");

  t :> time;
  time += 1000 * XS1_TIMER_KHZ;

  t when timerafter(time) :> void;

  while (1) {
    select {
      case t when timerafter(time) :> void:
        /* lsm.accelerometer_raw(acc); */
        /* lsm.magnetometer_raw(mag); */
        lsm.gyroscope_raw(gyro);

        if (k++ == 1000/(dt*10)) {
          /* debug_printf("ACC_RAW: %d %d %d\n", acc.x, acc.y, acc.z); */
          /* debug_printf("MAG_RAW: %d %d %d\n", mag.x, mag.y, mag.z); */
          /* debug_printf("GYRO_RAW: %d %d %d\n", gyro.x, gyro.y, gyro.z); */
          /* debug_printf("%d,%d,%d\n", gyro.x, gyro.y, gyro.z); */

          /* debug_printf("a\n"); */

          ap = lsm.accelerometer_pitch();
          gp = lsm.gyroscope_pitch();
          p = lsm.get_pitch();
          /* ap = 0; */
          /* gp = 0; */
          /* p = 0; */

          /* debug_printf("a\n"); */
          /* debug_printf("%d,%d,%d\n",  (int)(lsm.accelerometer_pitch() * 1000), (int)(lsm.gyroscope_pitch() * 1000), (int)(lsm.get_pitch()*1000)); */
          debug_printf("%d,%d,%d,%d\n",  (int)(ap * 1000), (int)(gyro.x * 17.50 / 1000.0), (int)(p*1000), (int)(p * 180.0 / M_PI));


          /* debug_printf("ACC_ANGLE: %d\n", (int)(angle_acc * 1000.0 * 180.0 / M_PI)); */
          /* debug_printf("GYRO_ANGLE: %d\n", (int)(angle_gyro * 1000.0 * 180.0 / M_PI)); */

          /* debug_printf("PITCH: %d\n\n", (int)(pitch * 1000.0 * 180.0 / M_PI)); */

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
