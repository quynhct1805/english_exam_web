from . import Base
import peewee as p


class Users(Base):
    id = p.PrimaryKeyField()
    name = p.TextField(unique=True)
    phone = p.TextField()
    email = p.TextField(unique=True)
    password = p.TextField()
    code = p.TextField()
    role = p.TextField(default="member")

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
