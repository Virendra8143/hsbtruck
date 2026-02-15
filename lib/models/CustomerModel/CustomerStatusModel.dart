// CustomerStatusModel.dart - FIXED VERSION
class CustomerStatusResponseModel {
  final String? status;
  final int? responseCode;
  final dynamic data; // CHANGED TO dynamic (accepts bool, Map, etc.)
  final String? message;

  CustomerStatusResponseModel({
    this.status,
    this.responseCode,
    this.data,
    this.message,
  });

  factory CustomerStatusResponseModel.fromJson(Map<String, dynamic> json) {
    return CustomerStatusResponseModel(
      status: json['status'],
      responseCode: json['response_code'],
      data: json['data'], // Can be bool, Map, List, etc.
      message: json['message'],
    );
  }
}