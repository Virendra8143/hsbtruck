class StaffDetailModel {
  String? status;
  int? responseCode;
  List<Data>? data;
  String? message;

  StaffDetailModel({this.status, this.responseCode, this.data, this.message});

  StaffDetailModel.fromJson(Map<String, dynamic> json) {
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
  String? branch;
  String? name;
  String? encPassword;
  String? phone;
  String? address;
  String? salary;
  String? aadharNumber;
  String? aadharFrontImage;
  String? aadharBackImage;
  String? shift;
  String? access;
  String? status;
  String? branchCode;

  Data(
      {this.id,
        this.role,
        this.workId,
        this.branch,
        this.name,
        this.encPassword,
        this.phone,
        this.address,
        this.salary,
        this.aadharNumber,
        this.aadharFrontImage,
        this.aadharBackImage,
        this.shift,
        this.access,
        this.status,
        this.branchCode});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    role = json['role'];
    workId = json['work_id'];
    branch = json['branch'];
    name = json['name'];
    encPassword = json['enc_password'];
    phone = json['phone'];
    address = json['address'];
    salary = json['salary'];
    aadharNumber = json['aadhar_number'];
    aadharFrontImage = json['aadhar_front_image'];
    aadharBackImage = json['aadhar_back_image'];
    shift = json['shift'];
    access = json['access'];
    status = json['status'];
    branchCode = json['branch_code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['role'] = this.role;
    data['work_id'] = this.workId;
    data['branch'] = this.branch;
    data['name'] = this.name;
    data['enc_password'] = this.encPassword;
    data['phone'] = this.phone;
    data['address'] = this.address;
    data['salary'] = this.salary;
    data['aadhar_number'] = this.aadharNumber;
    data['aadhar_front_image'] = this.aadharFrontImage;
    data['aadhar_back_image'] = this.aadharBackImage;
    data['shift'] = this.shift;
    data['access'] = this.access;
    data['status'] = this.status;
    data['branch_code'] = this.branchCode;
    return data;
  }
}
