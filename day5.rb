require 'digest'

class MD5Search

  def initialize key
    @key = key
    @generator = Digest::MD5.new
    @answer = Array.new(8, "*")
    puts @answer.join.to_s
    search
    puts @answer.join.to_s
  end

  def search
    i = 0
    while @answer.include? "*"
      string = @generator.digest( (@key + i.to_s) )
      digest = string.unpack('H*').first
      if digest[0,5] == "00000" && digest[5].to_i(16) < 8 && @answer[digest[5].to_i] == "*"
        @answer[digest[5].to_i] = digest[6].to_s
        puts @answer.join.to_s
      end
      i += 1
    end
  end
end

MD5Search.new('reyedfim')
