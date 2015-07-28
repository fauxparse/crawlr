module CharactersHelper
  def race_selector(form)
    races = Race.races.inject([]) do |races, race|
      subraces = race.races
      if subraces.any?
        subraces.each { |subrace| races << RacePresenter.new(subrace.new) }
      else
        races << RacePresenter.new(race.new)
      end
      races
    end

    choices = races.map { |r| [r.to_s, r.value_for_select] }
    form.select :name, choices
  end

  def character_class_selector(form)
    classes = CharacterClass.all_classes.map do |character_class|
      CharacterClassPresenter.new character_class.new
    end

    choices = classes.map { |c| [c.to_s, c.value_for_select] }
    form.select :name, choices
  end
end
