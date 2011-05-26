class DCCommand
  Lock = "Lock"
  LockString = "$Lock EXTENDEDPROTOCOLrujR<cmFE3W4SiPTp=0icpS0i;unix Pk=PtokaX"

  attr_accessor :name
  attr_accessor :data

  def initialize(*args)
    case args.size
      when 1
        @name, @data = args[0].split(' ', 2)

      when 2
        @name, @data = args

      else
        raise ArgumentError.new
    end

    @name = @name[1..(name.size-1)] if @name[0..0] == '$'
  end

  def ==(rhs)
    name == rhs.name && data == rhs.data
  end

  def to_s
    "$#{name} #{data}|"
  end
end
