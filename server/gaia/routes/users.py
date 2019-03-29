from datetime import datetime

from flask import Blueprint, jsonify

from .utils import verify_user

bp = Blueprint('users', __name__)


@bp.route('/')
def root():
    user = verify_user()

    return jsonify({
        'teste': f'{datetime.now().isoformat()}',
        'oi': user.uid,
    })
