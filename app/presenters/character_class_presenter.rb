class CharacterClassPresenter < SimpleDelegator
  def to_s
    I18n.t class_name.gsub("/", ".")
  end

  def value_for_select
    class_name.sub /^character_class\//, ""
  end

  def class_name
    __getobj__.class.name.underscore
  end
end
