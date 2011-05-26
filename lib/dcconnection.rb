require 'socket'
require 'lib/dccommand'

class DCConnection
  attr_reader :socket

  def initialize(host, port)
    @host = host
    @port = port
  end

  def connect
    @socket = TCPSocket.new(@host, @port)
    @socket.setsockopt(Socket::IPPROTO_TCP, Socket::TCP_NODELAY, 1)
    lock = get_command
    key = generate_key(lock.data.split(' ')[0])
    send_command(DCCommand.new('Supports', 'HubTopic'))
    send_command(DCCommand.new('Key', key))
    send_command(DCCommand.new('ValidateNick', 'TestBot'))
  end

  def get_command
    text = ""
    receiving = true
    while receiving
      data = socket.recv(1)

      data.each_char do |v|
        if v == '|'
          receiving = false
          break
        end
        text += v
      end
    end
    command = DCCommand.new(text)
    puts "GOT:#{command.to_s}"
    command
  end

  def send_command(command)
    puts "SEND:#{command.to_s}"
    socket.write(command.to_s)
    socket.flush
  end

  # By C Erler with suggestions by Robert Klemme.
  # Took the way of combining neighboring characters from the Python code.
  def generate_key(lock)
    # We need a String of at least two bytes.
    raise TypeError, "cannot convert #{lock.class} into String", caller unless lock.respond_to? :to_str
    lock = lock.to_str
    return '' unless lock.length >= 2

    # Transform the input bytes.
    result = Array.new(lock.length) { |i| lock[i - 1] ^ lock[i] }
    result[0] ^= lock[-2] ^ 5

    result.map! do |value|
      # Rotate each byte by four bits.
      value = ((value << 4) | (value >> 4)) & 0b11111111

      # Put the output in the correct format.
      case value
        when 0, 5, 36, 96, 124, 126
          '/%%DCN%03d%%/' % value
        else
          value.chr
      end
    end

    # Combine the parts into the resultant string.
    result.join
  end
end
