from . import Base
import peewee as p
from tests import SkillTypeEnum
from playhouse.postgres_ext import ArrayField


class Documentations(Base):
    id = p.PrimaryKeyField()
    name = p.TextField()
    description = p.TextField()
    files = ArrayField(field_class=p.TextField)
    category_id = p.IntegerField()
    skill = SkillTypeEnum()
    created_at = p.TextField()

    # class Meta:
    #     db_table = "users"

    # @classmethod
    # def get_list(cls):
    #     query = cls.select().order_by(score)
    #     return list(query)

    # def get_user(data):
    #     query = Users.select().where(
    #         Users.email == data["email"] and Users.password == data["password"]
    #     )
    #     query = list(query)
    #     if len(query):
    #         return {"code": 200, "data": query}
    #     else:
    #         return {"code": 400, "data": query}
