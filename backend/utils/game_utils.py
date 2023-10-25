from schemas.game_settings import GameSettings


def generate_new_game(game_settings: GameSettings):
    new_game_instruction = ""
    new_game_instruction += f"1. Create a {game_settings.role_system} session for {game_settings.num_players} players.\n"
    new_game_instruction += f"2. The character is a level {game_settings.character_level} {game_settings.career}.\n"
    new_game_instruction += f"3. The character's name is {game_settings.name}\n"
    new_game_instruction += f"4. The character's appearance is {game_settings.appearance}\n"
    new_game_instruction += f"5. The character's total health is {game_settings.hp}\n"
    new_game_instruction += f"6. His friend is {game_settings.friend} and his enemy is {game_settings.rival}\n"
    new_game_instruction += f"7. The character's gear is " + " " .join(game_settings.gear) + "\n"
    new_game_instruction += f"8. The attributes are"+ " ".join([attribute + " " + str(level) + "," for attribute, level in game_settings.skills.items()]) + "\n"
    new_game_instruction += f"9. The skills are " + " ".join(
        [skill + " " + str(level) + "," for skill, level in game_settings.skills.items()]) + "\n"
    new_game_instruction += f"10. The character's talenta are" + " ".join(game_settings.talents) + ".\n"
    new_game_instruction += f"11. The character has {game_settings.cash} dollars in cash.\n"
    new_game_instruction += f"12. The character personal's agenda is {game_settings.personal_agenda}.\n"
    new_game_instruction += f"13. The character's signature item is {game_settings.signature_item}.\n"
    new_game_instruction += f"14. Develop a story where {game_settings.story_description}.\n"

    return new_game_instruction
