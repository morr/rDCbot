class DCMessageCommand < DCCommand
  attr_accessor :user
  attr_accessor :text

  def initialize(user, data)
    @user = user
    @data = data
    @text = Iconv.iconv('utf-8', 'cp1251', data)
  end

  def to_s
    "$<#{@user}> #{@data}|"
  end
end
