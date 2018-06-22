defmodule Gallows.Views.Helpers.GameStateHelper do
  import Phoenix.HTML.Tag, only: [content_tag: 3]

  @responses %{
    :won => {:success, "You Won!"},
    :lost => {:danger, "You Lost!"},
    :good_guess => {:success, "Good guess!"},
    :bad_guess => {:warning, "Bad guess!"},
    :already_used => {:info, "You already guessed that"},
  }

  def game_state(state) do
    @responses[state]
    |> alert()
  end

  def alert(nil), do: ""
  def alert({type, message}) do
    content_tag(:div, message, class: "alert alert-#{type}")
  end
end
