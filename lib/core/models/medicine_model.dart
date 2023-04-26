import 'dart:convert';

class MedicineModel {
  String nameType;
  String drugName;
  MedicineModel({
    required this.nameType,
    required this.drugName,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name_type': nameType,
      'drug_name': drugName,
    };
  }

  factory MedicineModel.fromMap(Map<String, dynamic> map) {
    return MedicineModel(
      nameType: map['name_type'] as String,
      drugName: map['drug_name'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory MedicineModel.fromJson(String source) =>
      MedicineModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
