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
  final String tools;
  final int hp;
  final Map<String, int> skills;
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
    final proficiencies = _getRandomCash(characterClass);
    final tools = _getRandomCash(characterClass);
    final hp = _getRandomCash(characterClass, abilities);
    final skills = _getRandomCash(characterClass);
    final equipment = _getRandomCash(characterClass);
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
      return 1.12 + (makeRoll(2, 4) * 2.5);
    } else if (selectedRace == "Elf") {
      return 1.37 + (makeRoll(2, 10) * 2.5);
    } else if (selectedRace == "Halfling") {
      return 0.79 + (makeRoll(2, 4) * 2.5);
    } else if (selectedRace == "Human") {
      return 1.45 + (makeRoll(2, 10) * 2.5);
    } else if (selectedRace == "Dragonborn") {
      return 1.68 + (makeRoll(2, 8) * 2.5);
    } else if (selectedRace == "Gnome") {
      return 0.89 + (makeRoll(2, 4) * 2.5);
    } else if (selectedRace == "Half-elf") {
      return 1.45 + (makeRoll(2, 8) * 2.5);
    } else if (selectedRace == "Half-orc") {
      return 1.47 + (makeRoll(2, 10) * 2.5);
    } else { // if (selectedRace == "Tiefling") 
      return 1.45 + (makeRoll(2, 8) * 2.5);
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



//old
  static Map<String, int> _generateRandomSkills(String selectedCareer) {
    // TODO: make random but to sum 9
    if (selectedCareer == "Colonial marine" || selectedCareer == "Roughneck") {
      return {"Close combat": 3, "Stamina": 3, "Heavy Machinery": 3};
    }
    if (selectedCareer == "Kid" || selectedCareer == "Pilot") {
      return {"Ranged combat": 3, "Mobility": 3, "Piloting": 3};
    }
    if (selectedCareer == "Colonial marshall" ||
        selectedCareer == "Scientific" ||
        selectedCareer == "Agent") {
      return {"Observation": 3, "Survival": 3, "Comtech": 3};
    }
    if (selectedCareer == "Medic" || selectedCareer == "Official") {
      return {"Command": 3, "Manipulation": 3, "Medical aid": 3};
    }
    throw Exception("Unsupported career selected");
  }

  static List<String> _generateRandomTalents(String selectedCareer) {
    Map<String, List<String>> talents = {
      "Colonial marine": ["Banter", "Overkill", "Past the limit"],
      "Colonial marshall": ["Authority", "Investigator", "Subdue"],
      "Agent": ["Cunning", "Personal safety", "Take control"],
      "Kid": ["Beneath notice", "Dodge", "Nimble"],
      "Medic": ["Calming presence", "Investigator", "Subdue"],
      "Official": ["Field commander", "Influence", "Pull rank"],
      "Pilot": ["Full throttle", "Like the back of your hand", "Reckless"],
      "Roughneck": ["Resilient", "The long haul", "True grit"],
      "Scientific": ["Analysis", "Breakthrough", "Inquisitive"]
    };

    if (talents.containsKey(selectedCareer)) {
      return [randomChoice(talents[selectedCareer]!)];
    }
    throw Exception("Unsupported career selected");
  }
 static String _getRandomAppearance(String selectedCareer) {
    Map<String, List<String>> appearance = {
      "Colonial marine": [
        "Brush haircut",
        "Tattoo on the arm",
        "Scar",
        "Cold look",
        "Haughty smile",
        "Custom armor"
      ],
      "Colonial marshall": [
        "Toothpick in the mouth",
        "Cigarette in mouth",
        "Imposing mustache",
        "Old cap",
        "Scar that crosses your face",
        "Gray hair",
        "Brush haircut",
        "Inquisitive look",
        "Worn leather jacket"
      ],
      "Agent": [
        "Cold gaze",
        "Captivating smile",
        "Expensive watch",
        "Signet ring",
        "Tan",
        "Elaborate hairstyle",
        "Vacant expression",
        "Monogrammed silk tie"
      ],
      "Kid": [
        "Dirty and disheveled",
        "Cool sneakers that light up when you walk",
        "Jeans with slits at the knees",
        "T-shirt with a group logo",
        "Shorts with many pockets",
        "Hair in a ponytail",
        "Bored face",
        "Baseball cap"
      ],
      "Medic": [
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
      ],
      "Official": [
        "Hair cut with a brush or collected in a bun",
        "Intense and severe expression",
        "Impeccable uniform",
        "Looks like working a lot and sleeping little",
        "Stretched posture",
        "Serene and relaxing voice",
        "Flight suit with identification patch",
        "Impatient tapping of the foot"
      ],
      "Pilot": [
        "Arrogant walk",
        "Piercing blue eyes",
        "Flight suit with many pockets",
        "Sunglasses",
        "Identifying patches from previous missions",
        "Expressionless face",
        "Always chewing gum",
        "Look of skepticism"
      ],
      "Roughneck": [
        "Tattoos",
        "Scar",
        "Broken nose",
        "Taciturn expression",
        "Mocking smile",
        "Loud laughter",
        "Calloused and bruised hands",
        "Safety glasses that cover your eyes",
        "Dirty boots that echo with each step",
        "Disheveled hair"
      ],
      "Scientific": [
        "Disheveled and unkempt appearance",
        "Stained lab coat",
        "Nervous attitude",
        "Hands always in pockets",
        "Neat and well-trimmed hairstyle",
        "Thoughtful look",
        "Always clears throat before speaking",
        "Eyes tired from overwork"
      ]
    };

    if (appearance.containsKey(selectedCareer)) {
      return randomChoice(appearance[selectedCareer]!);
    }
    throw Exception("Unsupported career selected");
  }

  static String _getRandomPersonalAgenda(String selectedCareer) {
    Map<String, List<String>> appearance = {
      "Colonial marine": [
        "You are a decorated hero and you have to defend your reputation. At all costs.",
        "You once covered up a war crime. No one should ever know.",
        "The death of your companion has traumatized you, and now you are terrified of the possibility of entering combat. you have to overcome your fears."
      ],
      "Colonial marshall": [
        "After a long time together, your partner betrayed you and joined a criminal syndicate. He will have to answer you.",
        "You dream of handing in your badge and retiring to a place where you can live in peace. Do everything possible to achieve it.",
        "You did something terrible in the past and now it is taking its toll on you. You will have to decide what material you are made of."
      ],
      "Agent": [
        "You crave power and never pass up an opportunity to advance.",
        "The company is hiding information from you. What will it be? Why?",
        "You are a good person, but the company is blackmailing you to do their dirty work. Get even as you can."
      ],
      "Kid": [
        "You want to find an adult you can really trust.",
        "Your whole family has died. Make sure you are never left alone again.",
        "Nobody gives you any tasks, so dedicate yourself to exploring, trying things, finding life to have fun."
      ],
      "Medic": [
        "You are hooked on a strong painkiller. You have to keep your stock (and the secret) well.",
        "You have some unusual (and confidential) medical reports that the company is looking for. Find out why they are so important.",
        "You swore you would never take a life, and you intend to honor that oath."
      ],
      "Official": [
        "You come from a family of officers. You have to earn a promotion or some decoration, and tomorrow is too late.",
        "You screwed up once. Make sure no more shit happens to you.",
        "Mistakes are costly, don't let any of your subordinates screw up. And make sure they understand why."
      ],
      "Pilot": [
        "You only think about exceeding the limit, about taking risks and taking risks, so take risks.",
        "You are stubborn and do not shy away from anything, even if your friends may be hurt.",
        "You are a loner and prefer to act without depending on others."
      ],
      "Roughneck": [
        "You seek strong emotions compulsively. If there is something that entails a risk, you are there to assume it.",
        "You once gave up your family for work. Now you don't plan to disappoint your friends. Never.",
        "You like to enjoy your free time. If you can grab a can of beer and spend some time alone, you are the happiest person in the world."
      ],
      "Scientific": [
        "Your last project was stolen, so now you keep most of your findings a secret.",
        "You hate authority; Do your best to appear uncooperative.",
        "It is very difficult for you to delegate to others, even when it makes you work more than necessary."
      ],
    };

    if (appearance.containsKey(selectedCareer)) {
      return randomChoice(appearance[selectedCareer]!);
    }
    throw Exception("Unsupported career selected");
  }

  static List<String> _getRandomGear(String selectedCareer) {
    Map<String, List<List<String>>> appearance = {
      "Colonial marine": [
        ["A pulse rifle", "A smart machine gun"],
        ["A motion tracker", "2 electroshock grenades"],
        ["A pressure suit", "Armor"],
        ["A sparkler", "A deck of cards"]
      ],
      "Colonial marshall": [
        ["A .357 Magnum revolver", "A pump-action shotgun."],
        ["Some binoculars", "A high-power flashlight."],
        ["A first aid kit", "An electric baton."],
        ["1D6 Sleep Remover pills", "A personal communicator."],
      ],
      "Agent": [
        ["A leather briefcase", "A chrome briefcase."],
        ["A gold-plated fountain pen", "A luxury watch."],
        [
          "A data transmission card with corporate accreditation",
          "A service pistol."
        ],
        ["1D6 sleep reliever pills", "1D6 dose of Naproleve."]
      ],
      "Kid": [
        ["A fishing line", "a laser pointer."],
        ["A magnet", "A remote-controlled car."],
        ["A yo-yo", "An electronic game."],
        ["A personal locator", "colored pencils."]
      ],
      "Medic": [
        ["Surgical instruments", "A compression suit."],
        ["1D6 doses of Naproleve", "1D6 Quitaseño pills"],
        ["A first aid kit", "1D6 doses of experimental drugs."],
        ["A Samani E series watch", "A personal communicator."]
      ],
      "Official": [
        ["A service gun", "A high-tech gun"],
        ["A watch", "binoculars"],
        ["A motion tracker", "Compression suit"],
        ["A personal tablet", "A friend-enemy transponder"]
      ],
      "Pilot": [
        ["A service pistol", "A portable remote control terminal."],
        ["A personal communicator", "1D6 flares."],
        ["A maintenance tool", "A personal tablet."],
        ["A systems diagnostic tool", "A compression suit."]
      ],
      "Roughneck": [
        ["A blowtorch", "A pneumatic riveter."],
        ["1D6 dose of Hydroctin", "A maintenance tool."],
        ["High-proof liquor", "A compression suit."],
        ["A high-powered flashlight", "Magnetic tape recorder"]
      ],
      "Scientific": [
        ["A digital video camera", "A personal communicator."],
        ["A personal tablet", "A neurovisor."],
        ["A system diagnostic tool", "Personal data transmitter."],
        ["A motion tracker", "First aid kit."]
      ],
    };

    List<String> gear = [];
    if (appearance.containsKey(selectedCareer)) {
      appearance[selectedCareer]!.forEach((element) {
        String choice = randomChoice(element);
        gear.add(choice);
      });
      return gear;
    }
    throw Exception("Unsupported career selected");
  }

  static String _getRandomSignatureItem(String selectedCareer) {
    Map<String, List<String>> appearance = {
      "Colonial marine": [
        "The bullet that almost killed you",
        "The dog tags of a fallen comrade",
        "A trophy of a defeated enemy",
      ],
      "Colonial marshall": [
        "A photograph of a loved one.",
        "A dented flask with an inscription on the front.",
        "Newspaper clippings about an unsolved case.",
      ],
      "Agent": [
        "A written corporate authorization.",
        "Your divorce papers.",
        "An employee of the year award.",
      ],
      "Kid": [
        "A lunch box covered in stickers.",
        "Your favorite doll or action figure.",
        "The bracelet your older sibling made you.",
      ],
      "Medic": [
        "A framed medical certificate.",
        "A letter from your son (or daughter).",
        "Your last psychological evaluation. \"Everything's finally over\"",
      ],
      "Official": [
        "The on-board cat.",
        "A recommendation letter.",
        "A commercial flight officer license.",
      ],
      "Pilot": [
        "A bobblehead doll for the dashboard.",
        "A flight log.",
        "Some aviator sunglasses.",
      ],
      "Roughneck": [
        "A tool belt.",
        "Your partner's photograph.",
        "A crucifix or any other religious icon.",
      ],
      "Scientific": [
        "An albert einstein award.",
        "A half-written scientific article.",
        "Blackmail letters.",
      ],
    };

    if (appearance.containsKey(selectedCareer)) {
      return randomChoice(appearance[selectedCareer]!);
    }
    throw Exception("Unsupported career selected");
  }

  static int _getRandomCash(String selectedCareer) {
    Map<String, int> cash = {
      "Colonial marine": Random().nextInt(6) * 100,
      "Colonial marshall": Random().nextInt(6) * 100,
      "Agent": (Random().nextInt(6) + Random().nextInt(6)) * 100,
      "Kid": Random().nextInt(6) * 100,
      "Medic": Random().nextInt(6) * 100,
      "Official": (Random().nextInt(6) + Random().nextInt(6)) * 100,
      "Pilot": Random().nextInt(6) * 100,
      "Roughneck": Random().nextInt(6) * 100,
      "Scientific": Random().nextInt(6) * 100
    };

    if (cash.containsKey(selectedCareer)) {
      return cash[selectedCareer]!;
    }
    throw Exception("Unsupported career selected");
  }

  @override
  String toString() {
    return 'AliensCharacter: {'
        'userId: $userId,'
        ' id: $id,'
        ' mode: $mode,'
        ' characterLevel: $characterLevel,'
        ' career: $career,'
        ' attributes: $attributes,'
        ' skills: $skills,'
        ' talents: $talents,'
        ' name: $name,'
        ' appearance: $appearance,'
        ' personalAgenda: $personalAgenda,'
        ' friend: $friend,'
        ' rival: $rival,'
        ' gear: $gear,'
        ' photoUrl: $photoUrl,'
        ' signatureItem: $signatureItem,'
        ' cash: $cash,'
        ' hp: $hp'
        '}';
  }

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'id': id,
      'mode': mode,
      'character_level': characterLevel,
      'career': career,
      'attributes': attributes,
      'skills': skills,
      'talents': talents,
      'name': name,
      'appearance': appearance,
      'personal_agenda': personalAgenda,
      'friend': friend,
      'rival': rival,
      'gear': gear,
      'photo_url': photoUrl,
      'signature_item': signatureItem,
      'cash': cash,
      'hp': hp,
    };
  }

  static fromMap(Map<String, dynamic> statsData) {
    return DydCharacter(
      userId: statsData['userId'] as String,
      id: statsData['id'] as String,
      name: statsData['name'] as String,
      hp: statsData['hp'] as int,
      characterLevel: statsData['character_level'] as int,
      career: statsData['career'] as String,
      attributes: (statsData['attributes'] as Map<String, dynamic>)
          .map((key, value) => MapEntry(key, value as int)),
      skills: (statsData['skills'] as Map<String, dynamic>)
          .map((key, value) => MapEntry(key, value as int)),
      talents: (statsData['talents'] as List<dynamic>)
          .map((value) => value as String)
          .toList(),
      appearance: statsData['appearance'] as String,
      personalAgenda: statsData['signature_item'] as String,
      friend: statsData['friend'] as String,
      rival: statsData['rival'] as String,
      gear: (statsData['gear'] as List<dynamic>)
          .map((value) => value as String)
          .toList(),
      photoUrl: statsData['photo_url'] as String,
      signatureItem: statsData['signature_item'] as String,
      cash: statsData['cash'] as int,
    );
  }
}
