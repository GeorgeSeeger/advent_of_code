class Bathroom

  def initialize moves
    @moves = moves
    # @keys_old = [[1,2,3],[4,5,6],[7,8,9]]
    @keys = [ [false,false,1,false,false],
                [false, 2, 3, 4,false],
                    [5, 6, 7, 8, 9],
               [false,'A','B','C', false],
             [false,false,'D',false,false]]
    @position = [2,0]
    @answer = []
  end

  def solve
    parse.each do |line|
      line.each do |char|
        move char
      end
      @answer << key
    end
    @answer.join
  end

  def key
    @keys[@position.first][@position.last]
  end

  def parse
    @moves.map(&:chomp).map{|e| e.split('')}
  end

  def move char
    case char
    when "U"
      @position[0] -= 1
    when "R"
      @position[1] += 1
    when "L"
      @position[1] -= 1
    when "D"
      @position[0] += 1
    end
    periodic char
  end

  def periodic char
    @position.map! do |e|
      if e < 0 then 0
      elsif e > 4 then 4
      else e
      end
    end
    if !key then reverse_move char end
  end

  def reverse_move char
    moves = ['U','D','R','L']
    undos = ['D','U','L','R']
    move undos[moves.find_index char]
  end

end

p Bathroom.new(File.readlines("input_day2.txt")).solve
