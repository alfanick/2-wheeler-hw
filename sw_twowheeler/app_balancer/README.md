# TwoWheeler

## Commands

This is glossary of commands accepted and returned by TwoWheeler.
Every command must be ended with carriage return character to be
read.


### Requests

|   Command   |          Description           |
| ----------- | ------------------------------ |
| FLASH       | next cmd will use flash memory |
| V?          | get battery voltage            |
| PID?        | get current PID coefficients   |
| PID=p,i,d   | set PID coefficients           |
| PIDLP?      | get current PID lowpass coeff  |
| PIDLP=a     | set PID lowpass coefficient    |
| RPM?        | get RPM of motors              |
| T?          | get target angle               |
| T=a         | set target angle               |
| T           | set current angle as target    |
| A?          | get current pitch angle        |
| ALP?        | get current low pass coeff     |
| ALP=a       | set angle low pass coefficient |
| C?          | get motors current             |
| S           | starts balancing               |
| X           | stop balancing                 |
| VER?        | get firmware version           |
| LOOPTIME?   | get last loop execution time   |
| LOOPDELAY?  | get loop delay                 |
| LOOPDELAY=t | set loop delay                 |
| SB?         | get speed boost                |
| SB=a        | set speed boost                |
| ST?         | get speed threshold            |
| ST=a        | set speed threshold            |

#### FLASH command

Lorem ipsum

### Replies

|   Command   |          Description           |
| ----------- | ------------------------------ |
| OK          | default command acknowledge    |
| ERROR       | malformed command              |
| V=n         | battery voltage in mV          |
| PID=p,i,d   | current PID coefficients       |
| PIDLP=a     | current PID lowpass coefficient|
| RPM=l,r     | current motor RPM              |
| C=l,r       | motors current                 |
| T=a         | current target angle           |
| A=a         | current pitch angle            |
| ALP=a       | current angle low pass coeff   |
| VER=v       | firmware git commit id         |
| LOOPTIME=v  | last loop execution time in ms |
| LOOPDELAY=t | current loop delay in ms       |
| SB=a        | current speed boost            |
| ST=a        | current speed threshold        |
