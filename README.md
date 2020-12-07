# Advent of Code 2020 - Elixir

This is my attempt at solving [Advent of Code](https://www.adventofcode.com)
2020 using [Elixir](https://elixir-lang.org)!

## Usage

There are 25 modules, 25 tests, and 50 mix tasks.

### Provide tests to validate your code

Tests ensure your code is solving the puzzle. Each day we are provided with an
example input, some explainations about the puzzle and the expected answer. 

Tests allow us to set the provided example input, the expected answer for this
example and call our functions to check if our code is doing a good job.

```elixir
defmodule AdventOfCode.Day01Test do
  use ExUnit.Case

  import AdventOfCode.Day01

  @tag :skip # Make sure to remove to run your test.
  test "part1" do
    input = nil
    result = part1(input)

    assert result
  end

  @tag :skip # Make sure to remove to run your test.
  test "part2" do
    input = nil
    result = part2(input)

    assert result
  end
end
```

To run tests use `mix test`.

### Write code to solve the puzzle

Code to solve a given day puzzle lives in a dedicated module:

```elixir
defmodule AdventOfCode.Day01 do
  def part1(args) do
  end

  def part2(args) do
  end
end
```

### Provide the real input and get the answer

When our tests pass we can go forward and compute the answer for the real input.

We can feed a mix task with the real puzzle input to get the answer by running
the according day task such as `mix d01.p1`:

```elixir
defmodule Mix.Tasks.D01.P1 do
  use Mix.Task

  import AdventOfCode.Day01

  @shortdoc "Day 01 Part 1"
  def run(args) do
    input = some_provided_input

    if Enum.member?(args, "-b"),
      do: Benchee.run(%{part_1: fn -> input |> part1() end}),
      else:
        input
        |> part1()
        |> IO.inspect(label: "Part 1 Results")
  end
end
```
