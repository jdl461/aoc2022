defmodule Day3 do
  alias Inspect.Stream

  def common([a, b]) do
    MapSet.intersection(a, b)
  end

  def split_ruck(ruck) do
    String.split_at(ruck, trunc(String.length(ruck) / 2))
  end

  def priority(<<char::utf8>>) do
    cond do
      ?a <= char and char <= ?z -> char - 96
      ?A <= char and char <= ?Z -> char - 38
      true -> 0
    end
  end

  def part1() do
    {:ok, input} = File.read("input.txt")

    input
    |> String.split("\n", trim: true)
    |> Enum.map(&split_ruck/1)
    |> Enum.map(fn x -> Tuple.to_list(x) end)
    |> Enum.map(fn [a, b] ->
      [MapSet.new(String.to_charlist(a)), MapSet.new(String.to_charlist(b))]
    end)
    |> Enum.map(&common/1)
    |> Enum.map(&Enum.to_list/1)
    |> Enum.map(&List.first/1)
    |> Enum.filter(fn x -> !is_nil(x) end)
    |> Kernel.to_string()
    |> String.split("", trim: true)
    |> Enum.map(&priority/1)
    |> Enum.sum()
  end

  def common3([a, b, c]) do
    ab = common([MapSet.new(String.to_charlist(a)), MapSet.new(String.to_charlist(b))])
    common([MapSet.new(String.to_charlist(c)), ab])
  end

  def part2() do
    {:ok, input} = File.read("input.txt")

    groups = input |> String.split("\n", trim: true) |> Enum.chunk_every(3)

    groups
    |> Enum.map(&common3/1)
    |> Enum.map(&Enum.to_list/1)
    |> Kernel.to_string()
    |> String.split("", trim: true)
    |> Enum.map(&priority/1)
    |> Enum.sum()
  end
end
