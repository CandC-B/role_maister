import 'dart:math';
import 'package:dart_random_choice/dart_random_choice.dart';
import 'package:role_maister/config/app_singleton.dart';
import 'package:role_maister/models/character.dart';
import 'package:uuid/uuid.dart';

class DydCharacter extends Character {
  // TODO: de momento solo tenemos character level 1
  
  final int characterLevel;
  final String race;
  final Map<String, int> abilities;
  // final String name;
  final int age;
  final String alignment;
  final double height;
  final double weight;
  final String size;
  final List<String> traits;
  final List<String> languages;
  final String characterClass;
  final String description;
  final String hitDie;
  final List<String> proficiencies;
  final List<String> tools;
  final int hp;
  final List<String> skills;
  final List<String> equipment;
  //TODO
  final String sex;
  final String background;
  final String eyesColor;
  final String hairColor;
  final String skinColor;
  final String appearance;
  final String photoUrl;
  final String mode = "dyd";

  DydCharacter({
    String? id,
    required this.characterLevel,
    required this.race,
    required this.abilities,
    required this.age,
    required String name,
    required String userId,
    required this.alignment,
    required this.height, //metros
    required this.weight, // Kg
    required this.size,
    required this.traits,
    required this.languages,
    required this.characterClass,
    required this.description,
    required this.hitDie,
    required this.proficiencies,
    required this.tools,
    required this.hp,
    required this.skills,
    required this.equipment,
    required this.sex,
    required this.background,
    required this.eyesColor,
    required this.hairColor,
    required this.skinColor,
    required this.appearance,
    required this.photoUrl,
  }) : super(name, userId , id: id);

  // Factory constructor to generate random AliensCharacter
  factory DydCharacter.random() {
    final race = _generateRandomRace();
    final abilities = _generateRandomAbilities(race);
    final age = _getRandomAge(race);
    final alignment = _getRandomAlignment(race);
    String name = _getRandomName(race);
    String userId = "test";
    final height = _getRandomHeight(race);
    final weight = _getRandomWeight(race);
    final size = _getRandomSize(race);
    final traits = _generateRandomTraits(race);
    final languages = _generateRandomLanguages(race);
    final characterClass = _generateRandomClass();
    final description = _getRandomDescription(characterClass);
    final hitDie = _getRandomHitDie(characterClass);
    final proficiencies = _generateRandomProficiencies(characterClass);
    final tools = _getRandomTools(characterClass);
    final hp = _getRandomHp(characterClass, abilities["CON"]!);
    final skills = _generateRandomSkills(characterClass);
    final equipment = _getRandomEquipment(characterClass);
    final sex = _getRandomSex();
    final background = _getRandomBackground();
    final eyesColor = _getRandomEyesColor();
    final hairColor = _getRandomHairColor();
    final skinColor = _getRandomSkinColor();
    final appearance = _getRandomAppearance();
    const photoUrl = "small_logo.png";
    return DydCharacter(
      characterLevel: 1,
      race: race,
      abilities: abilities,
      age: age,
      alignment: alignment,
      name: name,
      height: height,
      weight: weight,
      size: size,
      traits: traits,
      languages: languages,
      photoUrl: photoUrl,
      characterClass: characterClass,
      description: description,
      hitDie: hitDie,
      proficiencies: proficiencies,
      tools: tools,
      hp: hp,
      skills: skills,
      equipment: equipment,
      sex: sex,
      background: background,
      eyesColor: eyesColor,
      hairColor: hairColor,
      skinColor: skinColor,
      appearance: appearance,
      userId: userId,
    );
  }

  static int makeRoll(int times, int dice) {
    int result = 1;
    for (int i = 0; i < times; i++) {
      result += Random().nextInt(dice + 1);
    }
    return result;
  }
  
  static String _generateRandomRace() {
    List<String> races = [
      "Dwarf",
      "Elf",
      "Halfling",
      "Human",
      "Dragonborn",
      "Gnome",
      "Half-elf",
      "Half-orc",
      "Tiefling"
    ];
    return randomChoice(races);
  }

