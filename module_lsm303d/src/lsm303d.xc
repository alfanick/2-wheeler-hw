#include "lsm303d.h"

#define MIN(a,b) ((b) ^ (((a) ^ (b)) & -((a) < (b))))
#define MAX(a,b) ((a) ^ (((a) ^ (b)) & -((a) < (b))))

void lsm303d_init(lsm303d_t &pin) {
  unsigned char data[1];
  i2c_master_init(pin);

  // enable acc
  data[0] = 0b10100111;
  i2c_master_write_reg(LSM303D_ADDRESS, 0x20, data, 1, pin);

  // acc = 2g
  data[0] = 0b00000000;
  i2c_master_write_reg(LSM303D_ADDRESS, 0x21, data, 1, pin);

  // temp and high res
  data[0] = 0b11110100;
  i2c_master_write_reg(LSM303D_ADDRESS, 0x24, data, 1, pin);

  // mag = 8g
  data[0] = 0b01000000;
  i2c_master_write_reg(LSM303D_ADDRESS, 0x25, data, 1, pin);

  // enable mag
  data[0] = 0b00100000;
  i2c_master_write_reg(LSM303D_ADDRESS, 0x26, data, 1, pin);

}

inline void lsm303d_read_vector(lsm303d_t &pin, unsigned char reg, vector3d &v) {
  unsigned char data[6];
  i2c_master_read_reg(LSM303D_ADDRESS, reg | (1 << 7), data, 6, pin);

  v.x = data[1] << 8 | data[0];
  v.y = data[3] << 8 | data[2];
  v.z = data[5] << 8 | data[4];
}

inline void lsm303d_read_accelerometer(lsm303d_t &pin, vector3d &v) {
  lsm303d_read_vector(pin, 0x28, v);
}

inline void lsm303d_read_magnetometer(lsm303d_t &pin, vector3d &v) {
  lsm303d_read_vector(pin, 0x08, v);
}

inline int median(int a, int b, int c) {
  return a ^ b ^ c ^ MAX(MAX(a, b), c) ^ MIN(MIN(a, b), c);
}

inline vector3d median_vector3d(vector3d a, vector3d b, vector3d c) {
  vector3d v;

  v.x = median(a.x, b.x, c.x);
  v.y = median(a.y, b.y, c.y);
  v.z = median(a.z, b.z, c.z);

  return v;
}

[[combinable]]
void lsm303d(interface lsm303d_i server i, lsm303d_t &pin) {
  unsigned time;
  timer t;

  vector3d acc_buffer[3], mag_buffer[3];
  unsigned acc_position = 0, mag_position = 0;

  lsm303d_init(pin);
  t :> time;

  while (1) {
    select {
      case i.accelerometer_raw(vector3d &v):
        v = acc_buffer[acc_position];
        break;
      case i.accelerometer(vector3d &v):
        v = median_vector3d(acc_buffer[0], acc_buffer[1], acc_buffer[2]);
        break;
      case i.magnetometer_raw(vector3d &v):
        v = mag_buffer[mag_position];
        break;
      case i.magnetometer(vector3d &v):
        v = median_vector3d(mag_buffer[0], mag_buffer[1], mag_buffer[2]);
        break;

      case t when timerafter(time) :> void:
        time += 100 * XS1_TIMER_KHZ;

        lsm303d_read_accelerometer(pin, acc_buffer[acc_position++]);
        lsm303d_read_magnetometer(pin, mag_buffer[mag_position++]);

        acc_position %= 3;
        mag_position %= 3;

        break;
    }
  }

}
