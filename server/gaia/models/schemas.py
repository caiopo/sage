from schema import Schema, Or, Optional

from gaia.models.utils import QuestionType

question_schema = Schema({
    'type': Or(*QuestionType.ALL),
    'title': str,
    'required': bool,
    Optional('description', default=''): str,
    Optional('extras', default=dict): {str: object},
})

survey_schema = Schema({
    Optional('uuid', default=None): Or(str, None),
    'title': str,
    'questions': [question_schema],
})
