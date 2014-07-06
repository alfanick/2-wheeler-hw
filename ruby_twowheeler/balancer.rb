#!/usr/bin/env ruby

require 'rubygems'
require './twowheeler.rb'

puts "Welcome to balancer console!"
print "Connecting... "

begin
  $balancer = TwoWheeler.new
  puts "done."
rescue => e
  puts "failed (#{e.message})."

  Kernel.exit 1
end

if ARGV.size > 0
  ARGV.each do |f|
    if not File.exists? f
      f = "settings/#{f}.rb"

      next unless File.exists? f
    end

    print "Loading '#{f}'... "

    begin
      require File.absolute_path(f)
      puts "done."
    rescue => e
      puts "failed (#{e.message})."
    end
  end
end

require 'pry'

Pry.config.history.file = "#{ENV['HOME']}/.twowheeler_history"
Pry.config.prompt = [ proc { "% " }, proc { "  " }]

open(Pry.config.history.file, 'a') do |f|
  f.puts "# TwoWheeler session on #{Time.now}"
end

$balancer.pry
