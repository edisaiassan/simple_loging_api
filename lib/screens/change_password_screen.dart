import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:login_sigup/screens/just_changed_password_screen.dart';
import '../const/coments.dart';
import '../const/reg_exp.dart';
import '../const/sizes.dart';
import '../widgets/buttons/button.dart';
import '../widgets/cards/card_form.dart';
import '../widgets/lists/better_list_view.dart';
import '../widgets/waiting_result.dart';
import 'package:http/http.dart' as http;

class ChangePasswordScreen extends StatefulWidget {
  final String email;
  const ChangePasswordScreen({super.key, required this.email});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _repeatNewPasswordController =
      TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isObscureText = true;

  @override
  void dispose() {
    _newPasswordController.dispose();
    _repeatNewPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.email),
      ),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: BetterListView(
            center: true,
            children: [
              CardForm(
                leading: const FlutterLogo(size: 32.0),
                title: nameApp,
                subtitle: changePasswordText,
                description: changePasswordDescripText,
                content: [
                  TextFormField(
                    obscureText: _isObscureText,
                    controller: _newPasswordController,
                    decoration: InputDecoration(
                      labelText: newPasswordText,
                      suffixIcon: IconButton(
                        onPressed: _hidePassword,
                        icon: Icon(_isObscureText
                            ? Icons.visibility
                            : Icons.visibility_off),
                      ),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Ingrese su nueva contraseña';
                      }
                      if (_newPasswordController.text.length < 6) {
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
                  const SizedBox(height: minMargin),
                  TextFormField(
                    obscureText: _isObscureText,
                    controller: _repeatNewPasswordController,
                    decoration: InputDecoration(
                      labelText: repeatNewPasswordText,
                      suffixIcon: IconButton(
                        onPressed: _hidePassword,
                        icon: Icon(_isObscureText
                            ? Icons.visibility
                            : Icons.visibility_off),
                      ),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Ingrese su nueva contraseña';
                      }
                      if (_repeatNewPasswordController.text.length < 6) {
                        return 'Ingrese al menos 6 caracteres';
                      }
                      if (value.contains(' ')) {
                        return 'No se permiten espacios';
                      }
                      if (!passwordValidate(value)) {
                        return 'Ingrese caracteres entre números y letras';
                      }

                      if (_repeatNewPasswordController.text !=
                          _newPasswordController.text) {
                        return 'Ambos campos deben ser iguales';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: maxMargin),
                  Button(
                    text: confirmText,
                    onTap: () => updatePassword(
                        widget.email, _repeatNewPasswordController.text),
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

  void updatePassword(String email, String password) async {
    waitingResult(context: context);
    String url = 'https://63db0326e4158e02f3149c13.mockapi.io/api/users';
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final users = json.decode(response.body) as List;
      final user =
          users.firstWhere((u) => u['email'] == email, orElse: () => null);
      if (_formKey.currentState!.validate()) {
        if (user != null) {
          final id = user['id'];
          final url =
              'https://63db0326e4158e02f3149c13.mockapi.io/api/users/$id';
          final response = await http.patch(
            Uri.parse(url),
            body: {'password': password},
          );
          if (response.statusCode == 200) {
            // ignore: use_build_context_synchronously
            Navigator.pop(context);

            // ignore: avoid_print
            print('Exito');
            // ignore: use_build_context_synchronously
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                    builder: (context) => JustChangedPasswrod(
                        viewNewPassword: _newPasswordController.text)),
                (route) => false);
            // Actualización exitosa
          } else {
            // Error al actualizar
          }
        } else {
          // Usuario no encontrado
        }
      } else {
        // Error al obtener usuarios
        // ignore: use_build_context_synchronously
        Navigator.pop(context);
      }
    }
  }

  void _hidePassword() {
    _isObscureText = !_isObscureText;
    setState(() {});
  }
}
