// ignore_for_file: non_constant_identifier_names

class UserSchema {
  final int id;
  final String first_name;
  final String last_name;
  final DateTime? created_at;
  final String birthday;
  final int age;

  UserSchema(
      {required this.id,
      required this.first_name,
      required this.last_name,
      this.created_at,
      required this.birthday,
      required this.age});
}
