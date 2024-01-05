import 'dart:math';
import 'package:dart_random_choice/dart_random_choice.dart';
import 'package:role_maister/config/app_singleton.dart';
import 'package:role_maister/models/character.dart';
import 'package:uuid/uuid.dart';

class CthulhuCharacter extends Character {
  // TODO: de momento solo tenemos character level 1
  
  final int characterLevel;
  final String? photoUrl;
  final String mode = "cthulhu";

  final String occupation;
  final String gender;
  final int age;
  final Map<String, int> characteristics;
  final int bonusDamage;
  final int hp;
  final int sanity;
  final int mp;
  final int luck;
  final Map<String, int> skills;
  final Map<String, int> weapons;
  final List<String> personalDescription;
  final String ideology;
  final String relatives;
  final String significantPlaces;
  final String prizedPossessions;
  final String traits;
  final String phobias;
  final String manias;
  final List<String> equipment;

  CthulhuCharacter({
    String? id,
    required this.characterLevel,
    required String name,
    required String userId,
    required this.photoUrl,
    
    required this.occupation,
    required this.gender,
    required this.age,
    required this.characteristics,
    required this.bonusDamage,
    required this.hp,
    required this.sanity,
    required this.mp,
    required this.luck,
    required this.skills,
    required this.weapons,
    required this.personalDescription,
    required this.ideology,
    required this.relatives,
    required this.significantPlaces,
    required this.prizedPossessions,
    required this.traits,
    required this.phobias,
    required this.manias,
    required this.equipment,
  }) : super(name, userId , id: id);

  // Factory constructor to generate random AliensCharacter
  factory CthulhuCharacter.random() {
    final occupation = _generateRandomOccupation();
    final gender = _generateRandomGender();
    final age = _generateRandomAge();
    final characteristics = _generateRandomCharacteristics();
    final bonusDamage = _getRandomBonusDamage(characteristics);
    final hp = _getRandomHp(characteristics);
    final sanity = _getRandomSanity(characteristics);
    final mp = _getRandomMp(characteristics);
    final luck = _getRandomLuck();
    final skills = _getRandomSkills(occupation);
    final weapons = _getRandomWeapons();
    final personalDescription = _getRandomPersonalDescription(gender);
    final ideology = _getRandomIdeology();
    final relatives = _getRandomRelatives();
    final significantPlaces = _getRandomSignificantPlaces();
    final prizedPossessions = _getRandomPrizedPossessions();
    final traits = _getRandomTraits();
    final phobias = _getRandomPhobias();
    final manias = _getRandomManias();
    final equipment = _getRandomEquipment();
    
    String name = _getRandomName(gender);
    String userId = "test";
    const photoUrl = "small_logo.png";
    return CthulhuCharacter(
      characterLevel: 1,
      name: name,
      userId: userId,
      photoUrl: photoUrl,
      occupation: occupation,
      gender: gender,
      age: age,
      characteristics: characteristics,
      bonusDamage: bonusDamage,
      hp: hp,
      sanity: sanity,
      mp: mp,
      luck: luck,
      skills: skills,
      weapons: weapons,
      personalDescription: personalDescription,
      ideology: ideology,
      relatives: relatives,
      significantPlaces: significantPlaces,
      prizedPossessions: prizedPossessions,
      traits: traits,
      phobias: phobias,
      manias: manias,
      equipment: equipment,
    );
  }


  static String _generateRandomOccupation() {
    List<String> occupations = [
      "Antiquarian",
      "Dilettante",
      "Writer",
      "Police inspector",
      "Private investigator",
      "Medic",
      "Journalist",
      "University professor",
    ];
    return randomChoice(occupations);
  }

  static String _generateRandomGender() {
    return randomChoice(["Male", "Female"]);
  }

  static String _getRandomName(String gender) {
    if(gender == "Male") {
      return randomChoice(["Nevada Jones", "Wentworth Avebury", "Mike Hawk"]);
    } else {
      return randomChoice(["Jessie Williams", "Keiko Cain", "Lois Russo"]);
    }
  }

  static int _generateRandomAge() {
    return Random().nextInt(63) + 18;
  }

  static Map<String, int> _generateRandomCharacteristics() {
    Map<String, int> characteristics = {
      "STR": 0,
      "CON": 0,
      "POW": 0,
      "DEX": 0,
      "APP": 0,
      "SIZ": 0,
      "INT": 0,
      "EDU": 0,
    };

    List<int> probs = [40, 50, 50, 50, 60, 60, 70, 80];
    characteristics.forEach((_, percent) {
      int prob = randomChoice(probs);
      percent = prob;
      probs.remove(prob);
    });

    return characteristics;
  }

