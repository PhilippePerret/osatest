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
    self.assertions = 0
  end

  def press(keys)
    Osascript::Key.press(keys, app, options)      
  end
  alias :<< :press

  def run(key)
    Osascript::Key.press([key, :RETURN], app, options)
    return self
  end

  def finish
    app == 'Terminal' || raise("L’instruction 'finish' s'emploie seulement avec l’application Terminal.")
    press([
      'exit', :RETURN, 
      {key:'w', modifiers:[:command]}
    ])
    return self
  end

  def abort
    app == 'Terminal' || raise("L’instruction 'abort' s'emploie seulement avec l’application Terminal.")
    press([
      {key:'c', modifiers:[:control]}
    ])
    return self
  end

  # @return console state (all text inside) or document
  # text
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

  # Ouvrir une nouvelle fenêtre dans l'application
  def new_window
    press({key:"n", modifiers:[:command]})
    return self
  end

  # @return clear console before continuing
  def clear
    press(["clear", :RETURN])
    return self
  end

end #/class OSATest
end #/class Test
end #/module Minitest
