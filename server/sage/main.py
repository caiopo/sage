from firebase_admin import credentials, initialize_app
from flask import Flask, jsonify
from pony.flask import Pony

from sage.config import PORT, FIREBASE_CERTIFICATE

app = Flask(__name__)

Pony(app)

initialize_app(
    credentials.Certificate(FIREBASE_CERTIFICATE)
)

if app.env != 'development':
    @app.errorhandler(Exception)
    def error_handler(error):
        from sage.utils.exceptions import GaiaException
        if isinstance(error, GaiaException):
            return jsonify({
                'code': error.status_code,
                'type': type(error).__name__,
                'message': error.message,
            }), error.status_code

        print(type(error).__name__, error.args)

        return jsonify({
            'code': 500,
            'type': 'Internal Server Error',
            'message': error.args
        }), 500

from sage.routes import blueprints

for (bp, prefix) in blueprints:
    app.register_blueprint(bp, url_prefix=prefix)

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=PORT)
