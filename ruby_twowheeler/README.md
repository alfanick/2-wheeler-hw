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

CLI is based on Pry - great Ruby console. You need pry and awesome_print gems to run CLI (and serialport as requirment of API). 

CLI works inside API - every command available in API (documented below)
is available in console. As in API, you can use helper commands or
directly raw balancer commands (they are translated from Ruby to text).

You still can enjoy power of Ruby language - console just works inside
TwoWheeler context instead of default context, so every Ruby feature is
available to you.

TODO: Write about twowheeler/tw/balancer/$balancer

## API (twowheeler.rb)

Lorem ipsum
