defmodule Day01 do
  def read do
    {:ok, input} = File.read("input1.txt")
    String.split(input, "\n")
  end

  def chunker(element, acc) do
    if element == "" do
      {:cont, acc, []}
    else
      {:cont, [element | acc]}
    end
  end

  def part1(input) do
    Enum.chunk_while(input, [], chunker, fn acc -> {:cont, acc} end)
    |> Enum.map(fn x -> Enum.map(x, &String.to_integer/1) end)
    |> Enum.map(&Enum.sum/1)
    |> Enum.with_index()
    |> Enum.max()
  end

  def part2(input) do
    Enum.chunk_while(input, [], chunker, fn acc -> {:cont, acc} end)
    |> Enum.map(fn x -> Enum.map(x, &String.to_integer/1) end)
    |> Enum.map(&Enum.sum/1)
    |> Enum.sort()
    |> Enum.reverse()
    |> Enum.take(3)
    |> Enum.sum()
  end
end
