from fastapi import FastAPI

# from peewee import JOIN

from routers import (
    users,
    categories,
    documentations,
    histories,
    login,
    parts,
    questions,
    reviews,
    tests,
)

from fastapi.middleware.cors import CORSMiddleware

router = FastAPI()
router.include_router(users.router)
router.include_router(login.router)
router.include_router(documentations.router)
router.include_router(categories.router)
router.include_router(histories.router)
router.include_router(parts.router)
router.include_router(reviews.router)
router.include_router(questions.router)
router.include_router(tests.router)

router.add_middleware(
    CORSMiddleware,
    allow_origins=[
        "http://localhost:8080",
        "http://localhost:8081",
        "http://localhost:3000",
        "http://192.168.64.3:3000",
        "http://localhost:8000",
    ],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)


@router.get("/")
async def root():
    return {"message": "Hello Bigger Applications!"}


# @app.on_event("startup")
# def startup():
#     if db.is_closed():
#         db.connect()


# @app.on_event("shutdown")
# def shut_down():
#     if not db.is_closed():
#         db.close()


# @app.post("/createuser")
# def create_account(user: routers_user.User):
#     user = user.dict()
#     print(user)
#     return User.create(**user)


# @app.post("/api/users/login")
# def login(account: routers.login.Login):
#     """Login"""
#     account = account.dict()
#     query = (
#         User.select()
#         .where(
#             (User.email == account["email"]) & (User.password == account["password"])
#         )
#         .dicts()
#     )
#     query_len = list(query)
#     if len(query_len):
#         return {"code": 200, "data": query_len}
#     else:
#         return {"code": 400, "data": query_len}


# @app.get("/api/users")
# def get_user():
#     """Get all User"""
#     query_user = User.select().dicts()
#     query_user = list(query_user)
#     return query_user


# @app.get("/api/users/{user_id}")
# def get_user_by_id(user_id: int):
#     """get user by id"""
#     query_info = User.select().where(User.id == user_id).dicts()
#     query_info = list(query_info)
#     return query_info


# @app.get("/api/categories")
# def get_category():
#     """get all categories"""
#     query_category = Category.select().dicts()
#     query_category = list(query_category)
#     return query_category


# @app.get("/api/categories/{category_id}")
# def get_category_by_categoryid(category_id: int):
#     """get category by category_id"""
#     query_info = Category.select().where(Category.id == category_id).dicts()
#     query_info = list(query_info)
#     return query_info


# @app.get("/api/brands")
# def get_category():
#     """Get all product"""
#     query_brand = Brand.select().dicts()
#     query_brand = list(query_brand)
#     return query_brand


# @app.get("/api/brands/{brand_id}")
# def get_brand_by_brandid(brand_id: int):
#     """get brand by brand_id"""
#     query_info = Brand.select().where(Brand.id == brand_id).dicts()
#     query_info = list(query_info)
#     return query_info


# @app.get("/api/products")
# def get_product():
#     """Get all product"""
#     query_product = Product.select().where(Product.is_hidden == 1).dicts()
#     query_product = list(query_product)
#     return query_product


# @app.get("/api/products/{product_id}")
# def get_product_by_productid(product_id: int):
#     """get product by product_id"""
#     query_info = Product.select().where(Product.id == product_id).dicts()
#     query_info = list(query_info)
#     return query_info


# @app.get("/api/products/category/{category_id}")
# def get_product_by_categoryid(category_id: int):
#     """get product by product_id"""
#     query_info = (
#         Product.select()
#         .where((Product.is_hidden == 1) & (Product.category_id == category_id))
#         .dicts()
#     )
#     query_info = list(query_info)
#     return query_info


# @app.get("/api/products/category/4/{category_id}")
# def get_product_by_categoryid(category_id: int):
#     """get product by product_id"""
#     query_info = (
#         Product.select()
#         .where((Product.is_hidden == 1) & (Product.category_id == category_id))
#         .dicts()
#     )
#     query_info = list(query_info)
#     query_info = query_info[0:4]
#     return query_info


