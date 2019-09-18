from gaia.models.db import Survey, Question
from gaia.utils.exceptions import Forbidden


def create_survey(survey_data, owner):
    survey = Survey(
        owner=owner,
        title=survey_data['title'],
    )

    for question_data in survey_data['questions']:
        Question(
            survey=survey,
            type=question_data['type'],
            title=question_data['title'],
            description=question_data['description'],
            extras=question_data['extras'],
        )

    return survey


def edit_survey(survey_data, owner):
    survey = Survey[survey_data['id']]

    if survey.owner != owner:
        raise Forbidden('user is not the owner of this survey')

    return survey