  static Map<String, int> _generateRandomAbilities(String selectedRace) {
    Map<String, int> abilities = {
      "STR": makeRoll(3, 6),
      "DEX": makeRoll(3, 6),
      "CON": makeRoll(3, 6),
      "INT": makeRoll(3, 6),
      "WIS": makeRoll(3, 6),
      "CHA": makeRoll(3, 6)
    };

    if (selectedRace == "Human") {
      abilities["STR"] = (abilities["STR"] ?? 0) + 1;
      abilities["DEX"] = (abilities["DEX"] ?? 0) + 1;
      abilities["CON"] = (abilities["CON"] ?? 0) + 1;
      abilities["INT"] = (abilities["INT"] ?? 0) + 1;
      abilities["WIS"] = (abilities["WIS"] ?? 0) + 1;
      abilities["CHA"] = (abilities["CHA"] ?? 0) + 1;
    }

    if (selectedRace == "Dragonborn") {
      abilities["STR"] = (abilities["STR"] ?? 0) + 2;
      abilities["CHA"] = (abilities["CHA"] ?? 0) + 2;
    }

    if (selectedRace == "Half-orc") {
      abilities["STR"] = (abilities["STR"] ?? 0) + 2;
      abilities["CON"] = (abilities["CON"] ?? 0) + 1;
    }

    if (selectedRace == "Elf") {
      abilities["DEX"] = (abilities["DEX"] ?? 0) + 2;
    }
    
    if (selectedRace == "Halfling") {
      abilities["DEX"] = (abilities["DEX"] ?? 0) + 2;
    }
    
    if (selectedRace == "Dwarf") {
      abilities["CON"] = (abilities["CON"] ?? 0) + 2;
    }
    
    if (selectedRace == "Gnome") {
      abilities["INT"] = (abilities["INT"] ?? 0) + 2;
    }
    
    if (selectedRace == "Tiefling") {
      abilities["INT"] = (abilities["INT"] ?? 0) + 1;
      abilities["CHA"] = (abilities["CHA"] ?? 0) + 2;
    }
    
    if (selectedRace == "Half-elf") {
      abilities["CHA"] = (abilities["CHA"] ?? 0) + 2;
      for(int i=0; i<2; i++) {
        int randomIndex = Random().nextInt(6);
        List<String> randomAbilityKeys = abilities.keys.toList();
        String randomAbility = randomAbilityKeys[randomIndex];
        abilities[randomAbility] = (abilities[randomAbility] ?? 0) + 1;
      }
    }

    return abilities;
  }

  static String _getRandomName(String selectedRace) {
    Map<String, List<String>> names = {
      "Dwarf": [
        "Thoradin",
        "Orsik",
        "Gardain",
        "Sannl",
        "Kathra",
        "Riswynn"
      ],
      "Elf": [
        "Aelar",
        "Riardon",
        "Thamior",
        "Bethrynna",
        "Queleena",
        "Althaea"
      ],
      "Halfling": [
        "Garret",
        "Milo",
        "Finnan",
        "Cora",
        "Jillian",
        "Lavinia"
      ],
      "Human": [
        "Paco",
        "Jose Luis",
        "Antonio",
        "Mari Carmen",
        "Lola",
        "Paquita"
      ],
      "Dragonborn": [
        "Arjhan",
        "Medrash",
        "Torinn",
        "Kava",
        "Uady",
        "Harann"
      ],
      "Gnome": [
        "Alston",
        "Warryn",
        "Gerbo",
        "Donella",
        "Nissa",
        "Nyx"
      ],
      "Half-elf": [
        "Aelar",
        "Riardon",
        "Thamior",
        "Bethrynna",
        "Queleena",
        "Althaea",
        "Paco",
        "Jose Luis",
        "Antonio",
        "Mari Carmen",
        "Lola",
        "Paquita"
      ],
      "Half-orc": [
        "Dench",
        "Feng",
        "Mhurren",
        "Kansif",
        "Sutha",
        "Yevelda"
      ],
      "Tiefling": [
        "Akmenos",
        "Mordai",
        "Therai",
        "Kallista",
        "Orianna",
        "Anakis"
      ]
    };

    if (names.containsKey(selectedRace)) {
      return randomChoice(names[selectedRace]!);
    }
    throw Exception("Unsupported race selected");
  }

  static int _getRandomAge(String selectedRace) {
    if (selectedRace == "Dwarf") {
      return 50 + Random().nextInt(301);
    } else if (selectedRace == "Elf") {
      return 100 + Random().nextInt(651);
    } else if (selectedRace == "Halfling") {
      return 20 + Random().nextInt(131);
    } else if (selectedRace == "Human") {
      return 18 + Random().nextInt(63);
    } else if (selectedRace == "Dragonborn") {
      return 3 + Random().nextInt(78);
    } else if (selectedRace == "Gnome") {
      return 40 + Random().nextInt(461);
    } else if (selectedRace == "Half-elf") {
      return 20 + Random().nextInt(151);
    } else if (selectedRace == "Half-orc") {
      return 15 + Random().nextInt(61);
    } else { // if (selectedRace == "Tiefling") 
      return 18 + Random().nextInt(77);
    }  
  }

