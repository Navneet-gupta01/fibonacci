defmodule FibonacciTest do
  use ExUnit.Case
  doctest Fibonacci

  setup_all do
    {:ok, _pid} = Fibonacci.start_link(nil)
    :ok
  end

  test "greets the world", _context do
    assert Fibonacci.hello() == :world
  end

  # @tag :pending
  test "Fibnoacci.calculate/1 should give the correct result", _context do
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

  @tag :pending
  test "Fibnoacci.calculate/1 with list element should give the correct result" do
    assert Fibonacci.calculate([0, 1, 2]) == {:ok, [0, 1, 1]}
    assert Fibonacci.calculate([0, 3, 5]) == {:ok, [0, 2, 5]}
    assert Fibonacci.calculate([4, 6, 8]) == {:ok, [3, 8, 21]}
    assert Fibonacci.calculate([11, 12, 16]) == {:ok, [89, 144, 987]}
    assert Fibonacci.calculate([0, 1, 100]) == {:ok, [0, 1, 354_224_848_179_261_915_075]}
  end

  @tag :pending
  test "Fibonacci.calculate/1 should fail for non-integer arguments" do
    assert Fibonacci.calculate("test") == {:error, :invalid_argument}
  end

  @tag :pending
  test "Fibonacci.history/0 should return already asked numbers ordered from first to last" do
    [1, 2, 3, 4, 5, 6, 8, 9, 0, 1, 2, 0, 1]
    |> Enum.each(&Fibonacci.calculate(&1))

    assert Fibonacci.history() ==
             {:ok,
              [
                {1, 1},
                {2, 1},
                {3, 2},
                {4, 3},
                {5, 5},
                {6, 8},
                {8, 21},
                {9, 34},
                {0, 0},
                {1, 1},
                {2, 1},
                {0, 0},
                {1, 1}
              ]}
  end

  @tag :pending
  test "Fibonacci.history_count/0 should return map of %{input => count}" do
    a = [0, 1, 2, 0, 3, 1, 2, 3, 0, 0, 1, 100, 100, 12, 13, 15, 12]
    a |> Enum.each(&Fibonacci.calculate(&1))

    assert Fibonacci.history_count() ==
             {:ok,
              a
              |> Enum.reduce(%{}, fn x, acc ->
                {_, acc} = acc |> Map.get_and_update(x, &Updater.update(&1))
                acc
              end)}
  end
end
