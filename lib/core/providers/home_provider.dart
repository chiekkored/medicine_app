import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:medicine_app/core/models/medicine_model.dart';
import 'package:medicine_app/core/models/response_model.dart';
import 'package:medicine_app/core/services/http_service.dart';
import 'package:medicine_app/utilities/constants/medicine_constant.dart';
import 'package:medicine_app/utilities/constants/url_contant.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeProvider extends ChangeNotifier {
  bool _isLoading = true;
  List<MedicineModel> _medicineList = [];

  bool get isLoading => _isLoading;
  List<MedicineModel> get medicineList => _medicineList;

  Future<void> initialize() async {
    _isLoading = true;

    final prefs = await SharedPreferences.getInstance();

    String? medicineListData = prefs.getString(MedicineConstants.medicineList);

    if (medicineListData != null) {
      ResponseModel responseModel = ResponseModel.fromJson(medicineListData);
      _medicineList = responseModel.data;
    } else {
      final response = await Http.get(Endpoints.drugnames);

      if (response.statusCode == 200) {
        ResponseModel responseModel = ResponseModel.fromJson(response.body);
        _medicineList = responseModel.data;

        await prefs.setString(MedicineConstants.medicineList, response.body);
      } else {
        throw Exception('Failed to fetch posts');
      }
    }

    _isLoading = false;
    notifyListeners();
  }

  void setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  void setMedicineList(List<MedicineModel> medicineList) {
    _medicineList = medicineList;
    notifyListeners();
  }

  void refreshMedicineList(List<MedicineModel> medicineList) {
    _medicineList = medicineList;
    notifyListeners();
  }
}
