from fastapi import APIRouter

from typing import List, Optional
from peewee import fn

from models.documentations import Documentations
from models.categories import Categories
from models.tests import SkillTypeEnum
from routers.tests import SkillEnum

from pydantic import BaseModel

from starlette.responses import Response
from fastapi.exceptions import HTTPException
from starlette.status import HTTP_204_NO_CONTENT, HTTP_404_NOT_FOUND


router = APIRouter()


# class File(BaseModel):
#     name: str
#     size: int


class Documentation(BaseModel):
    id: int
    name: str
    description: str = None
    files: List[dict] = None
    skill: SkillTypeEnum
    category_id: int
    category_code: str
    doc: str = None
    type: str = None


class DocumentationPostRequest(BaseModel):
    name: str
    category_id: int
    skill: SkillEnum
    files: Optional[List[dict]]
    description: Optional[str]
    doc: Optional[str]
    type: str


class DocumentationPostResponse(BaseModel):
    id: int


class DocumentationPatchRequest(BaseModel):
    name: str
    category_id: int
    skill: SkillEnum
    files: Optional[List[dict]]
    description: Optional[str]
    doc: Optional[str]
    type: Optional[str]


@router.get(
    "/api/documentations", tags=["Documentations"], response_model=List[Documentation]
)
async def get_all_documentations():
    """Get all documentations"""
    documentations = (
        Documentations.select(
            Documentations, fn.Upper(Categories.code).alias("category_code")
        )
        .join(Categories, on=Categories.id == Documentations.category_id)
        .order_by(Documentations.id)
    )
    documentations = list(documentations.dicts())
    return documentations


@router.get(
    "/api/documentations/{documentation_id}",
    tags=["Documentations"],
    response_model=Documentation,
)
async def get_documentation(documentation_id: int):
    """Get documentation"""
    documentations = (
        Documentations.select(
            Documentations, fn.Upper(Categories.code).alias("category_code")
        )
        .join(Categories, on=Categories.id == Documentations.category_id)
        .where(Documentations.id == documentation_id)
    )
    documentations = list(documentations.dicts())
    documentation = documentations[0] if len(documentations) > 0 else None
    if not documentation:
        raise HTTPException(HTTP_404_NOT_FOUND)

    return documentation


@router.post(
    "/api/documentations",
    tags=["Documentations"],
    response_model=DocumentationPostResponse,
)
async def create_documentation(payload_: DocumentationPostRequest):
    """Create a new documentation"""
    payload = payload_.dict()
    documentation = Documentations.create(**payload)
    return {"id": documentation.id}


@router.patch(
    "/api/documentations/{documentation_id}",
    tags=["Documentations"],
    status_code=204,
)
async def edit_documentation(
    documentation_id: int, payload_: DocumentationPatchRequest
):
    """Update documentation info"""
    payload = payload_.dict()

    documentation = (
        Documentations.update(**payload)
        .where(Documentations.id == documentation_id)
        .execute()
    )
    if not documentation:
        raise HTTPException(HTTP_404_NOT_FOUND)
    return Response(status_code=HTTP_204_NO_CONTENT)


@router.delete(
    "/api/documentations/{documentation_id}",
    tags=["Documentations"],
    status_code=204,
)
async def delete_documentation(documentation_id: int):
    """Delete documentation"""
    documentation = (
        Documentations.delete().where(Documentations.id == documentation_id).execute()
    )
    if not documentation:
        raise HTTPException(HTTP_404_NOT_FOUND)
    return Response(status_code=HTTP_204_NO_CONTENT)
