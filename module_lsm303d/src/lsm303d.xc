#include "lsm303d.h"

#include <print.h>

void lsm303d(lsm303d_t &pin) {
  spi_master_init(pin, 80);
  printstrln("lsm init");

  const unsigned char buffer[] = {0x00, 0x00, 0x00};

  while (1) {
    spi_master_out_buffer(pin, buffer, 3);
  }
}
