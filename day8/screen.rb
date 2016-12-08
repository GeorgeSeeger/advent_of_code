class Screen

  def initialize input
    @display = new_display
    @instructions = input.map(&:split)
    parse
  end

  def new_display
    Array.new(6){Array.new(50){false}}
  end

  def parse
    @instructions.each do |line|
      perform line
    end

  end

  def perform array
    case array[0]
    when "rect"
      rect_parse array[1]
    when "rotate"
      rotate_parse array[1..-1]
    end
  end

  def rect_parse string
    turn_on string.split("x").map(&:to_i)
  end

  def turn_on coords
    coords[0].times do |x|
      coords[1].times do |y|
        @display[y][x] = true
      end
    end
  end

  def rotate_parse array
    case array[0]
    when "column"
      column_rotate coord_parse(array)
    when "row"
      row_rotate coord_parse(array)
    end
  end

  def coord_parse array
    [array[1][2..-1].to_i, array[-1].to_i]
  end

  def row_rotate arg
    @display[arg[0]].rotate! -arg[1]
  end

  def column_rotate arg
    @display = @display.transpose
    row_rotate arg
    @display = @display.transpose
  end

  def count_on
    count = 0
    @display.each do |line|
      line.each do |e|
        count += 1 if e
      end
    end
    count
  end

  def print_display on, off
    @display.each{|a| puts a.map{|e| e ? on : off }.inspect }
  end
end

Screen.new(File.readlines("day8/input.txt")).print_display '#', '.'
