defmodule Day6 do
  def is_start(recents, freqs, size) do
    Enum.sort(recents) |> Enum.uniq() |> Enum.count() === size
  end

  def update_freq(freqs, c) do
    Map.get_and_update(freqs, c, fn x -> {x, x + 1} end)
  end

  def part1() do
    {:ok, input} = File.read("input.txt")
    freqs = for x <- ?a..?z, into: %{}, do: {List.to_string([x]), 0}
    datastream = input |> String.trim() |> String.split("", trim: true)

    Enum.reduce_while(Enum.with_index(datastream), {freqs, [], 0}, fn {c, idx},
                                                                      {freqs, recents, _pos} ->
      {_, freqs} = update_freq(freqs, c)
      recents = Enum.take([c] ++ recents, 4)

      if is_start(recents, freqs, 4) do
        {:halt, {freqs, recents, idx + 1}}
      else
        {:cont, {freqs, recents, 0}}
      end
    end)
  end

  def part2() do
    {:ok, input} = File.read("input.txt")
    freqs = for x <- ?a..?z, into: %{}, do: {List.to_string([x]), 0}
    datastream = input |> String.trim() |> String.split("", trim: true)

    Enum.reduce_while(Enum.with_index(datastream), {freqs, [], 0}, fn {c, idx},
                                                                      {freqs, recents, _pos} ->
      {_, freqs} = update_freq(freqs, c)
      recents = Enum.take([c] ++ recents, 14)

      if is_start(recents, freqs, 14) do
        {:halt, {freqs, recents, idx + 1}}
      else
        {:cont, {freqs, recents, 0}}
      end
    end)
  end
end
