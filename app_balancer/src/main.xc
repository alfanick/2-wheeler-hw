#include "../../platform.h"

#include "logic.h"

int main() {
  interface motors_i motors;
  interface motor_i left_motor, right_motor;

  par {
    on tile[0] : logic(motors);

    // Balancing and motors control
    // balancer_pid(balancer, motion, motors);

    // Distance sensing, battery level monitor, motors current, motors status
    // balancer_safety(balancer, front, rear, adc, motors);

    // Reacting to commands from bluetooth (on/off, front/back, left/right, status)
    // balancer_communication(balancer, bluetooth);

    on tile[0].core[5] : motors_logic(motors, left_motor, right_motor, motors_bridge.directions);
    par {
      on tile[0].core[6] : motor(left_motor, motors_bridge.left);
      on tile[0].core[6] : motor(right_motor, motors_bridge.right);
    }
  }

  return 0;
}
