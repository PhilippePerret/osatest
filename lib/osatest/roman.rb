=begin

  Module qui apporte à Minitest des méthodes pour vraiment suivre
  les tests.
  Les tests deviennent des romans.

  Note : ça pourrait être un autre gem…

=end
module Minitest
class Test

  def resume(str)
    puts "Résumé : #{str}".jaune
  end

  def synopsis(str)
    puts "Synopsis : #{str}".bleu
  end

  def action(str)
    puts "🪚 #{str}".bleu_clair
  end

  def mini_success(str)
    puts "👌🏻 #{str}".vert
  end

  # Pour un test à faire
  def to_check(str)
    puts "🆘 Check à faire : #{str}".orange
  end

end #/class Test
end #/module Minitest
