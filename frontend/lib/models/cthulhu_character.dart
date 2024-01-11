import 'dart:math';
import 'package:dart_random_choice/dart_random_choice.dart';
import 'package:role_maister/config/app_singleton.dart';
import 'package:role_maister/models/character.dart';
import 'package:uuid/uuid.dart';

class CthulhuCharacter extends Character {
  
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
  final String personalDescription;
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
    final skills = _getRandomSkills(characteristics, occupation);
    final weapons = _getRandomWeapons(bonusDamage, skills);
    final personalDescription = _getRandomPersonalDescription(gender);
    final ideology = _getRandomIdeology(gender);
    final relatives = _getRandomRelatives(gender);
    final significantPlaces = _getRandomSignificantPlaces();
    final prizedPossessions = _getRandomPrizedPossessions(gender);
    final traits = _getRandomTraits(gender);
    final phobias = _getRandomPhobias();
    final manias = _getRandomManias();
    final equipment = _getRandomEquipment(weapons);
    
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

    List<String> probs = ["40", "50", "50", "50", "60", "60", "70", "80"];
    characteristics.forEach((stat, percent) {
      int prob = int.parse(randomChoice((probs)));
      characteristics[stat] = prob;
      probs.remove(prob.toString());
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
      result += Random().nextInt(dice);
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

  static Map<String, int> _getRandomSkills(Map<String, int> characteristics, String occupation) {
    Map<String, Map<String, int>> skills = {
      "Antiquarian": {
        "Appraise": 05,
        "Art/Craft": 05,
        "History": 05,
        "Language (other)": 01,
        "Library Use": 20,
        "Spot Hidden": 25,
      },
      "Dilettante": {
        "Art/Craft": 05,
        "Language (other)": 01,
        "Ride": 05,
      },
      "Writer": {
        "Art/Craft": 05,
        "History": 05,
        "Library Use": 20,
        "Language (other)": 01,
        "Language (own)": characteristics["EDU"]!,
        "Psychology": 10,
      },
      "Police inspector": {
        "Law": 05,
        "Listen": 20,
        "Psychology": 10,
        "Spot Hidden": 25,
      },
      "Private investigator": {
        "Art/Craft": 05,
        "Disguise": 05,
        "Law": 05,
        "Library Use": 20,
        "Psychology": 10,
        "Spot Hidden": 25,
      },
      "Medic": {
        "Art/Craft": 05,
        "Disguise": 05,
        "Law": 05,
        "Library Use": 20,
        "Psychology": 10,
        "Spot Hidden": 25,
      },
    };
    if(occupation == 'Antiquarian') { 
      Map<String, int> extras = _getExtraRandomSkills(
        characteristics, 
        1, 
        ["Fast Talk", "Charm", "Intimidate", "Persuade"], 
        skills['Antiquarian']!.keys.toList()
      );
      extras.forEach((skill, prob) { 
        skills['Antiquarian']![skill] = prob;
      }); 
    } else if(occupation == 'Dilettante') {
      Map<String, int> extras = _getExtraRandomSkills(
        characteristics, 
        0, 
        ["Fast Talk", "Charm", "Intimidate", "Persuade"], 
        skills['Dilettante']!.keys.toList()
      );
      extras.forEach((skill, prob) { 
        skills['Dilettante']![skill] = prob;
      }); 
      extras = _getExtraRandomSkills(
        characteristics, 
        3, 
        ["Firearms (Handgun)", "Firearms (Rifle/Shotgun)"], 
        skills['Dilettante']!.keys.toList()
      );
      extras.forEach((skill, prob) { 
        skills['Dilettante']![skill] = prob;
      }); 
    } else if(occupation == 'Writer') {
      Map<String, int> extras = _getExtraRandomSkills(
        characteristics, 
        1, 
        ["Natural World", "Occult"], 
        skills['Writer']!.keys.toList()
      );
      extras.forEach((skill, prob) { 
        skills['Writer']![skill] = prob;
      }); 
    } else if(occupation == 'Police inspector') {
      Map<String, int> extras = _getExtraRandomSkills(
        characteristics, 
        0, 
        ["Fast Talk", "Charm", "Intimidate", "Persuade"], 
        skills['Police inspector']!.keys.toList()
      );
      extras.forEach((skill, prob) { 
        skills['Police inspector']![skill] = prob;
      }); 
      extras = _getExtraRandomSkills(
        characteristics, 
        0, 
        ["Art/Craft", "Disguise"], 
        skills['Police inspector']!.keys.toList()
      );
      extras.forEach((skill, prob) { 
        skills['Police inspector']![skill] = prob;
      }); 
      extras = _getExtraRandomSkills(
        characteristics, 
        1, 
        ["Firearms (Handgun)", "Firearms (Rifle/Shotgun)"], 
        skills['Police inspector']!.keys.toList()
      );
      extras.forEach((skill, prob) { 
        skills['Police inspector']![skill] = prob;
      }); 
    } else if(occupation == 'Private investigator') {
      Map<String, int> extras = _getExtraRandomSkills(
        characteristics, 
        0, 
        ["Fast Talk", "Charm", "Intimidate", "Persuade"], 
        skills['Private investigator']!.keys.toList()
      );
      extras.forEach((skill, prob) { 
        skills['Private investigator']![skill] = prob;
      }); 
      extras = _getExtraRandomSkills(
        characteristics, 
        0, 
        ["Locksmith", "Firearms (Handgun)", "Firearms (Rifle/Shotgun)"], 
        skills['Private investigator']!.keys.toList()
      );
      extras.forEach((skill, prob) { 
        skills['Private investigator']![skill] = prob;
      }); 
    } else if(occupation == 'Medic') {
      Map<String, int> extras = _getExtraRandomSkills(
        characteristics, 
        1, 
        ["Fast Talk", "Charm", "Intimidate", "Persuade"], 
        skills['Antiquarian']!.keys.toList()
      );
      extras.forEach((skill, prob) { 
        skills['Antiquarian']![skill] = prob;
      }); 
    } else if(occupation == 'Journalist') {
      Map<String, int> extras = _getExtraRandomSkills(
        characteristics, 
        1, 
        ["Fast Talk", "Charm", "Intimidate", "Persuade"], 
        skills['Journalist']!.keys.toList()
      );
      extras.forEach((skill, prob) { 
        skills['Journalist']![skill] = prob;
      }); 
    } else if(occupation == 'University professor') {
      Map<String, int> extras = _getExtraRandomSkills(
        characteristics, 
        1, 
        ["Fast Talk", "Charm", "Intimidate", "Persuade"], 
        skills['University professor']!.keys.toList()
      );
      extras.forEach((skill, prob) { 
        skills['University professor']![skill] = prob;
      }); 
    }
    
    return skills[occupation]!;
  }

  static Map<String, int> _getExtraRandomSkills (Map<String, int> characteristics, int extraNum, List<String> extraSkills, List<String> currentSkills) {
    Map<String, int> skills = {
      "Accounting": 05,
      "Anthropology": 01,
      "Appraise": 05,
      "Archeology": 01,
      "Art/Craft": 05,
      "Charm": 15,
      "Climb": 20,
      "Credit Rating": 00,
      "Disguise": 05,
      // "Dodge": (characteristics['DEX']!/2).floor(),
      "Dodge": (characteristics["DEX"]!/2).floor(),
      "Drive Auto": 20,
      "Elec. Repair": 10,
      "Fast Talk": 05,
      "Fighting (Brawl)": 25,
      "Firearms (Handgun)": 20,
      "Firearms (Rifle/Shotgun)": 25,
      "First Aid": 30,
      "History": 05,
      "Intimidate": 15,
      "Jump": 20,
      "Language (other)": 01,
      "Language (own)": characteristics["EDU"]!,
      "Law": 05,
      "Library Use": 20,
      "Listen": 20,
      "Locksmith": 01,
      "Mech. Repair": 10,
      "Medicine": 01,
      "Natural World": 10,
      "Navigate": 10,
      "Occult": 05,
      "Persuade": 10,
      "Pilot": 01,
      "Psychoanalysis": 01,
      "Psychology": 10,
      "Ride": 05,
      "Science": 01,
      "Sleight of Hand": 10,
      "Spot Hidden": 25,
      "Stealth": 20,
      "Survival": 10,
      "Swim": 20,
      "Throw": 20,
      "Track": 10
    };
    Map<String, int> newSkills = {};
    if(extraSkills.isNotEmpty) {
      for (String extraSkill in extraSkills) {
        newSkills[extraSkill] = skills[extraSkill]!;
        skills.remove(extraSkill);
      }
    }
    for(String currentSkill in currentSkills) {
      skills.remove(currentSkill);
    }
    if(extraNum > 0) {
      // we want some extra skills defined in extraNum
      List<String> skillsKeys = skills.keys.toList();
      for(int i = 0; i < extraNum; i++) {
        // int randomSkillIndex = Random().nextInt(extraSkills.length);
        // if(skills.)
        String randomSkill = randomChoice(skillsKeys);
        newSkills[randomSkill] = skills[randomSkill]!;
      }
    } 
    return newSkills;
  }

  static Map<String, int> _getRandomWeapons(int bonus, Map<String, int> skills) {
    Map<String, int> allWeapons = {
      // "Brawl": makeRoll(1, 3) + bonus,
      "Small Knife" : makeRoll(1, 4) + bonus,
      "Machete": makeRoll(1, 8) + bonus,
      "Small Club": makeRoll(1, 6) + bonus,
      "Baseball bat": makeRoll(1, 8) + bonus,
      // "Handgun": makeRoll(1, 10),
      // "Shotgun": makeRoll(2, 6),
      // "Rifle": makeRoll(2, 6) + 4
    };
    Map<String, int> weapons = {
      "Brawl": makeRoll(1, 3) + bonus
    };
    // List<String> randomWeapons = ["Small Knife", "Machete", "Small Club", "Baseball bat"];
    List<String> randomWeapons = allWeapons.keys.toList();
    int numExtraWeapons = Random().nextInt(3);
    for(int i = 0; i < numExtraWeapons; i++){
      String extraRandomWeapon = randomChoice(randomWeapons);
      weapons[extraRandomWeapon] = allWeapons[extraRandomWeapon]!;
      randomWeapons.remove(extraRandomWeapon);
    }

    if(skills.containsKey("Firearms (Handgun)")) {
      weapons["Handgun"] = makeRoll(1, 10);
    }
    if(skills.containsKey("Firearms (Rifle/Shotgun)")) {
      String firearm = randomChoice(["Shotgun", "Rifle"]);
      if(firearm == "Shotgun") {
        weapons["Shotgun"] = makeRoll(2, 6);
      } else {
        weapons["Rifle"] = makeRoll(2, 6) + 4;
      }
    }
    
    return weapons;
  }

  static String _getRandomPersonalDescription(String gender) {
    List<String> personalMaleDescriptions = [
      "He is wearing a slightly worn suit. Average height. Careful mustache. He uses monocle instead of glasses when examining a text.",
      "Handsome but rough. Slim. He wears a suit if he has to, but prefers a more casual outfit.",
      "Youthful and bright-eyed. Wear fashionable clothes"
    ];
    List<String> personalFemaleDescriptions = [
      "Athletic physique. Elegant hairstyle for dark brown hair. Dressed in the style of the 20's",
      "Thin, below average weight. Thick black hair, glasses and a huge smile",
      "Youthful and bright-eyed. Wear fashionable clothes"
    ];
    if(gender == "Male") {
      return randomChoice(personalMaleDescriptions);
    } else {
      return randomChoice(personalFemaleDescriptions);
    }
  }

  static String _getRandomIdeology(String gender) {
    List<String> maleIdeologies = [
      "Interested all his life in myth and folklore. He is willing to believe in the reality of the supernatural, although he has not yet found any solid evidence",
      "Deep love for history and ancient cultures. He wants to make a reputation as a treasure hunter"
      "The science. OVer time, it will be possible to explain everything. He does not believe in ghosts and seeks a scientific explanation for any strange event."
    ];
    List<String> femaleIdeologies = [
      "Raised in the Christian faith, she has a healthy respect for the supernatural and can be superstitious",
      "Intense faith in God, she has been raised in the Christian Church by her mother"
    ];
    if(gender == "Male") {
      return randomChoice(maleIdeologies);
    } else {
      return randomChoice(femaleIdeologies);
    }
  }

  static String _getRandomRelatives(String gender) {
    List<String> maleRelatives = [
      "His late wife, Jane. He thinks there was something she wanted to tell him before she died",
      "His father, Francisco Jones, whose discoveries made him famous. He feels overshadowed by his father",
      "His older brother Paco, who adores him and works as a doctor in San Francisco"
    ];
    List<String> femaleRelatives = [
      "Her father, who she knew worked for the notorious gangster Dutch Schultz in New York",
      "Her mother, to whom she writes every week"
    ];
    if(gender == "Male") {
      return randomChoice(maleRelatives);
    } else {
      return randomChoice(femaleRelatives);
    }
  }

  static String _getRandomSignificantPlaces() {
    List<String> significantPlaces = [
      "A wooded and quiet space, where you can listen to the birds and relax with a good book",
      "A bar where strong liquor is served and you can forget your problems",
      "Within beloved family in New York. Practices athletics to clear her mind",
      "Libraries, where you can get lost in a huge science book",
      "Mother's house in Boston, where they serve the best food you can eat" 
    ];
    return randomChoice(significantPlaces);
  }

  static String _getRandomPrizedPossessions(String gender) {
    List<String> malePrizedPossessions = [
      "A small frame containing a photograph of Jane, his late wife",
      "His little medal of Saint Christofer, which gives him good luck",
      "A silver penknife, a gift from his brother and which he wears as an amulet"
    ];
    List<String> femalePrizedPossessions = [
      "A switchblade knife, a gift from his father, who told her 'take it whith you and it will help you get out of any problem'",
      "Her father's last pocket bible"
    ];
    if(gender == "Male") {
      return randomChoice(malePrizedPossessions);
    } else {
      return randomChoice(femalePrizedPossessions);
    }
  }

  static String _getRandomTraits(String gender) {
    List<String> maleTraits = [
      "Inquisitive. Takes a meticulous approach to research",
      "Indomitable. He usually acts without thinking",
    ];
    List<String> femaleTraits = [
      "Inquisitive. Takes a meticulous approach to research",
      "Tough and temperamental. She loves to argue. Never goes under a ladder",
      "Adventuress. She likes to stay busy and get her hands dirty",
      "She likes to take risks and be immersed in the action"
    ];
    if(gender == "Male") {
      return randomChoice(maleTraits);
    } else {
      return randomChoice(femaleTraits);
    }
  }

  static String _getRandomPhobias() {
    List<String> phobias = [
      "None",
      "Acrophobia: fear of heights",
      "Arachnophobia: fear of spiders",
      "Bibliophobia: fear of books",
      "Eisoptrophobia: fear of mirrors",
      "Hematophobia: fear of blood",
      "Necrophobia: fear of dead things",
      "Odontophobia: fear of teeth",
      "Pyrophobia: fear of fire",
      "Telephonephobia: fear of phones",
      "Xenophobia: fear of foreigners and strangers",
    ];
    return randomChoice(phobias);
  }

  static String _getRandomManias() {
    List<String> manias = [
      "None",
      "Agatomania: pathological kindness",
      "Algomania: obsession with pain",
      "Amenomania: irrational joy",
      "Bibliokleptomania: compulsion to steal books",
      "Clazomania: irrational urge to scream",
      "Kleptomania: irrational impulse to steal",
      "Dikemania: Obsession with compliance with laws",
      "Geliomania: uncontrollable urge to laugh",
      "Nosomania: delusions of suffering from imaginary illness",
      "Pseudomania: irrational urge to lie",
    ];
    return randomChoice(manias);
  }

  static List<String> _getRandomEquipment(Map<String, int> weapons) {
    List<String> allEquipment = [
      "Fountain pen, pencils and small blue ink bottle",
      "Memo pad",
      "Travel equipment in a suitcase",
      // ".38 pistol and ammunition",
      "Pencils and notepad",
      "Comb",
      "Medallion of Saint Christopher",
      "Razor",
      "Bag",
      "Forks",
      "Crucifix shaped pendant",
      // "A silver knife",
      "Wallet containing small science equipment",
      "Hockey stick",
      "Wallet",
      "Pocket bible"
    ];
    List<String> equipment = [];
    int equipmentNum = 5;
    if(weapons.containsKey("Small knife")) {
      equipment.add("A silver knife");
      equipmentNum--;
    } else if(weapons.containsKey("Handgun")) {
      equipment.add(".38 pistol and ammunition");
      equipmentNum--;
    }
    for(int i = 0; i < equipmentNum; i++) {
      String newEquipment = randomChoice(allEquipment);
      equipment.add(newEquipment);
      allEquipment.remove(newEquipment);
    }
    return equipment;
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
      personalDescription: statsData['personalDescription'] as String,
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
