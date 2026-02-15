class UpdateAdminStatus {
  final String status;
  final int responseCode;
  final bool data;
  final String message;

  UpdateAdminStatus({
    required this.status,
    required this.responseCode,
    required this.data,
    required this.message,
  });

  factory UpdateAdminStatus.fromJson(Map<String, dynamic> json) {
    return UpdateAdminStatus(
      status: json['status'] ?? '',
      responseCode: json['response_code'] ?? 0,
      data: json['data'] ?? false,
      message: json['message'] ?? '',
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
