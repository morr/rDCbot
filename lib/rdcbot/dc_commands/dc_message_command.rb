class DCMessageCommand < DCCommand
  attr_accessor :user
  attr_accessor :text

  def initialize(user, data)
    @user = Iconv.iconv('utf-8', 'cp1251', user)
    @data = data
    @text = Iconv.iconv('utf-8', 'cp1251', data)
  end

  def to_s
    "$<#{@user}> #{@data}|"
  end
end
