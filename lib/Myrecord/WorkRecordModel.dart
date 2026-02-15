// models/WorkRecordModel.dart
import 'dart:convert';

class WorkRecordModel {
  String? status;
  int? responseCode;
  List<WorkRecordData>? data;
  String? message;

  WorkRecordModel({
    this.status,
    this.responseCode,
    this.data,
    this.message,
  });

  factory WorkRecordModel.fromJson(Map<String, dynamic> json) {
    var dataList = json['data'] as List?;

    return WorkRecordModel(
      status: json['status'],
      responseCode: json['response_code'],
      data: dataList != null
          ? dataList.map((item) => WorkRecordData.fromJson(item)).toList()
          : [],
      message: json['message'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['response_code'] = responseCode;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['message'] = message;
    return data;
  }
}

class WorkRecordData {
  String? date;
  dynamic openingReading; // Changed to dynamic to handle both String and int
  dynamic closingReading; // Changed to dynamic to handle both String and int
  List<WorkRecord>? records;

  WorkRecordData({
    this.date,
    this.openingReading,
    this.closingReading,
    this.records,
  });

  factory WorkRecordData.fromJson(Map<String, dynamic> json) {
    var recordsList = json['records'] as List?;
    return WorkRecordData(
      date: json['date']?.toString(),
      openingReading: json['opening_reading'],
      closingReading: json['closing_reading'],
      records: recordsList != null
          ? recordsList.map((item) => WorkRecord.fromJson(item)).toList()
          : [],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['date'] = date;
    data['opening_reading'] = openingReading;
    data['closing_reading'] = closingReading;
    if (records != null) {
      data['records'] = records!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class WorkRecord {
  String? productId;
  String? unitOfMeasure;
  String? totalQty;
  String? totalAmount;
  String? productCode;
  String? productName;

  WorkRecord({
    this.productId,
    this.unitOfMeasure,
    this.totalQty,
    this.totalAmount,
    this.productCode,
    this.productName,
  });

  factory WorkRecord.fromJson(Map<String, dynamic> json) {
    return WorkRecord(
      productId: json['product_id']?.toString(),
      unitOfMeasure: json['unit_of_measure'],
      totalQty: json['total_qty'],
      totalAmount: json['total_amount'],
      productCode: json['product_code'],
      productName: json['product_name'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['product_id'] = productId;
    data['unit_of_measure'] = unitOfMeasure;
    data['total_qty'] = totalQty;
    data['total_amount'] = totalAmount;
    data['product_code'] = productCode;
    data['product_name'] = productName;
    return data;
  }
}