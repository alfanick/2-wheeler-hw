# TwoWheeler
TwoWheeler is Self Balancing Robot implemented using [XMOS startKIT](http://www.xmos.com/startkit) platform.

The robot is solving physical problem of inverted pendulum using PID regulator connecting motors with accelerometer. However its hardware design has much more features:
* 8 core 32-bit microcontroller
* bluetooth transceiver
* two distance meters
* motor driver with current sensing
* buck converter designed for use with LiPo battery
* battery voltage monitoring
* Over-The-Air parameters programming to built-in flash
* high torque motors with encoders

## Parts

* XMOS firmware - more in [balancer README](sw_twowheeler/app_balancer/README.md)
* computer app - API available in Ruby and console command interface with scripting (more in [documentation](ruby_twowheeler/README.md))
* circuit schematic and PCB design
* hardware design - not yet documented

## Authors

* Amadeusz Juskowiak - amadeusz@me.com
* Piotr Żurkowski  - kareth92@gmail.com

Inspired by Embedded Systems course at Poznan University of
Technology.



## License

*Copyright 2014 Amadeusz Juskowiak*

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
