require 'socket'

class DCHubConnection
  attr_reader :socket
  attr_accessor :logger

  def initialize(host, port, command_trigger_callback)
    @host = host
    @port = port
    @command_trigger_callback = command_trigger_callback
  end

  def connect
    @socket = TCPSocket.new(@host, @port)
    @socket.setsockopt(Socket::IPPROTO_TCP, Socket::TCP_NODELAY, 1)
  end

  def disconnect
    @socket.close
  end

  def fetch_command
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
    @logger.debug "[#{Process.pid}] GOT:#{command.to_s}" if @logger
    @command_trigger_callback.call(command)
  end

  def send_command(command)
    @logger.debug "[#{Process.pid}] SEND:#{command.to_s}" if @logger
    socket.write(command.to_s)
    socket.flush
  end
end
