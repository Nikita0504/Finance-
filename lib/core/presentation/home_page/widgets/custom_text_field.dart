import 'package:flutter/material.dart';
import '../../../utils/colors.dart';

class CustomTextField extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  const CustomTextField(
      {super.key, required this.hintText, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 5),
      child: TextField(
        cursorColor: const Color.fromARGB(255, 129, 125, 125),
        autofocus: false,
        controller: controller,
        style: const TextStyle(color: textColor),
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderSide:
                BorderSide(color: const Color.fromARGB(255, 129, 125, 125)),
            borderRadius: BorderRadius.circular(12),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide:
                BorderSide(color: const Color.fromARGB(255, 129, 125, 125)),
            borderRadius: BorderRadius.all(Radius.circular(12)),
          ),
          enabledBorder: const OutlineInputBorder(
            borderSide:
                BorderSide(color: const Color.fromARGB(255, 129, 125, 125)),
            borderRadius: BorderRadius.all(Radius.circular(12)),
          ),
          hintText: hintText,
          hintStyle: TextStyle(color: Color.fromARGB(255, 132, 140, 155)),
          focusColor: textColor,
          fillColor: searchColor,
          filled: true,
        ),
      ),
    );
  }
}
