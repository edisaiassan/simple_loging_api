import 'package:flutter/material.dart';
import 'package:login_sigup/const/coments.dart';
import 'package:login_sigup/const/sizes.dart';
import 'package:login_sigup/screens/login_screen.dart';
import 'package:login_sigup/widgets/buttons/button.dart';
import 'package:login_sigup/widgets/lists/better_list_view.dart';
import 'package:login_sigup/widgets/texts/subtitle_text.dart';
import 'package:login_sigup/widgets/texts/title_text.dart';

class JustChangedPasswrod extends StatelessWidget {
  final String viewNewPassword;

  const JustChangedPasswrod({super.key, required this.viewNewPassword});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BetterListView(
          center: true,
          children: [
            const TitleText('Ahora tu contraseña es:'),
            const SizedBox(height: maxMargin),
            SubTitleText(viewNewPassword),
            const SizedBox(height: maxMargin),
            Button(
              onTap: () => Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const LoginScreen(),
                  ),
                  (route) => false),
              text: confirmText,
            ),
          ],
        ),
      ),
    );
  }
}
