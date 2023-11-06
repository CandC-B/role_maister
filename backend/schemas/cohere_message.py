from pydantic import BaseModel

class CohereMessage(BaseModel):
    role: str
    message: str