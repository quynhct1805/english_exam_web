from typing import List
from fastapi import APIRouter

from playhouse.shortcuts import model_to_dict
from peewee import fn

from models.questions import Questions
from pydantic import BaseModel
from models.tests import SkillTypeEnum

router = APIRouter()


class Question(BaseModel):
    name: str
    part_id: int
    test_id: int
    question: str
    answers: List[str]
    true_answer: str
    explanation: str
