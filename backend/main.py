from fastapi import FastAPI
from routes.game import game_router

app = FastAPI(description="Master's project to implement a role app powered by AI.", title="Role MAIster")

app.include_router(game_router, prefix="/game")


