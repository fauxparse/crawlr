class Race::Dwarf < Race
  FIRST_NAMES = %w(Adrik Alberich Baern Barendd Brottor Bruenor Dain Darrak Delg Eberk Einkil Fargrim Flint Gardain Harbek Kildrak Morgran Orsik Oskar Rangrim Rurik Taklinn Thoradin Thorin Tordek Traubon Travok Ulfgar Veit Vondal Amber Artin Audhild Bardryn Dagnal Diesa Eldeth Falkrunn Finellen Gunnloda Gurdis Helja Hlin Kathra Kristryd Ilde Liftrasa Mardred Riswynn Sannl Torbera Torgga Vistra)
  CLAN_NAMES = %w(Balderk Battlehammer Brawnanvil Dankil Fireforge Frostbeard Gorunn Holderhek Ironfist Loderr Lutgehr Rumnaheim Strakeln Torunn Ungart)

  def ability_bonuses
    super + [["con", 2]]
  end

  def random_name
    [FIRST_NAMES.sample, CLAN_NAMES.sample].join(" ")
  end
end
