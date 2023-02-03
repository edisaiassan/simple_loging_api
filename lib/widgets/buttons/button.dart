import 'package:flutter/material.dart';
import 'package:login_sigup/utils/custom_theme.dart';

class Button extends StatelessWidget {
  final String text;
  final void Function()? onTap;

  const Button({
    super.key,
    required this.text,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 720.0,
      child: MaterialButton(
        
        textColor: CustomTheme.lightColor,
        color: CustomTheme.principalColor,
        padding: const EdgeInsets.all(16.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        onPressed: onTap,
        child: Text(text, style: const TextStyle(fontSize: 16.0), textAlign: TextAlign.center),
      ),
    );
  }
}
