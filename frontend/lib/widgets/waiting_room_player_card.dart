import 'package:flutter/material.dart';

class WaitingRoomPlayerCard extends StatelessWidget {
  final String? playerName;
  final bool? ready;

  const WaitingRoomPlayerCard({Key? key, this.playerName, this.ready})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(
          color: Colors.deepPurple,
          width: 2.0,
        ),
      ),
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Text(
            playerName! + (ready! ? ' ✓' : ''),
            style: TextStyle(
              fontSize: 22.0,
              color: Colors.white,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 8.0),
          CircleAvatar(
            backgroundColor: Colors.deepPurple,
            radius: 30.0,
            child: Text(
              playerName![0].toUpperCase(),
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(height: 8.0),
          ElevatedButton(onPressed: null, child: Text('Kick Player')),
        ],
      ),
    );
  }
}
