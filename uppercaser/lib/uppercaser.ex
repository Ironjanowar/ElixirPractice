defmodule Uppercaser do
  def start do
    loop()
  end

  def loop do
    receive do
      {:string, from, str} -> send(from, {:ok, String.upcase str})
    end
    loop()
  end
end
