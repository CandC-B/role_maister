import 'package:role_maister/config/config.dart';
import 'package:role_maister/models/aliens_character.dart';
import 'package:role_maister/models/game.dart';

Future<String> generateAliensPrompt(Game game) async {
  Map<String, dynamic> gameSettings = game.toMap();
  String newGameInstruction = "";

  // First sentence
  newGameInstruction +=
      "Create a ${gameSettings['role_system']} session for ${gameSettings['num_players']} players.\n";

  if (gameSettings['num_players'] > 1) {
    // Multiplayer sentence
    newGameInstruction +=
        "There are ${gameSettings['num_players']} players: player1, player2, player3, player4 and player5.\n";
    newGameInstruction +=
        "To distinguish their actions, each message will start with 'playerX: (message)', being X the user index.\n";
    // Get all player features
    for (int i = 0; i < gameSettings['num_players']; i++) {
      String characterId = gameSettings['players'][i];
      Map<String, dynamic> characterData =
          await firebase.getCharacter(characterId, gameSettings['role_system']);
      AliensCharacter aliensCharacter = AliensCharacter.fromMap(characterData);
      newGameInstruction += getAliensCharacterFeatures(aliensCharacter);
    }
  } else {
    // Singleplayer sentence
    String characterId = gameSettings['players'][0];
    Map<String, dynamic> characterData =
        await firebase.getCharacter(characterId, gameSettings['role_system']);
    AliensCharacter aliensCharacter = AliensCharacter.fromMap(characterData);
    newGameInstruction += getAliensCharacterFeatures(aliensCharacter);
    newGameInstruction +=
        "The story will develop as it follows:${gameSettings['story_description']}.\n";
    newGameInstruction +=
        "You firstly must develop an introduction to the story. Then suggest 3 possible actions for the player in each message and wait until the user response.\nThe user will choose what to do, and then you must readapt the story based on that decision.\n";
  }

  return newGameInstruction;
}

String getAliensCharacterFeatures(AliensCharacter aliensCharacter) {
  String alienFeatures = "";

  alienFeatures +=
      "The character is a level ${aliensCharacter.characterLevel} ${aliensCharacter.career}.\n";
  alienFeatures += "The character's name is ${aliensCharacter.name}\n";
  alienFeatures +=
      "The character's appearance is ${aliensCharacter.appearance}\n";
  alienFeatures += "The character's total health is ${aliensCharacter.hp}\n";
  alienFeatures +=
      "His friend is ${aliensCharacter.friend} and his enemy is ${aliensCharacter.rival}\n";
  alienFeatures +=
      "The character's gear is ${aliensCharacter.gear.join(" ")}\n";
  alienFeatures +=
      "The attributes are ${aliensCharacter.skills.entries.map((entry) => "${entry.key} ${entry.value},").join(" ")}\n";
  alienFeatures +=
      "The skills are ${aliensCharacter.skills.entries.map((entry) => "${entry.key} ${entry.value},").join(" ")}\n";
  alienFeatures +=
      "The character's talents are${aliensCharacter.talents.join(" ")}.\n";
  alienFeatures +=
      "The character has ${aliensCharacter.cash} dollars in cash.\n";
  alienFeatures +=
      "The character's personal agenda is ${aliensCharacter.personalAgenda}.\n";
  alienFeatures +=
      "The character's signature item is ${aliensCharacter.signatureItem}.\n";

  return alienFeatures;
}
