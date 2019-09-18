from flask import Blueprint, jsonify, request
from pony.orm import select

from gaia.business.surveys import create_survey, edit_survey
from gaia.models.db import Survey
from gaia.models.validators import survey_schema
from gaia.utils.exceptions import BadRequest
from .utils import auth_required, validate_with

bp = Blueprint('surveys', __name__)


@bp.route('/')
@auth_required
def survey_list(user):
    survey_ids = select(s.id for s in Survey if s.owner == user)

    return jsonify({
        'content': [{'id': sid} for sid in survey_ids]
    })


@bp.route('/', methods=['POST'])
@auth_required
def survey_create_or_edit(user):
    survey_data = validate_with(survey_schema, request.get_json())

    if survey_data['id'] is None:
        survey = create_survey(survey_data, user)
    else:
        survey = edit_survey(survey_data, user)

    return jsonify(survey.as_dict())


@bp.route('/<int:sid>')
@auth_required
def answer_create(user, sid):
    survey = Survey.get(id=sid)

    if survey is None:
        raise BadRequest(f'survey with id {sid} not found')

    return jsonify(survey.as_dict())
