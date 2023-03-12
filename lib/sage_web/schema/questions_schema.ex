defmodule SageWeb.Schema.QuestionsSchema do
  use SageWeb, :resolver

  enum :question_type do
    value :single
    value :multi
    value :text
    value :number
  end

  interface :question do
    field! :id, :id
    field! :title, :string
    field! :type, :question_type

    resolve_type fn
      %{type: :single}, _ -> :single_question
      %{type: :multi}, _ -> :multi_question
      %{type: :text}, _ -> :text_question
      %{type: :number}, _ -> :number_question
      _, _ -> nil
    end
  end

  object :single_question do
    field! :id, :id
    field! :title, :string
    field! :type, :question_type

    field! :options, list_of!(:string)

    interface :question
  end

  object :multi_question do
    field! :id, :id
    field! :title, :string
    field! :type, :question_type

    field! :options, list_of!(:string)

    interface :question
  end

  object :text_question do
    field! :id, :id
    field! :title, :string
    field! :type, :question_type

    field :min_length, :integer
    field :max_length, :integer

    interface :question
  end

  object :number_question do
    field! :id, :id
    field! :title, :string
    field! :type, :question_type

    field :min_value, :integer
    field :max_value, :integer

    interface :question
  end

  object :query_questions do
    field! :lorem, :question do
      resolve fn _, __ -> nil end
    end
  end

  object :mutation_questions do
    field! :lorem, :question do
      resolve fn _, __ -> nil end
    end
  end
end
