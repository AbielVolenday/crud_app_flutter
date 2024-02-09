import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class UserProvider extends ChangeNotifier {
  late Future<dynamic> users;

  void getAllUsers() {
    users = Supabase.instance.client.from('users').select();
    notifyListeners();
  }
}
