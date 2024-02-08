import 'package:age_calculator/age_calculator.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class CreateUserScreen extends StatelessWidget {
  const CreateUserScreen({super.key});

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
      body: const MyCustomForm(),
    );
  }
}

class MyCustomForm extends StatefulWidget {
  const MyCustomForm({super.key});

  @override
  MyCustomFormState createState() {
    return MyCustomFormState();
  }
}

class MyCustomFormState extends State<MyCustomForm> {
  final _formKey = GlobalKey<FormState>();
  DateTime birthday = DateTime.now();

  @override
  Widget build(BuildContext context) {
    final firstNameController = TextEditingController();
    final lastNameController = TextEditingController();

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            Title(
                color: const Color.fromARGB(255, 59, 164, 235),
                child: const Text(
                  "Create User",
                  style: TextStyle(
                      color: Color.fromARGB(255, 59, 164, 235),
                      fontSize: 24,
                      fontWeight: FontWeight.bold),
                )),
            TextFormField(
              controller: firstNameController,
              decoration: const InputDecoration(
                enabledBorder: UnderlineInputBorder(
                    borderSide:
                        BorderSide(color: Color.fromARGB(255, 59, 164, 235))),
                focusedBorder: UnderlineInputBorder(
                  borderSide:
                      BorderSide(color: Color.fromARGB(255, 59, 164, 235)),
                ),
                labelStyle: TextStyle(color: Color.fromARGB(255, 59, 164, 235)),
                labelText: 'First Name',
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Cannot be empty';
                }
                return null;
              },
            ),
            const SizedBox(
              height: 10,
            ),
            TextFormField(
              // The validator receives the text that the user has entered.
              controller: lastNameController,
              decoration: const InputDecoration(
                enabledBorder: UnderlineInputBorder(
                  borderSide:
                      BorderSide(color: Color.fromARGB(255, 59, 164, 235)),
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide:
                      BorderSide(color: Color.fromARGB(255, 59, 164, 235)),
                ),
                labelStyle: TextStyle(color: Color.fromARGB(255, 59, 164, 235)),
                labelText: 'Last Name',
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Cannot be empty';
                }
                return null;
              },
            ),
            const SizedBox(
              height: 20,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Birthday',
                  style: TextStyle(
                    fontSize: 16,
                    color: Color.fromARGB(255, 59, 164, 235),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                GestureDetector(
                  onTap: () async {
                    DateTime? selectedBirthday = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(1900),
                      lastDate: DateTime(2025),
                    );
                    if (selectedBirthday == null) return;
                    birthday = selectedBirthday;
                    setState(() {});
                  },
                  child: Container(
                    width: double.infinity,
                    child: Text(
                      '${birthday.day} / ${birthday.month} / ${birthday.year}',
                      style: const TextStyle(
                          fontSize: 16,
                          color: Color.fromARGB(255, 59, 164, 235)),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 50,
            ),
            Container(
              height: 45,
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    final duration = AgeCalculator.age(birthday);

                    final userData = {
                      'first_name': firstNameController.text,
                      'last_name': lastNameController.text,
                      'birthday': birthday.toIso8601String(),
                      'age': duration.years,
                    };

                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        backgroundColor: Color.fromARGB(255, 35, 108, 233),
                        content: Text('Creating user ...'),
                      ),
                    );

                    try {
                      final newUser = await Supabase.instance.client
                          .from('users')
                          .insert(userData)
                          .select();

                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                            duration: const Duration(seconds: 3),
                            backgroundColor:
                                const Color.fromARGB(255, 35, 108, 233),
                            content: Text(
                                'User Created: ${newUser[0]["first_name"]} ${newUser[0]["last_name"]}')),
                      );
                    } catch (err) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            backgroundColor: Color.fromARGB(255, 35, 108, 233),
                            duration: Duration(seconds: 3),
                            content: Text('Could not create user !!')),
                      );
                    } finally {
                      _formKey.currentState!.reset();
                    }
                  }
                },
                child: const Text(
                  'Submit',
                  style: TextStyle(
                      color: Color.fromARGB(255, 67, 130, 240),
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
