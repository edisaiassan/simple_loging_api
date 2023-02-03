import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:login_sigup/screens/change_password_screen.dart';
import '../const/coments.dart';
import '../const/reg_exp.dart';
import '../const/sizes.dart';
import '../widgets/buttons/button.dart';
import '../widgets/cards/card_form.dart';
import '../widgets/lists/better_list_view.dart';
import '../widgets/waiting_result.dart';
import 'package:http/http.dart' as http;

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final TextEditingController _emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: BetterListView(
            center: true,
            children: [
              CardForm(
                leading: const FlutterLogo(size: 32.0),
                title: nameApp,
                subtitle: forgotPasswordText,
                description: forgotPasswordDecripText,
                content: [
                  TextFormField(
                    controller: _emailController,
                    decoration: const InputDecoration(
                      labelText: 'Correo electrónico',
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Ingrese su correo electrónico por favor';
                      }
                      if (value.contains(' ')) {
                        return 'No se permiten espacios';
                      }
                      if (!emailValidate(value)) {
                        return 'Por favor llene este campo con un correo electrónico válido';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: maxMargin),
                  Button(
                    text: nextText,
                    onTap: _checkEmail,
                  ),
                ],
              ),
              const Text(about, textAlign: TextAlign.center),
            ],
          ),
        ),
      ),
    );
  }

  void _checkEmail() async {
    waitingResult(context: context);

    final response = await http.get(
        Uri.parse('https://63db0326e4158e02f3149c13.mockapi.io/api/users'));
    final responseJson = jsonDecode(response.body);
    if (_formKey.currentState!.validate()) {
      for (var user in responseJson) {
        if (user['email'] == _emailController.text) {
          print('Usuario existente');
          Navigator.pop(context);
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      ChangePasswordScreen(email: _emailController.text)));

          return;
        }
      }
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Este correo no existe o no se ha registrado')));
      print('Este usuario no existe');
    }
    Navigator.pop(context);
  }
}
