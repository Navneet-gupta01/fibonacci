defmodule Fibonacci.Application do
  use Application

  def start(_, _) do
    Fibonacci.Supervisor.start_link()
  end
end
