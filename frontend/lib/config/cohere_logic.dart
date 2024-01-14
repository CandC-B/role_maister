import 'package:http/http.dart' as http;
import 'package:role_maister/config/game_logic.dart';
import 'dart:convert';
import 'package:role_maister/models/cohere_models.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:role_maister/models/game.dart';

// Function to create a new game // TODO comentar que se pasa game y no lo que había antes
Future<String> createGame(Game game) async {
  // await dotenv.load(fileName: ".env");
  var access_token = "FTt5WJrBKxsheIdKYyi8qK6XJV2JjkwM4KuHUWUq";
  final Map<String, String> headers = {
    'Content-Type': 'application/json',
    'Authorization': 'Bearer $access_token',
    'Accept': 'application/json'
  };
  String initialPrompt = "";
  if (game.role_system == 'aliens') 
    initialPrompt = await generateAliensPrompt(game);
  else if (game.role_system == 'dyd')
    initialPrompt = await generateDyDPrompt(game);
  else if (game.role_system == 'cthulhu')
    initialPrompt = await generateCthulhuPrompt(game);
  else
    throw Exception('Role system not supported yet');

  final Map<String, dynamic> requestBody = {
    "chat_history": [],
    "message": initialPrompt,
  };
  final response = await http.post(Uri.parse('https://api.cohere.ai/v1/chat'),
      headers: headers, body: jsonEncode(requestBody));
  var json_response = jsonDecode(response.body);
  return json_response['text'];
}

// Function to update the game data
Future<void> resumeGame(
    List<Map<String, dynamic>> chat_history, String message) async {
  // await dotenv.load(fileName: ".env");
  var access_token = "FTt5WJrBKxsheIdKYyi8qK6XJV2JjkwM4KuHUWUq";
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
