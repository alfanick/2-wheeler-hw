#include "../../platform.h"

#include <startkit_adc.h>

#include "balancer.h"
#include "pid.h"
#include "safety.h"
#include "communication.h"

int main() {
  interface distance_sensor_i front, rear;
  interface lsm303d_i motion;
  interface motors_i motors;
  interface motors_status_i motors_status;
  interface motor_i left_motor, right_motor;
  interface balancer_i balancer[2];
  interface bluetooth_i bluetooth;
  startkit_adc_if adc;
  chan adc_chan;

  par {
    // Balancing and motors control
    on tile[0] : balancer_pid(balancer, motion, motors);

    // Distance sensing, battery level monitor, motors current, motors status
    on tile[0] : balancer_safety(balancer[0], front, rear, adc, motors_status);

    // Reacting to commands from bluetooth (on/off, front/back, left/right, status)
    on tile[0] : balancer_communication(balancer[1], bluetooth);

    startkit_adc(adc_chan);
    on tile[0] : adc_task(adc, adc_chan, 0);

    on tile[0].core[6] : motors_logic(motors, motors_status, left_motor, right_motor, motors_bridge.directions, motors_bridge.sensors);
    on tile[0].core[6] : motor(left_motor, motors_bridge.left);
    on tile[0].core[6] : motor(right_motor, motors_bridge.right);

    on tile[0].core[7] : lsm303d(motion, motion_sensor);
    on tile[0].core[7] : distance_sensor(front, distance_sensors[0]);
    on tile[0].core[7] : distance_sensor(rear, distance_sensors[1]);
    // motion
  }

  return 0;
}