  static int _getRandomBonusDamage(Map<String, int> characteristics) {
    int sum = characteristics['STR']! + characteristics['SIZ']!;
    if(sum >= 2 && sum <= 64) {
      return -2;
    } else if(sum >= 65 && sum <= 84) {
      return -1;
    } else if(sum >= 85 && sum <= 124) {
      return 0;
    } else if(sum >= 125 && sum <= 164) {
      return makeRoll(1, 4);
    } else {
      return makeRoll(1, 6);
    }
  }

  static int makeRoll(int times, int dice) {
    int result = 1;
    for (int i = 0; i < times; i++) {
      result += Random().nextInt(dice + 1);
    }
    return result;
  }

  static int _getRandomHp(Map<String, int> characteristics) {
    int sum = characteristics['STR']! + characteristics['CON']!;
    return (sum/10).floor();
  }

  static int _getRandomSanity(Map<String, int> characteristics) {
    return characteristics['POW']!;
  }

  static int _getRandomMp(Map<String, int> characteristics) {
    return characteristics['POW']!;
  }

  static int _getRandomLuck() {
    return makeRoll(3, 6) * 5;
  }

  static Map<String, int> _getRandomSkills(String occupation) {
    Map<String, Map<String, int>> skills = {
      "Antiquarian": {
        "Appraise": 0,
        "Art/Craft": 0,
        "History": 0,
        "Language (other)": 0,
        "Library Use": 0,
        
      },
    };
    if(occupation == 'Antiquarian') {

    }
    
    return Map<String, int>();
  }

  static final Map<String, int> _randomSkills = {
    "Accounting": 05,
    "Anthropology": 01,
    "Appraise": 05,
    "Archeology": 01,
    "Art/Craft": 05,
    "Charm": 15,
    "Climb": 20,
    "Credit Rating": 00,
    "Disguise": 05,
    "Dodge": characteristics['DEX']!/2.floor(),
    
  };

  static Map<String, int> _getRandomWeapons() {
    return Map<String, int>();
  }

  static List<String> _getRandomPersonalDescription(String gender) {
    return [""].toList();
  }

  static String _getRandomIdeology() {
    return "";
  }

  static String _getRandomRelatives() {
    return "";
  }

  static String _getRandomSignificantPlaces() {
    return "";
  }

  static String _getRandomPrizedPossessions() {
    return "";
  }

  static String _getRandomTraits() {
    return "";
  }

  static String _getRandomPhobias() {
    return "";
  }

  static String _getRandomManias() {
    return "";
  }

  static List<String> _getRandomEquipment() {
    return [""].toList();
  }


  static String _generateCareer() {
    List<String> careers = [
      "Colonial marine",
      "Colonial marshall",
      "Agent",
      "Kid",
      "Medic",
      "Official",
      "Pilot",
      "Roughneck",
      "Scientific"
    ];
    return randomChoice(careers);
  }

  static Map<String, int> _generateRandomAttributes(String selectedCareer) {
    Map<String, int> attributes = {
      "Strength": 0,
      "Agility": 0,
      "Wits": 0,
      "Empathy": 0
    };
    int remainingPoints = 14;

    if (selectedCareer == "Colonial marine" || selectedCareer == "Roughneck") {
      attributes["Strength"] = 5;
    }

    if (selectedCareer == "Kid" || selectedCareer == "Pilot") {
      attributes["Agility"] = 5;
    }

    if (selectedCareer == "Colonial marshall" ||
        selectedCareer == "Scientific" ||
        selectedCareer == "Agent") {
      attributes["Wits"] = 5;
    }

    if (selectedCareer == "Medic" || selectedCareer == "Official") {
      attributes["Empathy"] = 5;
    }

    // Assign the remaining attributes randomly so that they sum 14
    remainingPoints -= attributes.values.reduce((a, b) => a + b);
    while (remainingPoints > 0) {
      String attributeToIncrement = randomChoice(attributes.keys.toList());
      if (attributes[attributeToIncrement]! < 5) {
        attributes[attributeToIncrement] =
            (attributes[attributeToIncrement] ?? 0) + 1;
        remainingPoints--;
      }
    }

    return attributes;
  }

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

