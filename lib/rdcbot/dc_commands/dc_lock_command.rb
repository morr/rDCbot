class DCLockCommand < DCCommand
  def key
    @data.split(' ')[0]
  end
end
