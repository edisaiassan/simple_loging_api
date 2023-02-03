import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:login_sigup/const/sizes.dart';
import 'package:login_sigup/screens/forgot_password_screen.dart';
import 'package:login_sigup/screens/home_screen.dart';
import 'package:login_sigup/widgets/buttons/button.dart';
import 'package:login_sigup/widgets/cards/card_form.dart';
import 'package:login_sigup/widgets/lists/better_list_view.dart';
import 'package:login_sigup/widgets/waiting_result.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../const/coments.dart';
import '../const/reg_exp.dart';
import 'package:http/http.dart' as http;

late SharedPreferences prefs;

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _isObscureText = true;
  final TextEditingController _userController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _checkIfLoggedIn();
  }

  @override
  void dispose() {
    _userController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: BetterListView(
            center: true,
            children: [
              CardForm(
                leading: const FlutterLogo(size: 32.0),
                title: nameApp,
                subtitle: loginText,
                description: loginDescripText,
                content: [
                  TextFormField(
                    controller: _userController,
                    decoration: const InputDecoration(
                      labelText: userText,
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Ingrese su nombre de usuario';
                      }
                      if (_userController.text.length < 6) {
                        return 'Ingrese al menos 6 caracteres';
                      }
                      if (value.contains(' ')) {
                        return 'No se permiten espacios';
                      }
                      if (!userNameValidate(value)) {
                        return 'Solo se permiten caracteres entre letras y números';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: minMargin),
                  TextFormField(
                    controller: _passwordController,
                    obscureText: _isObscureText,
                    decoration: InputDecoration(
                      labelText: passwordText,
                      suffixIcon: IconButton(
                        onPressed: () => setState(() {
                          _isObscureText = !_isObscureText;
                        }),
                        icon: Icon(_isObscureText
                            ? Icons.visibility
                            : Icons.visibility_off),
                      ),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Ingrese su contraseña';
                      }
                      if (_passwordController.text.length < 6) {
                        return 'Ingrese al menos 6 caracteres';
                      }
                      if (value.contains(' ')) {
                        return 'No se permiten espacios';
                      }
                      if (!passwordValidate(value)) {
                        return 'Ingrese caracteres entre números y letras';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: maxMargin),
                  Button(
                    text: loginText,
                    onTap: _login,
                  ),
                ],
              ),
              TextButton(
                onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ForgotPasswordScreen())),
                child: const Text(forgotPasswordText),
              ),
              const SizedBox(height: maxMargin),
              const Text(
                about,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _checkIfLoggedIn() async {
    prefs = await SharedPreferences.getInstance();
    final username = prefs.getString('username');
    final password = prefs.getString('password');

    if (username != null && password != null) {
      // ignore: use_build_context_synchronously
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => HomeScreen(
            username: username,
          ),
        ),
      );
    }
  }

  void _login() async {
    waitingResult(context: context);
    final prefs = await SharedPreferences.getInstance();

    final response = await http.get(
        Uri.parse('https://63db0326e4158e02f3149c13.mockapi.io/api/users'));
    final responseJson = jsonDecode(response.body);
    if (_formKey.currentState!.validate()) {
      for (var user in responseJson) {
        if (user['username'] == _userController.text &&
            user['password'] != _passwordController.text) {
          // ignore: use_build_context_synchronously
          Navigator.pop(context);
          // ignore: use_build_context_synchronously
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Contraseña erronea')));

          // ignore: avoid_print
          print('Contraseña erronea');
          return;
        }
        if (user['username'] == _userController.text &&
            user['password'] == _passwordController.text) {
          // ignore: avoid_print
          print('Usuario existente');
          prefs.setString('username', _userController.text);
          prefs.setString('password', _passwordController.text);

          // ignore: use_build_context_synchronously
          Navigator.pop(context);
          // ignore: use_build_context_synchronously
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                  builder: (context) => HomeScreen(
                        username: _userController.text,
                      )),
              (route) => false);
          return;
        }
      }
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Usuario no existe')));
      // ignore: avoid_print
      print('Este usuario no existe');
    }
    // ignore: use_build_context_synchronously
    Navigator.pop(context);
  }
}
