defmodule Hangman.Server do

  use GenServer

  alias Hangman.Game


  # external api

  def start_link() do
    GenServer.start_link(__MODULE__, nil)
  end

  def tally(game_pid) do
    GenServer.call(game_pid, {:tally})
  end

  def make_move(game_pid, guess) do
    GenServer.call(game_pid, {:make_move, guess})
  end


  # internal api (callbacks)

  def init(_) do
    {:ok, Game.new_game()}
  end

  def handle_call({:tally}, _from, game) do
    {:reply, Game.tally(game), game}
  end

  def handle_call({:make_move, guess}, _from, game) do
    {game, tally} = Game.make_move(game, guess)
    {:reply, tally, game}
  end

end
