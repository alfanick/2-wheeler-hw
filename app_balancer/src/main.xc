#include "../../platform.h"

#include "logic.h"

int main() {
  interface motors_i motors;
  interface motor_i left_motor, right_motor;

  par {
    on tile[0] : logic(motors);

    on tile[0].core[5] : motors_logic(motors, left_motor, right_motor, motors_bridge.directions);
    par {
      on tile[0].core[6] : motor(left_motor, motors_bridge.left);
      on tile[0].core[6] : motor(right_motor, motors_bridge.right);
    }
  }

  return 0;
}
