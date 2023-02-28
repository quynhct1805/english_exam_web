from fastapi import APIRouter

from typing import List, Optional, Dict, Union
from enum import Enum
from peewee import fn

from models.tests import Tests
from models.categories import Categories
from models.parts import Parts
from routers.parts import Part

from pydantic import BaseModel
from starlette.responses import Response
from fastapi.exceptions import HTTPException
from starlette.status import HTTP_204_NO_CONTENT, HTTP_404_NOT_FOUND
from models.tests import SkillTypeEnum

router = APIRouter()


class Test(BaseModel):
    id: int
    name: str
    total_part: int
    category_id: int
    category_code: str
    description: str = None
    time: int
    skill: SkillTypeEnum
    total_ques: int


class TestPostResponse(BaseModel):
    id: int


class SkillEnum(str, Enum):
    LISTENING = "Listening"
    READING = "Reading"
    SPEAKING = "Speaking"
    WRITING = "Writing"


class TestPostRequest(BaseModel):
    name: str
    total_part: int
    category_id: int
    time: int
    skill: SkillEnum
    total_ques: int
    description: Optional[str]
    # parts: Part


class TestPatchRequest(BaseModel):
    name: Optional[str]
    total_part: Optional[int]
    category_id: Optional[int]
    time: Optional[int]
    skill: Optional[SkillEnum]
    total_ques: Optional[int]
    description: Optional[str]


# class PartOfTest(BaseModel):
#     id: int
#     name: str
#     total_ques: int
#     description: str


@router.get("/api/tests", tags=["Tests"], response_model=List[Test])
async def get_all_tests():
    """Get all tests"""
    tests = (
        Tests.select(Tests, fn.Upper(Categories.code).alias("category_code"))
        .join(Categories, on=Categories.id == Tests.category_id)
        .order_by(Tests.id)
    )
    tests = list(tests.dicts())
    return tests


@router.get("/api/tests/{test_id}", tags=["Tests"], response_model=Test)
async def get_test(test_id):
    tests = (
        Tests.select(Tests, fn.Upper(Categories.code).alias("category_code"))
        .join(Categories, on=Categories.id == Tests.category_id)
        .where(Tests.id == test_id)
    )
    tests = list(tests.dicts())
    test = tests[0] if len(tests) > 0 else None
    if not test:
        raise HTTPException(HTTP_404_NOT_FOUND)
    return test


@router.post(
    "/api/tests",
    tags=["Tests"],
    response_model=TestPostResponse,
    summary="Create a test",
)
async def create_test(payload_: TestPostRequest):
    """Create a new test"""
    payload = payload_.dict()
    test = Tests.create(**payload)
    return {"id": test.id}


@router.patch("/api/tests/{test_id}", tags=["Tests"], status_code=204)
async def patch_test(test_id: int, payload_: TestPatchRequest):
    """Update user info"""
    payload = payload_.dict()

    test = Tests.update(**payload).where(Tests.id == test_id).execute()
    if not test:
        raise HTTPException(HTTP_404_NOT_FOUND)

    return Response(status_code=HTTP_204_NO_CONTENT)


@router.delete("/api/tests/{test_id}", tags=["Tests"], status_code=204)
async def delete_test(test_id: int):
    """Delete test"""
    test = Tests.delete().where(Tests.id == test_id).execute()
    if not test:
        raise HTTPException(HTTP_404_NOT_FOUND)
    return Response(status_code=HTTP_204_NO_CONTENT)


@router.get("/api/tests/{test_id}/parts", tags=["Tests"], response_model=List[Part])
async def get_parts_of_test(test_id):
    parts = Parts.select().where(Parts.test_id == test_id).order_by(Parts.id)
    parts = list(parts.dicts())
    if not parts:
        raise HTTPException(HTTP_404_NOT_FOUND)
    return parts


@router.get(
    "/api/tests/{test_id}/parts/{part_id}",
    tags=["Tests"],
    response_model=Part,
)
async def get_part_of_test(test_id, part_id):
    parts = Parts.select().where(Parts.test_id == test_id)
    parts = list(parts.dicts())
    print(parts)
    if not parts:
        raise HTTPException(HTTP_404_NOT_FOUND)
    return parts


# Histories.select(Histories, Users.name.alias("user"), Tests.name.alias("test"))
#         .join(Users, on=Users.id == Histories.user_id)
#         .join(Tests, on=Tests.id == Histories.test_id)
#         .where(Histories.id == history_id)


# @router.patch("/tests/{test_id}/parts/{part_id}", tags=["Tests"])
# @router.delete("/tests/{test_id}", tags=["Tests"], status_code=204)
# async def delete_test(test_id: int):
#     """Delete test"""
#     Tests.delete(test_id).excute()
#     return Response(status_code=HTTP_204_NO_CONTENT)
