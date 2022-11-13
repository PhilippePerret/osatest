require 'minitest/assertions'

module Minitest::Assertions

  # @param tosa {Minitest::Test::OSATest}
  # @param expected {String} String to find in the +x+ lines
  #                 of tosa.content (10 lines by default)
  def assert_in_last_lines(tosa, expected, x = 10)
    content = tosa.content.split("\n").reverse[0..x].reverse.join("\n")
    assert_includes content, expected,
      "Expected to find '#{expected}' in #{x} last lines of #{content}"

  end

end #/module Minitest::Assertions

module Minitest
class Test
class OSATest
  include Minitest::Assertions
  attr_accessor :assertions

  def has_in_last_lines(strs, x = 10, failure_message = nil)
    content = self.content.split("\n").reverse[0..x].reverse.join("\n")
    strs = [strs] if not(strs.is_a?(Array))
    failure_message = failure_message ? "#{failure_message}\n" : ''
    strs.each do |str|
      assert_includes content, str,
        "#{failure_message}Expected to find '#{str}' in #{x} last lines of #{content}"
    end
  end
end #/class OSATest
end #/class Test
end #/module Minitest::Test
