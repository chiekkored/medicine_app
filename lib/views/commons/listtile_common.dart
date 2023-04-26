import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:medicine_app/core/models/medicine_model.dart';
import 'package:medicine_app/core/viewmodels/home_viewmodel.dart';
import 'package:medicine_app/utilities/constants/color_constant.dart';
import 'package:medicine_app/views/screens/medicine/medicine_form_screen.dart';
import 'package:provider/provider.dart';

/// Custom List Tile
///
/// Accepts `medicine` value that is a [MedicineModel] object for displaying data,
/// and [int] value of `index` for representing the item position of the list.
class CustomListTile extends StatelessWidget {
  const CustomListTile({
    super.key,
    required this.medicine,
    required this.index,
  });

  final MedicineModel medicine;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Slidable(
      endActionPane: ActionPane(
        motion: const ScrollMotion(),
        children: [
          editWidget(),
          deleteWidget(),
        ],
      ),
      child: ListTile(
        title: Text(medicine.drugName),
        subtitle: Text(medicine.nameType),
      ),
    );
  }

  SlidableAction deleteWidget() {
    return SlidableAction(
      onPressed: (context) => Provider.of<HomeViewModel>(context, listen: false)
          .deleteMedicineList(index),
      foregroundColor: Colors.white,
      backgroundColor: Colors.red,
      icon: Icons.delete,
      label: 'Delete',
    );
  }

  SlidableAction editWidget() {
    return SlidableAction(
      onPressed: (context) => Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  MedicineFormScreen(medicine: medicine, index: index))),
      foregroundColor: Colors.white,
      backgroundColor: CColors.blue,
      icon: Icons.edit_rounded,
      label: 'Edit',
    );
  }
}
