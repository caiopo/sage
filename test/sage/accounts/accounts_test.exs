defmodule Sage.Accounts.AccountsTest do
  use Sage.DataCase

  import Commanded.Assertions.EventAssertions

  alias Sage.Accounts
  alias Sage.Accounts.Projections.Survey
  alias Sage.Accounts.Events.{UserRegistered, PasswordChanged}

  describe "register user" do
    test "blabla" do
      email = "lorem@ipsum.com"
      password = "Helloworld123"

      {:ok, state} =
        Accounts.register_user(
          email: email,
          password: password
        )

      %{id: user_id} = state

      # assert produced events
      assert_receive_event(Sage.Commanded, UserRegistered, fn event ->
        assert event.user_id == user_id
        assert event.email == email
        assert state.password_hash == event.password_hash
      end)

      # assert aggregate state
      assert {:ok, _} = Uniq.UUID.info(state.id)
      assert state.email == email
      assert Bcrypt.verify_pass(password, state.password_hash)

      # assert projected entity
      projected = Accounts.get_by_id!(user_id)
      assert projected.id == user_id
      assert projected.email == email
      assert projected.password_hash == state.password_hash
    end
  end
end
