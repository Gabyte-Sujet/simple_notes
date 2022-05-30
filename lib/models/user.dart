import 'package:flutter/foundation.dart';

class User {
  final String fullName;
  final String eMail;
  final String password;

  User({
    required this.fullName,
    required this.eMail,
    required this.password,
  });
}

class Users with ChangeNotifier {
  List<User> _users = [];

  List<User> get users {
    return [..._users];
  }

  Map<String, User> userdt = {};

  void addUser(String fullname, String email, String pass) {
    if (userdt.containsKey(email)) {
      return;
    }
    userdt.putIfAbsent(
        email, () => User(fullName: fullname, eMail: email, password: pass));

    _users.add(User(fullName: fullname, eMail: email, password: pass));

    notifyListeners();
  }

  bool isUser(String email, String pass) {
    var cUser = userdt['email'];
    if (userdt.containsKey(email) && userdt[email]?.password == pass) {
      return true;
    }
    return false;
    // return userdt.containsKey(email);
  }
}
