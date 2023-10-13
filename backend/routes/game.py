from fastapi import APIRouter
from utils.config import get_settings
from schemas.game_settings import GameSettings
from utils.game_utils import generate_new_game
from uuid import UUID
import cohere

game_router = APIRouter(tags=["Game"])

settings = get_settings()
co = cohere.Client(settings.COHERE_API_KEY)


@game_router.post("/")
async def create_new_game(game_settings: GameSettings):
    instruction = generate_new_game(game_settings)
    response = co.chat(
        message=instruction
    )

    return {"message": response.text}


@game_router.post("/{id}/message")
async def resume_game(id: UUID, message: str):
    response = co.chat(
        message=message
    )

    return {"message": response.text}
