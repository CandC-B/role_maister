import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:role_maister/models/cohere_models.dart';

// Function to create a new game
Future<String> createGame(AliensGameSettings game_settings) async {
  final response = await http.post(
    Uri.parse('https://api.cohere.ai/v1/chat'),
    body: {"chat_history": [], "message": "Hello"},
  );
  if (response.statusCode != 201) {
    throw Exception('Failed to create game');
  }
  print(response);
  return "hello";
}

// Function to update the game data
Future<void> resumeGame(Map<String, dynamic> data) async {
  final response = await http.put(
    Uri.parse('http://your-backend-url/game'),
    body: json.encode(data),
    headers: {'Content-Type': 'application/json'},
  );
  if (response.statusCode != 200) {
    throw Exception('Failed to update game data');
  }
}
