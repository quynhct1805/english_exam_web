from fastapi import APIRouter

from typing import List
import pytz

from starlette.responses import Response
from fastapi.exceptions import HTTPException
from starlette.status import HTTP_204_NO_CONTENT, HTTP_404_NOT_FOUND

from models.histories import Histories
from models.users import Users
from models.tests import Tests
from pydantic import BaseModel
from datetime import datetime


router = APIRouter()


class History(BaseModel):
    id: int
    user: str
    test: str
    grade: int
    time: int
    created_at: datetime


class HistoryPostResponse(BaseModel):
    id: int


class HistoryPostRequest(BaseModel):
    user_id: int
    test_id: int
    grade: int
    time: int


@router.get("/api/histories", tags=["Histories"], response_model=List[History])
async def get_all_histories():
    """Get all histories"""
    histories = (
        Histories.select(Histories, Users.name.alias("user"), Tests.name.alias("test"))
        .join(Users, on=Users.id == Histories.user_id)
        .join(Tests, on=Tests.id == Histories.test_id)
    )
    # print(datetime.now().strftime("%H:%M:%S"))
    print(
        datetime.now().astimezone(pytz.timezone("Asia/Ho_Chi_Minh"))
        # .strftime("%Y-%m-%d %H:%M:%S")
    )
    histories = list(histories.dicts())
    return histories


@router.get("/api/histories/{history_id}", tags=["Histories"])
async def get_history(history_id):
    """Get history"""
    histories = (
        Histories.select(Histories, Users.name.alias("user"), Tests.name.alias("test"))
        .join(Users, on=Users.id == Histories.user_id)
        .join(Tests, on=Tests.id == Histories.test_id)
        .where(Histories.id == history_id)
    )
    histories = list(histories.dicts())
    history = histories[0] if len(histories) > 0 else None
    if not history:
        raise HTTPException(HTTP_404_NOT_FOUND)
    return history


@router.post(
    "/api/histories",
    tags=["Histories"],
    response_model=HistoryPostResponse,
    summary="Create a history",
)
async def create_history(payload_: HistoryPostRequest):
    """Create a new history"""
    payload = payload_.dict()
    history = Histories.create(**payload)
    return {"id": history.id}
