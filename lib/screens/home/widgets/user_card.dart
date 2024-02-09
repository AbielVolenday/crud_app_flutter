import 'package:crud_app/schemas/user.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class UserCard extends StatelessWidget {
  const UserCard({super.key, required this.user});
  final UserSchema user;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        ContentRow(name: "Id :", value: user.id.toString()),
        ContentRow(name: "First Name :", value: user.first_name),
        ContentRow(name: "Last Name :", value: user.last_name),
        ContentRow(name: "Birthday :", value: user.birthday.toString()),
        ContentRow(name: "Age :", value: user.age.toString()),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Row(
            children: [
              UpdateButton(id: user.id.toString()),
              const SizedBox(
                width: 10,
              ),
              DeleteButton(
                id: user.id.toString(),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Container(
            width: double.infinity,
            height: 2,
            color: Colors.grey,
          ),
        )
      ],
    );
  }
}

class ContentRow extends StatelessWidget {
  final String name;
  final String value;

  const ContentRow({
    super.key,
    required this.name,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          name,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const Padding(padding: EdgeInsets.only(left: 10)),
        Text(value),
      ],
    );
  }
}

class DeleteButton extends StatelessWidget {
  final String id;
  const DeleteButton({
    super.key,
    required this.id,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      decoration: BoxDecoration(
        color: Colors.red,
        borderRadius: BorderRadius.circular(5),
      ),
      child: TextButton(
          style: TextButton.styleFrom(foregroundColor: Colors.white),
          onPressed: () async {
            try {
              final newUser = await Supabase.instance.client
                  .from('users')
                  .delete()
                  .eq("id", int.parse(id))
                  .select();

              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                    duration: const Duration(seconds: 3),
                    backgroundColor: const Color.fromARGB(255, 35, 108, 233),
                    content: Text(
                        'User Deleted: ${newUser[0]["first_name"]} ${newUser[0]["last_name"]}')),
              );
            } catch (err) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                    backgroundColor: Color.fromARGB(255, 35, 108, 233),
                    duration: Duration(seconds: 3),
                    content: Text('Could not delete user !!')),
              );
            } 
          },
          child: const Text(
            "Delete",
            style: TextStyle(fontWeight: FontWeight.bold),
          )),
    );
  }
}

class UpdateButton extends StatelessWidget {
  final String id;

  const UpdateButton({
    super.key,
    required this.id,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      decoration: BoxDecoration(
        color: Colors.blue,
        borderRadius: BorderRadius.circular(5),
      ),
      child: TextButton(
          style: TextButton.styleFrom(foregroundColor: Colors.white),
          onPressed: () {
            context
                .goNamed("updateUser", pathParameters: {"id": id.toString()});
          },
          child: const Text(
            "Update",
            style: TextStyle(fontWeight: FontWeight.bold),
          )),
    );
  }
}
