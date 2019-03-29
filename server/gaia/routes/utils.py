from firebase_admin.auth import AuthError, get_user as firebase_get_user, verify_id_token

from exceptions import BadRequest, Unauthorized


def get_user(token):
    if token is None:
        raise BadRequest('Missing token')

    try:
        data = verify_id_token(token, check_revoked=False)
    except AuthError:
        raise Unauthorized()

    return firebase_get_user(data['uid'])
