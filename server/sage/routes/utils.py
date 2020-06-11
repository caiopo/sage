from functools import wraps

from firebase_admin.auth import verify_id_token, CertificateFetchError, \
    RevokedIdTokenError, ExpiredIdTokenError, InvalidIdTokenError, get_user
from flask import request

from sage.business.users import create_user
from sage.models.db import User
from sage.utils.exceptions import Unauthorized


def verify_user() -> User:
    token = request.args.get('token')

    if token is None:
        return User[1]
        # raise BadRequest('Missing token')  # TODO

    try:
        data = verify_id_token(token, check_revoked=False)
    except (
            InvalidIdTokenError,
            ExpiredIdTokenError,
            RevokedIdTokenError,
            CertificateFetchError,
    ) as e:
        print(e)
        raise Unauthorized()

    print(data)



    uid = data['uid']

    user = User.get(uid=uid)

    if user is not None:
        return user

    return create_user(uid)


def auth_required(decorated):
    @wraps(decorated)
    def decorator(*args, **kwargs):
        user = verify_user()
        return decorated(*args, **kwargs, user=user)

    return decorator