  static String _getRandomAlignment(String selectedRace) {
    Map<String, List<String>> alignments = {
      "Dwarf": [
        "Lawful good",
        "Lawful neutral",
        "Lawfuk evil",
      ],
      "Elf": [
        "Chaotic good",
      ],
      "Halfling": [
        "Lawful good",
      ],
      "Human": [
        "Lawful good",
        "Neutral good",
        "Chaotic good",
        "Lawful neutral",
        "Neutral",
        "Chaotic neutral",
        "Lawful evil",
        "Neutral evil",
        "Chaotic evil",
      ],
      "Dragonborn": [
        "Lawful good",
        "Neutral good",
        "Chaotic good",
        "Lawful evil",
        "Neutral evil",
        "Chaotic evil",
      ],
      "Gnome": [
        "Lawful good",
        "Chaotic good",
      ],
      "Half-elf": [
        "Chaotic neutral",
      ],
      "Half-orc": [
        "Chaotic evil",
      ],
      "Tiefling": [
        "Chaotic evil",
      ]
    };

    if (alignments.containsKey(selectedRace)) {
      return randomChoice(alignments[selectedRace]!);
    }
    throw Exception("Unsupported race selected");
  }

  static double _getRandomHeight(String selectedRace) {
    if (selectedRace == "Dwarf") {
      return 1.12 + (makeRoll(2, 4) * 0.025);
    } else if (selectedRace == "Elf") {
      return 1.37 + (makeRoll(2, 10) * 0.025);
    } else if (selectedRace == "Halfling") {
      return 0.79 + (makeRoll(2, 4) * 0.025);
    } else if (selectedRace == "Human") {
      return 1.45 + (makeRoll(2, 10) * 0.025);
    } else if (selectedRace == "Dragonborn") {
      return 1.68 + (makeRoll(2, 8) * 0.025);
    } else if (selectedRace == "Gnome") {
      return 0.89 + (makeRoll(2, 4) * 0.025);
    } else if (selectedRace == "Half-elf") {
      return 1.45 + (makeRoll(2, 8) * 0.025);
    } else if (selectedRace == "Half-orc") {
      return 1.47 + (makeRoll(2, 10) * 0.025);
    } else { // if (selectedRace == "Tiefling") 
      return 1.45 + (makeRoll(2, 8) * 0.025);
    }  
  }

  static double _getRandomWeight(String selectedRace) {
    if (selectedRace == "Dwarf") {
      return 52 + (makeRoll(2, 4) * makeRoll(2, 6) * 2.2);
    } else if (selectedRace == "Elf") {
      return 40 + (makeRoll(2, 10) * makeRoll(1, 4) * 2.2);
    } else if (selectedRace == "Halfling") {
      return 16 + (makeRoll(2, 4) * 2.2);
    } else if (selectedRace == "Human") {
      return 50 + (makeRoll(2, 10) * makeRoll(2, 4) * 2.2);
    } else if (selectedRace == "Dragonborn") {
      return 80 + (makeRoll(2, 8) * makeRoll(2, 6) * 2.2);
    } else if (selectedRace == "Gnome") {
      return 16 + (makeRoll(2, 4) * 2.2);
    } else if (selectedRace == "Half-elf") {
      return 50 + (makeRoll(2, 8) * makeRoll(2, 4) * 2.2);
    } else if (selectedRace == "Half-orc") {
      return 63.5 + (makeRoll(2, 10) * makeRoll(2, 6) * 2.2);
    } else { // if (selectedRace == "Tiefling") 
      return 50 + (makeRoll(2, 8) * makeRoll(2, 4) * 2.2);
    }  
  }

  static String _getRandomSize(String selectedRace) {
    if (selectedRace == "Dwarf") {
      return "Medium";
    } else if (selectedRace == "Elf") {
      return "Medium";
    } else if (selectedRace == "Halfling") {
      return "Small";
    } else if (selectedRace == "Human") {
      return "Medium";
    } else if (selectedRace == "Dragonborn") {
      return "Medium";
    } else if (selectedRace == "Gnome") {
      return "Small";
    } else if (selectedRace == "Half-elf") {
      return "Medium";
    } else if (selectedRace == "Half-orc") {
      return "Medium";
    } else { // if (selectedRace == "Tiefling") 
      return "Medium";
    }  
  }

