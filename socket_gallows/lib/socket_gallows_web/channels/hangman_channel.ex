defmodule SocketGallowsWeb.HangmanChannel do

  use Phoenix.Channel

  require Logger

  def join("hangman:game", _, socket) do
    game = Hangman.new_game()
    socket = assign(socket, :game, game)
    {:ok, socket}
  end

  def handle_in("tally", _, socket) do
    game = socket.assigns.game
    tally = Hangman.tally(game)
    push(socket, "tally", tally)
    {:noreply, socket}
  end

  def handle_in("make_move", guess, socket) do
    tally = Hangman.make_move(socket.assigns.game, guess)
    push(socket, "tally", tally)
    {:noreply, socket}
  end

  def handle_in("new_game", _, socket) do
    game = Hangman.new_game()
    socket = assign(socket, :game, game)
    handle_in("tally", nil, socket)
  end

  def handle_in(kind, message, socket) do
    Logger.warn("#{__MODULE__}.handle_in unhandled message \"#{kind}\": #{inspect(message)}")
    {:noreply, socket}
  end

end
