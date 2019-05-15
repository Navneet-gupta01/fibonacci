# Fibonacci


## Fibonacci Server
```
  git clone git@github.com:Navneet-gupta01/fibonacci.git
  cd fibonacci
  mix deps.get
  iex -S mix
```

Playing With Server
```elixir
   iex> Fibonacci.calculate(3)
   {:ok, 2}
   iex> Fibonacci.calculate(5)
   {:ok, 5}
   iex> Fibonacci.calculate(3)
   {:ok, 2}
   iex> Fibonacci.calculate(100)
   {:ok, 354224848179261915075}
   iex> Fibonacci.calculate(0)
   {:ok, 0}
   iex> Fibonacci.calculate([1,2,3,4])
   {:ok, [1,1,2,3]}
   iex> Fibonacci.history()
   {:ok, [{3, 2}, {5, 5}, {3, 2}, {100, 354224848179261915075}, {0, 0}, {1, 1}, {2, 1}, {3, 2}, {4, 3}]}
   iex> Fibonacci.history_count()
   {:ok, %{0 => 1, 1 => 1, 2 => 1, 3 => 3, 4 => 1, 5 => 1, 100 => 1}}
```

## Running without repl 
```
  git clone git@github.com:Navneet-gupta01/fibonacci.git
  cd fibonacci
  mix deps.get
  mix run --no-halt
```

Playing with Http Apis
```
curl http://localhost:4000/fibonacci\?numbers\=6
{"resp":8}
curl http://localhost:4000/fibonacci\?numbers\=7
{"resp": 13}
curl http://localhost:4000/fibonacci\?numbers\=7,8,9,11
{"resp":[13,21,34,89]}
curl http://localhost:4000/fibonacci/history
{"resp":{"0":0,"1":1,"2":1,"3":2,"4":3,"5":5,"6":8,"7":13,"8":21,"9":34,"11":89,"100":354224848179261915075}}
curl http://localhost:4000/fibonacci/history/count
{"resp":{"0":1,"1":2,"2":1,"3":3,"4":1,"5":1,"6":2,"7":2,"8":1,"9":1,"11":1,"100":1}}
```

## Assumptions:
* history of list is shown one by one. Ex: Fibonacci.calculate([1,2,3]) and then getting history Fibonacci.history() will  give [{1,1}, {2, 1}, {3, 2}].   
	It Could be changed if its not desirable like that.  
* history_count response format given as map cannot be sorted as per requirement by req count, Since elixir Does not map sorting   



**TODO: Add description**

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `fibonacci` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:fibonacci, "~> 0.1.0"}
  ]
end
```

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at [https://hexdocs.pm/fibonacci](https://hexdocs.pm/fibonacci).

