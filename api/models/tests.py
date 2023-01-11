from . import Base
import peewee as p
from enum import Enum


class SkillTypeEnum(str, Enum):
    listen = "Listening"
    read = "Reading"
    speak = "Speaking"
    write = "Writting"


class Tests(Base):
    id = p.PrimaryKeyField()
    name = p.TextField()
    total_part = p.IntegerField()
    category_id = p.IntegerField()
    description = p.TextField()
    time = p.IntegerField()
    skill = SkillTypeEnum()
    total_ques = p.IntegerField()

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
