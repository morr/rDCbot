class DCCommand
  attr_accessor :data

  def initialize(data)
    @data = data
  end

  def name
    self.class.name.gsub(/^DC|Command$/, '')
  end

  def self.type
    self.name.gsub(/^DC|Command$/, '')
  end

  def ==(rhs)
    self.class == rhs.class && self.name == rhs.name && @data == rhs.data
  end

  def to_s
    @data == nil || @data == '' ? "$#{self.name}|" : "$#{self.name} #{@data}|"
  end
end
