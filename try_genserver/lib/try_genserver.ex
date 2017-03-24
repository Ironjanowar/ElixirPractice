defmodule TryGenserver do
  use GenServer

  def start_link(initial_state) do
    GenServer.start_link(__MODULE__, initial_state, [name: :fridge])
  end

  def init(initial_state) do
    {:ok, initial_state}
  end

  # Server
  def handle_call({:add, food}, _, state) do
    {:reply, {:added, food}, [food | state]}
  end

  def handle_call(:drop, _, state) do
    {:reply, "The base had been dropped", []}
  end

  def handle_call(:show, _, state) do
    {:reply, state, state}
  end

  def handle_call(:ping, _, state) do
    {:reply, :pong, state}
  end
end
