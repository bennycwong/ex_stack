defmodule Stack do
  use Application

  # See http://elixir-lang.org/docs/stable/elixir/Application.html
  # for more information on OTP Applications
  def start(_type, initial_state) do
    import Supervisor.Spec, warn: false

    # Define workers and child supervisors to be supervised
    {:ok, _pid} = Stack.Supervisor.start_link(initial_state)
  end
end
