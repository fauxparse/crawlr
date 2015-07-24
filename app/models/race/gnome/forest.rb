class Race::Gnome::Forest < Race::Gnome
  def ability_bonuses
    super + [["dex", 1]]
  end
end
