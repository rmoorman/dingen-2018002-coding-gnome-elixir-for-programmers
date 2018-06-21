defmodule GallowsWeb.PageView do
  use GallowsWeb, :view

  def plural_of(word, 1), do: "1 #{word}"
  def plural_of(word, count) when count < 0 do
    {:safe, [
      "<span style='color: red'>",
      Plug.HTML.html_escape(plural_of(word, abs(count))),
      "</span>"
    ]}
  end
  def plural_of(word, count), do: "#{count} #{word}s"
end
