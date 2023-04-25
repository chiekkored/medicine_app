import 'package:flutter/material.dart';

class HomeProvider with ChangeNotifier {
  bool loading = false;
  bool get isLoading => loading;

  bool setLoading() => !loading;
}
