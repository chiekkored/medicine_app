import 'package:flutter/material.dart';
import 'package:medicine_app/utilities/constants/color_constant.dart';
import 'package:medicine_app/utilities/constants/sizing_constant.dart';

/// Custom Text Field.
///
/// This Widget accepts five parameters: [TextEditingController] `textFieldController`
/// for controlling the text field, [String] `hintText` for displaying hint text
/// inside the field, [bool] `readOnl` for determining if the text field is tappable
/// or not, [Widget] `suffixIcon` for displaying an icon on the end of the field, and
/// [void Function] `onTap` for representing the action if the user taps the field.
class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    super.key,
    required this.textFieldController,
    required this.hintText,
    required this.readOnly,
    this.suffixIcon,
    this.onTap,
  });

  final TextEditingController textFieldController;
  final String hintText;
  final bool readOnly;
  final Widget? suffixIcon;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: textFieldController,
      onTap: onTap,
      readOnly: readOnly,
      style: Theme.of(context).textTheme.labelMedium!.copyWith(
            fontSize: Sizing.t16,
          ),
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: Theme.of(context).textTheme.bodySmall!.copyWith(
              fontSize: Sizing.t16,
            ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(32.0),
          borderSide: const BorderSide(
            color: Colors.grey,
            width: 1.0,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(32.0),
          borderSide: const BorderSide(
            color: CColors.blue,
            width: 2.0,
          ),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(32.0),
        ),
        suffixIcon: suffixIcon,
      ),
    );
  }
}
