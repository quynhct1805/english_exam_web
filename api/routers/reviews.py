from fastapi import APIRouter

from typing import List


from models.reviews import Reviews
from models.users import Users
from models.tests import Tests
from pydantic import BaseModel
from datetime import datetime

from starlette.responses import Response
from fastapi.exceptions import HTTPException
from starlette.status import HTTP_204_NO_CONTENT, HTTP_404_NOT_FOUND


router = APIRouter()


class Review(BaseModel):
    id: int
    user_id: int
    test_id: int
    rate_stars: int
    comment: str
    created_at: datetime
    updated_at: datetime


class ReviewPostResponse(BaseModel):
    id: int


class ReviewPostRequest(BaseModel):
    user_id: int
    test_id: int
    rate_stars: int
    comment: str
    created_at: datetime


class ReviewPatchRequest(BaseModel):
    rate_stars: int
    comment: str
    updated_at: datetime


@router.get("/api/reviews", tags=["Reviews"])
async def get_all_reviews():
    """Get all reviews"""
    reviews = (
        Reviews.select(Reviews, Users.name.alias("user"), Tests.name.alias("test"))
        .join(Users, on=Users.id == Reviews.user_id)
        .join(Tests, on=Tests.id == Reviews.test_id)
    )
    reviews = list(reviews.dicts())
    return reviews


@router.get("/api/reviews/{review_id}", tags=["Reviews"])
async def get_review_by_id(review_id: int):
    """Get review by id"""
    reviews = (
        Reviews.select(Reviews, Users.name.alias("user"), Tests.name.alias("test"))
        .join(Users, on=Users.id == Reviews.user_id)
        .join(Tests, on=Tests.id == Reviews.test_id)
        .where(Reviews.id == review_id)
    )
    reviews = list(reviews.dicts())
    review = reviews[0] if len(reviews) > 0 else None
    if not review:
        raise HTTPException(HTTP_404_NOT_FOUND)
    return review


@router.post(
    "/api/reviews",
    tags=["Reviews"],
    response_model=ReviewPostResponse,
    summary="Create a review",
)
async def create_review(payload_: ReviewPostRequest):
    """Create a new review"""
    payload = payload_.dict()
    review = Reviews.create(**payload)
    return {"id": review.id}


@router.patch(
    "/api/reviews/{review_id}",
    tags=["Reviews"],
    status_code=204,
)
async def edit_review(review_id: int, payload_: ReviewPatchRequest):
    """Update documentation info"""
    payload = payload_.dict()
    Reviews.update(**payload).where(Reviews.id == review_id).execute()
    return Response(status_code=HTTP_204_NO_CONTENT)
