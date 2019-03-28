from firebase_admin.auth import get_user
from flask import Blueprint, jsonify

bp = Blueprint('users', __name__)


@bp.route('/')
def hello():
    user = get_user('fAQ1W5XEutZP7k0w0K4MmFF7juk1')

    print(user.display_name)

    return jsonify({
        'teste': user.photo_url,
    })
