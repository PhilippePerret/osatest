class Integer

  def DOWN
    Array.new(self, :DOWN)
  end
  alias :down :DOWN

  def UP
    Array.new(self, :UP)
  end
  alias :up :UP

  def RIGHT
    Array.new(self, :RIGHT)
  end
  alias :right :RIGHT

  def LEFT
    Array.new(self, :LEFT)
  end
  alias :left :LEFT
end
