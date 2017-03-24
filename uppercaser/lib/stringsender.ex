defmodule Stringsender do
  def start(receiver, string) do
    send(receiver, {:string, self, string})
    IO.puts "#{string} sended"
    receive do
      {:ok, upper} -> IO.puts "#{upper} received!"
    end
  end
end
