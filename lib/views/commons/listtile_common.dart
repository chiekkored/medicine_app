import 'package:flutter/material.dart';
import 'package:medicine_app/core/models/medicine_model.dart';

class CustomListTile extends StatelessWidget {
  const CustomListTile({
    super.key,
    required this.medicine,
  });

  final MedicineModel medicine;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(medicine.drugName),
      subtitle: Text(medicine.nameType),
    );
  }
}
