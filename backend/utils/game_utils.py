from schemas.game_settings import GameSettings


def generate_new_game(game_settings: GameSettings):
    new_game_instruction = ""
    new_game_instruction += f"1. Create a {game_settings.role_system} session for {game_settings.num_players} players.\n"
    new_game_instruction += f"2. He is a level {game_settings.level} {game_settings.career}.\n"
    new_game_instruction += f"3. His gear is " + " " .join(game_settings.equipment) + "\n"
    new_game_instruction += f"4. His attributes are strength {game_settings.attributes[0]}, " \
                            f"wits {game_settings.attributes[1]}, agility {game_settings.attributes[2]} and " \
                            f"empathy {game_settings.attributes[3]}.\n"
    new_game_instruction += f"5. His skills are " + " ".join(
        [skill + " " + str(level) + "," for skill, level in game_settings.skills.items()]) + "\n"
    new_game_instruction += f"6. His talent is {game_settings.talent}.\n"
    new_game_instruction += f"7. He has {game_settings.money} dollars in cash.\n"
    new_game_instruction += f"8. His personal agenda is {game_settings.personal_agenda}.\n"
    new_game_instruction += f"9. His signature item is {game_settings.signature_item}.\n"
    new_game_instruction += f"10. Develop a story where {game_settings.story_description}.\n"
    new_game_instruction += f"11. The game session will end with {game_settings.game_objective}.\n"

    return new_game_instruction
