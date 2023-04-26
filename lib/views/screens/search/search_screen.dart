import 'package:flutter/material.dart';
import 'package:medicine_app/core/models/medicine_model.dart';
import 'package:medicine_app/core/providers/home_provider.dart';
import 'package:medicine_app/views/commons/listtile_common.dart';
import 'package:provider/provider.dart';

class SearchScreen extends StatelessWidget {
  SearchScreen({super.key});

  final TextEditingController searchQueryController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    List<MedicineModel> resultList = [];
    HomeProvider homeProvider =
        Provider.of<HomeProvider>(context, listen: true);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: const BackButton(
          color: Colors.black,
        ),

        // NOTE Please use emulator/physical phone keyboard
        // Pressing backspace when field is empty, fires a Flutter error
        // https://github.com/flutter/flutter/issues/122441
        // https://stackoverflow.com/questions/69113977/getting-assertion-failed-pressedkeys-containskeyevent-physicalkey-error-in
        title: TextField(
          controller: searchQueryController,
          autofocus: true,
          onChanged: (value) => homeProvider.searchMedicineList(value),
          decoration: InputDecoration(
              border: InputBorder.none,
              hintText: 'Search',
              suffixIcon: GestureDetector(
                  onTap: () => searchQueryController.text = "",
                  child: const Icon(Icons.close)),
              suffixIconColor: Colors.grey),
        ),
      ),
      body: Consumer<HomeProvider>(builder: (context, homeProvider, _) {
        searchQueryController.text.isEmpty
            ? resultList.clear()
            : resultList.addAll(homeProvider.searchResultMedicineList);
        return ListView.builder(
            itemCount: resultList.length,
            itemBuilder: (context, index) {
              MedicineModel medicine = resultList[index];
              return CustomListTile(medicine: medicine);
            });
      }),
    );
  }
}
