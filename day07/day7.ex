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
    Map.put(filesystem, filename, size)
  end

  def add_file(filesystem, {filename, size}, path) do
    {path, cwd} = Enum.split(path, -1)
    d = Map.get(filesystem, hd(cwd))
    upd = add_file(d, {filename, size}, path)
    Map.put(filesystem, hd(cwd), upd)
  end

  def add_dir(filesystem, dir, []) do
    Map.put(filesystem, dir, %{})
  end

  def add_dir(filesystem, dir, path) do
    {path, cwd} = Enum.split(path, -1)
    d = Map.get(filesystem, hd(cwd))
    upd = add_dir(d, dir, path)
    Map.put(filesystem, hd(cwd), upd)
  end

  def part1() do
    {:ok, input} = File.read("input.txt")
    # input = """
    # $ cd /
    # $ ls
    # dir a
    # 14848514 b.txt
    # 8504156 c.dat
    # dir d
    # $ cd a
    # $ ls
    # dir e
    # 29116 f
    # 2557 g
    # 62596 h.lst
    # $ cd e
    # $ ls
    # 584 i
    # $ cd ..
    # $ cd ..
    # $ cd d
    # $ ls
    # 4060174 j
    # 8033020 d.log
    # 5626152 d.ext
    # 7214296 k
    # """

    [_ | terminal] = input |> String.split("\n", trim: true)
    execute(terminal, %{"/" => %{}}, ["/"])
  end
end
