defmodule Sage.QuestionTypeTest do
  use Sage.DataCase

  alias Sage.Surveys
  alias Sage.Surveys.Question
  alias Sage.Surveys.QuestionType.{Single, Multi, Text, Number}

  describe "create_question/1 with type single:" do
    test "options must not be empty" do
      assert %Ecto.Changeset{valid?: false} =
               Single.changeset(%Single{}, %{
                 options: []
               })
    end

    test "valid" do
      assert %Ecto.Changeset{valid?: true} =
               Single.changeset(%Single{}, %{
                 options: ["Teste", "Teste 2"]
               })
    end
  end

  describe "create_question/1 with type multi:" do
    test "options must not be empty" do
      assert %Ecto.Changeset{valid?: false} =
               Multi.changeset(%Multi{}, %{
                 options: []
               })
    end

    test "valid" do
      assert %Ecto.Changeset{valid?: true} =
               Multi.changeset(%Multi{}, %{
                 options: ["Teste", "Teste 2"]
               })
    end
  end

  describe "create_question/1 with type text:" do
    test "length must be >= 0" do
      assert %Ecto.Changeset{valid?: false} =
               Text.changeset(%Text{}, %{
                 min_length: -1
               })

      assert %Ecto.Changeset{valid?: false} =
               Text.changeset(%Text{}, %{
                 max_length: 0
               })
    end

    test "valid" do
      assert %Ecto.Changeset{valid?: true} = Text.changeset(%Text{}, %{})

      assert %Ecto.Changeset{valid?: true} =
               Text.changeset(%Text{}, %{
                 min_length: 5,
                 max_length: 10
               })
    end
  end

  describe "create_question/1 with type number:" do
    test "value can be negative or zero" do
      assert %Ecto.Changeset{valid?: true} =
               Text.changeset(%Text{}, %{
                 min_value: -10
               })

      assert %Ecto.Changeset{valid?: true} =
               Text.changeset(%Text{}, %{
                 max_value: 0
               })
    end

    test "valid" do
      assert %Ecto.Changeset{valid?: true} = Text.changeset(%Text{}, %{})

      assert %Ecto.Changeset{valid?: true} =
               Text.changeset(%Text{}, %{
                 min_length: 5,
                 max_length: 10
               })
    end
  end
end
