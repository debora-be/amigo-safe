defmodule AmigoSafe.Pets.Amigo do
  use Ecto.Schema
  import Ecto.Changeset

  schema "amigos" do
    field :name, :string
    field :kind, :string
    field :description, :string
    field :latitude, :float
    field :longitude, :float
    field :status, :string
    field :last_seen_address, :string
    field :last_seen_at, :naive_datetime
    belongs_to :user, AmigoSafe.Accounts.User

    timestamps()
  end

  def changeset(amigo, attrs) do
    amigo
    |> cast(attrs, [
      :name,
      :kind,
      :description,
      :latitude,
      :longitude,
      :status,
      :last_seen_address,
      :last_seen_at,
      :user_id
    ])
    |> validate_required([
      :name,
      :kind,
      :last_seen_address,
      :status,
      :last_seen_at,
      :user_id
    ])
    |> foreign_key_constraint(:user_id)
  end
end
