defmodule FibonacciTest do
  use ExUnit.Case
  doctest Fibonacci

  test "greets the world" do
    assert Fibonacci.hello() == :world
  end

  test "Fibnoacci.calculate/1 should give the correct result" do
    assert Fibonacci.calculate(0) == {:ok, 0}
    assert Fibonacci.calculate(2) == {:ok, 1}
    assert Fibonacci.calculate(1) == {:ok, 1}
    assert Fibonacci.calculate(3) == {:ok, 2}
    assert Fibonacci.calculate(4) == {:ok, 3}
    assert Fibonacci.calculate(5) == {:ok, 5}
    assert Fibonacci.calculate(6) == {:ok, 8}
    assert Fibonacci.calculate(7) == {:ok, 13}
    assert Fibonacci.calculate(8) == {:ok, 21}
    assert Fibonacci.calculate(100) == {:ok, 354_224_848_179_261_915_075}
  end

  test "Fibnoacci.calculate/1 with list element should give the correct result" do
    assert Fibonacci.calculate([0, 1, 2]) == {:ok, [0, 1, 1]}
    assert Fibonacci.calculate([0, 3, 5]) == {:ok, [0, 2, 5]}
    assert Fibonacci.calculate([4, 6, 8]) == {:ok, [3, 8, 21]}
    assert Fibonacci.calculate([11, 12, 16]) == {:ok, [89, 144, 987]}
    assert Fibonacci.calculate([0, 1, 100]) == {:ok, [0, 1, 354_224_848_179_261_915_075]}
  end
end
