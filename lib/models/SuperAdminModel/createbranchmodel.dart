class createbranch {
  String? status;
  int? responseCode;
  bool? data;
  String? message;

  createbranch({this.status, this.responseCode, this.data, this.message});

  createbranch.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    responseCode = json['response_code'];
    data = json['data'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['response_code'] = this.responseCode;
    data['data'] = this.data;
    data['message'] = this.message;
    return data;
  }
}