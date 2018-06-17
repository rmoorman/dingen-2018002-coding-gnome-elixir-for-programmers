defmodule Hangman.MixProject do
  use Mix.Project

  def project do
    [
      app: :hangman,
      version: "0.1.0",
      elixir: ">= 1.5.3",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  def application do
    [
      mod: {Hangman.Application, []},
      extra_applications: [:logger],
    ]
  end

  defp deps do
    [
      {:dictionary, path: "../dictionary"},
      #{:inflex, "~> 1.9"},
    ]
  end
end
