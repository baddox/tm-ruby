require_relative "./state"
require_relative "./tape"

class TuringMachine
  attr_reader :state
  attr_reader :tape
  attr_reader :step

  def initialize(start_state: State.new("start"), start_tape: Tape.new)
    @state = start_state
    @tape = start_tape
    @step = 0
  end

  def next
    new_sym, move, new_state = state.get_rule(tape.sym)
    @tape = tape.execute(write: new_sym, move: move)
    @state = new_state
    @step += 1
  end
  
  def halted?
    state.halt?
  end

  def sentence
    return nil if halted?
    new_sym, move, new_state = state.get_rule(tape.sym)
    state_phrase = if new_state == state
      "and remain in State:#{state.name}"
    elsif new_state.halt?
      "and halt"
    else
      "and switch to State:#{new_state.name}"
    end
    sentence = [
      "State:#{state.name} will #{new_sym.verb_phrase}",
      move.verb_phrase,
      state_phrase,
    ].join(", ") + "."
  end

  def to_s
    [
      tape,
      sentence,
    ].join("\n")
  end
end