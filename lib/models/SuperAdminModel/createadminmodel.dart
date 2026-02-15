class CreateAdminModel {
  String? status;
  int? responseCode;
  bool? data;
  String? message;

  CreateAdminModel({this.status, this.responseCode, this.data, this.message});

  factory CreateAdminModel.fromJson(Map<String, dynamic> json) {
    return CreateAdminModel(
      status: json['status'],
      responseCode: json['response_code'],
      data: json['data'],
      message: json['message'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'response_code': responseCode,
      'data': data,
      'message': message,
    };
  }
}
