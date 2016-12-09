class Decompressor

  def initialize input
    @input = input.chars
    @output = []
    @marker = ""
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
      @output << char
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
    @output << @input.shift(marker[0]).join * marker[1]
  end

  def print_count
    puts @output.flatten.reject{|e| e.match /\s/}.join.length
  end

  def print_output
    puts @output.join
  end

  def output
    @output.join
  end
end

Decompressor.new(File.readlines("day9/input.txt").first).print_count
