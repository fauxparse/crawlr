class RaceSerializer < ActiveModel::Serializer
  attributes :name

  def name
    object.value_for_select
  end
end
