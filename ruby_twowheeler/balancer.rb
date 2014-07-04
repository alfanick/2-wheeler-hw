#!/usr/bin/env ruby

require 'rubygems'
require 'pry'
Pry.config.prompt = [ proc { "% " }, proc { "  " }]


require './twowheeler.rb'

balancer = TwoWheeler.new
tw = balancer

balancer.balance!

binding.pry
