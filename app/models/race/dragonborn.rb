class Race::Dragonborn < Race
  FIRST_NAMES = %w(Arjhan Balasar Bharash Donaar Ghesh Heskan Kriv Medrash Mehen Nadarr Pandjed Patrin Rhogar Shamash Shedinn Tarhun Torinn Akra Biri Daar Farideh Harann Havilar Jheri Kava Korinn Mishann Nala Perra Raiann Sora Surina Thava Uadjit)
  CLAN_NAMES = %w(Clethtinthiallor Daardendrian Delmirev Drachedandion Fenkenkabradon Kepeshkmolik Kerrhylon Kimbatuul Linxakasendalor Myastan Nemmonis Norixius Ophinshtalajiir Prexijandilin Shestendeliath Turnuroth Verthisathurgiesh Yarjerit)

  def ability_bonuses
    super + [["str", 2], ["cha", 1]]
  end

  def random_name
    [CLAN_NAMES.sample, FIRST_NAMES.sample].join(" ")
  end
end
