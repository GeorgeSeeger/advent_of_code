class Code

  def initialize input
    @input = input.map(&:split)
    @code = [0,0,0,0]
    solve
  end

  def solve
    i = 0
    while i < 23 do
      line = @input[i]
      i += line[2].to_i if loop_end? line
      line = @input[i]
      parse line
      i+=1
    end
  end

  def parse array
    instruction = array[0]
    case instruction
    when 'cpy'
      copy array[1], array[2]
    when 'inc'
      increment array[1]
    when 'dec'
      decrement array[1]
    end
  end

  def location char
    ['a','b','c','d'].find_index char
  end

  def loop_end? line
    # print_code if line[0] == 'jnz'
    # p line if line[0] == 'jnz'
    line[0] == 'jnz' && evaluate(line[1]) != 0
  end

  def copy value, char
    @code[location char] = evaluate value
  end

  def evaluate char
    if char =~ /[abcd]/
      return @code[location char]
    else
       return char.to_i
    end
  end

  def increment char
    @code[location(char)] += 1
  end

  def decrement char
    @code[location char] -= 1
  end

  def print_code
    p @code
  end
end

Code.new(File.readlines('day12/input.txt')).print_code
