defmodule GallowsWeb.HangmanView do
  use GallowsWeb, :view

  import Gallows.Views.Helpers.GameStateHelper

  def word_so_far(tally) do
    tally.letters |> Enum.join(" ")
  end

  def letters_used(tally) do
    tally.used |> Enum.join(" ")
  end

  def new_game_button(conn, label) do
    button(label, to: hangman_path(conn, :create_game))
  end

  def game_over?(%{game_state: game_state}) do
    game_state in [:won, :lost]
  end

  def turn(left, target) when target >= left, do: nil
  def turn(_left, _target), do: :dim
end
