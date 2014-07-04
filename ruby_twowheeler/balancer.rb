require 'rubygems'
require 'pry'
require './twowheeler.rb'

balancer = TwoWheeler.new
tw = balancer

balancer.balance!

binding.pry