# @app.post("/api/products")
# def add_product(product: routers.product.Product):
#     """add product"""
#     data_product = product.dict()
#     query_info_brand = (
#         Brand.select().where(Brand.type == data_product["brand_id"]).dicts()
#     )
#     query_info_category = (
#         Category.select().where(Category.type == data_product["category_id"]).dicts()
#     )
#     query_brand = list(query_info_brand)
#     query_category = list(query_info_category)
#     data_product["brand_id"] = query_brand[0]["id"]
#     data_product["category_id"] = query_category[0]["id"]
#     print(data_product)
#     query_product = (
#         Product.select()
#         .where((Product.product_code == data_product["product_code"]))
#         .dicts()
#     )
#     query_product = list(query_product)
#     if len(query_product) == 0:
#         query = Product.insert(**data_product).execute()
#     else:
#         Product.update(**data_product).where(
#             (Product.product_code == data_product["product_code"])
#         ).execute()
#     return {"code": 200, "data": data_product}


# @app.delete("/api/products/{product_id}")
# def delete_product_by_productid(product_id: int):
#     """delete product by product_id"""
#     try:
#         query_info = Product.select().where(Product.id == product_id).dicts()
#         query_info = list(query_info)
#         if len(query_info):
#             for i in range(0, len(query_info)):
#                 is_hidden = 0
#         data_update = {"is_hidden": is_hidden}
#         Product.update(**data_update).where(Product.id == product_id).execute()
#         return {"code": 200, "isSuccess": True, "data": data_update}
#     except Exception as e:
#         return {"code": 400, "isSuccess": False, "err": e}


# @app.patch("/api/products/{product_id}")
# def edit_product_by_productid(product_id: int):
#     """edit product by product_id"""
#     try:
#         query_info = Product.select().where(Product.id == product_id).dicts()
#         query_info = list(query_info)
#         if len(query_info):
#             for i in range(0, len(query_info)):
#                 is_hidden = 0
#         data_update = {"is_hidden": is_hidden}
#         Product.update(**data_update).where(Product.id == product_id).execute()
#         return {"code": 200, "isSuccess": True, "data": data_update}
#     except Exception as e:
#         return {"code": 400, "isSuccess": False, "err": e}


# @app.get("/api/carts")
# def get_carts():
#     """Get all product"""
#     query_product_for_cart = (
#         Cart.select(Cart, Product)
#         .join(Product, on=Product.id == Cart.product_id)
#         .where(Cart.is_hidden == 1)
#         .dicts()
#     )
#     query_product_for_cart = list(query_product_for_cart)
#     return query_product_for_cart


# @app.delete("/api/carts/{cart_id}")
# def delete_product_by_productid(cart_id: int):
#     """delete cart by cart_id"""
#     try:
#         query_info = Cart.select().where(Cart.id == cart_id).dicts()
#         query_info = list(query_info)
#         if len(query_info):
#             for i in range(0, len(query_info)):
#                 is_hidden = 0
#         data_update = {"is_hidden": is_hidden}
#         Cart.update(**data_update).where(Cart.id == cart_id).execute()
#         return {"code": 200, "isSuccess": True, "data": data_update}
#     except Exception as e:
#         return {"code": 400, "isSuccess": False, "err": e}


# @app.post("/api/carts")
# def add_cart(carts: routers.cart.Cart):
#     """add product to cart"""
#     data_cart = carts.dict()
#     query_info = (
#         Cart.select()
#         .where(
#             (Cart.product_id == data_cart["product_id"])
#             & (Cart.size == data_cart["size"])
#         )
#         .dicts()
#     )
#     query_info = list(query_info)
#     if len(query_info) == 0:
#         query = Cart.insert(**data_cart).execute()
#     else:
#         data_cart["quantity"] = data_cart["quantity"] + query_info[0]["quantity"]
#         print(data_cart)
#         data_update = {"quantity": data_cart["quantity"]}
#         Cart.update(**data_cart).where(
#             (
#                 (Cart.product_id == data_cart["product_id"])
#                 & (Cart.size == data_cart["size"])
#             )
#         ).execute()
#     return {"code": 200, "data": data_cart}
