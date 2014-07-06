#!/usr/bin/env ruby

require 'rubygems'
require './twowheeler.rb'

puts "Welcome to balancer console!"
print "Connecting... "
$balancer = TwoWheeler.new

puts "done."

if ARGV.size > 0 and File.exists? ARGV[0]
  print "Loading '#{ARGV[0]}'... "
  require File.absolute_path(ARGV[0])
  puts "done."
end

require 'pry'

Pry.config.history.file = "#{ENV['HOME']}/.twowheeler_history"
Pry.config.prompt = [ proc { "% " }, proc { "  " }]

open(Pry.config.history.file, 'a') do |f|
  f.puts "# TwoWheeler session on #{Time.now}"
end

$balancer.pry
