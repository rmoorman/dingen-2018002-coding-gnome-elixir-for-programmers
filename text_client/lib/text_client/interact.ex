defmodule TextClient.Interact do

  alias TextClient.{State, Player}

  def start() do
    new_game()
    |> setup_state()
    |> Player.play()
  end

  defp setup_state(game) do
    %State{
      game_service: game,
      tally: Hangman.tally(game),
    }
  end

  defp new_game() do
    server_node = hangman_server()
    Node.connect(server_node)
    :rpc.call(server_node, Hangman, :new_game, [])
  end

  defp hangman_server() do
    System.get_env()
    |> Map.fetch!("HANGMAN_SERVER_NODE")
    |> String.to_atom()
  end

end
