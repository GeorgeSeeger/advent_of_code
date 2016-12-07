require_relative 'ipv7'

class IP_Count

  attr_reader :input, :tls_counts, :ssl_counts
  def initialize input
    @input = input
    @tls_counts = 0
    @ssl_counts = 0
    solve
  end

  def solve
    self.input.each do |line|
      @tls_counts += 1 if IPv7.new(line).tls_compliant?
      @ssl_counts += 1 if IPv7.new(line).support_ssl?
    end
    puts self.tls_counts
    puts self.ssl_counts
  end

end

IP_Count.new(File.readlines("day_7/input_day7.txt"))
