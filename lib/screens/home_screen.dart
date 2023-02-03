import 'package:flutter/material.dart';
import '../const/data.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bienvenido'),
      ),
      body: ListView.builder(
          itemCount: datos.length,
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
              title: Text(datos[index]['userName']),
              subtitle: Text(datos[index]['password']),
            );
          }),
    );
  }
}
