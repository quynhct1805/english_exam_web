from fastapi import APIRouter

from typing import List, Optional
from peewee import fn

from models.categories import Categories
from pydantic import BaseModel, constr
from models.tests import SkillTypeEnum
from starlette.responses import Response
from fastapi.exceptions import HTTPException
from starlette.status import HTTP_204_NO_CONTENT, HTTP_404_NOT_FOUND

router = APIRouter()


class Category(BaseModel):
    id: int
    code: str
    name: str
    description: str = None


class CategoryPostRequest(BaseModel):
    code: str
    name: str
    description: Optional[str]


class CategoryPatchRequest(BaseModel):
    name: str
    description: Optional[str]


@router.get("/api/categories", tags=["Categories"], response_model=List[Category])
async def get_all_categories():
    categories = (
        Categories.select(fn.Upper(Categories.code).alias("code"), Categories)
        .order_by(Categories.id)
        .dicts()
    )
    categories = list(categories)
    return categories


@router.get(
    "/api/categories/{category_id}", tags=["Categories"], response_model=Category
)
async def get_category(category_id):
    categories = Categories.select().where(Categories.id == category_id).dicts()
    categories = list(categories)
    category = categories[0] if len(categories) > 0 else None
    if not category:
        raise HTTPException(HTTP_404_NOT_FOUND)
    return category


@router.post(
    "/api/categories",
    tags=["Categories"],
    status_code=200,
)
async def create_category(payload_: CategoryPostRequest):
    category_codes = Categories.select(Categories.code).dicts()
    category_codes = list(category_codes)
    print("hi", category_codes)
    payload = payload_.dict()
    for code in category_codes:
        if code["code"] == payload["code"]:
            print(11, code)
            return {"code": 400, "message": "Mã thể loại đã tồn tại"}
    print(2, payload)
    category = Categories.create(**payload)
    return {"id": category.id}


@router.patch(
    "/api/categories/{category_code}",
    tags=["Categories"],
    status_code=204,
)
async def update_category(category_code: str, category: CategoryPatchRequest):
    category = (
        Categories.update(**category.dict())
        .where(Categories.code == category_code)
        .execute()
    )
    if not category:
        raise HTTPException(HTTP_404_NOT_FOUND)
    return Response(status_code=HTTP_204_NO_CONTENT)


@router.delete(
    "/api/categories/{category_id}",
    tags=["Categories"],
    status_code=204,
)
async def delete_category(category_id: int):
    """Delete category"""
    category = Categories.delete().where(Categories.id == category_id).execute()
    if not category:
        raise HTTPException(HTTP_404_NOT_FOUND)
    return Response(status_code=HTTP_204_NO_CONTENT)
