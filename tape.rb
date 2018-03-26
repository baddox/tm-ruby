require_relative "./sym"

class Tape
  def self.from_string(string)
    syms = string.chars.map {|char| Sym.from_char(char)}
    Tape.new(syms: syms)
  end

  def initialize(syms: [Sym::BLANK], index: 0)
    @array = syms.to_a
    @index = index
  end

  def sym
    @array[@index]
  end

  def execute(write:, move:)
    @array[@index] = write
    if move.none?
      # no-op
    elsif move.left?
      if @index == 0
        @array.unshift(Sym::BLANK)
      else
        @index -= 1
      end
    elsif move.right?
      if @index == @array.length - 1
        @array << Sym::BLANK
      end
      @index += 1
    end

    # In case we want to make everything immutable eventually
    return self
  end

  def to_s
    padding = " " * 5
    symbols = @array.map.with_index do |sym, i|
      if i == @index
        bold = "\e[1m"
        invert = "\e[7m"
        underline = "\e[4m"
        grey_bg = "\e[100m"
        color_end = "\e[0m"
        [grey_bg, sym.to_char, color_end].join
      else
        sym.to_char
      end
    end.join
    down_arrow = (" " * @index) + "↓"
    up_arrow = (" " * @index) + "↑"
    [
      [" ", padding, down_arrow, padding, " "],
      ["[", padding, symbols, padding, "]"],
      [" ", padding, up_arrow, padding, " "],
    ].map(&:join).join("\n")
  end
end