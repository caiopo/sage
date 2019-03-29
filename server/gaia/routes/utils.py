from firebase_admin.auth import AuthError, verify_id_token
from flask import request

from gaia.models.db import User
from gaia.utils.exceptions import BadRequest, Unauthorized


def verify_user() -> User:
    token = request.args.get('token')

    if token is None:
        raise BadRequest('Missing token')

    try:
        data = verify_id_token(token, check_revoked=False)
    except AuthError:
        raise Unauthorized()

    uid = data['uid']

    user = User.get(uid=uid)

    if user is not None:
        return user

    return User(
        uid=uid
    )
