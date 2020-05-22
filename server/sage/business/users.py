from sage.models.db import User
from sage.utils.crypto import RSAKey


def create_user(uid: str):
    return User(
        uid=uid,
        private_key=RSAKey.generate().to_private_pem(),
    )
