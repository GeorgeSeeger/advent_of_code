class Decompressor

  attr_accessor :count

  def initialize input
    @input = input.chars
    @marker = ""
    @count = 0
    solve
  end

  def solve
    while @input.size > 0
      parse @input.shift
    end
  end

  def parse char
    if char == "("
      process_bracket
    else
      @count +=1
    end
  end

  def process_bracket
    @input.each.with_index do |c, i|
      if c == ")"
        @marker = @input.shift(i+1).join
        break
      end
    end
    uncompress @marker
  end

  def uncompress string
    marker = string.split("x").map(&:to_i)
    @count += marker[1] * Decompressor.new(truncate(marker[0])).count
  end

  def print_count
    puts @count
  end

  def truncate amount
    @input.shift(amount).join
  end
end

Decompressor.new(File.readlines("day9/input.txt").first.chomp).print_count
# Decompressor.new("(27x12)(20x12)(13x14)(7x10)(1x12)A").print_count
