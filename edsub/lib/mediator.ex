defmodule Edsub.Mediator do
  use GenServer

  def start_link do
    GenServer.start_link __MODULE__, :ok, [name: :mediator]
  end

  def init(:ok) do
    {:ok, %{broadcast: [], meh: []}}
  end

  # Calls
  def handle_call({:sub, topic}, from, state) do
    case Map.has_key?(state, topic) do
      true ->
        %{^topic => topic_list} = state
        {pid, _} = from
        {:reply, "Added to #{topic} topic", Map.put(state, topic, [pid | topic_list])}
      _ -> {:reply, "Not added to #{topic} topic", state}
    end
  end

  def handle_call({:unsub, topic}, from, state) do
    case Map.has_key?(state, topic) do
      true ->
        {from_pid, _} = from
        case Map.get(state, topic) |> Enum.member?(from_pid) do
          true ->
            topic_list = Map.get(state, topic) |> List.delete(from_pid)
            {:reply, "Unsubscribed from #{topic}", Map.put(state, topic, topic_list)}
            _ -> {:reply, "Not subscribed to #{topic}", state}
        end
    end
  end

  def handle_call(:state, _from, state) do
    {:reply, state, state}
  end

  # Cast
  def handle_cast({:pub, topic, message}, state) do
    for pid <- Map.get(state, topic) do
      GenServer.cast(pid, {:notify, message})
    end

    {:noreply, state}
  end
end
