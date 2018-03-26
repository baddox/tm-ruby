require_relative './turing_machine'
require_relative './move'
require_relative './state'
require_relative './sym'

move_right_even = State.new('move-right-even')
move_right_odd = State.new('move-right-odd')
even_ones = State.halt_with_message("There is an even number of 1's.")
odd_ones = State.halt_with_message("There is an odd number of 1's.")

tm = TuringMachine.new(
  start_state: move_right_even,
  start_tape: Tape.from_string(
  "11111"
))

move_right_even.on(
  Sym::ONE,
  write: Sym::ONE,
  move: Move::RIGHT,
  next_state: move_right_odd
)

move_right_even.on(
  Sym::BLANK,
  write: Sym::BLANK,
  move: Move::RIGHT,
  next_state: even_ones
)

move_right_odd.on(
  Sym::ONE,
  write: Sym::ONE,
  move: Move::RIGHT,
  next_state: move_right_even
)

move_right_odd.on(
  Sym::BLANK,
  write: Sym::BLANK,
  move: Move::RIGHT,
  next_state: odd_ones
)

until tm.halted?
  puts tm
  puts ""
  tm.next
end

puts "The Turing machine halted after #{tm.step + 1} steps!"
puts tm
puts tm.state.message
