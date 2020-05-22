from random import choice
from string import ascii_letters, digits


class DbEnum:
    ALL = []

    @classmethod
    def validate(cls, item):
        return item in cls.ALL


class QuestionType(DbEnum):
    SINGLE = 'single'
    MULTI = 'multi'
    NUMERIC = 'numeric'
    TEXT = 'text'

    ALL = [
        SINGLE,
        MULTI,
        NUMERIC,
        TEXT,
    ]


_ID_CHARS = ascii_letters + digits


def unique_id():
    return ''.join(choice(_ID_CHARS) for _ in range(20))
