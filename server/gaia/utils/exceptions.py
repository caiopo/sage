from abc import ABC


class GaiaException(Exception, ABC):
    status_code = None
    default_message = None

    def __init__(self, message=None):
        self.message = message if message is not None else self.default_message

        super().__init__(self.message)


class BadRequest(GaiaException):
    status_code = 400
    default_message = 'Bad Request'


class Unauthorized(GaiaException):
    status_code = 401
    default_message = 'Unauthorized'


class NotFound(GaiaException):
    status_code = 404
    default_message = 'Not Found'


class InternalServerError(GaiaException):
    status_code = 500
    default_message = 'Internal Server Error'
