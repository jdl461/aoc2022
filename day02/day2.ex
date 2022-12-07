# rock
# "A X"  rock rock -> tie -> 1 + 3 -> 4
# "A Y"  rock paper -> win -> 2 + 6 -> 8
# "A Z"  rock scissors -> lose -> 3 + 0 -> 3

# paper
# "B X"  paper rock -> loss -> 1 + 0 -> 1
# "B Y"  paper paper -> tie -> 2 + 3 -> 5
# "B Z"  paper scissors -> win -> 3 + 6 -> 9

# scissors
# "C X"  scissors rock -> win -> 1 + 6 -> 7
# "C Y"  scissors paper -> loss -> 2 + 0 -> 2
# "C Z"  scissors scissors -> tie -> 3 + 3 -> 6

def score(x) do
  case x do
    "A X" -> 4
    "A Y" -> 8
    "A Z" -> 3
    "B X" -> 1
    "B Y" -> 5
    "B Z" -> 9
    "C X" -> 7
    "C Y" -> 2
    "C Z" -> 6
    _ -> 0
  end
end

Enum.map(guide, score) |> Enum.sum()

# part 2
def cheat(x) do
  case x do
    "A X" -> 3
    "A Y" -> 4
    "A Z" -> 8
    "B X" -> 1
    "B Y" -> 5
    "B Z" -> 9
    "C X" -> 2
    "C Y" -> 6
    "C Z" -> 7
    _ -> 0
  end
end
