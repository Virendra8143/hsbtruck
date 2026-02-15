class BranchUpdateResponse {
  final String status;
  final int responseCode;
  final bool data;
  final String message;

  BranchUpdateResponse({
    required this.status,
    required this.responseCode,
    required this.data,
    required this.message,
  });

  factory BranchUpdateResponse.fromJson(Map<String, dynamic> json) {
    return BranchUpdateResponse(
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

class BranchUpdateRequest {
  final int id;
  final String name;
  final String address;

  BranchUpdateRequest({
    required this.id,
    required this.name,
    required this.address,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'address': address,
    };
  }
}