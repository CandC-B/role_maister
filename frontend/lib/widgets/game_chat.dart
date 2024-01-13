import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:role_maister/config/config.dart';
import 'package:chat_bubbles/chat_bubbles.dart';
import 'package:http/http.dart' as http;
import 'package:role_maister/config/constants.dart';
import 'package:role_maister/main.dart';
import 'package:role_maister/models/game.dart';
import 'package:role_maister/models/player_game_data.dart';
import '../models/models.dart';
import 'dart:convert';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class GameChat extends StatefulWidget {
  final String gameId;

  const GameChat({Key? key, required this.gameId}) : super(key: key);

  @override
  _GameChatState createState() => _GameChatState(gameId);
}

class _GameChatState extends State<GameChat> {
  _GameChatState(String gameId);

  late String currentUserId = singleton.user!.uid;
  Map<String, String> translationCache = {};
  List<String> translatedMessages = [];
  // final List<Message> messages = [];
  List<QueryDocumentSnapshot> listMessages = [];
  final TextEditingController textEditingController = TextEditingController();
  // final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    // scrollController.addListener(_scrollListener);
  }

  void observeAndHandleGameChanges(
      String gameId, String currentUserUid, BuildContext context) {
    FirebaseFirestore.instance
        .collection('game')
        .doc(gameId)
        .snapshots()
        .listen((event) {
      if (event.exists) {
        final data = event.data() as Map<String, dynamic>?;
        if (data != null) {
          // check if currentUserUid is in the players list
          if (data['players'].containsKey(currentUserUid)) {
            // check if the player has voted to kick
            PlayerGameData playerGameData =
                PlayerGameData.fromMap(data['players'][currentUserUid]);

            Game game = Game.fromMap(data);
            print('GAME DATA: ' + game.toString());
            print('PLAYER ID: ' + currentUserUid);
            print('PLAYER DATA: ' +
                playerGameData.characterId +
                ' ' +
                playerGameData.votedToGetKicked.toString());

            if (data['players'].length != 1 &&
                playerGameData.votedToGetKicked >= data['players'].length - 1) {
              // kick the player
              print('A TOMAR POR CULO!!');

              firestoreService.deleteKickedPlayer(gameId, currentUserUid);
              context.go("/");
              context.push("/");
              // singleton.currentGame = "";
            }
          }
        }
      }
    });
  }

  void onSendMessage(String text) async {
    text = await translateText(text, 'en');

    // TODO: mandar todo pal BE primero
    List<Map<String, dynamic>>? messages =
        await firebase.fetchConversationByGameID(singleton.currentGame!);

    Map<String, String> headers = {
      'Content-Type': 'application/json',
    };

    // firestoreService.saveMessage(
    //     text, DateTime.now(), widget.gameId, currentUserId);

    firestoreService.saveMessage(
      ChatMessages(
          sentBy: currentUserId,
          sentAt: DateTime.now(),
          text: text,
          senderName: singleton.player!.username,
          characterName: singleton.selectedCharacterName!,
          userImage: singleton.player!.photoUrl!),
      widget.gameId,
    );
    firestoreService.updatePlayerWordCount(
        widget.gameId, singleton.player!.uid, text.split(' ').length);

    textEditingController.clear();

    if (messages != null) {
      final response = await http.post(
          // TODO: add constants.dart in utils folder
          // Uri.http("localhost:8000", "/game/master?message=$text"),
          Uri.parse(
              "https://rolemaister.onrender.com/game/master?message=$text"),
          headers: headers,
          body: jsonEncode(messages));
      if (text.trim().isNotEmpty) {
        // firestoreService.saveMessage(json.decode(response.body)["message"],
        //     DateTime.now(), widget.gameId, "IA");

        firestoreService.saveMessage(
          ChatMessages(
              sentBy: 'IA',
              sentAt: DateTime.now(),
              text: json.decode(response.body)["message"],
              senderName: 'IA',
              characterName: '',
              userImage:
                  'https://firebasestorage.googleapis.com/v0/b/role-maister.appspot.com/o/bot_master.png?alt=media&token=50e2cacc-58fa-41a4-b6bc-a838538dd48a'),
          widget.gameId,
        );
        firebase.updateAiWordCount(widget.gameId,
            json.decode(response.body)["message"].split(' ').length);

        Game game = Game.fromMap(await firebase.getGame(widget.gameId));
        // Quitarle tokens al usuario
        double tokensToSubstract = getPlayerGamePrice(
            text.split(' ').length,
            json.decode(response.body)["message"].split(' ').length,
            game.num_players);
        await firebase.changePlayerBalance(
            singleton.user!.uid, -tokensToSubstract);
      }
    } else {
      // Handle the case where there was an error fetching messages
      // TODO: ni puta idea de que hacer
    }

    // else {
    //   Fluttertoast.showToast(
    //       msg: 'Nothing to send', backgroundColor: Colors.grey);
    // }
  }

  @override
  Widget build(BuildContext context) {
    MyAppState? appState = context.findAncestorStateOfType<MyAppState>();
    Locale locale = appState?.locale ?? const Locale('en');
    Size size = MediaQuery.of(context).size;

    observeAndHandleGameChanges(widget.gameId, singleton.player!.uid, context);

    // print ('LOCALE: $locale');

    return Stack(
      children: [
        Container(
          decoration: const BoxDecoration(
            // image: DecorationImage(
            //   image: AssetImage('assets/images/background4.png'),
            //   fit: BoxFit.cover,
            //   opacity: 0.9,
            // ),
            color: Colors.black87,
          ),
          child: Column(
            children: [
              Expanded(
                child: StreamBuilder<QuerySnapshot>(
                  stream: firestoreService.fetchMessagesByGameId(widget.gameId),
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.hasData) {
                      listMessages = snapshot.data!.docs;
                      if (listMessages.isNotEmpty) {
                        return ListView.builder(
                          padding: const EdgeInsets.all(10),
                          reverse: true,
                          // controller: scrollController,
                          itemBuilder: (context, index) {
                            if (index < listMessages.length) {
                              bool others_msg =
                                  listMessages[index].get('sentBy') !=
                                      singleton.user!.uid;

                              print(
                                  'listMessages[index]: ${listMessages[index]}');
                              print(
                                  'listMessages[index].get(sender): ${listMessages[index].get('senderName')}');

                              return FutureBuilder<String>(
                                // future: translateText(listMessages[index].get('text'), locale.languageCode),
                                future: getTranslation(
                                    listMessages[index].get('text'),
                                    locale.languageCode),
                                builder: (context, translateSnapshot) {
                                  if (translateSnapshot.connectionState ==
                                          ConnectionState.waiting ||
                                      translateSnapshot.connectionState ==
                                          ConnectionState.none) {
                                    // Mostrar el mensaje original mientras espera la traducción
                                    // return BubbleSpecialThree(
                                    //   text: listMessages[index].get('text'),
                                    //   color: others_msg
                                    //       ? const Color.fromARGB(255, 234, 226, 248)
                                    //       : Colors.deepPurple,
                                    //   tail: true,
                                    //   isSender: !others_msg,
                                    //   textStyle: TextStyle(
                                    //     color: others_msg ? Colors.black : Colors.white,
                                    //     fontSize: 16,
                                    //   ),
                                    // );

                                    // TODO
                                    // return DiscordChatBubble(
                                    //   username: 'Usuario1',
                                    //   message: 'Hola, ¿cómo estás?',
                                    //   isSender: true,
                                    // );

                                    // return DiscordChatMessage(
                                    //   username: 'Usuario1',
                                    //   message: 'Hola, ¿cómo estás?',
                                    //   isSender: true,
                                    // );

                                    return DiscordChatMessage(
                                      username:
                                          listMessages[index].get('sentBy'),
                                      message: listMessages[index].get('text'),
                                      isSender: !others_msg,
                                      senderName:
                                          listMessages[index].get('senderName'),
                                      characterName: listMessages[index]
                                          .get('characterName'),
                                      userImage:
                                          listMessages[index].get('userImage'),
                                    );
                                  } else if (translateSnapshot.hasError) {
                                    // En caso de error durante la traducción
                                    return Text(
                                        'Error de traducción: ${translateSnapshot.error}');
                                  } else {
                                    // Mostrar la burbuja del mensaje traducido
                                    // return BubbleSpecialThree(
                                    //   text: translateSnapshot.data ?? '',
                                    //   color: others_msg
                                    //       ? const Color.fromARGB(255, 234, 226, 248)
                                    //       : Colors.deepPurple,
                                    //   tail: true,
                                    //   isSender: !others_msg,
                                    //   textStyle: TextStyle(
                                    //     color: others_msg
                                    //         ? Colors.black
                                    //         : Colors.white,
                                    //     fontSize: 16,
                                    //   ),
                                    // );

                                    // TODO
                                    // return DiscordChatBubble(
                                    //   username: 'Usuario1',
                                    //   message: 'Hola, ¿cómo estás?',
                                    //   isSender: true,
                                    // );

                                    // return DiscordChatMessage(
                                    //   username: 'Usuario1',
                                    //   message: 'Hola, ¿cómo estás?',
                                    //   isSender: true,
                                    // );

                                    return DiscordChatMessage(
                                      username:
                                          listMessages[index].get('sentBy'),
                                      message: translateSnapshot.data ?? '',
                                      isSender: !others_msg,
                                      senderName:
                                          listMessages[index].get('senderName'),
                                      characterName: listMessages[index]
                                          .get('characterName'),
                                      userImage:
                                          listMessages[index].get('userImage'),
                                    );
                                  }
                                },
                              );
                            }
                          },
                        );
                      } else {
                        return Center(
                          child: Text(
                              AppLocalizations.of(context)!.game_no_messages),
                        );
                      }
                    } else {
                      return const Center(
                          child: Center(
                              child: CircularProgressIndicator(
                        color: Colors.deepPurple,
                      )));
                    }
                  },
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        // focusNode: focusNode,
                        textInputAction: TextInputAction.send,
                        keyboardType: TextInputType.text,
                        textCapitalization: TextCapitalization.sentences,
                        controller: textEditingController,
                        decoration: InputDecoration(
                          hintText:
                              AppLocalizations.of(context)!.game_epic_phase,
                          hintStyle: const TextStyle(color: Colors.white),
                          enabledBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors
                                    .white), // Set the underline color to white
                          ),
                          focusedBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors
                                    .deepPurple), // Set the underline color to white when focused
                          ),
                        ),
                        style: const TextStyle(color: Colors.white),
                        // kTextInputDecoration.copyWith(hintText: 'write here...'),
                        onSubmitted: (value) {
                          onSendMessage(textEditingController.text);
                        },
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      // color: AppColors.burgundy,
                      borderRadius: BorderRadius.circular(50.0),
                    ),
                    child: IconButton(
                      onPressed: () {
                        onSendMessage(textEditingController.text);
                      },
                      icon: const Icon(Icons.send_rounded),
                      color: Colors.white,
                      // color: AppColors.white,
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
        Positioned(
          top: kIsWeb ? 0.0 : 20.0,
          child: Padding(
            padding: (size.width <= 700 || !kIsWeb) ? const EdgeInsets.only(left: 10.0) : const EdgeInsets.only(left: 50.0),
            child: Align(
              alignment: Alignment.topRight,
              child: Container(
                padding: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  color: Colors.deepPurple,
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: StreamBuilder<double>(
                  stream: firebase.getUserSpendingStream(
                    widget.gameId,
                    singleton.user!.uid,
                  ),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return CircularProgressIndicator();
                    } else if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    } else {
                      return Container(
                        padding: const EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          color: Colors.deepPurple,
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Text(
                          'Tokens spent: ${snapshot.data?.toString() ?? "N/A"}',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16.0,
                          ),
                        ),
                      );
                    }
                  },
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  // TODO: modificar los bubbles para que no parezca un chat de whatts
  Widget messageBubble({
    required String chatContent,
    required String messageType,
  }) {
    return messageType == 'IA'
        ? Padding(
            padding: const EdgeInsets.only(right: 50.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  child: Column(
                    children: [
                      Image.asset(
                        'assets/images/bot_master.png',
                        width: 100.0,
                        height: 100.0,
                      ),
                      const SizedBox(height: 8.0),
                      Text(
                        chatContent,
                        style: const TextStyle(color: Colors.black),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )
        : Align(
            alignment: messageType == currentUserId
                ? Alignment.centerRight
                : Alignment.centerLeft,
            child: Container(
              padding: const EdgeInsets.all(8.0),
              margin:
                  const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
              decoration: BoxDecoration(
                color: messageType == currentUserId
                    ? Colors.deepPurple
                    : Colors.green,
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: Text(
                chatContent,
                style: const TextStyle(color: Colors.white),
              ),
            ),
          );
  }

  Future<String> translateText(String text, String targetLocale) async {
    if (translationCache.containsKey('$text-$targetLocale')) {
      return translationCache['$text-$targetLocale']!;
    } else {
      final url = Uri.parse(
          'https://google-translate113.p.rapidapi.com/api/v1/translator/text');
      final headers = {
        'content-type': 'application/x-www-form-urlencoded',
        'X-RapidAPI-Key': 'caf9b2a90emsh35ef4bc666f9d1ap107021jsnb69346f6591e',
        'X-RapidAPI-Host': 'google-translate113.p.rapidapi.com',
      };

      final body = {
        'from': 'auto',
        'to': targetLocale,
        'text': text,
      };

      try {
        final response = await http.post(url, headers: headers, body: body);
        final Map<String, dynamic> responseData = json.decode(response.body);

        if (responseData.containsKey('trans')) {
          translationCache['$text-$targetLocale'] = responseData['trans'];
          return responseData['trans'];
        } else {
          throw Exception('Campo "trans" no encontrado en la respuesta');
        }
      } catch (error) {
        throw Exception('Error en la solicitud de traducción: $error');
      }
    }
  }

  Future<String> getTranslation(String text, String targetLocale) async {
    if (translationCache.containsKey('$text-$targetLocale')) {
      return translationCache['$text-$targetLocale']!;
    } else {
      String translation = await translateText(text, targetLocale);

      translationCache['$text-$targetLocale'] = translation;

      return translation;
    }
  }
}

class DiscordChatMessage extends StatelessWidget {
  final String username;
  final String message;
  final bool isSender;
  final String senderName;
  final String characterName;
  final String userImage;

  DiscordChatMessage(
      {required this.username,
      required this.message,
      this.isSender = false,
      this.characterName = '',
      required this.senderName,
      required this.userImage});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
            height: 16.0), // Aumenté el espacio entre el Divider y el mensaje
        Divider(height: 0.0, thickness: 0.2, color: Colors.grey[300]),
        ListTile(
          contentPadding: EdgeInsets.symmetric(horizontal: 16.0),
          leading: /*senderName == 'IA'
              ?
              // CircleAvatar(
              //   backgroundColor: Colors.deepPurple,
              //   child: Image.asset(
              //     'assets/images/bot_master.png',
              //     width: 100.0,
              //     height: 100.0,
              //   ),
              // )

              CircleAvatar(
                  backgroundColor: Colors.transparent,
                  child: Image.asset(
                    'assets/images/bot_master.png',
                    width: 100.0,
                    height: 100.0,
                  ),
                )
              : */
              CircleAvatar(
            backgroundColor: Colors.transparent,
            backgroundImage: NetworkImage(userImage),
          ),
          title: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      senderName == 'IA' || senderName == 'System'
                          ? senderName
                          : '$senderName${isSender ? " (You)" : " ($characterName)"}',
                      style: TextStyle(
                        color: senderName == 'System'
                            ? Colors.red
                            : Colors.deepPurple,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 4.0),
                    Text(
                      message,
                      style: TextStyle(
                        color:
                            senderName == 'System' ? Colors.red : Colors.white,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
