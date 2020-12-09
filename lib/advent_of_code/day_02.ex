defmodule AdventOfCode.Day02 do
  def part1(input) do
    lines = String.split(input, "\n", trim: true)

    for line <- lines, filter_line_part_1(line), reduce: 0 do
      count -> count + 1
    end
  end

  def part2(input) do
    lines = String.split(input, "\n", trim: true)

    for line <- lines, filter_line_part_2(line), reduce: 0 do
      count -> count + 1
    end
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

  defp spec_from_line_2(line) do
    Regex.named_captures(
      ~r/(?<pos1>\d+)-(?<pos2>\d+) (?<letter>[[:alpha:]]): (?<password>[[:lower:]]+)/,
      line
    )
  end

  defp valid_spec?(spec) do
    spec["password"]
    |> String.graphemes()
    |> Enum.count(&(&1 == spec["letter"]))
    |> Kernel.in(spec["range"])
  end

  defp valid_spec_2?(spec) do
    :erlang.xor(
      char_at_position?(spec["letter"], spec["pos1"], spec["password"]),
      char_at_position?(spec["letter"], spec["pos2"], spec["password"])
    )
  end

  defp filter_line_part_1(line) do
    line
    |> spec_from_line()
    |> valid_spec?()
  end

  defp filter_line_part_2(line) do
    line
    |> spec_from_line_2()
    |> valid_spec_2?()
  end

  defp char_at_position?(char, pos, string) do
    String.at(string, String.to_integer(pos) - 1) == char
  end
end
