defmodule Demo do

  def reverse do
    receive do
      {from, msg} ->
        result = msg |> String.reverse()
        send(from, result)
        reverse()
    end
  end

end
