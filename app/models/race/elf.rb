class Race::Elf < Race
  FIRST_NAMES = %w(Adran Aelar Aramil Arannis Aust Beiro Berrian Carric Enialis Erdan Erevan Galinndan Hadarai Heian Himo Immeral Ivellios Laucian Mindartis Paelias Peren Quarion Riardon Rolen Soveliss Thamior Tharivol Theren Varis Adrie Althaea Anastrianna Andraste Antinua Bethrynna Birel Caelynn Drusilia Enna Felosial Ielenia Jelenneth Keyleth Leshanna Lia Meiele Mialee Naivara Quelenna Quillathe Sariel Shanairra Shava Silaqui Theirastra Thia Vadania Valanthe Xanaphia)
  FAMILY_NAMES = %w(Gemflower Starflower Moonwhisper Diamonddew Gemblossom Silverfrond Oakenheel Nightbreeze Moonbrook Goldpetal)

  def ability_bonuses
    super + [["dex", 2]]
  end

  def random_name
    [FIRST_NAMES.sample, FAMILY_NAMES.sample].join(" ")
  end
end
