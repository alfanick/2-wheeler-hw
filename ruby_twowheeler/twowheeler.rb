require 'rubygems'
require 'serialport'
require 'awesome_print'

class TwoWheeler

  def battery
    v / 1000.0
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

  def looptime
    looptime? / 100000000.0
  end

  def target=(a)
    method_missing('t=', Integer(a * 1000.0) )
  end

  def angle_lowpass
    alp? / 1000.0
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
  end

  def method_missing(name, *args)
    name = name.to_s
    name = ALIASES[name] if ALIASES.include? name

    @serial_port.write create_command(name, args=args)

    parse_response @serial_port.readline("\r").rstrip
  end

  private

  ALIASES = {
    'balance!'    => 's!',
    'stop!'       => 'x!',
    'calibrate!'  => 't!',
    'firmware'    => 'ver?',
    'version'     => 'ver?'
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

