import 'package:flutter/cupertino.dart';
import 'package:medicine_app/core/models/medicine_model.dart';
import 'package:medicine_app/core/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashViewModel {
  static Future<bool> initialize(BuildContext context) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? userPrefs = prefs.getString("user");
      String? medicineListPrefs = prefs.getString("medicineList");
      if (userPrefs != null && medicineListPrefs != null) {
        UserModel user = UserModel.fromJson(userPrefs);
      } else {}
      return true;
    } on Exception catch (e) {
      return false;
    }
  }
}
