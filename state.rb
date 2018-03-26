require_relative './move'

class State
  attr_reader :name
  attr_reader :message

  def self.halt_with_message(message)
    State.new('HALT', halt: true, message: message)
  end

  def initialize(name, halt: false, message: nil)
    @rules =  Hash.new {|h, k| h[k] = Hash.new}
    @name = name
    @halt = halt
    @message = message
  end

  def add_rule(
    current_sym,
    write: current_sym,
    move: Move::NONE,
    next_state:
    )
    @rules[current_sym] = [write, move, next_state]
  end
  alias_method :on, :add_rule

  def get_rule(symbol)
    @rules[symbol]
  end

  def halt?
    @halt
  end

  def to_s
    if halt?
      "<State HALT!>"
    else
      "<State '#{@name}' with #{@rules.length} rules>"
    end
  end
end