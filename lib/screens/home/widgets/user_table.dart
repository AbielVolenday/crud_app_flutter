import 'package:crud_app/providers/userProvider.dart';
import 'package:crud_app/schemas/user.dart';
import 'package:crud_app/screens/home/widgets/user_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserTable extends StatefulWidget {
  const UserTable({super.key});

  @override
  State<UserTable> createState() => _UserTableState();
}

class _UserTableState extends State<UserTable> {
  @override
  Widget build(BuildContext context) {
    Future usersFuture = context.watch<UserProvider>().users;

    return FutureBuilder(
      future: usersFuture,
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        } else {
          List users = snapshot.data!;
          return ListView.builder(
            itemCount: users.length,
            itemBuilder: (context, index) {
              final UserSchema user = UserSchema(
                  id: users[index]["id"],
                  first_name: users[index]["first_name"],
                  last_name: users[index]["last_name"],
                  birthday: users[index]["birthday"],
                  age: users[index]["age"]);

              return UserCard(user: user);
            },
          );
        }
      },
    );
  }
}
