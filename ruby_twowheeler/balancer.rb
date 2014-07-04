#!/usr/bin/env ruby

require 'rubygems'
require 'pry'

Pry.config.history.file = "#{ENV['HOME']}/.twowheeler_history"
Pry.config.prompt = [ proc { "% " }, proc { "  " }]

open(Pry.config.history.file, 'a') do |f|
  f.puts "# TwoWheeler session on #{Time.now}"
end

require './twowheeler.rb'

puts "Welcome to balancer console!"
print "Connecting... "
balancer = TwoWheeler.new

puts "done."

balancer.balance!

balancer.pry
