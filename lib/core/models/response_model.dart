import 'dart:convert';

import 'package:medicine_app/core/models/medicine_model.dart';

class ResponseModel {
  List<MedicineModel> data;
  Map<String, dynamic> metadata;
  ResponseModel({
    required this.data,
    required this.metadata,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'data': data.map((x) => x.toMap()).toList(),
      'metadata': metadata,
    };
  }

  factory ResponseModel.fromMap(Map<String, dynamic> map) {
    return ResponseModel(
        data: List<MedicineModel>.from(
          (map['data'] as List<dynamic>).map<MedicineModel>(
            (x) => MedicineModel.fromMap(x as Map<String, dynamic>),
          ),
        ),
        metadata: Map<String, dynamic>.from(
          (map['metadata'] as Map<String, dynamic>),
        ));
  }

  String toJson() => json.encode(toMap());

  factory ResponseModel.fromJson(String source) =>
      ResponseModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
