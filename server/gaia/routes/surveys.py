from flask import Blueprint, jsonify

from gaia.models.db import Survey, SurveyQuestion
from gaia.models.utils import QuestionType
from .utils import verify_user

bp = Blueprint('surveys', __name__)


@bp.route("/create", methods=['POST'])
def survey_create():
    user = verify_user()

    survey = Survey(
        title='Banana',
        owner=user
    )

    for i in range(10):
        SurveyQuestion(
            survey=survey,
            title=f'Single Choice #{i}',
            description='Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nunc eget '
                        'sapien eu massa tempus euismod sed quis lectus. Pellentesque augue arcu, '
                        'auctor ac erat at, pharetra faucibus augue. In lorem ligula, '
                        'maximus vitae lorem eu, feugiat porttitor elit. Vivamus ut sagittis '
                        'nulla. Nam fermentum blandit lacus id viverra. Nullam vitae dui ac nunc '
                        'euismod aliquam. Nam nisi mi, ultricies id nunc eu, faucibus lobortis '
                        'nibh. Nullam vel porta lorem, quis mollis elit. Vivamus in mauris sit '
                        'amet massa viverra mollis eu sit amet elit. Maecenas molestie elementum '
                        'velit nec tempor.',
            type=QuestionType.SINGLE_CHOICE
        )

        SurveyQuestion(
            survey=survey,
            title=f'Multiple Choice #{i}',
            description='Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
            type=QuestionType.MULTI_CHOICE
        )

    return jsonify(survey.to_dict())


@bp.route("/list")
def survey_list():
    user = verify_user()

    survey = Survey(
        title='Banana',
        owner=user
    )

    return jsonify(survey.to_dict())


@bp.route("/<id>")
def survey_detail(id):
    user = verify_user()

    survey = Survey.get(id=id)

    survey_d = survey.to_dict(exclude='answers', related_objects=True, with_collections=True)

    survey_d['owner'] = survey_d['owner'].to_dict()

    return jsonify(survey_d)
