defmodule AmigoSafe.Repo.Migrations.CreateAmigosTable do
  use Ecto.Migration

  def change do
    create table(:amigos) do
      add :name, :string
      add :kind, :string
      add :description, :text
      add :latitude, :float
      add :longitude, :float
      add :status, :string
      add :last_seen_address, :string
      add :last_seen_at, :naive_datetime
      add :user_id, references(:users, on_delete: :delete_all), null: false

      timestamps()
    end

    create index(:amigos, [:user_id])
  end
end
