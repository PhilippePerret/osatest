module Minitest
class Test
class OSATest

  attr_reader :app
  attr_reader :options

  # Initialize a new OSATester.
  # @param [Hash] Optional parameters (see below)
  # @option params [Float] :delay   Delay between actions
  # @option params [Rectangle] :window_bounds Bounds for the windows
  def initialize(params)
    @app      = params[:app] || "Terminal"
    @options  = {
      delay:          params[:delay] || 0.5,
      window_bounds:  params[:window_bounds] || nil
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
  # @note
  #   On revient à la vitesse normal sur le dernier.
  def fast(keys, delay = 0.1)
    last_key = keys.pop
    Osascript::Key.press(keys, app, options.merge(delay:delay))
    Osascript::Key.press(last_key, app, options)
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
  # @param [Rectangle|False] bounds  Rectangle to define the window 
  #             bounds [left, top, rigth, bottom]
  #             If false, no bounds affected even if defined.
  # @note
  #   If +bounds+ is defined and not options[:window_bounds], then
  #   options[:window_bounds] is set to +bounds+ so the next windows
  #   retrieves the same bounds. Unless bounds is explicitely false
  def new_window(bounds = nil)
    press({key:"n", modifiers:[:command]})
    # 
    # Set maybe the window size and position
    # 
    if (bounds || options[:window_bounds]) && not(bounds === false)
      options.merge!(window_bounds: bounds) unless options[:window_bounds]
      Osascript.set_window_bounds(app, bounds || options[:window_bounds])
    end
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
