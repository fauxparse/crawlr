class Race::Tiefling < Race
  INFERNAL_NAMES = %w(Akmenos Amnon Barakas Damakos Ekemon Iados Kairon Leucis Melech Mordai Morthos Pelaios Skamos Therai Akta Anakis Bryseis Criella Damaia Ea Kallisya Lerissa Makaria Nemeia Orianna Phelaia Rieta)
  VIRTUE_NAMES = %w(Art Carrion Chant Creed Despair Excellence Dear Glory Hope Ideal Music Nowhere Open Poetry Quest Random Reverence Sorrow Temerity Torment Weary)

  def ability_bonuses
    super + [["cha", 2], ["int", 1]]
  end

  def random_name
    (INFERNAL_NAMES + VIRTUE_NAMES).sample
  end
end
