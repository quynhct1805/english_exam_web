from pydantic import BaseMode

from fastapi import APIRouter
from models.users import Users


class Login(BaseMode):
    email: str
    password: str


router = APIRouter()


@router.post("/api/users/login", tags=["login"])
async def login(account: routers.login.Login):
    """Login"""
    account = account.dict()
    query = (
        Users.select()
        .where(
            (Users.email == account["email"]) & (Users.password == account["password"])
        )
        .dicts()
    )
    query_len = list(query)
    if len(query_len):
        return {"code": 200, "data": query_len}
    else:
        return {"code": 400, "data": query_len}
