class DbEnum:
    ALL = None

    @classmethod
    def validate(cls, item):
        return item in cls.ALL


class QuestionType(DbEnum):
    RADIO = 'radio'
    CHECKBOX = 'radio'
    TEXT_FIELD = 'radio'

    ALL = [
        RADIO,
        CHECKBOX,
        TEXT_FIELD,
    ]