  static List<String> _generateRandomTraits(String selectedRace) {
    Map<String, List<String>> alignments = {
      "Dwarf": [
        "Dark vision",
        "Poison resistance",
        "Combat proficiency with battleaxe, handaxe, throwing hammer and war hammer"
      ],
      "Elf": [
        "Dark vision",
        "Keen Senses: Perception proficiency",
        "Trance: you don't need to sleep. You may meditate for 4 hours instead of sleeping for 8 hours",
      ],
      "Halfling": [
        "Lucky: When you roll a 1 on a die throw, you can reroll the die and must use a new roll",
        "Lucky: Brave: you can't be frightened",
      ],
      "Human": [
        "None",
      ],
      "Dragonborn": [
        "Damage resistance",
        "Breath weapon: you can use your action to exhale destructive energy. After you use your breath weapon, you can't use it again until you finish a short or long rest",
      ],
      "Gnome": [
        "Dark vision",
      ],
      "Half-elf": [ //TODO
        "Dark vision",
        "Skill versatility: you gain proficiency in two extra skills"
      ],
      "Half-orc": [
        "Dark vision",
        "Menacing: You gain proficiency in intimidation skill", //TODO
        "Relentless Endurance: When you are reduced to 0 HP, you can drop to 1 hit point instead. You can't use this again until you finish a long rest"
      ],
      "Tiefling": [
        "Dark vision",
        "Hellish resistance: You have resistance to fire damage"
      ]
    };

    if (alignments.containsKey(selectedRace)) {
      return alignments[selectedRace]!;
    }
    throw Exception("Unsupported race selected");
  }

  static String _extraRandomLanguage(List<String> currentLanguages) {
    String newLanguage;
    List<String> extraLanguages = ["Common", "Dwarvish", "Elvish", "Halfling", "Draconic", "Gnomish", "Orc", "Infernal"];
    do {
      int randomIndex = Random().nextInt(7);
      newLanguage = extraLanguages[randomIndex];
    } while(extraLanguages.contains(newLanguage));
    return newLanguage;
  }

  static List<String> _generateRandomLanguages(String selectedRace) {
    Map<String, List<String>> languages = {
      "Dwarf": [
        "Common",
        "Dwarvish",
      ],
      "Elf": [
        "Common",
        "Elvish",
      ],
      "Halfling": [
        "Common",
        "Halfling",
      ],
      "Human": [ 
        "Common",
        _extraRandomLanguage(["Common"]),
      ],
      "Dragonborn": [
        "Common",
        "Draconic",
      ],
      "Gnome": [
        "Common",
        "Gnomish",
      ],
      "Half-elf": [ 
        "Common",
        "Elvish",
        _extraRandomLanguage(["Common", "Elvish"])
      ],
      "Half-orc": [
        "Common",
        "Orc", 
      ],
      "Tiefling": [
        "Common",
        "Infernal"
      ]
    };

    if (languages.containsKey(selectedRace)) {
      return languages[selectedRace]!;
    }
    throw Exception("Unsupported language selected");
  }

  static String _generateRandomClass() {
    List<String> classes = [
      "Barbarian",
      "Bard",
      "Cleric",
      "Druid",
      "Fighter",
      "Monk",
      "Paladin",
      "Ranger",
      "Rogue",
      "Sorcerer",
      "Warlock",
      "Wizard"
    ];
    return randomChoice(classes);
  }

  static String _getRandomDescription(String selectedClass) {
    if (selectedClass == "Barbarian") {
      return "A fierce warrior of primitive background who can enter a battle rage";
    } else if (selectedClass == "Bard") {
      return "An inspiring magician whose power echoes the music of creation";
    } else if (selectedClass == "Cleric") {
      return "A priestly champion who wields divine magic in service of a higher power";
    } else if (selectedClass == "Druid") {
      return "A priest of the Old Faith, wielding the powers of nature— moonlight and plant growth, fire and lightning— and adopting animal forms";
    } else if (selectedClass == "Fighter") {
      return "A master of martial combat, skilled with a variety of weapons and armor";
    } else if (selectedClass == "Monk") {
      return "A master of martial arts, harnessing the power of the body in pursuit of physical and spiritual perfection";
    } else if (selectedClass == "Paladin") {
      return "A holy warrior bound to a sacred oath";
    } else if (selectedClass == "Ranger") {
      return "A warrior who uses martial prowess and nature magic to combat threats on the edges of civilization";
    } else if (selectedClass == "Rogue") {
      return "A scoundrel who uses stealth and trickery to overcome obstacles and enemies";
    } else if (selectedClass == "Sorcerer") {
      return "A spellcaster who draws on inherent magic from a gift or bloodline";
    } else if (selectedClass == "Warlock") {
      return "A wielder of magic that is derived from a bargain with an extraplanar entity";
    } else { // if (selectedClass == "Wizard")  
      return "A scholarly magic-user capable of manipulating the structures of reality";
    }  
  }

  static String _getRandomHitDie(String selectedClass) {
    if (selectedClass == "Barbarian") {
      return "d12";
    } else if (selectedClass == "Bard") {
       return "d8";
    } else if (selectedClass == "Cleric") {
       return "d8";
    } else if (selectedClass == "Druid") {
       return "d8";
    } else if (selectedClass == "Fighter") {
       return "d10";
    } else if (selectedClass == "Monk") {
       return "d8";
    } else if (selectedClass == "Paladin") {
       return "d10";
    } else if (selectedClass == "Ranger") {
       return "d10";
    } else if (selectedClass == "Rogue") {
       return "d8";
    } else if (selectedClass == "Sorcerer") {
       return "d6";
    } else if (selectedClass == "Warlock") {
       return "d8";
    } else { // if (selectedClass == "Wizard")  
       return "d6";
    }  
  }

