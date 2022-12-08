defmodule Day4 do
  def to_range(s) do
    String.split(s, "-", trim: true) |> Enum.map(&String.to_integer/1)
  end

  def contain([[a, b], [c, d]]) do
    (a <= c && b >= d) || (c <= a && d >= b)
  end

  def overlap([[a, b], [c, d]]) do
    MapSet.intersection(
      MapSet.new(a..b),
      MapSet.new(c..d)
    )
  end

  def part1() do
    {:ok, input} = File.read("input.txt")

    input
    |> String.split("\n", trim: true)
    |> Enum.map(fn x -> String.split(x, ",", trim: true) end)
    |> Enum.map(fn [a, b] ->
      [to_range(a), to_range(b)]
    end)
    |> Enum.map(&contain/1)
    |> Enum.filter(&Function.identity/1)
    |> Enum.count()
  end

  def part2() do
    {:ok, input} = File.read("input.txt")

    input
    |> String.split("\n", trim: true)
    |> Enum.map(fn x -> String.split(x, ",", trim: true) end)
    |> Enum.map(fn [a, b] ->
      [to_range(a), to_range(b)]
    end)
    |> Enum.map(&overlap/1)
    |> Enum.map(&Enum.to_list/1)
    |> Enum.filter(fn x -> Enum.count(x) > 0 end)
    |> Enum.count()
  end
end
