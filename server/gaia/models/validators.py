from schema import Schema, Or, SchemaError, Optional

from gaia.models.utils import QuestionType

question_schema = Schema({
    'type': Or(*QuestionType.ALL),
    'title': str,
    'description': str,
    'required': bool,
    Optional('extras'): {str: str},
})

survey_schema = Schema({
    Optional('id', default=None): Or(int, None),
    'title': str,
    'questions': [question_schema],
})

question_schema.validate({
    'type': 'multi',
    'title': 'aaaaaaaaaaaaaaaaaaaaaaaa',
    'description': 'bbbbbbbbbbbbbb',
    'required': False,
})

survey_schema.validate({
    'id': None,
    'title': 'aaaaaa',
    'questions': [
        {
            'type': 'multi',
            'title': 'aaaaaaaaaaaaaaaaaaaaaaaa',
            'description': 'bbbbbbbbbbbbbb',
            'required': True,
        },
        {
            'type': 'single',
            'title': 'dfsafasdfadfa',
            'description': 'bbbbbbbbbbbbbb',
            'required': False,
        }
    ]
})
