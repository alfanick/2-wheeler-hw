# TwoWheeler API & CLI
This is simple API in Ruby for TwoWheeler and command line interface build upon
this API. Communication is done over Bluetooth using command set
[implemented on balancer](../sw_twowheeler/app_balancer/README.md)
itself.

Just to make a note - Ruby is executed on your computer, balancer
accepts only simple command set. Balancing and other actions are
computed inside XMOS, not on the computer. Balancer will work just fine
without API/CLI using parameters hardcoded in firmware. Yet you can
use basic command set without API by connecting directly using Bluetooth
serial port.

## Command Line Interface

Lorem ipsum

## API (twowheeler.rb)

Lorem ipsum
