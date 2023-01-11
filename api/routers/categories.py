from fastapi import APIRouter

from playhouse.shortcuts import model_to_dict
from peewee import fn

from models.categories import Categories
from pydantic import BaseModel
from models.tests import SkillTypeEnum
from starlette.responses import Response
from starlette.status import HTTP_204_NO_CONTENT

router = APIRouter()


class Category(BaseModel):
    code: str
    name: str
    description: str


class CategoryPostResponse(BaseModel):
    id: int


class CategoryPostRequest(BaseModel):
    code: str
    name: str


class CategoryPatchRequest(BaseModel):
    name: str
    description: str


@router.get("/categories/", tags=["Categories"], respone_model=Category)
async def get_all_categories():
    categories = Categories.select()
    return categories


@router.get("/categories/{category_id}", tags=["Categories"], respone_model=Category)
async def get_category(category_id):
    category = Categories.select().where(Categories.id == category_id)
    return category


@router.post(
    "/categories/",
    tags=["Categories"],
    status_code=200,
    response_model=CategoryPostResponse,
)
async def create_category(payload_: CategoryPostRequest):
    # print(category)
    payload = payload_.dict()
    category = Categories.create(**payload)
    return category


@router.patch(
    "/categories/{category_code}",
    tags=["Categories"],
    status_code=204,
)
async def update_category(category_code: str, category: CategoryPatchRequest):
    print(category)
    Categories.update(**category.dict()).where(
        Categories.code == category_code
    ).execute()
    return "update category"


@router.delete(
    "/categories/{category_id}",
    tags=["Categories"],
    status_code=204,
)
async def delete_category(category_id: int):
    """Delete category"""
    Categories.delete(category_id).excute()
    return Response(status_code=HTTP_204_NO_CONTENT)
