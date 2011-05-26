require 'lib/dcconnection'

class RDCbot
  def initialize(host, port)
    @hub = DCConnection.new(host, port)
    @hub.connect
  end

  def listen
    while true
      command = @hub.get_command
      case command.name
        when 'Hello'

        else
          
      end
    end
  end
end
