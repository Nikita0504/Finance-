import 'package:finance/core/utils/colors.dart';
import 'package:flutter/material.dart';

import 'custom_text_field.dart';

class MyAlertDialog extends StatelessWidget {
  final GestureTapCallback onPressed;
  final TextEditingController controllerTop;
  final TextEditingController controllerDown;
  final String title;
  const MyAlertDialog({
    super.key,
    required this.onPressed,
    required this.controllerTop,
    required this.controllerDown,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      titleTextStyle: const TextStyle(
          color: textColor, fontWeight: FontWeight.w600, fontSize: 20),
      backgroundColor: backgroundColor,
      title: Text(title),
      content: SingleChildScrollView(
        child: ConstrainedBox(
          constraints: const BoxConstraints(
            maxHeight: 200.0,
            maxWidth: 300.0,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CustomTextField(
                hintText: 'Enter the amount',
                controller: controllerTop,
              ),
              CustomTextField(
                hintText: 'Enter a description',
                controller: controllerDown,
              ),
            ],
          ),
        ),
      ),
      actions: <Widget>[
        TextButton(
            onPressed: onPressed,
            child: const Text(
              'Approve',
              style: TextStyle(color: textColor),
            )),
      ],
    );
  }
}
