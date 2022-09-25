defmodule Sage.SurveyUsersTest do
  use Sage.DataCase

  alias Sage.Surveys

  alias Sage.Surveys.SurveyUsers

  import Sage.SurveysFixtures
  import Sage.AccountsFixtures

  test "grant_survey_user_role/3 creates a SurveyUsers with its parameters" do
    survey = survey_fixture()
    user = user_fixture()

    assert Surveys.get_survey_users(survey, user) == nil

    Surveys.grant_survey_user_role(survey, user, :editor)

    su = Surveys.get_survey_users(survey, user)
    assert su.user_id == user.id
    assert su.survey_id == survey.id
    assert su.role == :editor

    # changing the user's role should create a new SurveyUsers
    Surveys.grant_survey_user_role(survey, user, :admin)

    # and soft delete the previous
    assert Repo.get!(SurveyUsers, su.id).deleted_at != nil

    su2 = Surveys.get_survey_users(survey, user)
    assert su2.user_id == user.id
    assert su2.survey_id == survey.id
    assert su2.role == :admin

    # Revoking should also soft delete all SUs
    Surveys.revoke_survey_user_role(survey, user)

    assert Surveys.get_survey_users(survey, user) == nil
  end
end
