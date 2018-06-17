defmodule Dictionary.WordList do

  @me __MODULE__

  @spec start_link() :: Agent.on_start
  def start_link() do
    Agent.start_link(&word_list/0, name: @me)
  end

  @spec random_word() :: String.t
  def random_word() do
    # for random crashes ... use this
    #if :rand.uniform() < 0.33 do
    #  Agent.get(@me, fn _ -> exit(:boom) end)
    #end
    Agent.get(@me, &Enum.random/1)
  end

  @spec word_list() :: [String.t()]
  def word_list() do
    "../../assets/words.txt"
    |> Path.expand(__DIR__)
    |> File.read!()
    |> String.split(~r/\n/)
  end

end
