class Ability::BonusSerializer < ActiveModel::Serializer
  attributes :stat, :bonus, :editable

  def editable
    object.editable?
  end
end
