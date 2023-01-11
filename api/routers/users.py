from fastapi import APIRouter

from typing import List
from peewee import fn

from models.users import Users
from pydantic import BaseModel
from starlette.responses import Response
from starlette.status import HTTP_204_NO_CONTENT

router = APIRouter()


class User(BaseModel):
    activestatus: bool
    fullname: str
    mobile: str
    email: str


class UserPostRequest(BaseModel):
    fullname: str
    mobile: str
    email: str


@router.get("/users", tags=["Users"], respone_model=List[User])
async def get_all_users():
    """Get all users"""
    users = Users.select().order_by(Users.activestatus.desc(), fn.LOWER(Users.fullname))
    return users


@router.get("/users/{user_id}", tags=["Users"], respone_model=User)
async def get_user(user_id: int):
    """Get user"""
    user = (
        Users.select()
        .where(Users.id == user_id)
        .order_by(Users.activestatus.desc(), fn.LOWER(Users.fullname))
    )
    return user


@router.post("/users", tags=["Users"], response_model=int)
async def create_user(payload_: UserPostRequest):
    """Create a new user"""
    payload = payload_.dict()
    user = Users.create(**payload)
    return user


@router.patch(
    "/users/{user_id}",
    tags=["Users"],
    response_model=int,
    status_code=204,
)
async def edit_user(user_id: int, payload_: User):
    """Update user info"""
    payload = payload_.dict()
    user = (
        Users.update(
            activestatus=payload["activestatus"],
            fullname=payload["fullname"],
            mobile=payload["mobile"],
            email=payload["email"],
        )
        .where(Users.id == user_id)
        .execute()
    )
    # number of changed rows
    return user


@router.delete(
    "/users/{user_id}",
    tags=["Users"],
    status_code=204,
)
async def delete_user(user_id: int):
    """Delete user"""
    Users.delete(user_id).excute()
    return Response(status_code=HTTP_204_NO_CONTENT)


# fix
@router.get("/users/{user_id}/{history_id}", tags=["Users"], respone_model=User)
async def get_user_history(user_id: int, history_id: int):
    """Get user's history"""
    user = (
        Users.select()
        .where(Users.id == user_id)
        .order_by(Users.activestatus.desc(), fn.LOWER(Users.fullname))
    )
    return user
