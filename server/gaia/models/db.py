from datetime import datetime

from dynaconf import settings
from pony.orm import *

from .utils import QuestionType

db = Database()


class User(db.Entity):
    uid = Required(str, unique=True)
    active = Required(bool, default=lambda: True)

    surveys = Set(lambda: Survey)


class Survey(db.Entity):
    title = Required(str)
    owner = Required(User)


class SurveyQuestion(db.Entity):
    survey = Required(Survey)
    type = Required(str, py_check=QuestionType.validate)
    extras = Required(Json)


class Answer(db.Entity):
    survey = Required(Survey)

    created_at = Required(datetime)
    uploaded_at = Required(datetime)


class QuestionAnswer(db.Entity):
    answer = Required(Answer)
    question = Required(SurveyQuestion)
    extras = Required(Json)


db.bind(**settings.DB)
db.generate_mapping(create_tables=True)
