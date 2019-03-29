from datetime import datetime

from flask import Blueprint, jsonify, request

from routes.utils import get_user

bp = Blueprint('users', __name__)


@bp.route('/')
def root():
    token = request.args.get('token')

    user = get_user(token)

    return jsonify({
        'teste': f'{datetime.now().isoformat()}',
        'oi': user.email,
    })
