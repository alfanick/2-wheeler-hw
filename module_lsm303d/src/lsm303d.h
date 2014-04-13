#ifndef ALJ_LSM303D_H
#define ALJ_LSM303D_H

#include <i2c.h>

#ifndef LSM303D_ADDRESS
#define LSM303D_ADDRESS 0b0011101
#endif

typedef r_i2c lsm303d_t;


typedef struct vector3d {
  short x;
  short y;
  short z;
} vector3d;

interface lsm303d_i {
  void accelerometer_raw(vector3d &v);
  void accelerometer(vector3d &v);

  void magnetometer_raw(vector3d &v);
  void magnetometer(vector3d &v);
};

typedef interface lsm303d_i client lsm303d_client;

void lsm303d_init(lsm303d_t &pin);
inline void lsm303d_read_vector(lsm303d_t &pin, unsigned char reg, vector3d &v);

inline void lsm303d_read_accelerometer(lsm303d_t &pin, vector3d &v);
inline void lsm303d_read_magnetometer(lsm303d_t &pin, vector3d &v);

void lsm303d(interface lsm303d_i server i, lsm303d_t &pin);

#endif
