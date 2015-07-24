class Ability::Validator < ActiveModel::Validator
  def validate(record)
    unless record.abilities.sort.map(&:stat) == Ability::STATS
      record.errors.add :abilities, :bad_abilities
    end
  end
end
