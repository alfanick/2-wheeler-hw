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
| ALP?        | get current low pass coeff     |
| ALP=a       | set angle low pass coefficient |
| S           | starts balancing               |
| X           | stop balancing                 |
| VER?        | get firmware version           |
| LOOPTIME?   | get last loop execution time   |
| LOOPDELAY?  | get loop delay                 |
| LOOPDELAY=t | set loop delay                 |


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
| ALP=a       | current angle low pass coeff   |
| VER=v       | firmware git commit id         |
| LOOPTIME=v  | last loop execution time in ms |
| LOOPDELAY=t | current loop delay in ms       |
