// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:zoom_clone_main/utils/colors.dart';

class CustomLoginButton extends StatelessWidget {
  final String text;
  final VoidCallback function;
  const CustomLoginButton({
    Key? key,
    required this.text,
    required this.function,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        function();
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: buttonColor,
        minimumSize: const Size(double.infinity, 50),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
            side: const BorderSide(color: buttonColor)),
      ),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 17,
        ),
      ),
    );
  }
}
