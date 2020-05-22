from flask import Blueprint

from .utils import auth_required

bp = Blueprint('answers', __name__)


@bp.route('/', methods=['POST'])
@auth_required
def answer_create(user, sid):
    pass
