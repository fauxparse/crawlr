class Race::Halfling < Race
  FIRST_NAMES = %w(Alton Ander Cade Corrin Eldon Errich Finnan Garret Lindal Lyle Merric Milo Osborn Perrin Reed Roscoe Wellby Andry Bree Callie Cora Euphemia Jillian Kithri Lavinia Lidda Merla Nedda Paela Portia Seraphina Shaena Trym Vani Verna)
  FAMILY_NAMES = %w(Brushgather Goodbarrel Greenbottle High-hill Hilltopple Leagallow Tealeaf Thorngage Tosscobble Underbough)

  def ability_bonuses
    super + [["dex", 2]]
  end

  def random_name
    [FIRST_NAMES.sample, FAMILY_NAMES.sample].join(" ")
  end
end
