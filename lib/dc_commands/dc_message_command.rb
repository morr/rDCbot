require 'lib/dc_commands/dc_command'

class DCMessageCommand < DCCommand
  def initialize(user, data)
    @user = user
    @data = Iconv.iconv('utf-8', 'cp1251', data)
  end

  def to_s
    "$<#{@user}> #{@data}|"
  end
end
