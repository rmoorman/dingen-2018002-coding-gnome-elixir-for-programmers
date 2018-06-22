defmodule GallowsWeb.HangmanController do
  use GallowsWeb, :controller

  def new_game(conn, _params) do
    render conn, "new_game.html"
  end

  def create_game(conn, _params) do
    game = Hangman.new_game()

    conn
    |> put_session(:game, game)
    |> redirect(to: hangman_path(conn, :game_field))
  end

  def game_field(conn, _params) do
    game = get_session(conn, :game)
    tally = Hangman.tally(game)

    conn
    |> render("game_field.html", tally: tally)
  end
end
