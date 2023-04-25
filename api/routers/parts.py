from fastapi import APIRouter

from typing import List, Optional

from models.parts import Parts
from models.tests import Tests
from models.questions import Questions
from pydantic import BaseModel
from routers.questions import Question

from starlette.responses import Response
from fastapi.exceptions import HTTPException
from starlette.status import HTTP_204_NO_CONTENT, HTTP_404_NOT_FOUND


router = APIRouter()


class Part(BaseModel):
    id: int
    name: str
    test_id: int
    test_name: str = None
    total_ques: int
    description: str = None
    audio: str = None
    paragraph: str = None


class PartPostResponse(BaseModel):
    id: int


class PartPostRequest(BaseModel):
    name: str
    test_id: int
    total_ques: int
    description: Optional[str]
    audio: Optional[str]
    paragraph: Optional[str]


class PartPatchRequest(BaseModel):
    name: str
    total_ques: int
    description: Optional[str]
    audio: Optional[str]
    paragraph: Optional[str]


@router.get("/api/parts", tags=["Parts"], response_model=List[Part])
async def get_all_parts():
    """Get all parts"""
    parts = Parts.select(Parts, Tests.name.alias("test_name")).join(
        Tests, on=Tests.id == Parts.test_id
    )
    parts = list(parts.dicts())
    return parts


@router.get("/api/parts/{part_id}", tags=["Parts"], response_model=Part)
async def get_part(part_id):
    """Get part"""
    parts = (
        Parts.select(Parts, Tests.name.alias("test_name"))
        .join(Tests, on=Tests.id == Parts.test_id)
        .where(Parts.id == part_id)
    )
    parts = list(parts.dicts())
    part = parts[0] if len(parts) > 0 else None
    if not part:
        raise HTTPException(HTTP_404_NOT_FOUND)
    return part


@router.post("/api/parts", tags=["Parts"], response_model=PartPostResponse)
async def create_part(payload_: PartPostRequest):
    """Create a new part"""
    payload = payload_.dict()
    if not payload["audio"]:
        payload["audio"] = "music"
    part = Parts.create(**payload)
    return {"id": part.id}


@router.patch(
    "/api/parts/{part_id}",
    tags=["Parts"],
    status_code=204,
)
async def edit_part(part_id: int, payload_: PartPatchRequest):
    """Update part info"""
    payload = payload_.dict()
    part = Parts.update(**payload).where(Parts.id == part_id).execute()
    if not part:
        raise HTTPException(HTTP_404_NOT_FOUND)
    return Response(status_code=HTTP_204_NO_CONTENT)


@router.delete(
    "/api/parts/{part_id}",
    tags=["Parts"],
    status_code=204,
)
async def delete_part(part_id: int):
    """Delete part"""
    part = Parts.delete().where(Parts.id == part_id).execute()
    if not part:
        raise HTTPException(HTTP_404_NOT_FOUND)
    return Response(status_code=HTTP_204_NO_CONTENT)


@router.get(
    "/api/parts/{part_id}/questions", tags=["Parts"], response_model=List[Question]
)
async def get_ques_of_part(part_id):
    """Get questions of part"""
    questions = (
        Questions.select(Questions, Parts.name.alias("part_name"))
        .join(Parts, on=Parts.id == Questions.part_id)
        .where(Questions.part_id == part_id)
        .order_by(Questions.id)
    )
    questions = list(questions.dicts())
    print()
    if not questions:
        raise HTTPException(HTTP_404_NOT_FOUND)
    return questions
