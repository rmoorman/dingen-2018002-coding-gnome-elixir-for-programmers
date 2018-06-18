defmodule Chain do

  defstruct([
    next_node: nil,
    count: 4000,
  ])


  def start_link(next_node) do
    spawn_link(Chain, :message_loop, [%Chain{next_node: next_node}])
    |> Process.register(:chainer)
  end


  def message_loop(%Chain{count: 0}) do
    IO.puts("done")
  end

  def message_loop(%Chain{next_node: next_node, count: count} = state) do
    receive do
      {:trigger, list} ->
        send({:chainer, next_node}, {:trigger, [node() | list]})
    end
    message_loop(%Chain{state | count: count - 1})
  end

end
