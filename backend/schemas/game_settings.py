from pydantic import BaseModel, Field
from typing import List, Dict


class GameSettings(BaseModel):
    role_system: str
    num_players: int
    story_description: str
    character_level: int
    career: str
    attributes: Dict[str, int]
    skills: Dict[str, int]
    talents: List[str]
    name: str
    appearance: str
    personal_agenda: str
    friend: str
    rival: str
    gear: List[str]
    signature_item: str
    cash: int
    hp: int
