defmodule EggTimer.Alarm do
  defstruct ~w[duration name time f]a

  def new(name, duration, f \\ &default_fn/0)
      when is_atom(name) and is_integer(duration) and is_function(f) do
    __struct__(
      time: Time.utc_now(),
      name: name,
      duration: duration,
      f: f
    )
  end

  def trigger(alarm) do
    alarm.f.()
    alarm
  end

  def default_fn do
    IO.puts("Alarm triggered!")
  end
end
