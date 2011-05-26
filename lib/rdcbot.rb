require 'lib/dc_command_builder'
require 'lib/dc_hub_connection'

class RDCbot
  attr_accessor :bot_name
  attr_accessor :bot_version
  attr_accessor :share_size
  attr_accessor :hub_name
  attr_accessor :email

  attr_accessor :callbacks

  # constructor
  def initialize(nickname, host, port)
    @nickname = nickname
    @host = host
    @port = port

    @bot_name = 'rubyDC++bot'
    @bot_version = '0.01'
    @share_size = 4073741824
    @email = 'takandar@gmail.com'

    @logged_in = false
    @listener = true

    @callbacks = {}

    add_callback(DCLockCommand, lambda {|command|
      # handshake
      @hub.send_command(DCSupportsCommand.new('HubTopic'))
      @hub.send_command(DCKeyCommand.new(command.key))
      @hub.send_command(DCValidateNickCommand.new(@nickname))
    })
    add_callback(DCHelloCommand, lambda {|command|
      # login
      return unless !logged_in? && command.data == @nickname
      @hub.send_command(DCVersionCommand.new)
      @hub.send_command(DCGetNickListCommand.new)
      @hub.send_command(DCMyINFOCommand.new(@nickname, @bot_name, @bot_version, @share_size, @email))
    })
    add_callback(DCValidateDenideCommand, lambda {|command|
      # shutdown
      listener = @listener
      @listener = nil
      listener.kill
    })
    add_callback(DCNickListCommand, lambda {|command|
      # final login step
      @logged_in = true
    })
  end

  # adds callback for command
  def add_callback(command_class, callback)
    @callbacks[command_class] = [] unless @callbacks.include?(command_class)
    @callbacks[command_class] << callback
  end

  # sepate thread for DCHub listening
  def start
    @hub = DCHubConnection.new(@host, @port, method(:fire))
    @hub.connect
    @listener = Thread.new do
      while true
        begin
          @hub.fetch_command

        rescue Exception => e
          exit if e.class == Interrupt
          puts e.message
          puts e.backtrace.join("\n")
        end
      end
    end
  end

  # is bot alive?
  def alive?
    @listener != nil
  end

  # is bot loged in?
  def logged_in?
    @logged_in
  end

  # callback for received commands
  def fire(command)
    return unless @callbacks.include?(command.class)
    @callbacks[command.class].each do |callback|
      callback.call(command)
    end
  end

  # send message to hub
  def say(message)
    @hub.send_command(DCSayCommand.new(@nickname, message))
  end
end
