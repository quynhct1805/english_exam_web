from fastapi import APIRouter

from typing import List, Optional
from datetime import datetime, date

from models.users import Users
from models.histories import Histories
from models.tests import Tests
from routers.histories import History

from pydantic import BaseModel, constr

from starlette.responses import Response
from fastapi.exceptions import HTTPException
from starlette.status import HTTP_204_NO_CONTENT, HTTP_404_NOT_FOUND

router = APIRouter()


class User(BaseModel):
    id: int
    name: constr(min_length=1)
    phone: str
    email: constr(min_length=1)
    role: str
    code: str = None
    password: constr(min_length=6)


class UserPostResponse(BaseModel):
    id: int


class UserUpdateRequest(BaseModel):
    name: str
    phone: constr(min_length=9)
    email: str
    role: str
    code: Optional[str]
    password: Optional[constr(min_length=6)]


class UserHistories(BaseModel):
    id: int
    test: str
    grade: str
    time: int
    answers: List[Optional[str]]
    created_at: date


class UserDetail(User):
    histories: List[UserHistories]


@router.get("/api/users", tags=["Users"], response_model=List[User])
async def get_all_users():
    """Get all users"""
    users = Users.select().order_by(Users.id).dicts()
    users = list(users)
    return users


@router.get("/api/users/{user_id}", tags=["Users"], response_model=UserDetail)
async def get_user(user_id: int):
    """Get user"""
    users = Users.select().where(Users.id == user_id).dicts()
    users = list(users)
    histories = (
        Histories.select(Histories, Tests.name.alias("test"))
        .join(Tests, on=Tests.id == Histories.test_id)
        .where(Histories.user_id == user_id)
        .order_by(Histories.created_at.desc())
        .dicts()
    )
    user = users[0] if len(users) > 0 else None
    if not user:
        raise HTTPException(HTTP_404_NOT_FOUND)
    user["histories"] = list(histories)
    return user


@router.post(
    "/api/users", tags=["Users"], status_code=200, response_model=UserPostResponse
)
async def create_user(payload_: UserUpdateRequest):
    """Create a new user"""
    payload = payload_.dict()
    if payload["role"] is None:
        payload["role"] = "member"
    user = Users.create(**payload)
    return {"id": user.id}


@router.patch(
    "/api/users/{user_id}",
    tags=["Users"],
    status_code=204,
)
async def edit_user(user_id: int, payload_: UserUpdateRequest):
    """Update user info"""
    payload = payload_.dict()
    print(payload)
    user = Users.update(**payload).where(Users.id == user_id).execute()
    if not user:
        raise HTTPException(HTTP_404_NOT_FOUND)
    return Response(status_code=HTTP_204_NO_CONTENT)


@router.delete(
    "/api/users/{user_id}",
    tags=["Users"],
    status_code=204,
)
async def delete_user(user_id: int):
    """Delete user"""
    user = Users.delete().where(Users.id == user_id).execute()
    if not user:
        raise HTTPException(HTTP_404_NOT_FOUND)
    return Response(status_code=HTTP_204_NO_CONTENT)
