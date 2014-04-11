#include "lsm303d.h"

#include <print.h>

void lsm303d(lsm303d_t &pin) {
  spi_master_init(pin, 80);
  printstrln("lsm init");

  const unsigned char buffer[] = {0x00, 0x00, 0x00};

  // enable temperature sensor
  //spi_master_out_byte(pin, 0x22 | (1 << 8));
  printuintln(spi_master_in_byte(pin));

  /*while (1) {
    spi_master_out_buffer(pin, buffer, 3);
  }*/
}
