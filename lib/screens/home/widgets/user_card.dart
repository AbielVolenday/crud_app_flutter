import 'package:crud_app/schemas/user.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

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
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 10),
          child: Row(
            children: [
              UpdateButton(),
              SizedBox(
                width: 10,
              ),
              DeleteButton(),
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
  const DeleteButton({
    super.key,
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
          onPressed: () {},
          child: const Text(
            "Delete",
            style: TextStyle(fontWeight: FontWeight.bold),
          )),
    );
  }
}

class UpdateButton extends StatelessWidget {
  const UpdateButton({
    super.key,
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
            context.go("/updateUser/123");
          },
          child: const Text(
            "Update",
            style: TextStyle(fontWeight: FontWeight.bold),
          )),
    );
  }
}
