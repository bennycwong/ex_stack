defmodule Stack.Supervisor do
  use Supervisor
  def start_link(initial_state) do
    result = {:ok, sup} = Supervisor.start_link(__MODULE__, [initial_state])
    start_workers(sup, initial_state)
    result

  end
  def start_workers(sup, initial_state) do
    #Start the stash workers
    {:ok, stash} = Supervisor.start_child(sup, worker(Stack.Stash, [initial_state]))
    #Then start the subsupervisor
    Supervisor.start_child(sup, supervisor(Stack.SubSupervisor, [stash]) )
  end
  
  def init(_) do
    supervise [], strategy: :one_for_one
  end


end

