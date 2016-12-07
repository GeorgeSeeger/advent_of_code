class FrequencyDecode

  def initialize input
    @input = input
    @answer = ""
    solve
  end

  def solve
    parse.each do |line|
      @answer += most_frequent_char line
    end
    puts @answer
  end

  def parse
    @input.map(&:chomp).map(&:chars).transpose.map(&:join)
  end

  def frequency_count string
    count = {}
    string.chars.uniq.each do |e|
      count[e] = string.count e
    end
    # puts count.max_by{|k, v| [v,k]}
    count
  end

  def most_frequent_char string
    frequency_count(string).min_by{|k, v| [v,k]}.first
  end

end

# p File.readlines("input_day6.txt").first
FrequencyDecode.new(File.readlines("input_day6.txt"))
