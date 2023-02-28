from . import Base
import peewee as p


class Parts(Base):
    id = p.PrimaryKeyField()
    name = p.TextField()
    test_id = p.IntegerField()
    total_ques = p.IntegerField()
    description = p.TextField()
    audio = p.TextField()
    paragraph = p.TextField()

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
