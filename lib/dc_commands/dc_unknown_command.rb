require 'lib/dc_commands/dc_command'

class DCUnknownCommand < DCCommand
  def initialize(name, data)
    @name = name
    @data = data
  end

  def name
    @name
  end
end

