from . import Base
import peewee as p
from playhouse.postgres_ext import DateTimeField


class Histories(Base):
    id = p.PrimaryKeyField()
    user_id = p.IntegerField()
    test_id = p.IntegerField()
    grade = p.IntegerField()
    time = p.IntegerField()
    created_at = DateTimeField(default=p.SQL("NOW()"))

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
