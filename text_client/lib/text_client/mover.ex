defmodule TextClient.Mover do

  alias TextClient.State

  def make_move(%State{game_service: game_service, guess: guess} = game) do
    {game_service, tally} = Hangman.make_move(game_service, guess)
    %State{game | game_service: game_service, tally: tally}
  end

end