  static List<String> _generateRandomProficiencies(String selectedClass) {
    Map<String, List<String>> languages = {
      "Barbarian": [
        "Light and medium armor",
        "Shields",
        "Simple and martial weapons",
      ],
      "Bard": [
        "Light armor",
        "Simple weapons",
        "Hand crossbows",
        "Longswords",
        "Rapiers",
        "Shortsword",
      ],
      "Cleric": [
        "Light and medium armor",
        "Shields",
        "Simple weapons",
      ],
      "Druid": [ 
        "Light and medium armor (nonmetal)",
        "Shields (nonmetal)",
        "Clubs",
        "Daggers",
        "Darts",
        "Javelins",
        "Maces",
        "Quarterstaffs",
        "Scimitars",
        "Sickles",
        "Slings",
        "Spears",
      ],
      "Fighter": [
        "All armor",
        "Shields",
        "Simple and martial weapons",
      ],
      "Monk": [
        "Simple weapons",
        "Shortswords",
      ],
      "Paladin": [ 
        "All armor",
        "Shields",
        "Simple and martial weapons",
      ],
      "Ranger": [
        "Light and medium armor",
        "Shields",
        "Simple and martial weapons", 
      ],
      "Rogue": [
        "Light armor",
        "Simple weapons"
        "Hand crossbows",
        "Longswords",
        "Rapiers",
        "Shortswords",
      ],
      "Sorcerer": [
        "Daggers",
        "Darts"
        "Slings",
        "Quarterstaff",
        "Light crossbows",
      ],
      "Warlock": [
        "Light armor",
        "Simple weapons"
      ],
      "Wizard": [
        "Daggers",
        "Darts",
        "Slings",
        "Quarterstaff",
        "Light crossbows",
      ]
    };

    if (languages.containsKey(selectedClass)) {
      return languages[selectedClass]!;
    }
    throw Exception("Unsupported language selected");
  }

  static List<String> _getRandomTools(String selectedClass) {
    Map<String, List<List<String>>> tools = {
      "Barbarian": [
        ["Nothing"],
      ],
      "Bard": [
        ["Lira", "Harp", "Lute"],
        ["Bagpipe", "Flute", "Gemshorn"],
        ["Cymbals", "Pandeiro", "Tambourine"],
      ],
      "Cleric": [
        ["Nothing"],
      ],
      "Druid": [
        ["Herbalism kit"],
      ],
      "Fighter": [
        ["Nothing"],
      ],
      "Monk": [
        ["Artisan's tools", "A musical instrument"],
      ],
      "Paladin": [
        ["Nothing"],
      ],
      "Ranger": [
        ["Nothing"],
      ],
      "Rogue": [
        ["Thieve's tools"],
      ],
      "Sorcerer": [
        ["Nothing"],
      ],
      "Warlock": [
        ["Nothing"],
      ],
      "Wizard": [
        ["Nothing"],
      ],
    };

    List<String> randomTools = [];
    if (tools.containsKey(selectedClass)) {
      tools[selectedClass]!.forEach((element) {
        String choice = randomChoice(element);
        randomTools.add(choice);
      });
      return randomTools;
    }
    throw Exception("Unsupported career selected");
  }

  static int _getRandomHp(String selectedClass, int con) {
    Map<String, int> hp = {
      "Barbarian": 12 + con,
      "Bard": 8 + con,
      "Cleric": 8 + con,
      "Druid": 8 + con,
      "Fighter": 10 + con,
      "Monk": 8 + con,
      "Paladin": 10 + con,
      "Ranger": 10 + con,
      "Rogue": 8 + con,
      "Sorcerer": 6 + con,
      "Warlock": 8 + con,
      "Wizard": 6 + con,
    };

    if (hp.containsKey(selectedClass)) {
      return hp[selectedClass]!;
    }
    throw Exception("Unsupported HP selected");
  }

  static List<String> _getExtraRandomSkills(int num, List<String> availableSkills) {
    List<String> newExtraSkills = [];
    List<String> extraSkills = availableSkills;
    for(int i=0; i<num; i++) {
      String newRandomSkill = randomChoice(extraSkills);
      newExtraSkills.add(newRandomSkill);
      extraSkills.remove(newRandomSkill);
    }
    return newExtraSkills;
  }

