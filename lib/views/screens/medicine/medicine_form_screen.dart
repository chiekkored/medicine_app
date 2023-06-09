import 'package:flutter/material.dart';
import 'package:medicine_app/core/extensions/string_extension.dart';
import 'package:medicine_app/core/models/medicine_model.dart';
import 'package:medicine_app/core/viewmodels/home_viewmodel.dart';
import 'package:medicine_app/utilities/constants/medicine_constant.dart';
import 'package:medicine_app/utilities/constants/sizing_constant.dart';
import 'package:medicine_app/views/commons/popup_common.dart';
import 'package:medicine_app/views/commons/text_common.dart';
import 'package:medicine_app/views/commons/textfield_common.dart';
import 'package:provider/provider.dart';

class MedicineFormScreen extends StatelessWidget {
  MedicineFormScreen({
    super.key,
    this.medicine,
    this.index,
  });

  final MedicineModel? medicine;
  final int? index;
  final TextEditingController drugNameController = TextEditingController();
  final TextEditingController nameTypeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // If medicne value is provided, populate text fields
    if (medicine != null) {
      drugNameController.text = medicine!.drugName;
      nameTypeController.text =
          medicine!.nameType == "B" ? "Branded" : "Generic";
    }
    HomeViewModel homeViewModel = Provider.of<HomeViewModel>(context);
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(
            horizontal: Sizing.w16, vertical: Sizing.w16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.only(bottom: Sizing.h8),
              child: CustomTextBold(
                text: "Drug Name",
                fontSize: Sizing.t22,
              ),
            ),
            CustomTextFormField(
              textFieldController: drugNameController,
              hintText: "Enter drug name",
              readOnly: false,
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: Sizing.w16),
              child: CustomTextBold(
                text: "Name Type",
                fontSize: Sizing.t22,
              ),
            ),
            // Popup for Name type
            Builder(
              builder: (context) {
                return CustomTextFormField(
                  readOnly: true,
                  onTap: () async {
                    String? nameType =
                        await customShowModelBottomSheet(context);
                    if (nameType != null) nameTypeController.text = nameType;
                    FocusManager.instance.primaryFocus?.unfocus();
                  },
                  textFieldController: nameTypeController,
                  hintText: "Enter drug name type",
                );
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(Sizing.w16),
        child: Row(
          children: [
            // Cancel button
            Expanded(
              child: OutlinedButton(
                onPressed: () => Navigator.pop(context),
                child: const Text("Cancel"),
              ),
            ),
            const SizedBox(
              width: 16.0,
            ),
            // Submit button
            Expanded(
              child: ElevatedButton(
                onPressed: () {
                  // Textfield validation
                  if (drugNameController.text.isNotEmpty &&
                      nameTypeController.text.isNotEmpty) {
                    MedicineModel medicineForm = MedicineModel(
                        nameType:
                            nameTypeController.text == "Branded" ? "B" : "G",
                        drugName: drugNameController.text);
                    // If medicine value is provided, just update data
                    if (medicine != null) {
                      homeViewModel.updateMedicineList(medicineForm, index!);
                    } else {
                      // If medicine value is NOT provided, add item to data
                      homeViewModel.addMedicineList(medicineForm);
                    }
                    Navigator.pop(context);
                  } else {
                    // Show dialog error
                    customShowCustomDialog(context,
                        title: "Input missing",
                        content: "All fields must be provided and filled.",
                        buttonText: "Okay");
                  }
                },
                child: const Text("Submit"),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<String?> customShowModelBottomSheet(BuildContext context) {
    return showModalBottomSheet(
        enableDrag: true,
        context: context,
        builder: (context) {
          return ListView(
            shrinkWrap: true,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: Sizing.w16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    CustomTextBold(text: "Select Name Type", fontSize: 16.0),
                    CloseButton(),
                  ],
                ),
              ),
              const Divider(),
              // Branded item
              ListTile(
                onTap: () => Navigator.pop(context, "Branded"),
                leading: const Icon(
                  Icons.local_pharmacy_rounded,
                  color: Colors.blue,
                  size: 32.0,
                ),
                contentPadding: const EdgeInsets.symmetric(
                    vertical: Sizing.h8, horizontal: Sizing.w16),
                title: CustomTextNormal(
                    text: MedicineConstants.branded.capitalizeFirstLetter,
                    fontSize: 16.0),
                subtitle: const CustomTextNormal(
                    text:
                        "A drug sold by a drug company under a specific name or trademark and that is protected by a patent",
                    fontSize: 12.0),
              ),
              // Generic item
              ListTile(
                onTap: () => Navigator.pop(
                    context, MedicineConstants.generic.capitalizeFirstLetter),
                leading: const Icon(
                  Icons.local_pharmacy_rounded,
                  color: Colors.amber,
                  size: 32.0,
                ),
                contentPadding: const EdgeInsets.symmetric(
                    vertical: Sizing.h8, horizontal: Sizing.w16),
                title: const CustomTextNormal(text: "Generic", fontSize: 16.0),
                subtitle: const CustomTextNormal(
                    text:
                        "A generic drug is a medication created to be the same as an already marketed brand-name drug in dosage form, safety, strength, route of administration, quality, performance characteristics, and intended use.",
                    fontSize: 12.0),
              )
            ],
          );
        });
  }
}
