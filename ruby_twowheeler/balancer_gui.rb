#!/usr/bin/env ruby

require 'Qt'

class BalancerGUI < Qt::Widget
  def initialize
    super

    setWindowTitle "Foobar"

    initialize_ui

    resize 800, 600

    show
  end

  def initialize_ui
    hbox = Qt::HBoxLayout.new(self)

    vbox1 = Qt::VBoxLayout.new(self)

    vbox11 = Qt::VBoxLayout.new(self)
    vbox11.addWidget Qt::Label.new('Proportional', self)
    p_dial = Qt::Dial.new(self)
    p_dial.notchesVisible = true
    vbox11.addWidget p_dial, 0, Qt::AlignTop
    vbox1.addLayout vbox11

    vbox12 = Qt::VBoxLayout.new(self)
    vbox12.addWidget Qt::Label.new('Integral', self)
    i_dial = Qt::Dial.new(self)
    i_dial.notchesVisible = true
    vbox12.addWidget i_dial, 0, Qt::AlignTop
    vbox1.addLayout vbox12

    d_dial = Qt::Dial.new(self)
    vbox1.addWidget d_dial
    hbox.addLayout vbox1, 0

    vbox2 = Qt::VBoxLayout.new(self)
    battery_level = Qt::ProgressBar.new(self)
    battery_level.maximum = 100
    battery_level.minimum = 0
    battery_level.value = 89.4
    vbox2.addWidget battery_level
    hbox.addLayout vbox2, 1

    setLayout hbox
  end
end

app = Qt::Application.new(ARGV)
BalancerGUI.new
app.exec
