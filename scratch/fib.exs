defmodule Fib.Naive do
  def fib(0), do: 0
  def fib(1), do: 1
  def fib(n), do: fib(n - 1) + fib(n - 2)
end


defmodule Fib.Cached do
  def fib(n) do
    {result, _} = fib(n, %{})
    result
  end

  def fib(0, cache), do: {0, cache}
  def fib(1, cache), do: {1, cache}
  def fib(n, cache) do
      case Map.fetch(cache, n) do
        {:ok, result} -> {result, cache}
        _ ->
          {fibMinus1, cache} = fib(n - 1, cache)
          {fibMinus2, cache} = fib(n - 2, cache)
          result = fibMinus1 + fibMinus2
          {fibMinus1 + fibMinus2, Map.put(cache, n, result)}
      end
  end
end


defmodule Fib.AgentCached do
  def fib(n) do
    {:ok, agent} = Agent.start_link(fn -> %{0 => 0, 1 => 1} end)
    result = fib(n, agent)
    Agent.stop(agent)
    result
  end

  def fib(n, agent) do
    Agent.get(agent, fn cache -> Map.get(cache, n) end)
    |> calculate_and_store_if_needed(agent, n, fn ->
      fib(n - 2, agent) + fib(n - 1, agent)
    end)
  end

  defp calculate_and_store_if_needed(nil, agent, n, calculation) do
    result = calculation.()
    Agent.get_and_update(agent, fn cache ->
      {result, Map.put(cache, n, result)}
    end)
  end

  defp calculate_and_store_if_needed(result, agent, n, calculation) do
    result
  end

  # nested gen server calls inside processes are not allowed (possible deadlock)
  # <https://elixirforum.com/t/using-process-register-and-getting-process-attempted-to-call-itself/4411>
  # "process attempted to call itself"
  #
  #def fib(n, agent) do
  #  Agent.get_and_update(agent, fn cache ->
  #    case Map.fetch(cache, n) do
  #      {:ok, result} -> {result, cache}
  #      _ ->
  #        result = fib(n - 2, agent) + fib(n - 1, agent)
  #        {result, Map.put(cache, n, result)}
  #    end
  #  end)
  #end
end


defmodule Fib.AgentCached2 do
  defmodule Cache do
    def start_link(initial_state) do
      Agent.start_link(fn -> initial_state end)
    end

    def get(cache, key) do
      Agent.get(cache, & Map.get(&1, key))
    end

    def put(cache, key, value) do
      Agent.get_and_update(cache, & {value, Map.put(&1, key, value)})
    end

    defdelegate stop(cache), to: Agent
  end

  def fib(n) do
    {:ok, cache} = Cache.start_link(%{0 => 0, 1 => 1})
    result = fib(cache, n)
    Cache.stop(cache)
    result
  end

  def fib(cache, n) do
    case Cache.get(cache, n) do
      nil ->
        result = fib(cache, n - 2) + fib(cache, n - 1)
        Cache.put(cache, n, result)
      result ->
        result
    end
  end
end


defmodule Fib.EssenceOfChaos do
  # https://gist.github.com/pragdave/f8c7684b69d235269139bad0a2419273#gistcomment-2354632
  # with adjustment so that it does terminate on find(0)
  # basically tail recursive fib as seen here for example
  # https://www.geeksforgeeks.org/tail-recursion-fibonacci/
  def find(n), do: find(n, 0, 1)
  def find(0, acc1, _acc2), do: acc1
  def find(1, _acc1, acc2), do: acc2

  def find(n, acc1, acc2) do
    find(n - 1, acc2, acc1 + acc2)
  end
end
