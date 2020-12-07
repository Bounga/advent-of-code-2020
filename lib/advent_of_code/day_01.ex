defmodule AdventOfCode.Day01 do
  @target 2020

  def part1(input) do
    for x <- input, y <- input, x + y == @target do
      x * y
    end
    |> hd()
  end

  def part2(input) do
    for x <- input, y <- input, z <- input, x + y + z == @target do
      x * y * z
    end
    |> hd()
  end
end
