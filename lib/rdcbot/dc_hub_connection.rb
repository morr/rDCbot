require 'socket'

class DCHubConnection
  attr_reader :socket
  attr_accessor :logger

  attr_reader :recv_timeout

  def initialize(host, port, command_trigger_callback)
    @host = host
    @port = port
    @command_trigger_callback = command_trigger_callback
    @recv_timeout = 60
  end

  def connect
    @socket = TCPSocket.new(Socket.getaddrinfo(@host, nil)[0][2], @port)
    @socket.setsockopt(Socket::IPPROTO_TCP, Socket::TCP_NODELAY, 1)
  end

  def disconnect
    @socket.close
  end

  def fetch_command
    text = ""
    receiving = true
    while receiving
      r, w, e = IO.select([@socket], nil, nil, @recv_timeout)
      unless r
        return false
      end
      data = r[0].recv(1)
      #print data

      data.each_char do |v|
        if v == '|'
          #print '\n'
          receiving = false
          break
        end
        text += v
      end
    end
    command = DCCommandBuilder.build(text)
    @logger.debug "GOT:#{command.to_s}" if @logger
    @command_trigger_callback.call(command)
    true
  end

  def send_command(command)
    @logger.debug "SEND:#{command.to_s}" if @logger
    socket.write(command.to_s)
    socket.flush
  end
end
