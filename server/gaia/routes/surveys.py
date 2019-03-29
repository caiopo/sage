from flask import Blueprint, jsonify, request

from gaia.models.db import Survey
from .utils import verify_user

bp = Blueprint('surveys', __name__)


@bp.route("/create", methods=['POST'])
def create():
    user = verify_user()

    data = request.get_json()

    survey = Survey(
        owner=user
    )

    return jsonify({
        'teste': "Hello World!",
    })
