defmodule Procs do

  def greeter(what_to_say) do
    receive do
      msg ->
        IO.puts("#{what_to_say}: #{msg}")
    end
    greeter(what_to_say)
  end


  def counter(count \\ 0) when is_integer(count) do
    receive do
      {:add, amount} when is_integer(amount) ->
        counter(count + amount)
      {:reset} ->
        counter(0)
      msg ->
        IO.puts "Unknown message #{inspect msg} received... Anyway, the current count is #{inspect count}"
        counter(count)
    end
  end
end
