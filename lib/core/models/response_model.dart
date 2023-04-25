import 'dart:convert';

import 'package:medicine_app/core/models/medicine_model.dart';
import 'package:medicine_app/utilities/constants/connection_contant.dart';

class ResponseModel {
  ConnectionStatus status;
  MedicineModel data;
  ResponseModel({
    required this.status,
    required this.data,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'status': status.toString(),
      'data': data.toMap(),
    };
  }

  factory ResponseModel.fromMap(Map<String, dynamic> map) {
    return ResponseModel(
      status: ConnectionStatus.values.byName(map['status']),
      data: MedicineModel.fromMap(map['data'] as Map<String, dynamic>),
    );
  }

  String toJson() => json.encode(toMap());

  factory ResponseModel.fromJson(String source) =>
      ResponseModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
