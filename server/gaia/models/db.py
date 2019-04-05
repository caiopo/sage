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

    questions = Set(lambda: SurveyQuestion)
    answers = Set(lambda: Answer)


class SurveyQuestion(db.Entity):
    survey = Required(Survey)
    type = Required(str, py_check=QuestionType.validate)

    title = Required(str)
    description = Required(str)

    extras = Required(Json)

    answers = Set(lambda: QuestionAnswer)


class Answer(db.Entity):
    survey = Required(Survey)

    created_at = Required(datetime)
    uploaded_at = Required(datetime)

    question_answers = Set(lambda: QuestionAnswer)


class QuestionAnswer(db.Entity):
    answer = Required(Answer)
    question = Required(SurveyQuestion)
    extras = Required(Json)


print(settings.DB)

db.bind(**settings.DB)
db.generate_mapping(create_tables=True)
