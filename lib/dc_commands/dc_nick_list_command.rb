require 'lib/dc_commands/dc_command'

class DCNickListCommand < DCCommand
  attr_accessor :users

  def initialize(data)
    @users = data.split('$$').compact
    @data = data
  end
end
