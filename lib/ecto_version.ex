defmodule EctoVersion do
  @behaviour Ecto.Type

  @impl true
  def type(), do: :string

  @impl true
  def dump(%Version{} = version), do: {:ok, to_string(version)}
  @impl true
  def dump(_), do: :error

  @impl true
  def load(string) when is_binary(string), do: Version.parse(string)
  @impl true
  def load(_), do: :error

  @impl true
  def cast(string) when is_binary(string), do: Version.parse(string)
  @impl true
  def cast(_), do: :error
end
