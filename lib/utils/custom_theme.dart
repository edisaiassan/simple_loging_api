import 'package:flutter/material.dart';
import 'package:login_sigup/const/sizes.dart';

class CustomTheme {
  static const Color principalColor = Color(0xff245FA5);
  static const Color secondaryColor = Color(0xff03C988);
  static const Color lightColor = Color(0xffFAFAFA);
  static const Color errorColor = Color(0xffEB455F);

  static ThemeData light(
    BuildContext context,
  ) {
    return ThemeData(
      appBarTheme: AppBarTheme(
        elevation: 0.0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        foregroundColor: Theme.of(context).colorScheme.primary,
      ),
      primaryColor: principalColor,
      primarySwatch: Colors.blue,
      inputDecorationTheme: InputDecorationTheme(
        fillColor: Colors.grey,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(minCorner),
          borderSide: const BorderSide(
            width: 2,
            color: Colors.grey,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(minCorner),
          borderSide: const BorderSide(
            width: 2,
            color: principalColor,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(minCorner),
          borderSide: const BorderSide(
            width: 2,
            color: Colors.red,
          ),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(minCorner),
          borderSide: const BorderSide(
            width: 2,
          ),
        ),
      ),
      pageTransitionsTheme: const PageTransitionsTheme(
        builders: {
          TargetPlatform.android: CupertinoPageTransitionsBuilder(),
          TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
          TargetPlatform.windows: CupertinoPageTransitionsBuilder(),
          TargetPlatform.macOS: CupertinoPageTransitionsBuilder(),
          TargetPlatform.linux: CupertinoPageTransitionsBuilder(),
          TargetPlatform.fuchsia: CupertinoPageTransitionsBuilder(),
        },
      ),
    );
  }
}
