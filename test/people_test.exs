defmodule AmigoSafe.PeopleTest do
  use AmigoSafe.DataCase, async: true

  alias AmigoSafe.Accounts
  alias AmigoSafe.People
  alias AmigoSafe.People.Amigo

  @user_attrs %{name: "Test User", contact: "test@example.com"}
  @valid_attrs %{
    name: "Zed",
    kind: "cat",
    description: "A black and white cat, eight years, 4.2 kilograms, very friendly",
    latitude: 12.34,
    longitude: 56.78,
    status: "lost",
    last_seen_address: "123 Main St",
    last_seen_at: ~N[2024-05-05 12:30:00],
    picture: <<255, 216, 255, 224>>
  }
  @update_attrs %{
    name: "Zad",
    picture: <<255, 216, 255, 225>>
  }
  @invalid_attrs %{
    name: nil,
    kind: nil,
    description: nil,
    latitude: nil,
    longitude: nil,
    status: nil,
    last_seen_address: nil,
    last_seen_at: nil,
    user_id: nil,
    picture: nil
  }

  defp user_fixture(attrs \\ %{}) do
    {:ok, user} = attrs |> Enum.into(@user_attrs) |> Accounts.create_user()
    user
  end

  defp amigo_fixture(attrs \\ %{}) do
    user = user_fixture()

    {:ok, amigo} =
      attrs
      |> Enum.into(Map.put(@valid_attrs, :user_id, user.id))
      |> People.create_amigo()

    amigo
  end

  describe "list_amigos/0" do
    test "returns all amigos" do
      amigo = amigo_fixture()
      assert People.list_amigos() == [amigo]
    end
  end

  describe "get_amigo!/1" do
    test "returns the amigo with given id" do
      amigo = amigo_fixture()
      assert People.get_amigo!(amigo.id) == amigo
    end

    test "raises if no amigo with given id" do
      assert_raise Ecto.NoResultsError, fn -> People.get_amigo!(123_456) end
    end
  end

  describe "create_amigo/1" do
    test "creates an amigo with valid data" do
      assert {:ok, %Amigo{} = amigo} =
               People.create_amigo(Map.put(@valid_attrs, :user_id, user_fixture().id))

      assert amigo.name == "Zed"
      assert amigo.kind == "cat"

      assert amigo.description ==
               "A black and white cat, eight years, 4.2 kilograms, very friendly"

      assert amigo.latitude == 12.34
      assert amigo.longitude == 56.78
      assert amigo.status == "lost"
      assert amigo.last_seen_address == "123 Main St"
      assert amigo.last_seen_at == ~N[2024-05-05 12:30:00]
      assert amigo.picture == <<255, 216, 255, 224>>
    end

    test "returns error changeset with invalid data" do
      assert {:error, %Ecto.Changeset{}} = People.create_amigo(@invalid_attrs)
    end
  end

  describe "update_amigo/2" do
    test "updates an amigo with valid data" do
      amigo = amigo_fixture()
      assert {:ok, %Amigo{} = amigo} = People.update_amigo(amigo, @update_attrs)
      assert amigo.name == "Zad"
      assert amigo.picture == <<255, 216, 255, 225>>
    end

    test "returns error changeset with invalid data" do
      amigo = amigo_fixture()
      assert {:error, %Ecto.Changeset{}} = People.update_amigo(amigo, @invalid_attrs)
      assert amigo == People.get_amigo!(amigo.id)
    end
  end

  describe "delete_amigo/1" do
    test "deletes the amigo" do
      amigo = amigo_fixture()
      assert {:ok, %Amigo{}} = People.delete_amigo(amigo)
      assert_raise Ecto.NoResultsError, fn -> People.get_amigo!(amigo.id) end
    end

    test "raises if amigo does not exist" do
      assert_raise Ecto.StaleEntryError, fn -> People.delete_amigo(%Amigo{id: 123_456}) end
    end
  end

  describe "change_amigo/2" do
    test "returns an amigo changeset" do
      amigo = amigo_fixture()
      assert %Ecto.Changeset{} = People.change_amigo(amigo)
    end

    test "returns error changeset when no amigo exists" do
      changeset = People.change_amigo(%Amigo{id: 123_456}, @update_attrs)
      assert changeset.valid? == false
    end
  end
end
