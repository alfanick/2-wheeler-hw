#include "lsm303d.h"

#include <print.h>

void lsm303d(lsm303d_t &pin) {
  i2c_master_init(pin);
  printstrln("lsm init");

  unsigned char data[6];

  // enable acc
  data[0] = 0b10100111;
  i2c_master_write_reg(0b0011101, 0x20, data, 1, pin);

  // acc = 8g
  data[0] = 0b00011000;
  i2c_master_write_reg(0b0011101, 0x21, data, 1, pin);

  // temp and high res
  data[0] = 0b11110100;
  i2c_master_write_reg(0b0011101, 0x24, data, 1, pin);

  // mag = 8g
  data[0] = 0b01000000;
  i2c_master_write_reg(0b0011101, 0x25, data, 1, pin);

  // enable mag
  data[0] = 0b00000000;
  i2c_master_write_reg(0b0011101, 0x26, data, 1, pin);

  while (1) {
    do {
      data[0] = i2c_master_read_reg(0b0011101, 0x27, data, 1, pin);
    } while ((data[0] & (0b00000111)) == 0);

    i2c_master_read_reg(0b0011101, 0x28 | (1 << 7), data, 6, pin);

    short x, y, z;

    x = ((data[1] << 8 | data[0]));
    y = ((data[3] << 8 | data[2]));
    z = ((data[5] << 8 | data[4]));

    printstrln("ACC:");
    printintln(x);
    printintln(y);
    printintln(z);

    do {
      data[0] = i2c_master_read_reg(0b0011101, 0x07, data, 1, pin);
    } while ((data[0] & (0b00000111)) == 0);

    i2c_master_read_reg(0b0011101, 0x08 | (1 << 7), data, 6, pin);

    short mx, my, mz;

    mx = ((data[1] << 8 | data[0]));
    my = ((data[3] << 8 | data[2]));
    mz = ((data[5] << 8 | data[4]));

    printstrln("MAG:");
    printintln(mx);
    printintln(my);
    printintln(mz);
    printstrln("");
  }
}
