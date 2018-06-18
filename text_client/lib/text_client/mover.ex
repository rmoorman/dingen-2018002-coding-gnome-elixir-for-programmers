defmodule TextClient.Mover do

  alias TextClient.State

  def make_move(%State{game_service: game_service, guess: guess} = game) do
    tally = Hangman.make_move(game_service, guess)
    %State{game | tally: tally}
  end

end