  static List<String> _getAnyExtraRandomSkills(int num) {
    List<String> newExtraSkills = [];
    List<String> extraSkills = ["Acrobatics", "Animal handling", "Arcana", "Athletics", "Deception", "History", "Insight", "Intimidation", "Investigation", "Nature", "Perception", "Performance", "Persuasion", "Religion", "Sleight of Hand", "Stealth", "Survival"];
    for(int i=0; i<num; i++) {
      String newRandomSkill = randomChoice(extraSkills);
      newExtraSkills.add(newRandomSkill);
      extraSkills.remove(newRandomSkill);
    }
    return newExtraSkills;
  }

  static List<String> _generateRandomSkills(String selectedClass) {
    Map<String, List<String>> skills = {
      "Barbarian": _getExtraRandomSkills(2, ["Animal handling", "Athletics", "Intimidation", "Nature", "Perception", "Survival"]),
      "Bard": _getAnyExtraRandomSkills(3),
      "Cleric": _getExtraRandomSkills(2, ["History", "Insight", "Medicine", "Persuasion", "Religion"]),
      "Druid": _getExtraRandomSkills(2, ["Arcana", "Animal Handling", "Insight", "Medicine", "Nature", "Perception", "Religion", "Survival"]),
      "Fighter": _getExtraRandomSkills(2, ["Acrobatics", "Animal Handling", "Athletics", "History", "Insight", "Intimidation", "Perception", "Survival"]),
      "Monk": _getExtraRandomSkills(2, ["Acrobatics", "Athletics", "History", "Insight", "Religion", "Stealth"]),
      "Paladin": _getExtraRandomSkills(2, ["Athletics", "Insight", "Intimidation", "Medicine", "Persuasion", "Religion"]),
      "Ranger": _getExtraRandomSkills(3, ["Animal Handling", "Athletics", "Insight", "Investigation", "Nature", "Perception", "Stealth", "Survival"]),
      "Rogue": _getExtraRandomSkills(4, ["Acrobatics", "Athletics", "Deception", "Insight", "Intimidation", "Investigation", "Perception", "Performance", "Persuasion", "Sleight of Hand", "Stealth"]),
      "Sorcerer": _getExtraRandomSkills(2, ["Arcana", "Deception", "Insight", "Intimidation", "Persuasion", "Religion"]),
      "Warlock": _getExtraRandomSkills(2, ["Arcana", "Deception", "History", "Intimidation", "Investigation", "Nature", "Religion"]),
      "Wizard": _getExtraRandomSkills(2, ["Arcana", "History", "Insight", "Investigation", "Medicine", "Religion"])
    };

    if (skills.containsKey(selectedClass)) {
      return skills[selectedClass]!;
    }
    throw Exception("Unsupported skills selected");
  }

  static List<String> _getRandomEquipment(String selectedClass) {
    Map<String, List<List<String>>> equipments = {
      "Barbarian": [
        ["A greataxe", "Any martial melee weapon"],
        ["Two hand axes ", "Any simple weapon "],
        ["An explorer’s pack and four javelins"],
      ],
      "Bard": [
        ["A rapier", "A longsword", "Any simple weapon"],
        ["A diplomat's pack ", "An entertainer's pack"],
        ["A lute", "Any other musical instrument"],
        ["Leather armor and a dagger"],
      ],
      "Cleric": [
        ["A mace", "A warhammer"],
        ["A scale mail", "A leather armor", "Chain mail"],
        [
          "A light crossbow and 20 bolts",
          "Any simple weapon"
        ],
        ["A priest's pack", "An explorer's pack "]
      ],
      "Druid": [
        ["A wooden shield ", "Any simple weapon"],
        ["A scimitar", "Any simple melee weapone."],
        ["Leather armor, an explorer’s pack, and a druidic focus"]
      ],
      "Fighter": [
        ["Chain mail", "A leather longbow and 20 arrows."],
        ["A martial weapon and a shield", "Two martial weapons"],
        ["A light crossbow and 20 bolts", "Two handaxes"],
        ["A dungeoneer's pack", "An explorer's pack"],
      ],
      "Monk": [
        ["A shortsword ", "Any simple weapon"],
        ["A dungeoneer's pack", "An explorer's pack"],
        ["10 darts"]
      ],
      "Paladin": [
        ["A martial weapon and a shield", "Two martial weapons"],
        ["Five javelins", "Any simple melee weapon"],
        ["A priest's pack", "An explorer's pack"],
        ["Chain mail and a holy symbol"]
      ],
      "Ranger": [
        ["Scale mail", "A leather armor"],
        ["Two shortswords", "Two simple melee weapons"],
        ["A dungeoneer's pack", "An explorer's pack"],
        ["A longbow and a quiver of 20 arrows"]
      ],
      "Rogue": [
        ["A rapier", "A shortsword"],
        ["A shortbow and quiver of 20 arrows", "A shortsword"],
        ["A burglar's pack", "A dungeoneer's pack"],
        ["Leather armor, two daggers, and thieves' tools"],
      ],
      "Sorcerer": [
        ["A light crossbow and 20 bolts", "Any simple weapon"],
        ["A component pouch", "An arcane focus"],
        ["A dungeoneer's pack", "An explorer's pack"],
        ["Two daggers"]
      ],
      "Warlock": [
        ["A light crossbow and 20 bolts", "Any simple weapon"],
        ["A component pouch", "An arcane focus"],
        ["A scholar's pack", "A dungeoneer's pack"],
        ["Leather armor, any simple weapon, and two daggers"]
      ],
      "Wizard": [
        ["A quarterstaff", "A dagger"],
        ["A component pouch", "An arcane focus"],
        ["A scholar's pack", "An explorer's pack"],
        ["A spellbook"]
      ]
    };

    List<String> equipment = [];
    if (equipments.containsKey(selectedClass)) {
      equipments[selectedClass]!.forEach((element) {
        String choice = randomChoice(element);
        equipment.add(choice);
      });
      return equipment;
    }
    throw Exception("Unsupported class selected");
  }

