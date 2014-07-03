# TwoWheeler

## Commands

This is glossary of commands accepted and returned by TwoWheeler.
Every command must be ended with carriage return character to be
read.


### Requests

|   Command   |          Description           |
| ----------- | ------------------------------ |
| V?          | get battery voltage            |
| PID?        | get current PID coefficients   |
| PID=p,i,d   | set PID coefficients           |
| RPM?        | get RPM of motors              |
| T?          | get target angle               |
| T=a         | set target angle               |
| T           | set current angle as target    |
| A?          | get current pitch angle        |
| S           | starts balancing               |
| X           | stop balancing                 |
| VER?        | get firmware version           |


### Replies

|   Command   |          Description           |
| ----------- | ------------------------------ |
| OK          | default command acknowledge    |
| ERROR       | malformed command              |
| V=n         | battery voltage in mV          |
| PID=p,i,d   | current PID coefficients       |
| RPM=l,r     | current motor RPM              |
| T=a         | current target angle           |
| A=a         | current pitch angle            |
| VER=v       | firmware git commit id         |
