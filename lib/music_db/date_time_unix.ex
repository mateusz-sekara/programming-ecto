defmodule MusicDB.DateTimeUnix do
  @behaviour Ecto.Type

  @impl true
  def type(), do: :datetime

  @impl true
  def dump(term), do: Ecto.Type.dump(:datetime, term)

  @impl true
  def load(term), do: Ecto.Type.load(:datetime, term)

  @impl true
  def cast("Date(" <> rest) do
    with {unix, ")"} <- Integer.parse(rest),
         {:ok, datetime} <- DateTime.from_unix(unix) do
      {:ok, datetime}
    else
      _ -> :error
    end
  end
  @impl true
  def cast(%DateTime{} = datetime), do: {:ok, datetime}
  @impl true
  def cast(_other), do: :error
end
