class AbilityBonusPresenter < SimpleDelegator
  def initialize(bonus, editable = false)
    super bonus
    @editable = editable
  end

  def editable?
    @editable
  end
end
