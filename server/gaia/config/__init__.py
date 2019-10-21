import base64
import json
from os import environ
from pathlib import Path

DEVELOPMENT = environ.get('ENVIRONMENT') != 'production'

if DEVELOPMENT:
    DATABASE = [
        'sqlite',
        'data.db',
        True,
    ]

else:
    DATABASE = [
        'postgres',
        environ['DATABASE_URL']
    ]

_firebase_cert = environ.get('FIREBASE_ADMIN_KEY')
if _firebase_cert is None:
    _firebase_cert_path = Path(__file__).parent / 'firebase-admin.json'
    with open(_firebase_cert_path) as f:
        FIREBASE_CERTIFICATE = json.load(f)

else:
    _firebase_cert_b64_dec = base64.b64decode(_firebase_cert)
    FIREBASE_CERTIFICATE = json.loads(_firebase_cert_b64_dec)

PORT = int(environ.get('PORT', 5000))
