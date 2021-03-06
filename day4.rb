class Rooms

  attr_reader :sector_sum, :room_names

  def initialize input
    @input = input
    @sector_sum = 0
    @counts = {}
    @room = nil
    @room_names = []
    solve
  end

  def solve
    @input.each do |string|
      @room = Room.new string
      @counts = count_letters_room
      @sector_sum += @room.sector_id if real_room?
      puts @room.sector_id if real_room? && @room.decoded_name.include?("north")
    end
  end

  def count_letters_room
    count = {}
    @room.name.chars.uniq.each do |e|
      count[e] = @room.name.count e
    end
    count
  end

  def real_room?
    i = 0
    @counts.sort_by {|k,v| [-v, k]}.each do |k, v|
      return false unless k == @room.check_sum[i]
      i += 1
      break if i == 4
    end
    return true
  end

end

class Room

  attr_reader :sector_id, :check_sum, :name

  def initialize string
    @input = string
    @sector_id = 0
    @check_sum = []
    @name = ""
    make
  end

  def parse
    @input.split('-')
  end

  def make
    last_bit = parse[-1]
    @sector_id = last_bit.to_i
    @check_sum = last_bit[last_bit.index('[')+1...-1].chars
    @name = parse[0...-1].join.chars.sort.join
  end

  def decoded_name
    parse[0...-1].join(" ").chars.map { |c|
      if c == " " then " " else decode c end
    }.join
  end

  def decode char
    ((char.ord-97+@sector_id)%26 + 97).chr
  end
end

# p Room.new("aczupnetwp-mfyyj-opalcexpye-977[peyac]").decoded_name
p Rooms.new(File.readlines("input_day4.txt")).sector_sum
