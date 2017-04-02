defmodule Edsub.Subscriber do
  use GenServer
  def start_link(name) do
    GenServer.start_link __MODULE__, :ok, [name: name]
  end

  def init(:ok) do
    subscribe(:broadcast)
    {:ok, []}
  end

  def subscribe(topic) do
    GenServer.call :mediator, {:sub, topic}
  end

  def unsubscribe(topic) do
    GenServer.call :mediator, {:unsub, topic}
  end

  # Cast
  def handle_cast({:notify, message}, state) do
    IO.puts "#{inspect self()} received: #{message}"
    {:noreply, state}
  end
end
