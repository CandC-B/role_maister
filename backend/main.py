from fastapi import FastAPI
from routes.game import game_router
from fastapi.middleware.cors import CORSMiddleware

app = FastAPI(description="Master's project to implement a role app powered by AI.", title="Role MAIster")

app.include_router(game_router, prefix="/game")

app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],  
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

@app.get("/")
async def main():
    return {"message": "Welcome"}

