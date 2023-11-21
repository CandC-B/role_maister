import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:role_maister/config/config.dart';
import 'package:chat_bubbles/chat_bubbles.dart';
import 'package:http/http.dart' as http;
import 'package:role_maister/main.dart';
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

  void onSendMessage(String text) async {
    text = await translateText(text, 'en');

    // TODO: mandar todo pal BE primero
    List<Map<String, dynamic>>? messages =
        await firebase.fetchConversationByGameID(singleton.currentGame!);

    Map<String, String> headers = {
      'Content-Type': 'application/json',
    };

    firestoreService.saveMessage(
        text, DateTime.now(), widget.gameId, currentUserId);
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
        firestoreService.saveMessage(json.decode(response.body)["message"],
            DateTime.now(), widget.gameId, "IA");
        // scrollController.animateTo(0,
        //     duration: const Duration(milliseconds: 300), curve: Curves.easeOut);
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

  // checking if sent message
  // bool isMessageSent(int index) {
  //   if ((index > 0 && listMessages[index - 1].get('sentBy') != currentUserId) ||
  //       index == 0) {
  //     return true;
  //   } else {
  //     return false;
  //   }
  // }

  // // checking if received message
  // bool isMessageReceived(int index) {
  //   if ((index > 0 && listMessages[index - 1].get('sentBy') == currentUserId) ||
  //       index == 0) {
  //     return true;
  //   } else {
  //     return false;
  //   }
  // }

  @override
  Widget build(BuildContext context) {

    MyAppState? appState = context.findAncestorStateOfType<MyAppState>();
    Locale locale = appState?.locale ?? const Locale('en');

    // print ('LOCALE: $locale');


    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/background4.png'),
          fit: BoxFit.cover,
          opacity: 0.9,
        ),
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
                          bool ai_msg =
                              listMessages[index].get('sentBy') == "IA";

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
                                return BubbleSpecialThree(
                                  text: listMessages[index].get('text'),
                                  color: ai_msg
                                      ? const Color.fromARGB(255, 234, 226, 248)
                                      : Colors.deepPurple,
                                  tail: true,
                                  isSender: !ai_msg,
                                  textStyle: TextStyle(
                                    color: ai_msg ? Colors.black : Colors.white,
                                    fontSize: 16,
                                  ),
                                );
                              } else if (translateSnapshot.hasError) {
                                // En caso de error durante la traducción
                                return Text(
                                    'Error de traducción: ${translateSnapshot.error}');
                              } else {
                                // Mostrar la burbuja del mensaje traducido
                                return BubbleSpecialThree(
                                  text: translateSnapshot.data ?? '',
                                  color: ai_msg
                                      ? const Color.fromARGB(255, 234, 226, 248)
                                      : Colors.deepPurple,
                                  tail: true,
                                  isSender: !ai_msg,
                                  textStyle: TextStyle(
                                    color: ai_msg ? Colors.black : Colors.white,
                                    fontSize: 16,
                                  ),
                                );
                              }
                            },
                          );
                        }
                      },
                    );
                  } else {
                    return  Center(
                      child: Text(AppLocalizations.of(context)!.game_no_messages),
                    );
                  }
                } else {
                  return const Center(
                    child: CircularProgressIndicator(
                        // color: AppColors.burgundy,
                        ),
                  );
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
                    decoration:  InputDecoration(
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
