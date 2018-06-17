defmodule Hangman do

  alias Hangman.Server

  defdelegate new_game(), to: Server, as: :start_link
  defdelegate tally(game_pid), to: Server
  defdelegate make_move(game_pid, guess), to: Server

end
