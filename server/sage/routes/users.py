from datetime import datetime

from flask import Blueprint, jsonify

from sage.models.db import User
from sage.utils.crypto import RSAKey
from .utils import verify_user, auth_required

bp = Blueprint('users', __name__)


@bp.route('/')
def root():
    user = verify_user()

    return jsonify({
        'teste': f'{datetime.now().isoformat()}',
        'oi': user.uid,
    })


@bp.route('/login')
@auth_required
def user_login(user: User):
    public_pem = RSAKey.from_pem(user.private_key).to_public_pem()

    return jsonify({
        'public_key': public_pem,
    })
