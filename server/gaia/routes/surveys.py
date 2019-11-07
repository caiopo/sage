from flask import Blueprint, jsonify, request
from pony.orm import select

from gaia.business.surveys import create_survey
from gaia.models.db import Survey
from gaia.models.schemas import survey_schema
from gaia.utils.exceptions import NotFound
from .utils import auth_required, validate_with

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
    survey_data = validate_with(survey_schema, request.get_json())

    survey = create_survey(survey_data, user)

    return jsonify(survey.as_dict())


@bp.route('/<string:suuid>')
@auth_required
def survey_detail(user, suuid):
    survey = Survey.get(uuid=suuid)

    if survey is None or survey.owner != user:
        raise NotFound(f'survey with uuid {suuid} not found')

    return jsonify(survey.as_dict())
