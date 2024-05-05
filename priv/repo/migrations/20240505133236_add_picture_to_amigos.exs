defmodule AmigoSafe.Repo.Migrations.AddPictureToAmigos do
  use Ecto.Migration

  def change do
    alter table(:amigos) do
      add :picture, :binary
    end
  end
end
