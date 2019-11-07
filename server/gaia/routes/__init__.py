from .answers import bp as answers_bp
from .surveys import bp as surveys_bp
from .users import bp as users_bp

blueprints = [
    (answers_bp, '/answers'),
    (surveys_bp, '/surveys'),
    (users_bp, '/users'),
]
