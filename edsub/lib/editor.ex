defmodule Edsub.Editor do
  def publish(topic, message) do
    GenServer.cast :mediator, {:pub, topic, message}
  end
end
