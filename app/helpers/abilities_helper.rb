module AbilitiesHelper
  def signed(n)
    if n >= 0
      "+#{n}"
    else
      n.to_s
    end
  end

  def ability_base_field(form, ability)
    form.number_field :base, class: "base",
      min: ability.min, max: ability.max,
      disabled: !ability.editable?
  end

  def ability_strategy_selector(form)
    choices = Ability::Strategy.strategies.map do |strategy|
      name = strategy.name.demodulize.underscore
      [t("abilities.strategies.#{name}"), name]
    end

    form.select :name, choices
  end
end
