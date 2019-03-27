from abc import ABC


class GaiaException(Exception, ABC):
    status_code = None
    default_message = None

    def __init__(self, message=None):
        m = message if message is not None else self.default_message

        super().__init__(m)


class NotFound(GaiaException):
    status_code = 404
    default_message = 'Not found'

