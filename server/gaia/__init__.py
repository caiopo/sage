from firebase_admin import credentials, initialize_app
from flask import Flask
from dynaconf import FlaskDynaconf, settings

app = Flask(__name__)

FlaskDynaconf(app)

initialize_app(
    credentials.Certificate(settings.FIREBASE_CERTIFICATE)
)

from gaia.routes import blueprints

for (bp, prefix) in blueprints:
    app.register_blueprint(bp, url_prefix=prefix)
