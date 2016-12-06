class TraingleCount

  def initialize input
    @input = input
    @count = 0
  end

  def parse
    @input.map!{|e| e.split.map!(&:to_i)}
  end

  def threes_transpose
    array = []
    parse.each_slice(3){|e| array << e.transpose }
    array.flatten(1)
  end

  def solve
    threes_transpose.each do |triangle|
      if triangle.max < triangle.min(2).inject(:+)
        @count +=1
      end
    end
    @count
  end

end

p TraingleCount.new(File.readlines("input_day3.txt")).solve
