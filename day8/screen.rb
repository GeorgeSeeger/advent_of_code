class Screen

  def initialize input
    @display = new_display
    @instructions = input
  end

  def new_display
    Array.new(6){Array.new(50){false}}
  end

end
