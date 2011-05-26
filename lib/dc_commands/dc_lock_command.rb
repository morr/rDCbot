require 'lib/dc_commands/dc_command'

class DCLockCommand < DCCommand
  def key
    @data.split(' ')[0]
  end
end
