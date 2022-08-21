defmodule MusicDb.ConcurrentTest do
  use ExUnit.Case, async: true
  alias MusicDB.Repo
  alias MusicDB.Album

  setup do
    :ok = Ecto.Adapters.SQL.Sandbox.checkout(Repo)
  end

  test "insert album" do
    parent = self()

    task = Task.async(fn ->
      Ecto.Adapters.SQL.Sandbox.allow(Repo, parent, self())
      album = Repo.insert!(%Album{title: "Giant Steps"})
      album.id
    end)

    album_id = Task.await(task)
    new_album = Repo.get!(Album, album_id)
    assert new_album.title == "Giant Steps"
  end
end
