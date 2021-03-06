defmodule Fibonacci do
  use GenServer

  alias Updater

  @moduledoc """
  Documentation for Fibonacci.
  """

  def start_link(_) do
    GenServer.start_link(__MODULE__, nil, name: __MODULE__)
  end

  def calculate(x) when is_integer(x) and x < 0, do: {:error, :invalid_argument}

  def calculate(x) when is_integer(x) do
    GenServer.call(__MODULE__, {:get, x})
  end

  def calculate(x) when is_list(x) do
    case Enum.all?(x, fn k -> k >= 0 end) do
      true ->
        list =
          x
          |> Enum.map(fn x ->
            {:ok, val} = calculate(x)
            val
          end)

        {:ok, list}

      _ ->
        {:error, :invalid_argument}
    end
  end

  def calculate(_x), do: {:error, :invalid_argument}

  def history() do
    GenServer.call(__MODULE__, :history)
  end

  def history_count do
    GenServer.call(__MODULE__, :history_count)
  end

  @impl true
  def init(_) do
    {:ok, %{series: %{0 => 0, 1 => 1}, history: [], history_count: %{}}}
  end

  @impl true
  def handle_call({:get, key}, _from, state) do
    case Map.get(state.series, key) do
      nil ->
        {val, x_series} = extend_series(key, state.series)

        {_, new_history_count} =
          state.history_count
          |> Map.get_and_update(key, &Updater.update(&1))

        {:reply, {:ok, val},
         %{
           series: Map.merge(state.series, x_series),
           history: [{key, val} | state.history],
           history_count: new_history_count
         }}

      value ->
        {_, new_history_count} =
          state.history_count
          |> Map.get_and_update(key, &Updater.update(&1))

        {:reply, {:ok, value},
         %{
           series: state.series,
           history: [{key, value} | state.history],
           history_count: new_history_count
         }}
    end
  end

  @impl true
  def handle_call(:history, _from, %{history: history} = state),
    do: {:reply, {:ok, Enum.reverse(history)}, state}

  @impl true
  def handle_call(:history_count, _from, %{history_count: history_count} = state),
    do: {:reply, {:ok, history_count}, state}

  def extend_series(0, already_calculated_series), do: {0, already_calculated_series}
  def extend_series(1, already_calculated_series), do: {1, already_calculated_series}

  def extend_series(key, already_calculated_series) do
    calculated_till =
      already_calculated_series
      |> Map.keys()
      |> Enum.max()

    # extra calculatin to be done for extension, second_last calculated, last_calculated, acc
    extend_series(
      key - calculated_till,
      Map.fetch!(already_calculated_series, calculated_till - 1),
      Map.fetch!(already_calculated_series, calculated_till),
      calculated_till,
      %{}
    )
  end

  def extend_series(0, _second_last, last, _, extension), do: {last, extension}

  def extend_series(extra_to_calculate, second_last, last, max_calculated, extension) do
    next_elt_of_series = second_last + last
    extension = Map.put(extension, max_calculated + 1, next_elt_of_series)
    extend_series(extra_to_calculate - 1, last, next_elt_of_series, max_calculated + 1, extension)
  end
end
