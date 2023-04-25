// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:medicine_app/core/models/medicine_model.dart';

class ResponseModel {
  List<MedicineModel> data;
  Map<String, dynamic>? metadata;
  ResponseModel({
    required this.data,
    this.metadata,
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
      metadata: map['metadata'] != null
          ? Map<String, dynamic>.from((map['metadata'] as Map<String, dynamic>))
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory ResponseModel.fromJson(String source) =>
      ResponseModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
