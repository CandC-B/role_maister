import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CopyToClipboardButton extends StatelessWidget {
  final String textToCopy;

  CopyToClipboardButton({required this.textToCopy});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
       Text(
            textToCopy,
            style: TextStyle(fontSize: 18.0, color: Colors.white),
          ),
        IconButton(
          icon: Icon(Icons.content_copy, color: Colors.white),
          onPressed: () {
            _copyToClipboard(textToCopy);
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Copied to clipboard!'),
              ),
            );
          },
        ),
      ],
    );
  }

  void _copyToClipboard(String text) {
    Clipboard.setData(ClipboardData(text: text));
  }
}