defmodule TextClient.Summary do

  alias TextClient.State

  def display(%State{tally: tally} = game) do
    IO.puts [
      "\n",
      "Word so far:  #{Enum.join(tally.letters, " ")}",
      "\n",
      "Letters used: #{tally.used}",
      "\n",
      "Guesses left: #{tally.turns_left}",
      "\n",
    ]
    game
  end 

end
