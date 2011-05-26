require 'lib/dc_commands/dc_command'

class DCMyINFOCommand < DCCommand
  def initialize(*args)
    case args.size
      when 1
        @data = Iconv.iconv('utf-8', 'cp1251', args[0])

      when 6
        nickname, bot_description, bot_name, bot_version, share_size, email = args
        @data = "$ALL #{nickname} #{bot_description}<#{bot_name} V:#{bot_version},M:P,H:1/0/0,S:4>$ $no upload\001$#{email}$#{share_size}$"

      else
        raise ArgumentError.new
    end
  end
end
