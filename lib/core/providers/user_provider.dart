import 'package:flutter/cupertino.dart';
import 'package:medicine_app/core/models/user_model.dart';

class UserProvider extends ChangeNotifier {
  final UserModel _user = UserModel();
  UserModel get user => _user;

  void setUser(UserModel user) {
    _user.name = user.name;
    _user.age = user.age;
    _user.type = user.type;
    notifyListeners();
  }
}
