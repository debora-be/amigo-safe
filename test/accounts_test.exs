defmodule AmigoSafe.AccountsTest do
  use AmigoSafe.DataCase, async: true

  alias AmigoSafe.Accounts
  alias AmigoSafe.Accounts.User

  @valid_attrs %{name: "Some User", contact: "user@example.com"}
  @update_attrs %{name: "Updated User"}
  @invalid_attrs %{name: nil, contact: nil}

  defp user_fixture(attrs \\ %{}) do
    {:ok, user} =
      attrs
      |> Enum.into(@valid_attrs)
      |> Accounts.create_user()

    user
  end

  describe "list_users/0" do
    test "returns all users" do
      user = user_fixture()
      assert Accounts.list_users() == [user]
    end
  end

  describe "get_user!/1" do
    test "returns the user with given id" do
      user = user_fixture()
      assert Accounts.get_user!(user.id) == user
    end

    test "raises if no user with given id" do
      assert_raise Ecto.NoResultsError, fn -> Accounts.get_user!(123_456) end
    end
  end

  describe "create_user/1" do
    test "creates a user with valid data" do
      assert {:ok, %User{} = user} = Accounts.create_user(@valid_attrs)
      assert user.name == "Some User"
      assert user.contact == "user@example.com"
    end

    test "returns error changeset with invalid data" do
      assert {:error, %Ecto.Changeset{}} = Accounts.create_user(@invalid_attrs)
    end
  end

  describe "update_user/2" do
    test "updates a user with valid data" do
      user = user_fixture()
      assert {:ok, %User{} = user} = Accounts.update_user(user, @update_attrs)
      assert user.name == "Updated User"
    end

    test "returns error changeset with invalid data" do
      user = user_fixture()
      assert {:error, %Ecto.Changeset{}} = Accounts.update_user(user, @invalid_attrs)
      assert user == Accounts.get_user!(user.id)
    end
  end

  describe "delete_user/1" do
    test "deletes the user" do
      user = user_fixture()
      assert {:ok, %User{}} = Accounts.delete_user(user)
      assert_raise Ecto.NoResultsError, fn -> Accounts.get_user!(user.id) end
    end

    test "raises if user does not exist" do
      assert_raise Ecto.StaleEntryError, fn -> Accounts.delete_user(%User{id: 123_456}) end
    end
  end

  describe "change_user/2" do
    test "returns a user changeset" do
      user = user_fixture()
      assert %Ecto.Changeset{} = Accounts.change_user(user)
    end

    test "returns error changeset when no user exists" do
      changeset = Accounts.change_user(%User{id: 123_456}, @update_attrs)
      assert changeset.valid? == false
    end
  end
end
