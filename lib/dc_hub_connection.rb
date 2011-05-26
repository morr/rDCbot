require 'socket'

class DCHubConnection
  attr_reader :socket

  def initialize(host, port)
    @host = host
    @port = port
  end

  def connect
    @socket = TCPSocket.new(@host, @port)
    @socket.setsockopt(Socket::IPPROTO_TCP, Socket::TCP_NODELAY, 1)
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
    command = DCCommandBuilder.build(text)
    puts "GOT:#{command.to_s}"
    command
  end

  def send_command(command)
    puts "SEND:#{command.to_s}"
    socket.write(command.to_s)
    socket.flush
  end
end
