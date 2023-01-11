from fastapi import APIRouter

from typing import List
from peewee import fn

from models.reviews import Reviews
from pydantic import BaseModel
from datetime import date


router = APIRouter()


class Review(BaseModel):
    user_id: int
    test_id: int
    rate_stars: int
    comment: str
    created_at: date
    updated_at: date


@router.get("/reviews", tags=["Reviews"], respone_model=List[Review])
async def get_all_reviews():
    """Get all reviews"""
    reviews = Reviews.select()
    return reviews


@router.get("/reviews/{review_id}", tags=["Reviews"], respone_model=Review)
async def get_review(review_id: int):
    """Get review"""
    review = Reviews.select().where(Reviews.id == review_id)
    return review


@router.get("/reviews/{test_id}", tags=["Reviews"], respone_model=Review)
async def get_review(test_id: int):
    """Get review"""
    review = Reviews.select().where(Reviews.test_id == test_id)
    return review


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
    user = Users.delete(user_id).excute()


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
