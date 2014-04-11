#include <xs1.h>
#include <platform.h>

#include <lsm303d.h>

lsm303d_t lsm303d_interface = {
  XS1_CLKBLK_1,
  XS1_CLKBLK_2,
  XS1_PORT_1I,
  XS1_PORT_1J,
  XS1_PORT_1H
};

int main() {

  par {
    lsm303d(lsm303d_interface);
  }

  return 0;
}

