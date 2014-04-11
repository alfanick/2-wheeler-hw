#ifndef ALJ_LSM303D_H
#define ALJ_LSM303D_H

#include <spi_master.h>

typedef spi_master_interface lsm303d_t;

void lsm303d(lsm303d_t &pin);

#endif
