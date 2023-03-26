import 'package:flutter/material.dart';

class TextWidget extends StatelessWidget {
  final String input_text;
  final double size;
  const TextWidget({
    super.key,
    required this.input_text,
    required this.size,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      input_text,
      style: TextStyle(
        fontSize: size,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
