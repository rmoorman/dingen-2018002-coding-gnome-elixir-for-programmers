defmodule Dictionary do

  alias Dictionary.WordList

  @spec random_word() :: String.t
  defdelegate random_word(), to: WordList

end
