from datetime import datetime
from pony.orm import *


db = Database()


class User(db.Entity):
    username = Required(str, unique=True)
    email = Required(str, unique=True)
    dt = Required(datetime)

    surveys = Set('Survey')


class Survey(db.Entity):
    title = Required(str)
    owner = User(User)


db.generate_mapping()
