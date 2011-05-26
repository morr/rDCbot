require 'lib/dc_commands/dc_command'

class DCMyINFOCommand < DCCommand
  def initialize(*args)
    case args.size
      when 1
        @data = args[0]

      when 5
        nickname, bot_name, bot_version, share_size, email = args
        @data = "$ALL #{nickname} test<#{bot_name} V:#{bot_version},M:P,H:1/0/0,S:4>$ $DSL\001$$#{share_size}$"
        #@data = "$ALL #{nickname} test<#{bot_name} V:#{bot_version},M:P,H:1/0/0,S:4>$#{email}$DSL\001$$#{share_size}$"

      else
        raise ArgumentError.new
    end
  end
end
