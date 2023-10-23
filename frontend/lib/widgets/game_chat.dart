import 'package:flutter/material.dart';

class Message {
  final String content;
  final MessageType messageType;

  Message(this.content, this.messageType);
}

enum MessageType {
  IA,
  PLAYER,
  USER,
}

class GameChat extends StatefulWidget {
  @override
  _GameChatState createState() => _GameChatState();
}

class _GameChatState extends State<GameChat> {
  final List<Message> messages = [];
  final TextEditingController _textController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Mock initial messages
    messages.addAll([
      Message('¡Hola! Soy la IA. ¿En qué puedo ayudarte?', MessageType.IA),
    ]);
  }

  void _addMessage(String content, MessageType messageType) {
    setState(() {
      messages.add(Message(content, messageType));
    });
  }

  void _sendMessage(String content) {

    // Simula mi mensaje
    String myResponse = content;
    _addMessage(myResponse, MessageType.USER);

    // Simular respuesta de otro jugador
    String response = 'Gracias por tu mensaje: $content';
    _addMessage(response, MessageType.PLAYER);

    // Simular respuesta de la IA
    String iaResponse = 'Estoy procesando tu pregunta...';
    _addMessage(iaResponse, MessageType.IA);

    _textController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: messages.length,
                itemBuilder: (context, index) {
                  return ChatBubble(
                    content: messages[index].content,
                    messageType: messages[index].messageType,
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                onSubmitted: (content) {
                  _sendMessage(content);
                },
                decoration: InputDecoration(
                  hintText: 'Escribe un mensaje...',
                  suffixIcon: IconButton(
                    icon: Icon(Icons.send),
                    onPressed: () {
                      // Enviar el mensaje cuando se hace clic en el icono de enviar
                      // _sendMessage(content);
                      _sendMessage('Hola, tengo una pregunta sobre Flutter.');
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      );
  }
}

class ChatBubble extends StatelessWidget {
  final String content;
  final MessageType messageType;

  const ChatBubble({
    required this.content,
    required this.messageType,
  });

  @override
  Widget build(BuildContext context) {
    return messageType == MessageType.IA
        ? Padding(
            padding: const EdgeInsets.only(right: 50.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  padding: EdgeInsets.all(8.0),
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
                      SizedBox(height: 8.0),
                      Text(
                        content,
                        style: TextStyle(color: Colors.black),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )
        : Align(
            alignment: messageType == MessageType.USER ? Alignment.centerRight : Alignment.centerLeft,
            child: Container(
              padding: EdgeInsets.all(8.0),
              margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
              decoration: BoxDecoration(
                color: messageType == MessageType.USER ? Colors.blue : Colors.green,
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: Text(
                content,
                style: TextStyle(color: Colors.white),
              ),
            ),
          );
  }
}
