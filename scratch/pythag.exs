IO.puts "Naive:"
:timer.tc(fn ->
  for \
    a <- 1..99,
    b <- 1..99,
    c <- 1..99,
    a*a + b*b == c*c
  do
    {a, b, c}
  end
end) |> IO.inspect(limit: 100)


IO.puts "Bit less naive:"
:timer.tc(fn ->
  for \
    a <- 1..99,
    b <- 1..99,
    c <- 1..99,
    a < b and b < c,
    a*a + b*b == c*c
  do
    {a, b, c}
  end
end) |> IO.inspect(limit: 100)


IO.puts "Even less naive:"
:timer.tc(fn ->
  for \
    a <- 1..99,
    b <- (a+1)..99,
    c <- (b+1)..99,
    a*a + b*b == c*c
  do
    {a, b, c}
  end
end) |> IO.inspect(limit: 100)



IO.puts "... less naive:"
:timer.tc(fn ->
  for \
    a <- 1..97,
    b <- (a+1)..98,
    c <- (b+1)..99,
    a + b > c,
    a*a + b*b == c*c
  do
    {a, b, c}
  end
end) |> IO.inspect(limit: 100)
