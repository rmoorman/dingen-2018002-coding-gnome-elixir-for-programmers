defmodule Dictionary do

  alias Dictionary.WordList

  @spec start() :: [String.t()]
  defdelegate start(), to: WordList, as: :word_list

  @spec random_word([String.t]) :: String.t
  defdelegate random_word(state), to: WordList

end
