defmodule Client do
  def add(food) do
    GenServer.call(:fridge, {:add, food})
  end

  def show do
    GenServer.call(:fridge, :show)
  end

  def ping do
    GenServer.call(:fridge, :ping)
  end

  def drop do
    GenServer.call(:fridge, :drop)
  end
end
