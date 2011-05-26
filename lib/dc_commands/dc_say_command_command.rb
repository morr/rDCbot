require 'lib/dc_commands/dc_command'

class DCSayCommand < DCCommand
  def initialize(name, message)
    @name = name
    @data = Iconv.iconv('cp1251', 'utf-8', message)
  end

  def to_s
    "<#{@name}> #{@data}|"
  end
end
