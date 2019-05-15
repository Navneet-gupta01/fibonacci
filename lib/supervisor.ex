defmodule Fibonacci.Supervisor do
  def start_link do
    Supervisor.start_link(
      [
        Fibonacci,
        Web
      ],
      strategy: :one_for_one
    )
  end
end
