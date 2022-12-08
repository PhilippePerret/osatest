module Minitest
class Test
class OSATest

  attr_reader :app
  attr_reader :options

  def initialize(params)
    @app      = params[:app] || "Terminal"
    @options  = {
      delay: params[:delay] || 0.5 
    }
    @initial_delay = @options[:delay]
    self.assertions = 0
  end

  # To modify on the fly delay between actions 
  # @param value [Float|:initial] Delay between actions.
  # @note
  #   To retrieve the initial value of delay, use :initial value
  #   Hence you can slow down a segment of test with `#delay = x`
  #   then retrieve initial value with `#delay = :initial`
  def delay(value)
    value = @initial_delay if value == :initial
    options.merge!(delay: value)
  end
  alias :delay= :delay

  # Simulate a keypress
  # @param keys [String|Integer|Array<String, Integer>] Key or list of keys.
  def press(keys)
    Osascript::Key.press(keys, app, options)
  end
  alias :<< :press

  # Simulate fast several keypress
  # @param keys [Array<String, Integer>] Key list
  # @param @optional delay [Float] Delay between action (default: 0.1)
  def fast(keys, delay = 0.1)
    Osascript::Key.press(keys, app, options.merge(delay:delay))
  end

  def slow(keys, delay = 2)
    Osascript::Key.press(keys, app, options.merge(delay:2))
  end

  def run(key)
    Osascript::Key.press([key, :RETURN], app, options)
    return self
  end

  # When app is Terminal, close the test window
  # @note 
  #   Raise a exception if app is not Terminal
  def finish
    app == 'Terminal' || raise("L’instruction 'finish' s'emploie seulement avec l’application Terminal.")
    press([
      'exit', :RETURN, 
      {key:'w', modifiers:[:command]}
    ])
    return self
  end

  # When app is Terminal, abort the tests here.
  # @example
  #   tosa = OSATest.new(app:'Terminal')
  #   # ... some tests
  #   tosa.abort
  # @note
  #   You can follow with #finish to close the window :
  #   tosa.abort.finish
  # 
  def abort
    app == 'Terminal' || raise("L’instruction 'abort' s'emploie seulement avec l’application Terminal.")
    press([
      {key:'c', modifiers:[:control]}
    ])
    return self
  end

  # Return text of app's window
  # @return [String] content of the front window of defined app.
  def content
    prev_delay = options[:delay].freeze
    options[:delay] = 0.1
    press([
      {key:"a", modifiers:[:command]},
      {key:"c", modifiers:[:command]}
    ])
    options[:delay] = prev_delay
    return `pbpaste`.strip.split("\n").map{|seg|seg.strip}.join("\n")
  end

  # Open a new window in defined app
  def new_window
    press({key:"n", modifiers:[:command]})
    return self
  end

  # When app is Terminal, clear the console
  # @return self
  def clear
    press(["clear", :RETURN])
    return self
  end

end #/class OSATest
end #/class Test
end #/module Minitest
