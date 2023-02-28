import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class AlertWidget extends StatefulWidget {
  final String title;
  final String content;
  final VoidCallback onPressed;
  AlertWidget(
      {required this.title, required this.content, required this.onPressed});

  @override
  State<AlertWidget> createState() => _AlertWidgetState();
}

class _AlertWidgetState extends State<AlertWidget> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.title),
      content: Text(widget.content),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text('Cancel'),
        ),
        TextButton(
          onPressed: widget.onPressed,
          child: Text('Yes'),
        )
      ],
    );
  }
}
