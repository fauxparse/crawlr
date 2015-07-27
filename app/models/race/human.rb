class Race::Human < Race
  NAMES = {
    "Calishite" => {
      first: %w(Aseir Bardeid Haseid Khemed Mehmen Sudeiman Zasheir Atala CeidilHama Jasmal Meilil Seipora Yasheira Zasheida),
      last: %w(Basha Dumein Jassan Khalid Mostana Pashar Rein)
    },
    "Chondathan" => {
      first: %w(Darvin Dorn Evendur Gorstag Grim Helm Malark Morn Randal Stedd Arveene Esvele Jhessail Kerri Lureene Miri Rowan Shandri Tessele),
      last: %w(Amblecrown Buckman Dundragon Evenwood Greycastle Tallstag)
    },
    "Damaran" => {
      first: %w(Bor Fodel Glar Grigor Igan Ivor Kosef Mival Orel Pavel Sergor Alethra Kara Katernin Mara Natali Olma Tana Zora),
      last: %w(Bersk Chernin Dotsk Kulenov Marsk Nemetsk Shemov Starag)
    },
    "Illuskan" => {
      first: %w(Ander Blath Bran Frath Geth Lander Luth Malcer Stor Taman Urth Amafrey Betha Cefrey Kethra Mara Olga Silifrey Westra),
      last: %w(Brightwood Helder Hornraven Lackman Stormwind Windrivver)
    },
    "Mulan" => {
      first: %w(Aoth Bareris Ehput-Ki Kethoth Mumed Ramas So-Kehur Thazar-De Urhur Arizima Chathi Nephis Nulara Murithi Sefris Thola Umara Zolis),
      last: %w(Ankhalab Anskuld Fezim Hahpet Nathandem Sepret Uuthrakt)
    },
    "Rashemi" => {
      first: %w(Borivik Faurgar Jandar Kanithar Madislak Ralmevik Shaumar Vladislak Fyevarra Hulmarra Immith Imzel Navarra Shevarra Tammith Yuldra),
      last: %w(Chergoba Dyernina Iltazyara Murnyethara Stayanoga Ulmokina)
    },
    "Shou" => {
      first: %w(An Chen Chi Fai Jiang Jun Lian Long Meng On Shan Shui Wen Bai Chao Jia Lei Mei Qiao Shui Tai),
      last: %w(Chien Huang Kao Kung Lao Ling Mei Pin Shin Sum Tan Wan),
      order: -1
    },
    "Turami" => {
      first: %w(Anton Diero Marcon Pieron Rimardo Romero Salazar Umbero Balama Dona Faila Jalana Luisa Marta Quara Selise Vonda),
      last: %w(Agosto Astorio Calabra Domine Falone Marivaldi Pisacar Ramondo)
    }
  }

  def random_name
    racial_group = NAMES.values.sample
    name = [racial_group[:first].sample, racial_group[:last].sample]
    name.reverse! if racial_group[:order] == -1
    name.join " "
  end
end
