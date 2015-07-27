class Race::Gnome < Race
  FIRST_NAMES = %w(Alston Alvyn Boddynock Brocc Burgell Dimble Eldon Erky Fonkin Frug Gerbo Gimble Glim Jebeddo Kellen Namfoodle Orryn Roondar Seebo Sindri Warryn Wrenn Zook Bimpnottin Breena Caramip Carlin Donella Duvamil Ella Ellyjobell Ellywick Lilli Loopmottin Lorilla Mardnab Nissa Nyx Oda Orla Roywyn Shamil Tana Waywocket Zanna)
  CLAN_NAMES = %w(Beren Daergel Folkor Garrick Nackle Murnig Ningel Raulnor Scheppen Timbers Turen)
  NICKNAMES = %w(Aleslosh Ashhearth Badger Cloak Doublelock Filchbatter Fnipper Ku Nim Oneshoe Pock Sparklegem Stumbleduck)

  def ability_bonuses
    super + [["int", 2]]
  end

  def random_name
    [FIRST_NAMES.sample, "“#{NICKNAMES.sample}”", CLAN_NAMES.sample].join " "
  end
end
