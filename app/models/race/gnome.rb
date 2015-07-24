class Race::Gnome < Race
  def ability_bonuses
    super + [["int", 2]]
  end
end
