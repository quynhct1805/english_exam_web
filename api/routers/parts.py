from fastapi import APIRouter

from playhouse.shortcuts import model_to_dict
from peewee import fn

from models.parts import Parts
from pydantic import BaseModel
from models.tests import SkillTypeEnum

router = APIRouter()


class Part(BaseModel):
    name: str
    question_id: int
    total_ques: int
    description: str
    time: int
