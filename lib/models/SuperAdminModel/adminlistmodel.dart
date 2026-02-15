class AdminListModel {
  String? status;
  int? responseCode;
  List<AdminData>? data;
  String? message;

  AdminListModel({this.status, this.responseCode, this.data, this.message});

  factory AdminListModel.fromJson(Map<String, dynamic> json) {
    return AdminListModel(
      status: json['status'],
      responseCode: json['response_code'],
      data: (json['data'] as List?)?.map((item) => AdminData.fromJson(item)).toList() ?? [],
      message: json['message'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'response_code': responseCode,
      'data': data?.map((admin) => admin.toJson()).toList(),
      'message': message,
    };
  }
}

class AdminData {
  String? id;
  String? workId;
  String? name;
  String? password;
  String? phone;
  String? branch;
  String? status;
  String? createdDate;
  String? branchName;

  AdminData({
    this.id,
    this.workId,
    this.name,
    this.password,
    this.phone,
    this.branch,
    this.status,
    this.createdDate,
    this.branchName,
  });

  factory AdminData.fromJson(Map<String, dynamic> json) {
    return AdminData(
      id: json['id'],
      workId: json['work_id'],
      name: json['name'],
      password: json['password'],
      phone: json['phone'],
      branch: json['branch'],
      status: json['status'],
      createdDate: json['created_date'],
      branchName: json['branch_name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'work_id': workId,
      'name': name,
      'password': password,
      'phone': phone,
      'branch': branch,
      'status': status,
      'created_date': createdDate,
      'branch_name': branchName,
    };
  }
}
