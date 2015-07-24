class Race::Gnome::Rock < Race::Gnome
  def ability_bonuses
    super + [["con", 1]]
  end
end
