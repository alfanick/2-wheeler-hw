#!/usr/bin/env ruby

require 'rubygems'
require 'pry'

Pry.config.auditlog_enabled = true
Pry.config.auditlog_file = "#{ENV['HOME']}/.twowheeler_history"
require 'pry-auditlog'
Pry.config.prompt = [ proc { "% " }, proc { "  " }]


require './twowheeler.rb'

puts "Welcome to balancer console!"
print "Connecting... "
balancer = TwoWheeler.new

puts "done."

balancer.balance!

balancer.pry
