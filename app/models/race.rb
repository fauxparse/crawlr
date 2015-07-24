class Race
  include ActiveModel::Model

  def ability_bonuses
    []
  end  

  def self.all_races
    dir = File.dirname(__FILE__) + "/race"
    @subclasses ||= Dir.glob("#{dir}/**/*.rb").map do |file|
      const_get file.gsub(/(^#{dir}\/|\.rb$)/, "").camelize
    end
  end

  def self.races
    all_races.select { |race| race.superclass == self }
  end
  singleton_class.send :alias_method, :subraces, :races

  def self.factory(type_name)
    type_name ||= "human/standard"
    type_name = type_name.to_s.camelize
    const_get(type_name).new
  end
end
