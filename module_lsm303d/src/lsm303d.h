#ifndef ALJ_LSM303D_H
#define ALJ_LSM303D_H

#include <i2c.h>

#ifndef LSM303D_ADDRESS
#define LSM303D_ADDRESS 0b0011101
#endif

typedef r_i2c lsm303d_t;

void lsm303d(lsm303d_t &pin);

typedef struct vector3d {
  short x;
  short y;
  short z;
} vector3d;

interface lsm303d_i {
  vector3d last_accelerometer();
  vector3d average_accelerometer();
  vector3d accelerometer();

  vector3d last_magnetometer();
  vector3d average_magnetometer();
  vector3d magnetometer();
};

void lsm303d_init(lsm303d_t &pin);
inline void lsm303d_read_vector(lsm303d_t &pin, unsigned char reg, vector3d &v);

inline void lsm303d_read_accelerometer(lsm303d_t &pin, vector3d &v);
inline void lsm303d_read_magnetometer(lsm303d_t &pin, vector3d &v);

#endif
