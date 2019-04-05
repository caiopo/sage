from random import choice
from string import ascii_letters, digits


class DbEnum:
    ALL = None

    @classmethod
    def validate(cls, item):
        return item in cls.ALL


class QuestionType(DbEnum):
    SINGLE_CHOICE = 'single_choice'
    MULTI_CHOICE = 'multi_choice'
    TEXT_FIELD = 'text_field'

    ALL = [
        SINGLE_CHOICE,
        MULTI_CHOICE,
        TEXT_FIELD,
    ]


_ID_CHARS = ascii_letters + digits


def unique_id():
    return ''.join(choice(_ID_CHARS) for _ in range(20))
