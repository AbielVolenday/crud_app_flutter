import 'package:crud_app/schemas/user.dart';
import 'package:crud_app/screens/home/widgets/user_card.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class UserTable extends StatefulWidget {
  UserTable({super.key});

  @override
  State<UserTable> createState() => _UserTableState();
}

class _UserTableState extends State<UserTable> {
  final _usersFuture = Supabase.instance.client.from("users").select();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _usersFuture,
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
