class RacePresenter < SimpleDelegator
  def to_s
    I18n.t class_name.gsub("/", ".")
  end

  def value_for_select
    class_name.sub /^race\//, ""
  end

  def class_name
    __getobj__.class.name.underscore
  end
end
