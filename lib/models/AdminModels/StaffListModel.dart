class StaffListModel {
  String? status;
  int? responseCode;
  List<Data>? data;
  String? message;

  StaffListModel({this.status, this.responseCode, this.data, this.message});

  StaffListModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    responseCode = json['response_code'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['response_code'] = this.responseCode;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['message'] = this.message;
    return data;
  }
}

class Data {
  String? id;
  String? role;
  String? workId;
  String? name;
  String? status;

  Data({this.id, this.role, this.workId, this.name, this.status});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    role = json['role'];
    workId = json['work_id'];
    name = json['name'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['role'] = this.role;
    data['work_id'] = this.workId;
    data['name'] = this.name;
    data['status'] = this.status;
    return data;
  }
}
