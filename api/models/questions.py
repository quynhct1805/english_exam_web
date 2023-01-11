from . import Base
import peewee as p
from playhouse.postgres_ext import ArrayField


class Questions(Base):
    id = p.PrimaryKeyField()
    name = p.TextField()
    part_id = p.IntegerField()
    test_id = p.IntegerField()
    question = p.TextField()
    answers = ArrayField(field_class=p.TextField)
    true_answer = p.TextField()
    explanation = p.TextField()

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
