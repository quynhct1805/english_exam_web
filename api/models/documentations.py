from . import Base
import peewee as p
from models.tests import SkillTypeEnum, EnumField
from playhouse.postgres_ext import ArrayField, BinaryJSONField


class Documentations(Base):
    id = p.PrimaryKeyField()
    name = p.TextField()
    description = p.TextField()
    files = BinaryJSONField()
    category_id = p.IntegerField()
    skill = EnumField(choices=SkillTypeEnum)
    created_at = p.TextField()
    doc = p.TextField()
    type = p.TextField()

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
