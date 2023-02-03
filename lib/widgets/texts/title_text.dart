import 'package:flutter/material.dart';
import 'package:login_sigup/utils/custom_theme.dart';

class TitleText extends StatelessWidget {
  final String data;
  const TitleText(
    this.data, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      data,
      style: const TextStyle(
        fontSize: 32.0,
        color: CustomTheme.principalColor,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