  static String _getRandomSex() {
    return randomChoice(["Male", "Female"]);
  }

  static String _getRandomBackground() {
    List<String> backgrounds = [
      "You are a decorated hero and you have to defend your reputation. At all costs.",
      "You once covered up a war crime. No one should ever know.",
      "The death of your companion has traumatized you, and now you are terrified of the possibility of entering combat. You have to overcome your fears.",
      "After a long time together, your partner betrayed you and joined a criminal syndicate. He will have to answer you.",
      "You dream of handing in your badge and retiring to a place where you can live in peace. Do everything possible to achieve it.",
      "You did something terrible in the past and now it is taking its toll on you. You will have to decide what material you are made of.",
      "You crave power and never pass up an opportunity to advance.",
      "Your family is hiding information from you. What will it be? Why?",
      "You want to find someone you can really trust.",
      "Your whole family has died. Make sure you are never left alone again.",
      "Nobody gives you any tasks, so dedicate yourself to exploring, trying things, finding life to have fun.",
      "You are hooked on a strong painkiller. You have to keep your stock (and the secret) well.",
      "You have some unusual (and confidential) medical reports that the local sheriff is looking for. Find out why they are so important.",
      "You swore you would never take a life, and you intend to honor that oath.",
      "You come from a family of officers. You have to earn a promotion or some decoration, and tomorrow is too late.",
      "You screwed up once. Make sure no more shit happens to you.",
      "Mistakes are costly, don't let any of your subordinates screw up. And make sure they understand why.",
      "You only think about exceeding the limit, about taking risks and taking risks, so take risks.",
      "You are stubborn and do not shy away from anything, even if your friends may be hurt.",
      "You are a loner and prefer to act without depending on others.",
      "You seek strong emotions compulsively. If there is something that entails a risk, you are there to assume it.",
      "You once gave up your family for work. Now you don't plan to disappoint your friends. Never.",
      "You like to enjoy your free time. If you can grab a can of beer and spend some time alone, you are the happiest person in the world."
      "Your last project was stolen, so now you keep most of your findings a secret.",
      "You hate authority; Do your best to appear uncooperative.",
      "It is very difficult for you to delegate to others, even when it makes you work more than necessary."
    ];
    return randomChoice(backgrounds);
  }


  static String _getRandomEyesColor() {
    List<String> eyes = [
      "Dark Brown",
      "Brown",
      "Light brown",
      "Hazel",
      "Amber",
      "Green"
      "Turquoise", 
      "Bluish gray",
      "Gray",
      "Icy blue",
      "Violet"
    ];
    return randomChoice(eyes);
  }

  static String _getRandomHairColor() {
    List<String> hairs = ["Black", "Brown", "Blonde", "Red", "Gray", "Brunette", "Silver"];
    return randomChoice(hairs);
  }

  static String _getRandomSkinColor() {
    List<String> skinTones = [
    "Fair", 
    "Light", 
    "Medium", 
    "Olive", 
    "Tan", 
    "Deep", 
    "Ebony",
  ];
    return randomChoice(skinTones);
  }

