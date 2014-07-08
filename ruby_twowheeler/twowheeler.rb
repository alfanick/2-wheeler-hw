require 'rubygems'
require 'serialport'

class TwoWheeler
  def github
    "https://github.com/alfanick/2-wheeler-hw/commit/#{version}"
  end

  def battery
    v / 1000.0
  end

  def motors_current
    c?.map{|a| a/1000.0}
  end

  def motors_rpm
    rpm?
  end

  def pid
    pid?.map{|a| a/1000.0}
  end

  def pid=(c)
    method_missing('pid=', c.map{|a| Integer(a*1000.0)})
  end

  def target
    t? / 1000.0
  end

  def loop_time
    looptime? / 100000000.0
  end

  def loop_delay
    loopdelay? / 1000.0
  end

  def loop_delay=(t)
    method_missing('loopdelay=', Integer(t * 1000.0))
  end

  def target=(a)
    method_missing('t=', Integer(a * 1000.0) )
  end

  def angle_lowpass
    alp? / 1000.0
  end

  def angle_lowpass_delay
    0.001 / angle_lowpass - 0.001
  end

  def angle_lowpass_delay=(d)
    self.angle_lowpass = 0.001 / (d + 0.001)
  end

  def angle_lowpass_cutoff
    1.0/(2*Math::PI*angle_lowpass_delay)
  end

  def angle_lowpass_cutoff=(f)
    self.angle_lowpass_delay = 1.0/(2*Math::PI*f)
  end

  def angle_lowpass=(a)
    self.alp = Integer(a * 1000.0)
  end

  def angle
    a? / 1000.0
  end

  def tilt
    angle
  end

  def pitch
    angle
  end

  def initialize(path="/dev/tty.TwoWheeler-SPP")
    @serial_port = SerialPort.new("/dev/tty.TwoWheeler-SPP",
                                  9600, 8, 1, SerialPort::NONE)

    10.times do
      @serial_port.write("\r")
      sleep 0.25
    end
    @serial_port.flush_input
    @serial_port.flush_output
    @tw = self
    @balancer = self
    @twowheeler = self
  end

  attr_accessor :tw, :balancer, :twowheeler

  def method_missing(name, *args)
    name = name.to_s
    name = ALIASES[name] if ALIASES.include? name

    @serial_port.write create_command(name, args=args)

    parse_response @serial_port.readline("\r").rstrip
  end

  private

  ALIASES = {
    'balance!'         => 's!',
    'balance'          => 's!',
    'start'            => 's!',
    'stop'             => 'x!',
    'stop!'            => 'x!',
    'calibrate!'       => 't!',
    'firmware'         => 'ver?',
    'version'          => 'ver?',
    'speed_boost'      => 'sb?',
    'speed_boost='     => 'sb=',
    'speed_threshold'  => 'st?',
    'speed_threshold=' => 'st=',
    'motors_boost'     => 'sb?',
    'motors_boost='    => 'sb=',
    'motors_threshold' => 'st?',
    'motors_threshold='=> 'st='
  }

  def create_command(name, args)
    command = ''
    name.upcase!

    if name[-1] == '!'
      command = name
    elsif name[-1] == '='
      command = name + args.join(',')
    else
      name += '?' unless name[-1] == '?'
      command = name
    end

    command + "\r"
  end

  def parse_response(response)
    if response == "OK"
      return true
    elsif response == "ERROR"
      return false
    else
      args = /^.*?=(.*)/.match(response)[1]
      args = args.split(',').map do |a|
        a.to_i if !!Integer(a) rescue a
      end

      args.size == 1 ? args[0] : args
    end
  end
end

