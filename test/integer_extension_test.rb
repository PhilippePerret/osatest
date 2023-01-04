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

  def test_right_method
    assert_respond_to 3, :RIGHT
    assert_respond_to 3, :right
    assert_equal [:RIGHT, :RIGHT, :RIGHT], 3.RIGHT
    assert_equal [:RIGHT, :RIGHT, :RIGHT, :RIGHT], 4.right
    assert_equal [], 0.right
  end

  def test_left_method
    assert_respond_to 3, :LEFT
    assert_respond_to 3, :left
    assert_equal [:LEFT, :LEFT, :LEFT], 3.LEFT
    assert_equal [:LEFT, :LEFT, :LEFT, :LEFT], 4.left
    assert_equal [], 0.left
  end

end #/minitest
