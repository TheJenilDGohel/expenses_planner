import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AdaptiveFlatButton extends StatefulWidget {
  final String text;
  final Function datePickerHandler;

  AdaptiveFlatButton({
    required this.text,
    required this.datePickerHandler,
  });

  @override
  State<AdaptiveFlatButton> createState() => _AdaptiveFlatButtonState();
}

class _AdaptiveFlatButtonState extends State<AdaptiveFlatButton> {
  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? CupertinoButton(
            child: Text(
              widget.text,
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            onPressed: widget.datePickerHandler(),
          )
        : TextButton(
            onPressed: widget.datePickerHandler(),
            child: Text(
              widget.text,
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          );
  }
}
