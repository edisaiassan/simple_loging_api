import 'package:flutter/material.dart';
import 'package:login_sigup/const/coments.dart';
import 'package:login_sigup/screens/login_screen.dart';
import 'package:login_sigup/widgets/lists/better_list_view.dart';
import 'package:login_sigup/widgets/texts/title_text.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatelessWidget {
  final String username;
  const HomeScreen({super.key, required this.username});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Center(child: FlutterLogo(size: 36.0)),
        title: const Text(nameApp),
        actions: [
          IconButton(
            onPressed: () async {
              prefs = await SharedPreferences.getInstance();
              await prefs.clear();
              // ignore: use_build_context_synchronously
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginScreen()),
                  (route) => false);
            },
            icon: const Icon(Icons.exit_to_app),
          ),
        ],
      ),
      body: BetterListView(
        center: true,
        children: [
          TitleText('Bienvenido $username'),
          Lottie.asset('assets/congratulations.json',
              repeat: false, reverse: true),
        ],
      ),
    );
  }
}
