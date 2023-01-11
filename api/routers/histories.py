from fastapi import APIRouter

from playhouse.shortcuts import model_to_dict
from peewee import fn

from models.histories import Histories
from pydantic import BaseModel
from models.tests import SkillTypeEnum
from datetime import date


router = APIRouter()


class History(BaseModel):
    user_id: int
    test_id: int
    grade: int
    time: int
    created_at: date
    updated_at: date
