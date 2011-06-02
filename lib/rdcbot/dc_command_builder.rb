class DCCommandBuilder
  def self.build(*args)
    name, data = parse(*args)

    begin
      if name =~ /<([^>]+)>/
        DCMessageCommand.new($1, data)
      else
        Object::const_get("DC#{name}Command").new(data)
      end
    rescue NameError => e
      DCUnknownCommand.new(name, data)
    end
  end

  def self.parse(*args)
    case args.size
      when 1
        name, data = args[0].split(' ', 2)

      when 2
        name, data = args

      else
        raise ArgumentError.new
    end

    name = name[1..(name.size-1)] if name[0..0] == '$'
    [name, data]
  end
end
