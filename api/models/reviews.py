from . import Base
import peewee as p


class Reviews(Base):
    id = p.PrimaryKeyField()
    user_id = p.IntegerField()
    test_id = p.IntegerField()
    rate_stars = p.IntegerField()
    comment = p.TextField()
    created_at = p.DateField()
    updated_at = p.DateField()

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
