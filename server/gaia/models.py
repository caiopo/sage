from datetime import datetime

from dynaconf import settings
from pony.orm import *

db = Database()


class User(db.Entity):
    username = Required(str, unique=True)
    email = Required(str, unique=True)
    registered_at = Required(datetime)

    surveys = Set('Survey')


class Survey(db.Entity):
    title = Required(str)
    owner = Required(User)


db.bind(**settings.DB)
db.generate_mapping(create_tables=True)
