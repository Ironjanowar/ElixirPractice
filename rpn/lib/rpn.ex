defmodule Rpn do
  def start do
    Agent.start(fn -> [] end)
  end

  def peek(pid) do
    Agent.get(pid, &operate/1)
  end

  def almost_last([x, _]), do: x
  def almost_last([_, y | rest]), do: almost_last([y|rest])
  def almost_last(_), do: {:error}

  def init([]), do: []
  def init([_]), do: []
  def init([h | rest]), do: [h] ++ init(rest)

  def tail([]), do: []
  def tail([_]), do: []
  def tail([_ | rest]), do: rest

  def operate(stack) do
    case stack |> Enum.reverse do
      [:+, x, y] -> [x + y]
      [:+ | rest] -> operate rest
      [:-, x, y] -> [x - y]
      [:- | rest] -> operate rest
      [:x, x, y] -> [x * y]
      [:x | rest] -> operate rest
    end
  end

  def get_val([x]), do: x
  def get_var(y), do: operate(y)

  def push(pid, elem) do
    Agent.update(pid, fn x -> [elem | x] end)
  end
end
