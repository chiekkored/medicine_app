import 'dart:async';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:medicine_app/core/models/medicine_model.dart';
import 'package:medicine_app/core/models/response_model.dart';
import 'package:medicine_app/core/services/http_service.dart';
import 'package:medicine_app/main.dart';
import 'package:medicine_app/utilities/constants/medicine_constant.dart';
import 'package:medicine_app/utilities/constants/url_contant.dart';

class HomeViewModel extends ChangeNotifier {
  // Initialization of provider values
  bool _isLoading = true;
  bool _isAZSorted = false;
  List<MedicineModel> _medicineList = [];
  List<MedicineModel> _searchResultMedicineList = [];
  ScrollController _scrollController = ScrollController();

  // Getters for provider values
  bool get isLoading => _isLoading;
  bool get isAZSorted => _isAZSorted;
  List<MedicineModel> get medicineList => _medicineList;
  List<MedicineModel> get searchResultMedicineList => _searchResultMedicineList;
  ScrollController get scrollController => _scrollController;

  /// Sets the page in loading state.
  ///
  /// This function accepts a [bool] value as its parameter for determining if
  /// the page is in loading state or not.
  void setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  /// Gets the data from an API and sets it to `_medicineList` variable.
  ///
  /// This function does not return any value(s).
  Future<void> fetchData() async {
    // Set loading to true
    _isLoading = true;

    // Get data from local cache storage
    String? medicineListData =
        localPrefs.getString(MedicineConstants.medicineList);
    double? scrollController = localPrefs.getDouble(MedicineConstants.scroll);

    // Initialize scroll controller from the local data if exist
    _scrollController =
        ScrollController(initialScrollOffset: scrollController ?? 0.0);

    // If a local cache for medicine list exist
    if (medicineListData != null) {
      ResponseModel responseModel = ResponseModel.fromJson(medicineListData);
      // Set to provider variable
      _medicineList = responseModel.data;
    } else {
      // If local cache does not exist, GET from API
      Response response = await Http.get(Endpoints.drugnames);

      if (response.statusCode == 200) {
        // Set to provider variable
        ResponseModel responseModel = ResponseModel.fromJson(response.body);
        _medicineList = responseModel.data;

        // Add medicine list to local cache
        await setMedicineListToLocal();
      } else {
        // Throw Exception if response has error
        throw Exception('Failed to get data.');
      }
    }

    // Set loading to false
    _isLoading = false;
  }

  /// Adds an element to medicine list
  ///
  /// This function accepts one parameter: The parameter `medicine`, which is an
  /// object of type [MedicineModel] representing the medicine data to be added in the list.
  Future<void> addMedicineList(MedicineModel medicine) async {
    // Insert medicine item to list
    _medicineList.insert(0, medicine);
    // Set the local cache with the new list
    await setMedicineListToLocal();
    notifyListeners();
  }

  /// Updates an element to medicine list
  ///
  /// This function accepts two parameters: The parameter `medicine`, which is an
  /// object of type [MedicineModel] representing the medicine data to be updted in the list,
  /// and `index`, which is an [int] representing the index of the medicine item
  /// in the list.
  Future<void> updateMedicineList(MedicineModel medicine, int index) async {
    // Update the medicine item
    _medicineList[index] = medicine;

    // Commented this block because there's is no API for updating this dummy API
    // Response response =
    //     await Http.put(Endpoints.updateDrug, body: medicine.toMap());

    // Set the local cache with the new list
    await setMedicineListToLocal();
    notifyListeners();
  }

  /// Deletes an element to medicine list.
  ///
  /// This function accepts one parameter: The parameter `index`, which is an
  /// [int] representing the index of the medicine item in the list.
  Future<void> deleteMedicineList(int index) async {
    // Remove medicine item to list
    _medicineList.removeAt(index);

    // Commented this block because there's is no API for deleting this dummy API
    // Response response =
    //     await Http.post(Endpoints.deleteDrug, body: medicine.toMap());

    // Set the local cache with the new list
    await setMedicineListToLocal();
    notifyListeners();
  }

  /// Sets the current provider variable, `_medicineList`, to local cache.
  ///
  /// This function does not have any parameters.
  Future<void> setMedicineListToLocal() async {
    // Sets the medicine list to shared_preferences
    await localPrefs.setString(MedicineConstants.medicineList,
        ResponseModel(data: _medicineList).toJson());
    notifyListeners();
  }

  /// Sorts medicine list to Ascending order.
  ///
  /// This function does not have any parameters.
  Future<void> sortMedicineListAsc() async {
    // Sort list by comparing each item name to another item name
    _medicineList.sort((a, b) => b.drugName.compareTo(a.drugName));
    // Set the local cache with the new list
    await setMedicineListToLocal();
    // Set the provider variable if the list is currently sorted or not
    _isAZSorted = !_isAZSorted;
    notifyListeners();
  }

  /// Sorts medicine list to Ascending order.
  ///
  /// This function does not have any parameters.
  Future<void> sortMedicineListDesc() async {
    // Sort list by comparing each item name to another item name
    _medicineList.sort((a, b) => a.drugName.compareTo(b.drugName));
    // Set the local cache with the new list
    await setMedicineListToLocal();
    // Set the provider variable if the list is currently sorted or not
    _isAZSorted = !_isAZSorted;
    notifyListeners();
  }

  /// Sorts medicine list to Ascending order.
  ///
  /// This function takes one paramter: `query`, which is a [String] representing
  /// the text to be queried for searching.
  void searchMedicineList(String query) {
    // Find the list that matched the provided query
    _searchResultMedicineList = _medicineList
        .where((medicine) =>
            medicine.drugName.toLowerCase().contains(query.toLowerCase()))
        .toList();
    notifyListeners();
  }

  /// Refreshes/Reloads medicine list from API.
  ///
  /// This function does not have any parameters.
  void refreshMedicineList() async {
    // Set loading provider to true
    setLoading(true);
    // Clear local cache
    localPrefs.clear();

    // Fetch/Get data again
    await fetchData();
    // Set loading provider to false
    setLoading(false);
  }

  /// Sets the scroll controller value for persistent scrolling.
  ///
  /// This function takes one parameter: `scrollController`, which is an object
  /// of a type [ScrollController] representing the values of where the user's
  /// scroll position.
  void setScrollController(ScrollController scrollController) {
    localPrefs.setDouble(MedicineConstants.scroll, scrollController.offset);
    scrollController = _scrollController;
  }
}
