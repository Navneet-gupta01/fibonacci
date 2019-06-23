defmodule Updater do
  @moduledoc """
  Documentation for Updater.
  """

  @doc """
  Updater Used in Map Update.

  Increments a value by 1 if value is integer, or retunr 1 if nil

  response: {old_value, new_value}

  ## Examples

      iex> Updater.update(nil)
      {nil, 1}

      iex> Updater.update(1)
      {1, 2}

      iex> Updater.update(9)
      {9, 10}

      iex> Updater.update("ssds")
      {:error, :invalid_argument}

  """
  @spec update(value: term) :: {term, term} | {:error, :invalid_argument}
  def update(value) when is_nil(value), do: {value, 1}

  def update(value) when is_integer(value) do
    {value, value + 1}
  end

  def update(_), do: {:error, :invalid_argument}
end
