%w(rdcbot dc_command_builder dc_hub_connection).each do |file|
  require File.dirname(__FILE__) + "/rdcbot/#{file}"
end

require File.dirname(__FILE__) + "/rdcbot/dc_commands/dc_command"
require File.dirname(__FILE__) + "/rdcbot/dc_commands/dc_nick_list_command"

Dir.glob(File.dirname(__FILE__) + "/rdcbot/dc_commands/*") do |v|
  require v
end
