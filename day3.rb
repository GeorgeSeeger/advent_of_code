class TraingleCount

  def initialize input
    @input = input
    @count = 0
  end

  def parse
    @input.map!{|e| e.split.map!(&:to_i)}
  end

  def solve
    parse.each do |triangle|
      if triangle.max < triangle.min(2).inject(:+)
        @count +=1
      end
    end
    @count
  end

end

p TraingleCount.new(File.readlines("input_day3.txt")).solve
