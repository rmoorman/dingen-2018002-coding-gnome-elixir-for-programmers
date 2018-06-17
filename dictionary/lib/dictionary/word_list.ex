defmodule Dictionary.WordList do

  @spec random_word([String.t]) :: String.t
  def random_word(word_list) do
    word_list
    |> Enum.random()
  end

  @spec word_list() :: [String.t()]
  def word_list() do
    "../../assets/words.txt"
    |> Path.expand(__DIR__)
    |> File.read!()
    |> String.split(~r/\n/)
  end

end
