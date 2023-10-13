from pydantic import BaseModel, Field
from typing import List, Dict


class GameSettings(BaseModel):
    role_system: str
    num_players: int
    level: int
    career: str
    equipment: List[str]
    attributes: List[int]
    skills: Dict[str, int]
    talent: str
    money: int
    personal_agenda: str
    signature_item: str
    story_description: str
    game_objective: str

    model_config = {
        "json_schema_extra": {
            "examples": [
                {
                    "role_system": "aliens rol game",
                    "num_players": 1,
                    "level": 1,
                    "career": "colonial marine",
                    "equipment": ["1 gun", "2 rifles"],
                    "attributes": [5, 4, 3, 2],
                    "skills": {"close combat": 3, "heavy machinery": 2, "stamina ": 1},
                    "talent": "investigator",
                    "money": 300,
                    "personal_agenda": "\"Cover a war crime\"",
                    "signature_item": "his son's photo",
                    "story_description": "he and his crew suffer an alien invasion in the middle of space",
                    "game_objective": "the killing of the aliens."
                }
            ]
        }
    }
