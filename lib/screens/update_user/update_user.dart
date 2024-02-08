import 'package:flutter/material.dart';

class UpdateUserScreen extends StatelessWidget {
  const UpdateUserScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
            child: Text(
          'Crud App',
          style: TextStyle(color: Colors.white),
        )),
        backgroundColor: const Color.fromARGB(255, 79, 169, 241),
      ),
      body: const Text("CREATE USER SCREEN"),
    );
  }
}
