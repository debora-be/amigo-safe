defmodule AmigoSafe.Repo.Migrations.CreateUsersTable do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :name, :string
      add :contact, :string

      timestamps()
    end
  end
end
