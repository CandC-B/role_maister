import 'package:uuid/uuid.dart';

class Character {
  String name = "";
  final String id;
  String userId = "";
  Character(this.name, this.userId ,{String? id}) : id = id ?? const Uuid().v4();
}