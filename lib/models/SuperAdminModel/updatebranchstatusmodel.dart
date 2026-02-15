class UpdateBranchStatus {
  String? status;
  int? responseCode;
  bool? data;
  String? message;

  UpdateBranchStatus({this.status, this.responseCode, this.data, this.message});

  // ✅ Factory constructor to create object from JSON
  factory UpdateBranchStatus.fromJson(Map<String, dynamic> json) {
    return UpdateBranchStatus(
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