  static String _getRandomName2(String selectedCareer) {
    Map<String, List<String>> names = {
      "Colonial marine": [
        "Marcus Mullaney",
        "Nik Elson",
        "Vic Pasengrau",
        "Kimi Diem",
        "Tara Zanelli",
        "Chrissy López"
      ],
      "Colonial marshall": [
        "Jack Kitani",
        "Barrell Klein",
        "Ivan Mankov",
        "Akira Kano",
        "Angela Harris",
        "Lee-Ann Jenkins"
      ],
      "Agent": [
        "Conrad Schmidt",
        "Alexander Balconi",
        "Ryan Middlebrook",
        "Michiko Nogumi",
        "Sheridan Lampara",
        "Mercedes Prince"
      ],
      "Kid": [
        "Chip Harrington",
        "Hugo Turner",
        "Jakey Myers",
        "Meggie Wu",
        "Maisie Kelly",
        "Becca David"
      ],
      "Medic": [
        "Cho Hadfield",
        "Ken Ibana",
        "Sullivan Ward",
        "Ana Kasnavik",
        "Juno Blanchard",
        "Katie Aberly"
      ],
      "Official": [
        "Eugene Proctor",
        "Oliver Bryant",
        "Lloyd T. Darrington",
        "Wendy Stern",
        "Julia Kwang",
        "Camille Kirschner"
      ],
      "Pilot": [
        "Casper Edmonton",
        "Sven Stackman",
        "Kiel Avari",
        "Fiona O'Neill",
        "Constance Navona",
        "Igraine Turner"
      ],
      "Roughneck": [
        "Mac Masterton",
        "Kip Tranter",
        "Charlie Stead",
        "Sassy Díaz",
        "Kat Longridge",
        "Jayden Pace"
      ],
      "Scientific": [
        "Viggo Kowalski",
        "Drew Lancaster",
        "Travis Torrence",
        "Elena Sánchez",
        "Louise Mallory",
        "Karima Yusef"
      ]
    };

    if (names.containsKey(selectedCareer)) {
      return randomChoice(names[selectedCareer]!);
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
        ' name: $name,'
        'photoUrl: $photoUrl,'

        ' occupation: $occupation,'
        ' gender: $gender,'
        ' age: $age,'
        ' characteristics: $characteristics,'
        ' bonusDamage: $bonusDamage,'
        ' hp: $hp,'
        ' sanity: $sanity,'
        ' mp: $mp,'
        ' luck: $luck,'
        ' skills: $skills,'
        ' weapons: $weapons,'
        ' personalDescription: $personalDescription,'
        ' ideology: $ideology,'
        ' relatives: $relatives,'
        ' significantPlaces: $significantPlaces,'
        ' prizedPossessions: $prizedPossessions,'
        ' traits: $traits,'
        ' phobias: $phobias,'
        ' manias: $manias,'
        ' equipment: $equipment'
        '}';
  }

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'id': id,
      'mode': mode,
      'character_level': characterLevel,
      'name': name,
      'photoUrl': photoUrl,
      
      'occupation': occupation,
      'gender': gender,
      'age': age,
      'characteristics': characteristics,
      'bonusDamage': bonusDamage,
      'hp': hp,
      'sanity': sanity,
      'mp': mp,
      'luck': luck,
      'skills': skills,
      'weapons': weapons,
      'personalDescription': personalDescription,
      'ideology': ideology,
      'relatives': relatives,
      'significantPlaces': significantPlaces,
      'prizedPossessions': prizedPossessions,
      'traits': traits,
      'phobias': phobias,
      'manias': manias,
      'equipment': equipment,
    };
  }

  static fromMap(Map<String, dynamic> statsData) {
    return CthulhuCharacter(
      characterLevel: statsData['character_level'] as int,
      userId: statsData['userId'] as String,
      id: statsData['id'] as String,
      name: statsData['name'] as String,
      photoUrl: statsData['photoUrl'] as String,

      occupation: statsData['occupation'] as String,
      gender: statsData['gender'] as String,
      age: statsData['age'] as int,
      characteristics: (statsData['characteristics'] as Map<String, dynamic>)
          .map((key, value) => MapEntry(key, value as int)),
      bonusDamage: statsData['bonusDamage'] as int,
      hp: statsData['hp'] as int,
      sanity: statsData['sanity'] as int,
      mp: statsData['mp'] as int,
      luck: statsData['luck'] as int,
      skills: (statsData['skills'] as Map<String, dynamic>)
          .map((key, value) => MapEntry(key, value as int)),
      weapons: (statsData['weapons'] as Map<String, dynamic>)
          .map((key, value) => MapEntry(key, value as int)),
      personalDescription: (statsData['personalDescription'] as List<dynamic>)
          .map((value) => value as String)
          .toList(),
      ideology: statsData['ideology'] as String,
      relatives: statsData['relatives'] as String,
      significantPlaces: statsData['significantPlaces'] as String,
      prizedPossessions: statsData['prizedPossessions'] as String,
      traits: statsData['traits'] as String,
      phobias: statsData['phobias'] as String,
      manias: statsData['manias'] as String,
      equipment: (statsData['equipment'] as List<dynamic>)
          .map((value) => value as String)
          .toList(),
    );
  }
}
