import 'package:flutter/material.dart';
import 'package:medicine_app/core/models/medicine_model.dart';
import 'package:medicine_app/core/providers/home_provider.dart';
import 'package:medicine_app/utilities/constants/color_constant.dart';
import 'package:medicine_app/views/commons/listtile_common.dart';
import 'package:medicine_app/views/commons/progress_indicator_common.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    late ScrollController scrollController;
    return SafeArea(
      child: Scaffold(
        body: Consumer<HomeProvider>(builder: (context, homeProvider, _) {
          if (homeProvider.isLoading) {
            return const Center(child: CustomProgressIndicator());
          } else {
            scrollController = homeProvider.scrollController;
            scrollController.addListener(
                () => homeProvider.setScrollController(scrollController));
            return RefreshIndicator(
              onRefresh: () async => homeProvider.refreshMedicineList(),
              child: SingleChildScrollView(
                controller: scrollController,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    sortWidget(homeProvider),
                    listWidget(homeProvider),
                  ],
                ),
              ),
            );
          }
        }),
      ),
    );
  }

  ListView listWidget(HomeProvider homeProvider) {
    return ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: homeProvider.medicineList.length,
        itemBuilder: (context, index) {
          MedicineModel medicine = homeProvider.medicineList[index];
          return CustomListTile(medicine: medicine);
        });
  }

  Padding sortWidget(HomeProvider homeProvider) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          GestureDetector(
            onTap: () {
              if (homeProvider.isAZSorted) {
                homeProvider.sortMedicineListDesc();
              } else {
                homeProvider.sortMedicineListAsc();
              }
            },
            child: Row(
              children: [
                const Text(
                  "SORT",
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                    color: CColors.blue,
                  ),
                ),
                const SizedBox(
                  width: 2.0,
                ),
                Icon(
                  homeProvider.isAZSorted
                      ? Icons.south_rounded
                      : Icons.north_rounded,
                  size: 16.0,
                  color: CColors.blue,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
