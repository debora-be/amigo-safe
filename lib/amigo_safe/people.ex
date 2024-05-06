defmodule AmigoSafe.People do
  import Ecto.Query, warn: false
  alias AmigoSafe.Repo
  alias AmigoSafe.People.Amigo

  def list_amigos do
    Repo.all(Amigo)
  end

  def get_amigo!(id), do: Repo.get!(Amigo, id)

  def create_amigo(attrs \\ %{}) do
    %Amigo{}
    |> Amigo.changeset(attrs)
    |> Repo.insert()
  end

  def update_amigo(%Amigo{} = amigo, attrs) do
    amigo
    |> Amigo.changeset(attrs)
    |> Repo.update()
  end

  def delete_amigo(%Amigo{} = amigo) do
    Repo.delete(amigo)
  end

  def change_amigo(%Amigo{} = amigo, attrs \\ %{}) do
    Amigo.changeset(amigo, attrs)
  end
end
