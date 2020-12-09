defmodule AdventOfCode.Day02 do
  def part1(input) do
    specs =
      String.split(input, "\n", trim: true)
      |> Enum.map(&spec_for_part1/1)

    matching_count(specs, fn spec ->
      spec["password"]
      |> String.graphemes()
      |> Enum.count(&(&1 == spec["letter"]))
      |> Kernel.in(spec["range"])
    end)
  end

  def part2(input) do
    specs =
      String.split(input, "\n", trim: true)
      |> Enum.map(&spec_for_part2/1)

    matching_count(specs, fn spec ->
      :erlang.xor(
        char_at_position?(spec["letter"], spec["pos1"], spec["password"]),
        char_at_position?(spec["letter"], spec["pos2"], spec["password"])
      )
    end)
  end

  defp matching_count(specs, filter) do
    for spec <- specs, filter.(spec), reduce: 0 do
      count -> count + 1
    end
  end

  defp spec_for_part1(line) do
    spec =
      Regex.named_captures(
        ~r/(?<range>\d+-\d+) (?<letter>[[:alpha:]]): (?<password>[[:lower:]]+)/,
        line
      )

    range = spec["range"] |> String.replace("-", "..") |> Code.eval_string() |> elem(0)

    %{spec | "range" => range}
  end

  defp spec_for_part2(line) do
    Regex.named_captures(
      ~r/(?<pos1>\d+)-(?<pos2>\d+) (?<letter>[[:alpha:]]): (?<password>[[:lower:]]+)/,
      line
    )
  end

  defp char_at_position?(char, pos, string) do
    String.at(string, String.to_integer(pos) - 1) == char
  end
end
