from datetime import datetime
from pathlib import Path

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


db_path = Path(__file__).absolute().parent.parent

print(db_path)

# db.bind(provider='sqlite', filename=db_path)
# db.generate_mapping(create_tables=True)
