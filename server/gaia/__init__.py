from dynaconf import FlaskDynaconf, settings
from firebase_admin import credentials, initialize_app
from flask import Flask, jsonify

from exceptions import GaiaException

app = Flask(__name__)

FlaskDynaconf(app)

initialize_app(
    credentials.Certificate(settings.FIREBASE_CERTIFICATE)
)


@app.errorhandler(Exception)
def error_handler(error):
    if isinstance(error, GaiaException):
        return jsonify({
            'code': error.status_code,
            'type': type(error).__name__,
            'message': error.message,
        }), error.status_code

    return jsonify({
        'code': 500,
        'type': 'Internal Server Error',
        'message': error.args
    }), 500


from gaia.routes import blueprints

for (bp, prefix) in blueprints:
    app.register_blueprint(bp, url_prefix=prefix)
