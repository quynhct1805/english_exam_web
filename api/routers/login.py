from pydantic import BaseModel

from fastapi import APIRouter
from models.users import Users


class Login(BaseModel):
    email: str
    password: str


router = APIRouter()


@router.post("/api/login", tags=["Login"])
async def login(payload_: Login):
    """Login"""
    payload = payload_.dict()
    query = (
        Users.select()
        .where(
            (Users.email == payload["email"]) & (Users.password == payload["password"])
        )
        .dicts()
    )
    user = list(query)
    if len(user):
        user[0].pop("password")
        return {"code": 200, "message": "Đăng nhập thành công", "data": user[0]}
    else:
        return {"code": 400, "message": "Tài khoản không tồn tại"}


# @router.post("/api/parts", tags=["Parts"], response_model=PartPostResponse)
# async def create_part(payload_: PartPostRequest):
#     """Create a new part"""
#     payload = payload_.dict()
#     part = Parts.create(**payload)
#     return {"id": part.id}
