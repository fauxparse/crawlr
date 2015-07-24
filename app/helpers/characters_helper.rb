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
    form.select :race_name, choices
  end
end
