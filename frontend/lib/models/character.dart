import 'package:uuid/uuid.dart';

class Character {
  String name = "";
  final id;
  Character(this.name, {Uuid? id}) : id = id ?? const Uuid().v4(); // TODO solve uid problem
}