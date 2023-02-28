from . import Base
import peewee as p
from enum import Enum


class EnumField(p.CharField):
    """
    This class enable a Enum like field for Peewee
    """

    def __init__(self, choices, *args, **kwargs):
        super(p.CharField, self).__init__(*args, **kwargs)
        self.choices = choices

    def db_value(self, value):
        return value

    def python_value(self, value):
        return self.choices(value)


class SkillTypeEnum(Enum):
    LISTENING = "Listening"
    READING = "Reading"
    SPEAKING = "Speaking"
    WRITING = "Writing"


class Tests(Base):
    id = p.PrimaryKeyField()
    name = p.TextField()
    total_part = p.IntegerField()
    category_id = p.IntegerField(default=1)
    description = p.TextField()
    time = p.IntegerField()
    skill = EnumField(choices=SkillTypeEnum)
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
