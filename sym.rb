class Sym
  ZERO = Sym.new
  ONE = Sym.new
  BLANK = Sym.new

  CHARS = [
    [ZERO, "0"],
    [ONE, "1"],
    [BLANK, " "],
    [BLANK, "."],
    [BLANK, "_"],
  ]

  def zero?
    self == ZERO
  end

  def one?
    self == ONE
  end

  def blank?
    self == BLANK
  end

  def verb_phrase
    if zero?
      "write a 0"
    elsif one?
      "write a 1"
    elsif blank?
      "erase the head"
    end
  end

  def to_char
    return CHARS.find {|sym, char| self == sym}[1]
    if one?
      "1"
    elsif zero?
      "0"
    elsif blank?
      " "
    end
  end
  
  def self.from_char(char)
    return CHARS.find {|sym, char_2| char == char_2}[0]
  end

  def to_s
    if one?
      "<Sym::ONE>"
    elsif zero?
      "<Sym::ZERO>"
    elsif blank?
      "<Sym::BLANK>"
    end
  end
end