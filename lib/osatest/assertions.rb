module Minitest::Assertions

  # @param tosa {Minitest::Test::OSATest}
  # @param expected {String} String to find in the +x+ lines
  #                 of tosa.content (10 lines by default)
  def assert_in_last_lines(tosa, expected, x = 10)
    content = tosa.content.split("\n").reverse[0..x].reverse.join("\n")
    assert_includes content, expected,
      "Expected to find '#{expected}' in #{x} last lines of #{content}"

  end

end #/module Minitest

module Minitest
class Test
class OSATest
  include Minitest::Assertions
  attr_accessor :assertions

  # Check if console contains lines of text
  # 
  # @param strs [String|Regexp|Array of theses] Text or Regex to find
  # @param x [Integer] Number lines to fetch (default: 10)
  # @param failure_message [String] Optional error message
  # 
  # @example
  #     tosa = OSATest.new(app:"Terminal", delay: 0.1)
  #     # some actions
  #     tosa.has_in_last_lines(["this texte", /some reg text/])
  # 
  def has_in_last_lines(strs, x = 10, failure_message = nil)
    content = self.content.split("\n").reverse[0..x].reverse.join("\n")
    strs = [strs] if not(strs.is_a?(Array))
    failure_message = failure_message ? "#{failure_message}\n" : ''
    strs.each do |str|
      if str.is_a?(String)
        assert_includes content, str,
          "#{failure_message}Expected to find '#{str}' in #{x} last lines of #{content}"
      elsif str.is_a?(Regexp)
        assert_match(str, content,
            "#{failure_message}Expected to find #{str.inspect} in #{x} last lines of #{content}")
      else
        raise "Je ne sais pas comment chercher #{str.inspect} (on ne peut fournir à #has_in_last_lines que des {String}s ou des expressions régulières.".rouge
      end
    end
  end

  def has_not_in_last_lines(strs, x = 10, failure_message = nil)
    content = self.content.split("\n").reverse[0..x].reverse.join("\n")
    strs = [strs] if not(strs.is_a?(Array))
    failure_message = failure_message ? "#{failure_message}\n" : ''
    strs.each do |str|
      if str.is_a?(String)
        refute_includes content, str,
          "#{failure_message}Expected not to find '#{str}' in #{x} last lines of #{content}"
      elsif str.is_a?(Regexp)
        refute_match(str, content,
            "#{failure_message}Expected not to find #{str.inspect} in #{x} last lines of #{content}")
      else
        raise "Je ne sais pas comment chercher #{str.inspect} (on ne peut fournir à #has_in_last_lines que des {String}s ou des expressions régulières.".rouge
      end
    end
  end
end #/class OSATest
end #/class Test
end #/module Minitest::Test
