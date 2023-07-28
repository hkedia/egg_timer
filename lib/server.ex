defmodule EggTimer.Server do
  use GenServer
  alias EggTimer.Alarm

  def start_link(timers) when is_map(timers) do
    GenServer.start_link(__MODULE__, timers)
  end

  def schedule(pid, alarm) do
    Process.send_after(pid, {:alarm, alarm.name}, alarm.duration)
    :ok
  end

  def init(timers) do
    {:ok, timers}
  end

  def handle_info({:alarm, name}, timers) do
    Alarm.trigger(timers[name])
    new_timers = Map.delete(timers, name)

    {:noreply, new_timers}
  end
end
