class Race::HalfOrc < Race
  NAMES = %w(Dench Feng Gell Henk Holg Imsh Keth Krusk Murren Ront Shump Thokk Baggi Emen Engong Kansif Myev Neega Ovak Ownka Shautha Sutha Vola Volen Yevelda)

  def ability_bonuses
    super + [["str", 2], ["con", 1]]
  end

  def random_name
    NAMES.sample
  end
end
