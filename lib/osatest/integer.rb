class Integer

  def DOWN
    Array.new(self, :DOWN)
  end
  alias :down :DOWN

  def UP
    Array.new(self, :UP)
  end
  alias :up :UP

end
