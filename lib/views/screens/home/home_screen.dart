import 'package:flutter/material.dart';
import 'package:medicine_app/core/models/medicine_model.dart';
import 'package:medicine_app/core/providers/home_provider.dart';
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
              onRefresh: () async => await homeProvider.refreshMedicineList(),
              child: ListView.builder(
                  controller: scrollController,
                  itemCount: homeProvider.medicineList.length,
                  itemBuilder: (context, index) {
                    MedicineModel medicine = homeProvider.medicineList[index];
                    return CustomListTile(medicine: medicine);
                  }),
            );
          }
        }),
      ),
    );
  }
}
