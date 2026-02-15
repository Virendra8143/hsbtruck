class LoginUserModel {
  String? status;
  int? responseCode;
  Data? data;
  String? message;

  LoginUserModel({this.status, this.responseCode, this.data, this.message});

  LoginUserModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    responseCode = json['response_code'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['response_code'] = this.responseCode;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['message'] = this.message;
    return data;
  }
}

class Data {
  String? id;
  String? workId;
  String? name;
  String? accessToken;
  String? lastLogin;

  Data({this.id, this.workId, this.name, this.accessToken, this.lastLogin});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    workId = json['work_id'];
    name = json['name'];
    accessToken = json['access_token'];
    lastLogin = json['last_login'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['work_id'] = this.workId;
    data['name'] = this.name;
    data['access_token'] = this.accessToken;
    data['last_login'] = this.lastLogin;
    return data;
  }
}
