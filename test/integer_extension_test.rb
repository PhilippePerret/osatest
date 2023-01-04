require 'test_helper'

class IntegerExtensionTest < Minitest::Test

  def test_down_method
    assert_respond_to 3, :DOWN
    assert_respond_to 3, :down
    assert_equal [:DOWN, :DOWN, :DOWN], 3.down
    assert_equal [:DOWN, :DOWN, :DOWN, :DOWN], 4.DOWN
    assert_equal [], 0.down
  end

  def test_up_method

    assert_respond_to 3, :UP
    assert_respond_to 3, :up
    assert_equal [:UP, :UP, :UP], 3.UP
    assert_equal [:UP, :UP, :UP, :UP], 4.up
    assert_equal [], 0.up
  end

end #/minitest