  static String _getRandomAppearance() {
    List<String> appearance = [
        "Brush haircut",
        "Tattoo on the arm",
        "Scar",
        "Cold look",
        "Haughty smile",
        "Custom armor"
        "Toothpick in the mouth",
        "Imposing mustache",
        "Old clothes",
        "Scar that crosses your face",
        "Brush haircut",
        "Inquisitive look",
        "Worn leather jacket"
        "Cold gaze",
        "Captivating smile",
        "Signet ring",
        "Tan",
        "Elaborate hairstyle",
        "Vacant expression",
        "Dirty and disheveled",
        "Shorts with many pockets",
        "Hair in a ponytail",
        "Bored face",
        "Compassionate smile",
        "Short",
        "Well-combed hair",
        "Warm and affectionate gaze",
        "Prominent dark circles",
        "Restless hands",
        "Sweet and calm voice",
        "Cold and indifferent gaze",
        "Glasses",
        "White coat"
        "Hair cut with a brush or collected in a bun",
        "Intense and severe expression",
        "Impeccable uniform",
        "Looks like working a lot and sleeping little",
        "Stretched posture",
        "Serene and relaxing voice",
        "Impatient tapping of the foot"
        "Arrogant walk",
        "Identifying patches from previous missions",
        "Expressionless face",
        "Look of skepticism"
        "Tattoos",
        "Scar",
        "Broken nose",
        "Taciturn expression",
        "Mocking smile",
        "Loud laughter",
        "Calloused and bruised hands",
        "Dirty boots that echo with each step",
        "Disheveled hair"
        "Disheveled and unkempt appearance",
        "Stained coat",
        "Nervous attitude",
        "Hands always in pockets",
        "Neat and well-trimmed hairstyle",
        "Thoughtful look",
        "Always clears throat before speaking",
        "Eyes tired from overwork"
      ];

      return randomChoice(appearance);
    }



  @override
  String toString() {
    return 'DyDCharacter: {'
        'userId: $userId,'
        ' id: $id,'
        ' mode: $mode,'
        ' characterLevel: $characterLevel,'
        ' race: $race,'
        ' abilities: $abilities,'
        ' age: $age,'
        ' alignment: $alignment,'
        ' name: $name,'
        ' height: $height,'
        ' weight: $weight,'
        ' size: $size,'
        ' traits: $traits,'
        ' languages: $languages,'
        ' photoUrl: $photoUrl,'
        ' characterClass: $characterClass,'
        ' description: $description,'
        ' hitDie: $hitDie,'
        ' proficiencies: $proficiencies,'
        ' tools: $tools,'
        ' hp: $hp,'
        ' skills: $skills,'
        ' equipment: $equipment,'
        ' sex: $sex,'
        ' background: $background,'
        ' eyesColor: $eyesColor,'
        ' hairColor: $hairColor,'
        ' skinColor: $skinColor,'
        ' appearance: $appearance,'
        '}';
  }

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'id': id,
      'mode': mode,
      'character_level': characterLevel,
      'race': race,
      'abilities': abilities,
      'age': age,
      'alignment': alignment,
      'name': name,
      'height': height,
      'weight': weight,
      'size': size,
      'traits': traits,
      'languages': languages,
      'photo_url': photoUrl,
      'characterClass': characterClass,
      'description': description,
      'hitDie': hitDie,
      'proficiencies': proficiencies,
      'tools': tools,
      'hp': hp,
      'skills': skills,
      'equipment': equipment,
      'sex': sex,
      'background': background,
      'eyesColor': eyesColor,
      'hairColor': hairColor,
      'skinColor': skinColor,
      'appearance': appearance
    };
  }

  static fromMap(Map<String, dynamic> statsData) {
    return DydCharacter(
      userId: statsData['userId'] as String,
      id: statsData['id'] as String,
      name: statsData['name'] as String,
      
      characterLevel: statsData['character_level'] as int,
      race: statsData['race'] as String,
      abilities: (statsData['abilities'] as Map<String, dynamic>)
          .map((key, value) => MapEntry(key, value as int)),
      age: statsData['age'] as int,
      alignment: statsData['alignment'] as String,
      height: statsData['height'] as double,
      weight: statsData['weight'] as double,
      size: statsData['size'] as String,
      traits: (statsData['traits'] as List<dynamic>)
          .map((value) => value as String)
          .toList(),
      languages: (statsData['languages'] as List<dynamic>)
          .map((value) => value as String)
          .toList(),
      characterClass: statsData['characterClass'] as String,
      description: statsData['description'] as String,
      hitDie: statsData['hitDie'] as String,
      proficiencies: (statsData['proficiencies'] as List<dynamic>)
          .map((value) => value as String)
          .toList(),
      tools: (statsData['tools'] as List<dynamic>)
          .map((value) => value as String)
          .toList(),
      hp: statsData['hp'] as int,
      skills: (statsData['skills'] as List<dynamic>)
          .map((value) => value as String)
          .toList(),
      equipment: (statsData['equipment'] as List<dynamic>)
          .map((value) => value as String)
          .toList(),
      sex: statsData['sex'] as String,
      background: statsData['background'] as String,
      eyesColor: statsData['eyesColor'] as String,
      hairColor: statsData['hairColor'] as String,
      skinColor: statsData['skinColor'] as String,
      appearance: statsData['appearance'] as String,
      photoUrl: statsData['photo_url'] as String,
    );
  }
}
