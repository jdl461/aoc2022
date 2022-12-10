defmodule Day5 do
  def move(diagram, count, from, to) do
    f = diagram[from]
    t = diagram[to]

    {moving, keeping} = Enum.split(f, String.to_integer(count))

    diagram
    |> Map.put(from, keeping)
    |> Map.put(to, Enum.reverse(moving) ++ t)
  end

  def part1() do
    {:ok, input} = File.read("input.txt")

    diagram = %{
      "1" => ["R", "W", "F", "H", "T", "S"],
      "2" => ["W", "Q", "D", "G", "S"],
      "3" => ["W", "T", "B"],
      "4" => ["J", "Z", "Q", "N", "T", "W", "R", "D"],
      "5" => ["Z", "T", "V", "L", "G", "H", "B", "F"],
      "6" => ["G", "S", "B", "V", "C", "T", "P", "L"],
      "7" => ["P", "G", "W", "T", "R", "B", "Z"],
      "8" => ["R", "J", "C", "T", "M", "G", "N"],
      "9" => ["W", "B", "G", "L"]
    }

    [_diagram, moves] =
      String.split(input, "\n", trim: false)
      |> Enum.split_while(fn x -> x !== "" end)
      |> Tuple.to_list()
      |> Enum.map(fn x -> Enum.filter(x, fn y -> y !== "" end) end)

    moves
    |> Enum.map(fn x ->
      Regex.scan(~r/^move (\d+) from (\d+) to (\d+)$/, x, capture: :all_but_first)
    end)
    |> Enum.reduce(
      diagram,
      fn [[count, from, to]], acc ->
        move(acc, count, from, to)
      end
    )
  end
end
