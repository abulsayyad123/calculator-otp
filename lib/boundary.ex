defmodule Calculator.Boundary do
  alias Calculator.Core
  def start(initial_state) do
    spawn(fn -> run(initial_state) end) # <--- init
  end

  def run(state) do
    state
    |> listen
    |> run
  end

  def listen(state) do
    receive do
      {:add, number} ->
        Core.add(state, number) # handle_cast
      {:subtract, number} ->
        Core.subtract(state, number) # handle_cast
      {:multiply, number} ->
        Core.multiply(state, number) # handle_cast
      {:divide, number} ->
        Core.divide(state, number) # handle_cast
      {:custom, f, number} ->
        Core.custom(state, f, number) # handle_cast
      {:state, pid} ->
        send(pid, {:state, state}) # handle_call
      state
    end
  end
end