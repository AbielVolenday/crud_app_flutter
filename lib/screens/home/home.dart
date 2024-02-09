import 'package:crud_app/providers/userProvider.dart';
import 'package:crud_app/screens/home/widgets/user_table.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    context.watch<UserProvider>().getAllUsers();
    return Scaffold(
      appBar: AppBar(
        title: const Center(
            child: Text(
          'Crud App',
          style: TextStyle(color: Colors.white),
        )),
        backgroundColor: const Color.fromARGB(255, 79, 169, 241),
      ),
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(),
        child: const Padding(
          padding: EdgeInsets.all(8.0),
          child: UserTable(),
        ),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            heroTag: "refreshUsers",
            onPressed: () {
              context.read<UserProvider>().getAllUsers();
            },
            backgroundColor: const Color.fromARGB(255, 79, 169, 241),
            child: const Icon(
              Icons.restore,
              color: Colors.white,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          FloatingActionButton(
            heroTag: "addUser",
            onPressed: () {
              context.goNamed(
                'createUser',
              );
            },
            backgroundColor: const Color.fromARGB(255, 79, 169, 241),
            child: const Icon(
              Icons.add,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
