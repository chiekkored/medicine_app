import 'dart:convert';

import 'package:medicine_app/utilities/constants/medicine_constant.dart';

class MedicineModel {
  NameType nameType;
  String drugName;
  MedicineModel({
    required this.nameType,
    required this.drugName,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'nameType': nameType,
      'drugName': drugName,
    };
  }

  factory MedicineModel.fromMap(Map<String, dynamic> map) {
    return MedicineModel(
      nameType: NameType.values.byName(map["nameType"]),
      drugName: map['drugName'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory MedicineModel.fromJson(String source) =>
      MedicineModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
