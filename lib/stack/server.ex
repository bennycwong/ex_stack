defmodule Stack.Server do
  use GenServer
  ######
  # External API
  def start_link(stash_pid) do
    GenServer.start_link(__MODULE__, stash_pid, name: __MODULE__)
  end

  def pop do
    GenServer.call(__MODULE__, :pop)
  end

  def push(item) do
    GenServer.cast(__MODULE__, {:push, item})
  end

  ######
  # Server Implimentation
  ###
  def init(stash_pid) do
    list = Stack.Stash.get_value stash_pid
    {:ok, {list, stash_pid}} 
  end

  def handle_call(:pop, _from, {[h | t], stash_pid}) do
    {:reply, h, {t, stash_pid}}
  end

  def handle_call(:pop, _from, {[], stash_pid}) do
    {:reply, nil, {[], stash_pid}}
  end

  def handle_cast({:push, item}, {list, stash_pid}) do
    {:noreply, {[item | list], stash_pid}}
  end

  def terminate(_reason, {list, stash_pid}) do
    Stack.Stash.save_value(stash_pid, list)
  end

end

