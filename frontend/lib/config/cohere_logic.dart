import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:role_maister/models/cohere_models.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';


// Function to create a new game
Future<String> createGame(AliensGameSettings game_settings) async {
  await dotenv.load(fileName: ".env");
  var access_token = dotenv.env['COHERE_ACCESS_TOKEN'];
  final Map<String, String> headers = {
  'Content-Type': 'application/json', 
  'Authorization': 'Bearer YourAccessToken', 
  'Accept': 'application/json'
  };
  final response = await http.post(
    Uri.parse('https://api.cohere.ai/v1/chat'),
    body: {
      "message": "Hello"
    },
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
