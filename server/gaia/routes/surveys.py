from flask import Blueprint, jsonify

bp = Blueprint('surveys', __name__)


@bp.route("/")
def hello():
    return jsonify({
        'teste': "Hello World!",
    })
