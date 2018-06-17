defmodule Hangman do

  alias Hangman.Server

  def new_game() do
    {:ok, game_pid} = Supervisor.start_child(Hangman.Supervisor, [])
    game_pid
  end

  defdelegate tally(game_pid), to: Server
  defdelegate make_move(game_pid, guess), to: Server

end
