defmodule Day7 do
  def execute(commands, filesystem, path) do
    case commands do
      [cur | next] ->
        case String.split(cur, " ", trim: true) do
          ["$", "ls"] ->
            execute(next, filesystem, path)

          ["$", "cd", dirname] ->
            case dirname do
              ".." -> execute(next, filesystem, tl(path))
              "/" -> execute(next, filesystem, ["/"])
              _ -> execute(next, filesystem, [dirname | path])
            end

          ["dir", dirname] ->
            execute(next, add_dir(filesystem, dirname, path), path)

          [size, filename] ->
            execute(next, add_file(filesystem, {filename, size}, path), path)

          _ ->
            execute(next, filesystem, path)
        end

      _ ->
        filesystem
    end
  end

  def add_file(filesystem, {filename, size}, []) do
    Map.put(filesystem, {:f, filename}, size)
  end

  def add_file(filesystem, {filename, size}, path) do
    {path, cwd} = Enum.split(path, -1)
    d = Map.get(filesystem, {:d, hd(cwd)})
    upd = add_file(d, {filename, size}, path)
    Map.put(filesystem, {:d, hd(cwd)}, upd)
  end

  def add_dir(filesystem, dir, []) do
    Map.put(filesystem, {:d, dir}, %{})
  end

  def add_dir(filesystem, dir, path) do
    {path, cwd} = Enum.split(path, -1)
    d = Map.get(filesystem, {:d, hd(cwd)})
    upd = add_dir(d, dir, path)
    Map.put(filesystem, {:d, hd(cwd)}, upd)
  end

  def part1() do
    {:ok, input} = File.read("input.txt")

    [_ | terminal] = input |> String.split("\n", trim: true)
    execute(terminal, %{{:d, "/"} => %{}}, ["/"])
  end
end
