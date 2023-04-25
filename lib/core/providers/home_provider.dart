import 'dart:async';

import 'package:flutter/material.dart';
import 'package:medicine_app/core/models/medicine_model.dart';
import 'package:medicine_app/core/models/response_model.dart';
import 'package:medicine_app/core/services/http_service.dart';
import 'package:medicine_app/main.dart';
import 'package:medicine_app/utilities/constants/medicine_constant.dart';
import 'package:medicine_app/utilities/constants/url_contant.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeProvider extends ChangeNotifier {
  bool _isLoading = true;
  List<MedicineModel> _medicineList = [];
  ScrollController _scrollController = ScrollController();

  bool get isLoading => _isLoading;
  List<MedicineModel> get medicineList => _medicineList;
  ScrollController get scrollController => _scrollController;

  void setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  Future<void> fetchData() async {
    _isLoading = true;

    String? medicineListData =
        localPrefs.getString(MedicineConstants.medicineList);
    double? scrollController = localPrefs.getDouble(MedicineConstants.scroll);

    _scrollController =
        ScrollController(initialScrollOffset: scrollController ?? 0.0);

    if (medicineListData != null) {
      ResponseModel responseModel = ResponseModel.fromJson(medicineListData);
      _medicineList = responseModel.data;
    } else {
      final response = await Http.get(Endpoints.drugnames);

      if (response.statusCode == 200) {
        ResponseModel responseModel = ResponseModel.fromJson(response.body);
        _medicineList = responseModel.data;

        await localPrefs.setString(
            MedicineConstants.medicineList, response.body);
      } else {
        throw Exception('Failed to get data.');
      }
    }

    _isLoading = false;
  }

  Future<void> refreshMedicineList() async {
    setLoading(true);
    final prefs = await SharedPreferences.getInstance();
    prefs.clear();

    await fetchData();
    setLoading(false);
  }

  void setScrollController(ScrollController scrollController) {
    localPrefs.setDouble(MedicineConstants.scroll, scrollController.offset);
    scrollController = _scrollController;
  }
}
