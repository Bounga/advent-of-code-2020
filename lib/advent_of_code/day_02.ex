defmodule AdventOfCode.Day02 do
  def part1(input) do
    lines = String.split(input, "\n", trim: true)

    for line <- lines, filter_line(line), reduce: 0 do
      count -> count + 1
    end
  end

  def part2(args) do
  end

  defp spec_from_line(line) do
    spec =
      Regex.named_captures(
        ~r/(?<range>\d+-\d+) (?<letter>[[:alpha:]]): (?<password>[[:lower:]]+)/,
        line
      )

    range = spec["range"] |> String.replace("-", "..") |> Code.eval_string() |> elem(0)

    %{spec | "range" => range}
  end

  defp valid_spec?(spec) do
    spec["password"]
    |> String.graphemes()
    |> Enum.count(&(&1 == spec["letter"]))
    |> Kernel.in(spec["range"])
  end

  defp filter_line(line) do
    line
    |> spec_from_line()
    |> valid_spec?()
  end
end
