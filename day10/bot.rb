class Bot

    attr_reader :number, :values, :low_to, :high_to

  def initialize array
    @number = array[1].to_i
    @low_to = array[5],array[6].to_i
    @high_to = array[-2], array[-1].to_i
    @values = []
  end

  def self.get_by_number id
    ObjectSpace.each_object(Bot) do |bot|
      return bot if bot.number == id
    end
    nil
  end

  def full?
    self.values.size == 2
  end

end
