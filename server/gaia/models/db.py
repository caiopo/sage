import uuid
from datetime import datetime

from pony.orm import *

from gaia.config import DATABASE
from gaia.utils.crypto import RSAKey
from .utils import QuestionType

db = Database()


class User(db.Entity):
    uid = Required(str, unique=True)
    active = Required(bool, default=lambda: True)

    private_key = Required(str)

    surveys = Set(lambda: Survey)


class Survey(db.Entity):
    uuid = Required(uuid.UUID, default=uuid.uuid4, index=True, unique=True)
    title = Required(str)
    owner = Required(User)

    questions = Set(lambda: Question)
    answers = Set(lambda: Answer)

    def as_dict(self):
        d = self.to_dict(related_objects=True)
        del d['owner']
        del d['id']
        d['answers'] = self.answers.count()
        d['questions'] = [q.as_dict() for q in self.questions]
        return d


class Question(db.Entity):
    uuid = Required(uuid.UUID, default=uuid.uuid4, index=True, unique=True)
    survey = Required(Survey)

    type = Required(str, py_check=QuestionType.validate)
    title = Required(str)
    description = Optional(str)
    required = Required(bool)

    extras = Required(Json, default=dict)

    answers = Set(lambda: QuestionAnswer)

    def as_dict(self):
        return self.to_dict(exclude='id answers survey')


class Answer(db.Entity):
    survey = Required(Survey)

    uuid = Required(uuid.UUID, index=True, unique=True)

    created_at = Required(datetime)
    uploaded_at = Required(datetime)

    question_answers = Set(lambda: QuestionAnswer)


class QuestionAnswer(db.Entity):
    answer = Required(Answer)
    question = Required(Question)
    extras = Required(Json)


db.bind(*DATABASE)
db.generate_mapping(create_tables=True)


def _ns():
    with db_session:
        if count(u for u in User) == 0:
            user = User(
                uid='testuser',
                private_key=RSAKey.generate().to_private_pem(),
            )

            survey = {
                'title': 'Questionário de Preferências',
                'questions': [
                    {
                        'type': 'single',
                        'title': 'Qual sua cor preferida?',
                        'description': 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. '
                                       'Fusce venenatis ut mauris a dignissim.',
                        'required': True,
                        'extras': {
                            'options': [
                                'Amarelo',
                                'Azul',
                                'Preto',
                                'Verde',
                                'Vermelho',
                            ]
                        }
                    },
                    {
                        'type': 'multi',
                        'title': 'Quais comidas você gosta?',
                        'description': '',
                        'required': True,
                        'extras': {
                            'options': [
                                'Pizza',
                                'Sushi',
                                'Feijoada',
                                'Churrasco',
                            ]
                        }
                    },
                    {
                        'type': 'numeric',
                        'title': 'Quantos anos você tem?',
                        'description': 'Em anos',
                        'required': True,
                        'extras': {
                            'min': 0,
                            'max': 130,
                        }
                    },
                    {
                        'type': 'text',
                        'title': 'Qual seu nome?',
                        'description': 'Nome completo',
                        'required': True,
                        'extras': {
                            'min_length': 10,
                            'max_length': 25,
                        }
                    },
                ]
            }

            from gaia.business.surveys import create_survey
            create_survey(survey, user)


_ns()
