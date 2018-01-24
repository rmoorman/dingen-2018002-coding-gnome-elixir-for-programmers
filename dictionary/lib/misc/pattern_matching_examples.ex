defmodule Misc.PatternMatchingExamples do
  defmodule Fib do
    def seq(0), do: 0
    def seq(1), do: 1
    def seq(n), do: seq(n - 1) + seq(n - 2)
  end

  def swap({x, y}), do: {y, x}

  def same(x, x), do: true
  def same(_, _), do: false
end
