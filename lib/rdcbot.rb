require 'lib/dc_command_builder'
require 'lib/dc_hub_connection'

class RDCbot
  attr_accessor :bot_name
  attr_accessor :bot_version
  attr_accessor :share_size
  attr_accessor :hub_name
  attr_accessor :email

  def initialize(nickname, host, port)
    @nickname = nickname
    @hub = DCHubConnection.new(host, port)
    @hub.connect

    @bot_name = 'rubyDC++bot'
    @bot_version = '0.01'
    @share_size = 4073741824
    @email = 'takandar@gmail.com'
  end

  def listen
    while true
      command = @hub.get_command

      case command.name
        # first response from hub
        when DCLockCommand.type
          @hub.send_command(DCSupportsCommand.new('HubTopic'))
          @hub.send_command(DCKeyCommand.new(command.key))
          @hub.send_command(DCValidateNickCommand.new(@nickname))

        when DCHelloCommand.type
          # entering the hub
          if command.data == @nickname
            @hub.send_command(DCVersionCommand.new)
            @hub.send_command(DCGetNickListCommand.new)
            @hub.send_command(DCMyINFOCommand.new(@nickname, @bot_name, @bot_version, @share_size, @email))

          else
            #puts ">unknown command: %s" % command.to_s
          end

        else
          #puts ">unknown command: %s" % command.to_s
      end
    end
  end
end

