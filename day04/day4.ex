defmodule Day4 do
  def to_range(s) do
    String.split(s, "-", trim: true) |> Enum.map(&String.to_integer/1)
  end

  def overlaps([[a, b], [c, d]]) do
    (a <= c && b >= d) || (c <= a && d >= b)
  end

  def part1() do
    {:ok, input} = File.read("input.txt")

    input
    |> String.split("\n", trim: true)
    |> Enum.map(fn x -> String.split(x, ",", trim: true) end)
    |> Enum.map(fn [a, b] ->
      [to_range(a), to_range(b)]
    end)
    |> Enum.map(&overlaps/1)
    |> Enum.filter(fn x -> x end)
    |> Enum.count()
  end
end
