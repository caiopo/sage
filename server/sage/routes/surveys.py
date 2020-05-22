from flask import Blueprint, jsonify, request
from pony.orm import select

from sage.business.surveys import create_survey
from sage.models.db import Survey
from sage.models.schemas import validate_survey
from sage.utils.exceptions import NotFound
from .utils import auth_required

bp = Blueprint('surveys', __name__)


@bp.route('/')
@auth_required
def survey_list(user):
    survey_uuids = select(s.uuid for s in Survey if s.owner == user)

    return jsonify({
        'content': [{'uuid': uuid} for uuid in survey_uuids]
    })


@bp.route('/', methods=['POST'])
@auth_required
def survey_create(user):
    survey_data = validate_survey(request.get_json())

    survey = create_survey(survey_data, user)

    return jsonify(survey.as_dict())


@bp.route('/<string:suuid>')
@auth_required
def survey_detail(user, suuid):
    survey = Survey.get(uuid=suuid)

    if survey is None or survey.owner != user:
        raise NotFound(f'survey with uuid {suuid} not found')

    return jsonify(survey.as_dict())
