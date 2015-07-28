class CharacterClass
  include ActiveModel::Model

  def primary_ability
    "str"
  end

  def hit_die
    "1d10"
  end

  def self.all_classes
    dir = File.dirname(__FILE__) + "/character_class"
    @subclasses ||= Dir.glob("#{dir}/**/*.rb").map do |file|
      const_get file.gsub(/(^#{dir}\/|\.rb$)/, "").camelize
    end
  end

  def self.factory(type_name)
    type_name ||= "fighter"
    type_name = type_name.to_s.camelize
    const_get(type_name).new
  end
end
