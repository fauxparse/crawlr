##
# Rolls some dice as specified by a string parameter.
#
# Examples of valid dice strings:
# * 1d4
# * 1d8+3
# * 4d6/3 (best 3 of 4 dice)
class RollDice
  FORMAT = /^(\d+)(d(\d+)(\/(\d+))?(\+(\d+))?)?$/

  def initialize(dice)
    @dice = dice
  end

  def call
    @dice.split("+").map { |d| roll d.strip }.sum
  end

  private

  def roll(dice)
    if dice =~ FORMAT
      if $2
        d = $3.to_i
        rolls = (1..$1.to_i).map { rand(1..d) }
        rolls = best(rolls, $5) if $4
        rolls.sum + ($7 || 0).to_i
      else
        $1.to_i
      end
    else
      raise ArgumentError, "bad dice: #{dice}"
    end
  end

  def best(rolls, n)
    rolls.sort[-(n.to_i)..-1]
  end
end
