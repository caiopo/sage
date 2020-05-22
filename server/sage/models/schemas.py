from schema import Schema, Or, Optional, SchemaError

from sage.models.utils import QuestionType
from sage.utils.exceptions import BadRequest

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

question_extra_schemas = {
    QuestionType.SINGLE: Schema({
        'options': [str],
    }),

    QuestionType.MULTI: Schema({
        'options': [str],
    }),

    QuestionType.NUMERIC: Schema({
        Optional('min', default=None): int,
        Optional('max', default=None): int,
    }),

    QuestionType.TEXT: Schema({
        Optional('min_length', default=None): int,
        Optional('max_length', default=None): int,
    }),
}


def validate_with(schema, data):
    try:
        return schema.validate(data)
    except SchemaError as e:
        print(str(e))
        raise BadRequest('schema validation failed')


def validate_survey(data):
    validate_with(survey_schema, data)

    extra_schema = question_extra_schemas[data['type']]

    validate_with(extra_schema, data['extra'])
