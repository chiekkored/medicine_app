import 'package:flutter/material.dart';
import 'package:medicine_app/core/models/medicine_model.dart';
import 'package:medicine_app/core/providers/home_provider.dart';
import 'package:medicine_app/views/commons/progress_indicator_common.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Consumer<HomeProvider>(builder: (context, homeProvider, _) {
          if (homeProvider.isLoading) {
            print("object");
            return const Center(
              child: CustomProgressIndicator(),
            );
          } else {
            return ListView.builder(
                itemCount: homeProvider.medicineList.length,
                itemBuilder: (context, index) {
                  MedicineModel medicine = homeProvider.medicineList[index];
                  return ListTile(
                    title: Text(medicine.drugName),
                    subtitle: Text(medicine.nameType),
                  );
                });
          }
        }),
      ),
    );
  }
}
