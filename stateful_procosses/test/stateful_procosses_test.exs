defmodule StatefulProcossesTest do
  use ExUnit.Case
  doctest StatefulProcosses

  test "Starting a counter" do
    {:ok, pid} = Counter.start(0)
    assert is_pid(pid)
  end

  test "Getting a counter value" do
    {:ok, pid} = Counter.start(0)
    assert {:ok, 0} = Counter.get_value(pid)
  end

  test "Incrementing the counter value" do
    {:ok, pid} = Counter.start(0)
    :ok = Counter.increment(pid)
    assert {:ok, 1} = Counter.get_value(pid)
  end

  test "Decrementing the counter value" do
    {:ok, pid} = Counter.start(1)
    :ok = Counter.decrement(pid)
    assert {:ok, 0} = Counter.get_value(pid)
  end
end
