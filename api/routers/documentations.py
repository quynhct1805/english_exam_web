from fastapi import APIRouter

from typing import List
from peewee import fn

from models.documentations import Documentations
from pydantic import BaseModel
from models.tests import SkillTypeEnum
from starlette.responses import Response
from starlette.status import HTTP_204_NO_CONTENT


router = APIRouter()


class Documentaion(BaseModel):
    name = str
    description = str
    files = List[str]
    category_id = int
    skill = SkillTypeEnum
    created_at = str


@router.get(
    "/documentations", tags=["Documentations"], respone_model=List[Documentaion]
)
async def get_all_decumentations():
    """Get all reviews"""
    documentations = Documentations.select()
    return documentations


@router.get(
    "/documentations/{documentation_id}",
    tags=["Documentations"],
    respone_model=Documentations,
)
async def get_documentation(documentation_id: int):
    """Get documentation"""
    documentation = Documentations.select().where(Documentations.id == documentation_id)
    return documentation


@router.post("/documentations", tags=["Documentations"], response_model=int)
async def create_documentation(payload_: UserPostRequest):
    """Create a new documentation"""
    payload = payload_.dict()
    documentation = Documentations.create(**payload)
    return documentation


@router.patch(
    "/documentations/{documentation_id}",
    tags=["Documentations"],
    response_model=int,
    status_code=204,
)
async def edit_documentation(documentation_id: int, payload_: User):
    """Update documentation info"""
    payload = payload_.dict()
    documentation = (
        Documentations.update(
            activestatus=payload["activestatus"],
            fullname=payload["fullname"],
            mobile=payload["mobile"],
            email=payload["email"],
        )
        .where(Documentations.id == documentation_id)
        .execute()
    )
    # number of changed rows
    return documentation


@router.delete(
    "/documentations/{documentation_id}",
    tags=["Users"],
    status_code=204,
)
async def delete_documentation(documentation_id: int):
    """Delete documentation"""
    Documentations.delete(documentation_id).excute()
    return Response(status_code=HTTP_204_NO_CONTENT)
