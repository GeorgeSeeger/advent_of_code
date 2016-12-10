require_relative 'bot'

class Factory

  def initialize input
    @input = input.map(&:split)
    @output = Array.new(21){nil}
    @bots = []
    @values = []
    parse
    solve
  end

  def parse
    @input.each do |line|
      @bots.push Bot.new(line) if line[0] == 'bot'
      @values.push line if line[0] == 'value'
    end
    values_parse
  end

  def values_parse
    @values.each do |line|
      give_bot line[1].to_i, line[-1].to_i
    end

  end

  def solve
    while @output.include? nil
      @bots.each do |bot|
        bot_give bot if bot.full?
      end
    end
  end

  def bot_give bot
    puts "17 and 61 #{bot.number}" if bot.values == [17,61]
    give_output bot.values.shift, bot.low_to[1] if bot.low_to[0] == 'output'
    give_bot bot.values.shift, bot.low_to[1] if bot.low_to[0] == 'bot'
    give_output bot.values.pop, bot.high_to[1] if bot.high_to[0] == 'output'
    give_bot bot.values.pop, bot.high_to[1] if bot.high_to[0] == 'bot'
  end

  def give_bot value, id
    bot = Bot.get_by_number id.to_i
    bot.values.push value
    bot.values.sort!
  end

  def give_output value, index
    @output[index] = value
  end

  def print_output
    puts @output.to_s
  end
end

Factory.new(File.readlines("input.txt"))
