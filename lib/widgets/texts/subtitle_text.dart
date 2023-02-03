import 'package:flutter/material.dart';

class SubTitleText extends StatelessWidget {
  final String text;
  const SubTitleText(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 18.0,
        fontWeight: FontWeight.w400,
      ),
    );
  }
}
