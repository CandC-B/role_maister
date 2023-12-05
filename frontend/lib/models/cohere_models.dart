// TODO Comentar esto
class AliensGameSettings {
  final String role_system;
  final int num_players;
  final String story_description;
  final int character_level;
  final String career;
  final Map<String, int> attributes;
  final Map<String, int> skills;
  final List<String> talents;
  final String name;
  final String appearance;
  final String personal_agenda;
  final String friend;
  final String rival;
  final List<String> gear;
  final String signature_item;
  final int cash;
  final int hp;

  AliensGameSettings({
    required this.role_system,
    required this.num_players,
    required this.story_description,
    required this.character_level,
    required this.career,
    required this.attributes,
    required this.skills,
    required this.talents,
    required this.name,
    required this.appearance,
    required this.personal_agenda,
    required this.friend,
    required this.rival,
    required this.gear,
    required this.signature_item,
    required this.cash,
    required this.hp,
  });

  static AliensGameSettings fromMap(Map<String, dynamic> data) {
    return AliensGameSettings(
        role_system: data['role_system'],
        num_players: data['num_players'],
        story_description: data['story_description'],
        character_level: data['character_level'],
        career: data['career'],
        attributes: data['attributes'],
        skills: data['skills'],
        talents: data['talents'],
        name: data['name'],
        appearance: data['appearance'],
        personal_agenda: data['personal_agenda'],
        friend: data['friend'],
        rival: data['rival'],
        gear: data['gear'],
        signature_item: data['signature_item'],
        cash: data['cash'],
        hp: data['hp']
    );
  }
}
