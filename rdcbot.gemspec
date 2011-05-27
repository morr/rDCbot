# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{rdcbot}
  s.version = "0.0.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Andrey Sidorov"]
  s.autorequire = %q{rdcbot}
  s.date = %q{2011-05-27}
  s.description = %q{Bot for the Direct Connect(DC) protocol}
  s.email = %q{takandar@gmail.com}
  s.extra_rdoc_files = ["README", "LICENSE", "CHANGELOG", "TODO"]
  s.files = ["LICENSE", "README", "CHANGELOG", "TODO", "Rakefile", "lib/dc_command_builder.rb", "lib/dc_commands", "lib/dc_commands/dc_say_command_command.rb", "lib/dc_commands/dc_quit_command.rb", "lib/dc_commands/dc_op_list_command.rb", "lib/dc_commands/dc_lock_command.rb", "lib/dc_commands/dc_hello_command.rb", "lib/dc_commands/dc_nick_list_command.rb", "lib/dc_commands/dc_validate_denide_command.rb", "lib/dc_commands/dc_version_command.rb", "lib/dc_commands/dc_message_command.rb", "lib/dc_commands/dc_my_info_command.rb", "lib/dc_commands/dc_unknown_command.rb", "lib/dc_commands/dc_key_command.rb", "lib/dc_commands/dc_command.rb", "lib/dc_commands/dc_user_command.rb", "lib/dc_commands/dc_hub_name_command.rb", "lib/dc_commands/dc_validate_nick_command.rb", "lib/dc_commands/dc_supports_command.rb", "lib/dc_commands/dc_get_nick_list_command.rb", "lib/dc_hub_connection.rb", "lib/rdcbot.rb", "spec/spec_helper.rb", "spec/dc_command", "spec/dc_command/dc_command_spec.rb", "spec/dc_command/dc_command_builder_spec.rb", "spec/dc_hub_connection", "spec/dc_hub_connection/dc_hub_connection_spec.rb", "spec/rdcbot", "spec/rdcbot/rdcbot_spec.rb"]
  s.homepage = %q{https://github.com/morr/rDCbot}
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.7}
  s.summary = %q{Bot for the Direct Connect(DC) protocol}

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
    else
    end
  else
  end
end
