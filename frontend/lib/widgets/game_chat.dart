import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:role_maister/config/app_singleton.dart';
import 'package:role_maister/config/firebase_logic.dart';

import '../models/models.dart';

class GameChat extends StatefulWidget {
  final String gameId;

  const GameChat({Key? key, required this.gameId}) : super(key: key);

  @override
  _GameChatState createState() => _GameChatState(gameId);
}

class _GameChatState extends State<GameChat> {
  _GameChatState(String gameId);

  // late String currentUserId = singleton.user!.uid;
  late String currentUserId = 'aXO4V6bhNHGFoEZK4Ji1';

  // final List<Message> messages = [];
  List<QueryDocumentSnapshot> listMessages = [];
  final TextEditingController textEditingController = TextEditingController();
  // final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    // scrollController.addListener(_scrollListener);
  }

  void onSendMessage(String text) {
    // TODO: mandar todo pal BE primero

    if (text.trim().isNotEmpty) {
      textEditingController.clear();
      firestoreService.saveMessage(
          text, DateTime.now(), widget.gameId, currentUserId);
      // scrollController.animateTo(0,
      //     duration: const Duration(milliseconds: 300), curve: Curves.easeOut);
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
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/dnd.png'),
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
                          return messageBubble(
                            chatContent: listMessages[index].get('text'),
                            messageType: listMessages[index].get('sentBy'),
                          );
                        }
                      },
                    );
                  } else {
                    return const Center(
                      child: Text('No messages...'),
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
                    decoration: const InputDecoration(
                      hintText:
                          "Craft the destiny of your character's journey...",
                      hintStyle: TextStyle(color: Colors.white),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                            color: Colors
                                .white), // Set the underline color to white
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                            color: Colors
                                .deepPurple), // Set the underline color to white when focused
                      ),
                    ),
                    style: TextStyle(color: Colors.white),
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
                        'images/bot_master.png',
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
                color:
                    messageType == currentUserId ? Colors.deepPurple : Colors.green,
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: Text(
                chatContent,
                style: const TextStyle(color: Colors.white),
              ),
            ),
          );
  }
}
