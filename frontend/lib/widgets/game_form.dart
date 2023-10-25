import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:role_maister/models/models.dart';
import 'package:role_maister/widgets/widgets.dart';
import 'package:http/http.dart' as http;

Future<void> _createNewGame(UserStatistics userStats, String history) async {
    Map<String, dynamic> mapUserStats = userStats.toMap();
    // TODO: don't harcode this
    mapUserStats["role_system"]= "aliens";
    mapUserStats["num_players"]= 1;
    mapUserStats["story_description"]= history;

    // Set the headers for the request, including the content type.
    Map<String, String> headers = {
      'Content-Type': 'application/json',
    };

    final response = await http.post(
        // TODO: add constants.dart in utils folder
        Uri.http("localhost:8000", "/game/"),
        headers: headers,
        body: jsonEncode(mapUserStats)
    );
    var coralMessage = json.decode(response.body)["message"];
    print(coralMessage);
}


class GameForm extends StatelessWidget {
  GameForm({super.key, required this.character});
  final UserStatistics character;
  var _storyController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      color: Colors.white,
      child: Column(children: [
        Expanded(
          flex: 1,
          child: Row(children: [
            Expanded(
              flex: 1,
              child: ImageColorFilter(
                  imagePath: 'assets/images/aliens.jpg',
                  routeName: 'ChatPage',
                  imageText: "ALIENS",
                  isAvailable: true,
                  height: size.height * 0.9 / 4,
                  width: size.width * 0.8 / 3,
                  isLink: false,
                  preset: true,
                  ),
            ),
            Expanded(
              flex: 1,
              child: ImageColorFilter(
                imagePath: 'assets/images/dungeons_and_dragons.jpg',
                routeName: 'ChatPage',
                imageText: "DUNGEONS AND DRAGONS",
                isAvailable: false,
                height: size.height * 0.9 / 4,
                width: (size.width * 0.8 * 2/3) / 3,
                isLink: false,
                preset: false,
              ),
            ),
            Expanded(
              flex: 1,
              child: ImageColorFilter(
                imagePath: 'assets/images/cthulhu.jpg',
                routeName: 'ChatPage',
                imageText: "THE CALL OF CTHULHU",
                isAvailable: false,
                height: size.height * 0.9 / 4,
                width: (size.width * 0.8 * 2/3) / 3,
                isLink: false,
                preset: false,
              ),
            ),
          ]),
        ),
        Expanded(
          flex: 2,
          child: Container(
            alignment: Alignment.topLeft,
            padding: EdgeInsets.symmetric(vertical: size.height * 0.01, horizontal: size.width * 0.01),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text("Number of players: 1"),
                SizedBox(height: size.height * 0.05,),
                Text("Brief story description:"),
                SizedBox(height: size.height * 0.02,),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: size.height * 0.01, horizontal: size.width * 0.01),
                    decoration: BoxDecoration(
                      color: Colors.black87, // Set the background color to grey
                      borderRadius: BorderRadius.circular(10), // Optionally, round the corners
                    ),
                    child: TextFormField(
                      controller: _storyController,
                      keyboardType: TextInputType.multiline,
                      style: const TextStyle(color: Colors.white),
                      maxLines: null,
                       decoration: const InputDecoration(
                        border: InputBorder.none,
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Required';
                        }
                      },
                    ),
                  )
                ),
              ]
            ),
          ),
        ),
        Expanded(
          flex: 1,
          child: Container(
            alignment: Alignment.center,
            child: Column(
              children: [
                SizedBox(height: size.height * 0.05,),
                Text("Tokens required: 5"),
                SizedBox(height: size.height * 0.05,),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      shape: StadiumBorder(),
                      backgroundColor: Colors.deepPurple,
                      textStyle: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold
                      )
                  ),
                  onPressed: () {
                    _createNewGame(character, _storyController.text);
                    _storyController.text = '';
                  },
                  child: const FittedBox(
                    fit: BoxFit.contain, child: Text("Start Game")
                  )
                ),
              ]
            ),
          ),
        ),
      ]),
    );
  }

}