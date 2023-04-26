import 'dart:async';

import 'package:flutter/material.dart';
import 'package:medicine_app/core/models/medicine_model.dart';
import 'package:medicine_app/core/models/response_model.dart';
import 'package:medicine_app/core/services/http_service.dart';
import 'package:medicine_app/main.dart';
import 'package:medicine_app/utilities/constants/medicine_constant.dart';
import 'package:medicine_app/utilities/constants/url_contant.dart';

class HomeViewModel extends ChangeNotifier {
  bool _isLoading = true;
  bool _isAZSorted = false;
  List<MedicineModel> _medicineList = [];
  List<MedicineModel> _searchResultMedicineList = [];
  ScrollController _scrollController = ScrollController();

  bool get isLoading => _isLoading;
  bool get isAZSorted => _isAZSorted;
  List<MedicineModel> get medicineList => _medicineList;
  List<MedicineModel> get searchResultMedicineList => _searchResultMedicineList;
  ScrollController get scrollController => _scrollController;

  void setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  Future<void> fetchData() async {
    _isLoading = true;

    String? medicineListData =
        localPrefs.getString(MedicineConstants.medicineList);
    // localPrefs.clear();
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

  void setMedicineList(List<MedicineModel> medicineList) {
    _medicineList = medicineList;
    notifyListeners();
  }

  Future<void> addMedicineList(MedicineModel medicine) async {
    _medicineList.insert(0, medicine);
    await setMedicineListToLocal();
    notifyListeners();
  }

  Future<void> updateMedicineList(MedicineModel medicine, int index) async {
    _medicineList[index] = medicine;
    await setMedicineListToLocal();
    notifyListeners();
  }

  Future<void> deleteMedicineList(int index) async {
    _medicineList.removeAt(index);
    await setMedicineListToLocal();
    notifyListeners();
  }

  Future<void> setMedicineListToLocal() async {
    await localPrefs.setString(MedicineConstants.medicineList,
        ResponseModel(data: _medicineList).toJson());
    notifyListeners();
  }

  Future<void> sortMedicineListAsc() async {
    _medicineList.sort((a, b) => b.drugName.compareTo(a.drugName));
    await setMedicineListToLocal();
    _isAZSorted = !_isAZSorted;
    notifyListeners();
  }

  Future<void> sortMedicineListDesc() async {
    _medicineList.sort((a, b) => a.drugName.compareTo(b.drugName));
    await setMedicineListToLocal();
    _isAZSorted = !_isAZSorted;
    notifyListeners();
  }

  void searchMedicineList(String query) {
    _searchResultMedicineList = _medicineList
        .where((medicine) =>
            medicine.drugName.toLowerCase().contains(query.toLowerCase()))
        .toList();
    notifyListeners();
  }

  void refreshMedicineList() async {
    setLoading(true);
    localPrefs.clear();

    await fetchData();
    setLoading(false);
  }

  void setScrollController(ScrollController scrollController) {
    localPrefs.setDouble(MedicineConstants.scroll, scrollController.offset);
    scrollController = _scrollController;
  }
}
