class Integer

  def DOWN
    Array.new(self, :DOWN)
  end
  alias :down :DOWN
  alias :downs :DOWN
  alias :DOWNS :DOWN

  def UP
    Array.new(self, :UP)
  end
  alias :up :UP
  alias :ups :UP
  alias :UPS :UP

  def RIGHT
    Array.new(self, :RIGHT)
  end
  alias :right :RIGHT
  alias :rights :RIGHT
  alias :RIGHTS :RIGHT

  def LEFT
    Array.new(self, :LEFT)
  end
  alias :left :LEFT
  alias :lefts :LEFT
  alias :LEFTS :LEFT
end
