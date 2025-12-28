import 'package:flutter/material.dart';
class AppDialog extends StatelessWidget {
  final String message;
  final String? title;
  const AppDialog({super.key,required this.message,this.title});

  @override
  Widget build(BuildContext context) {
    return  AlertDialog(
      title: title != null ? Text(title!) : null,
      content: Text(message),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('OK'),
        ),
      ],
    );
  }
}
