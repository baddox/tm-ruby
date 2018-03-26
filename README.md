# tm-ruby

## A Turing Machine in Ruby for Fun

A TuringMachine is initialized with an initial State and an initial Tape.

A Tape has an array of Syms and an index of where the head is.

A Sym is either BLANK, ONE, or ZERO. It's called "Sym" because Symbol is already a thing in Ruby.

Each State has a name (for display purposes only) and three rules (one for each Sym). Each rule says what the head should write, which direction (if any) the head should move, and finally which State to switch to.

There can be any number of halting States, each with a message (for convenience). Real Turing Machines generally leave a representation of their resulting value on the tape when they halt.

## Example: Computer the input contains an odd or an even number of 1's

This example Turing Machine takes an input tape of some number of consecutive 1's. It determines whether the number of 1's is even or odd, and halts with a message politely telling you its conclusion.

Note that this implementation has undefined behavior for input tapes that contain anything other than zero or more consecutive 1's. It will probably crash on any other inputs, due to States not specifying rules for all three Syms.

It works by moving right, each step alternating between two states that remember if the current number of 1's is even or odd, then halting with the corresponding even or odd State when it encounters the first blank cell.

### Code

```ruby
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
  "111"
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
```

### Console Output

```bash
bash-3.2$ ruby main.rb
      ↓
[     111     ]
      ↑
State:move-right-even will write a 1, move right, and switch to State:move-right-odd.

       ↓
[     111     ]
       ↑
State:move-right-odd will write a 1, move right, and switch to State:move-right-even.

        ↓
[     111     ]
        ↑
State:move-right-even will write a 1, move right, and switch to State:move-right-odd.

         ↓
[     111      ]
         ↑
State:move-right-odd will erase the head, move right, and halt.

The Turing machine halted after 5 steps!
          ↓
[     111       ]
          ↑
There is an odd number of 1's.
```