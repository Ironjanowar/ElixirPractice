defmodule PingpongTest do
  use ExUnit.Case

  test "It responds to a pong with a ping" do
    ping = spawn(Ping, :start, [])
    send(ping, {:pong, self()})
    assert_receive {:ping, ping}
    send(ping, {:pong, self()})
    assert_receive {:ping, ping}
  end
end
