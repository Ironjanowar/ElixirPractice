defmodule UppercaserTest do
  use ExUnit.Case
  doctest Uppercaser

  test "Simple upper case" do
    receiver = spawn(Uppercaser, :start, [])
    send(receiver, {:string, self, "Hello"})
    assert_receive {:ok, "HELLO"}
  end
end
