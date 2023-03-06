from typing import List
from fastapi import APIRouter

from models.questions import Questions
from models.parts import Parts
from pydantic import BaseModel

from starlette.responses import Response
from fastapi.exceptions import HTTPException
from starlette.status import HTTP_204_NO_CONTENT, HTTP_404_NOT_FOUND


router = APIRouter()


class Question(BaseModel):
    id: int
    name: str
    part_id: int
    part_name: str
    question: str
    answers: List[str] = None
    true_answer: str = None
    explaination: str = None


class QuestionPostResponse(BaseModel):
    id: int


class QuestionPostRequest(BaseModel):
    name: str
    part_id: int
    question: str
    answers: List[str]
    true_answer: str
    explaination: str


class QuestionPatchRequest(BaseModel):
    name: str
    question: str
    answers: List[str]
    true_answer: str
    explaination: str


@router.get("/api/questions", tags=["Questions"], response_model=List[Question])
async def get_all_questions():
    """Get all questions"""
    questions = (
        Questions.select(Questions, Parts.name.alias("part_name"))
        .join(Parts, on=Parts.id == Questions.part_id)
        .order_by(Questions.id)
    )
    questions = list(questions.dicts())
    return questions


@router.get(
    "/api/questions/{question_id}",
    tags=["Questions"],
    response_model=Question,
)
async def get_question(question_id: int):
    """Get question"""
    questions = (
        Questions.select(Questions, Parts.name.alias("part_name"))
        .join(Parts, on=Parts.id == Questions.part_id)
        .where(Questions.id == question_id)
    )
    questions = list(questions.dicts())
    question = questions[0] if len(questions) > 0 else None
    if not question:
        raise HTTPException(HTTP_404_NOT_FOUND)

    return question


@router.post("/api/questions", tags=["Questions"], response_model=QuestionPostResponse)
async def create_question(payload_: QuestionPostRequest):
    """Create a new question"""
    payload = payload_.dict()
    question = Questions.create(**payload)
    return {"id": question.id}


@router.patch(
    "/api/questions/{question_id}",
    tags=["Questions"],
    status_code=204,
)
async def edit_question(question_id: int, payload_: QuestionPatchRequest):
    """Update question info"""
    payload = payload_.dict()

    question = Questions.update(**payload).where(Questions.id == question_id).execute()
    if not question:
        raise HTTPException(HTTP_404_NOT_FOUND)
    return Response(status_code=HTTP_204_NO_CONTENT)


@router.delete(
    "/api/questions/{question_id}",
    tags=["Questions"],
    status_code=204,
)
async def delete_question(question_id: int):
    """Delete question"""
    question = Questions.delete().where(Questions.id == question_id).execute()
    if not question:
        raise HTTPException(HTTP_404_NOT_FOUND)
    return Response(status_code=HTTP_204_NO_CONTENT)
