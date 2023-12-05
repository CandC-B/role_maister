import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:role_maister/models/cohere_models.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:role_maister/models/game.dart';

// Function to create a new game // TODO comentar que se pasa game y no lo que había antes
Future<String> createGame(Game game) async {
  await dotenv.load(fileName: ".env");
  var access_token = dotenv.env['COHERE_ACCESS_TOKEN'];
  final Map<String, String> headers = {
    'Content-Type': 'application/json',
    'Authorization': 'Bearer $access_token',
    'Accept': 'application/json'
  };
  final Map<String, dynamic> requestBody = {
    "chat_history": [],
    "message": "Hello",
  };
  final response = await http.post(Uri.parse('https://api.cohere.ai/v1/chat'),
      headers: headers, body: jsonEncode(requestBody));
  var json_response = jsonDecode(response.body);
  // TODO: descomentar cuando esté el prompting
  // return json_response['text'];
  return "This is an automatic message: The game creation is incomplete since there is no prompting done yet.";
}

// Function to update the game data
Future<void> resumeGame(List<Map<String,dynamic>> chat_history, String message) async {
  await dotenv.load(fileName: ".env");
  var access_token = dotenv.env['COHERE_ACCESS_TOKEN'];
  final Map<String, String> headers = {
    'Content-Type': 'application/json',
    'Authorization': 'Bearer $access_token',
    'Accept': 'application/json'
  };

  final Map<String, dynamic> requestBody = {
    "chat_history": chat_history,
    "message": message,
  };
  final response = await http.post(Uri.parse('https://api.cohere.ai/v1/chat'),
      headers: headers, body: jsonEncode(requestBody));
  var json_response = jsonDecode(response.body);
  return json_response['text'];
}
