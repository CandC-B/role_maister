from pydantic_settings import BaseSettings, SettingsConfigDict
from functools import lru_cache
from typing import Optional


class Settings(BaseSettings):
    model_config = SettingsConfigDict(env_file="./utils/.env")
    COHERE_API_KEY: Optional[str]


@lru_cache()
def get_settings():
    return Settings()
