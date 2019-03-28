from .users import bp as users_bp
from .surveys import bp as surveys_bp

blueprints = [
    (users_bp, '/users'),
    (surveys_bp, '/surveys'),
]
