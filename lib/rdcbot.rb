require 'lib/dc_command_builder'
require 'lib/dc_hub_connection'

class RDCbot
  attr_accessor :client
  attr_accessor :version
  attr_accessor :share_size
  attr_accessor :hub_name

  attr_accessor :nickname
  attr_accessor :description
  attr_accessor :host
  attr_accessor :port
  attr_accessor :email

  attr_accessor :callbacks

  attr_accessor :reconnect_timeout

  # constructor
  def initialize
    @client = 'rubyDC++bot'
    @version = '0.01'
    @share_size = 4073741824

    @logged_in = false
    @listener = nil

    @hub = nil

    @reconnect_timeout = 2

    @callbacks = {}

    add_callback(DCLockCommand, lambda {|command|
      # handshake
      send(DCSupportsCommand.new('HubTopic'))
      send(DCKeyCommand.new(command.key))
      send(DCValidateNickCommand.new(@nickname))
    })
    add_callback(DCHelloCommand, lambda {|command|
      # login
      return unless !logged_in? && command.data == @nickname
      send(DCVersionCommand.new)
      send(DCGetNickListCommand.new)
      send(DCMyINFOCommand.new(@nickname, @description, @client, @version, @share_size, @email))
    })
    add_callback(DCValidateDenideCommand, lambda {|command|
      # reconnect in 5 seconds
      sleep(@reconnect_timeout)
      connect
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
    connect
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
    send(DCSayCommand.new(@nickname, message))
  end

  # sends command to hub
  def send(command)
    @hub.send_command(command)
  end

  private
  # init DCHubConnection
  def connect
    if @hub
      @hub.disconnect
    end
    @hub = DCHubConnection.new(@host, @port, method(:fire))
    @hub.connect
  end
end
