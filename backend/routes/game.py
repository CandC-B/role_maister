from fastapi import APIRouter
from utils.config import get_settings
import cohere

game_router = APIRouter(tags=["Game"])

settings = get_settings()
maister = cohere.Client(settings.COHERE_API_KEY)
