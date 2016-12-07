class IPv7

  def initialize input
    self.insides = input
    self.outsides = input
  end

  def tls_compliant?
    @insides.each do |fragment|
      return false if contain_abba? fragment
    end
    @outsides.each do |fragment|
      return true if contain_abba? fragment
    end
    return false
  end

  def contain_abba? string
    for i in (0..string.length-4)
      substring = string[i,4]
      if is_abba? substring
        return true
      end
    end
    false
  end

  def support_ssl?
    contain_aba_and_bab?
  end

  # private

  def contain_aba_and_bab?
    @outsides.each do |string|
      for i in (0..string.length - 3)
        substring = string[i,3]
        if is_abba? substring
          # puts substring
          return true if contain_bab? substring
        end
      end
    end
    false
  end

  def insides= string
    @insides = string.scan(/\[.*?\]/).map{|e| e.tr("[]", '')}
  end

  def outsides= string
    @outsides = string.split /\[.*?\]/
  end

  def contain_bab? string
    bab = bab_converter string
    @insides.each do |fragment|
      return true if fragment.include? bab
    end
    false
  end

  def bab_converter string
    string[1] + string[0] + string[1]
  end

  def is_abba? string
    string.reverse == string && string[0] != string[1]
  end

end
