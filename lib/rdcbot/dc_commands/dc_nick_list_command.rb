class DCNickListCommand < DCCommand
  attr_accessor :users

  def initialize(data)
    @users = Iconv.iconv('utf-8', 'cp1251', data).split('$$').compact
    @data = data
  end
end
