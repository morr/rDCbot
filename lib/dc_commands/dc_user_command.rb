require 'lib/dc_commands/dc_command'

class DCUserCommandCommand < DCCommand
  def initialize(data)
    @data = Iconv.iconv('utf-8', 'cp1251', data)
  end
end
