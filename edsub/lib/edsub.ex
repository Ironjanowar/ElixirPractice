defmodule Edsub do
  def mediator_state do
    GenServer.call :mediator, :state
  end

  def run_test do
    Edsub.Mediator.start_link
    state = mediator_state()
    IO.puts "Mediator state: #{inspect state}"
    Edsub.Subscriber.start_link :first_sub
    IO.puts "First subscriber!"
    state = mediator_state()
    IO.puts "Mediator state: #{inspect state}"
    Edsub.Editor.publish :broadcast, :hi
  end
end
