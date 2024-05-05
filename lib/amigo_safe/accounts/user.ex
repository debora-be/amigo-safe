defmodule AmigoSafe.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset

  schema "users" do
    field :name, :string
    field :contact, :string

    has_many :amigos, AmigoSafe.Pets.Amigo

    timestamps()
  end

  def changeset(user, attrs) do
    user
    |> cast(attrs, [:name, :contact])
    |> validate_required([:name, :contact])
  end
end
