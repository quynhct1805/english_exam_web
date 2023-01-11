from fastapi import APIRouter

from typing import List

from models.tests import Tests
from pydantic import BaseModel
from models.tests import SkillTypeEnum
from starlette.responses import Response
from starlette.status import HTTP_204_NO_CONTENT

router = APIRouter()


class Test(BaseModel):
    name: str
    total_part: int
    category_id: int
    description: str
    time: int
    skill: SkillTypeEnum
    total_ques: int


class TestPostResponse(BaseModel):
    id: int


class TestPostRequest(BaseModel):
    name: str
    total_part: int
    category_id: int
    time: int
    skill: SkillTypeEnum
    total_ques: int
    # parts: Part


class TestPatchRequest(BaseModel):
    name: str
    total_part: int
    category_id: int
    time: int
    skill: SkillTypeEnum
    total_ques: int


@router.get("/tests", tags=["Tests"], respone_model=List[Test])
async def get_all_tests():
    """Get all tests"""
    tests = Tests.select()
    # .order_by(Users.activestatus.desc(), fn.LOWER(Users.fullname))
    # tests = [model_to_dict(user) for user in users]
    return tests


@router.get("/tests/{test_id}", tags=["Tests"], respone_model=Test)
async def get_test(test_id):
    tests = Tests.select().where(Tests.id == test_id)
    # for test in tests:
    #     return {
    #         "id": .id,
    #         "name": user.name,
    #         "phone": user.phone,
    #         "email": user.email,
    #     }
    return tests


@router.get("/tests/{test_id}/parts/{part_id}", tags=["Tests"])
async def read_user(user_id):
    users = Users.select().where(Users.id == user_id)
    for user in users:
        return {
            "id": user.id,
            "name": user.name,
            "phone": user.phone,
            "email": user.email,
        }


@router.post(
    "/tests",
    tags=["Tests"],
    responses={204: {"model": None}},
    response_model=TestPostResponse,
    summary="Create a test",
)
async def create_test(payload_: TestPostRequest):
    """Create a new user"""
    payload = payload_.dict()
    test = Tests.create(**payload)
    return test


@router.patch("/tests/{test_id}", tags=["Tests"], status_code=204, response_model=Test)
async def patch_test(test_id: int, payload_: TestPatchRequest):
    """Update user info"""
    payload = payload_.dict()
    test = (
        Tests.update(
            # activestatus=payload["activestatus"],
            # fullname=payload["fullname"],
            # mobile=payload["mobile"],
            # email=payload["email"],
        )
        .where(Tests.id == test_id)
        .execute()
    )
    # number of changed rows
    return test


@router.patch("/tests/{test_id}/parts/{part_id}", tags=["Tests"], response_model=int)
@router.delete("/tests/{test_id}", tags=["Tests"], status_code=204)
async def delete_test(test_id: int):
    """Delete test"""
    Tests.delete(test_id).excute()
    return Response(status_code=HTTP_204_NO_CONTENT)
