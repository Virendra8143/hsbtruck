class branchlist {
  String? status;
  int? responseCode;
  List<Data>? data;
  String? message;

  branchlist({this.status, this.responseCode, this.data, this.message});

  branchlist.fromJson(Map<String, dynamic> json) {
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
  String? branchId;
  String? name;
  String? address;
  String? status;
  String? createdDate;
  String? updatedDate;

  Data(
      {this.id,
        this.branchId,
        this.name,
        this.address,
        this.status,
        this.createdDate,
        this.updatedDate});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    branchId = json['branch_id'];
    name = json['name'];
    address = json['address'];
    status = json['status'];
    createdDate = json['created_date'];
    updatedDate = json['updated_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['branch_id'] = this.branchId;
    data['name'] = this.name;
    data['address'] = this.address;
    data['status'] = this.status;
    data['created_date'] = this.createdDate;
    data['updated_date'] = this.updatedDate;
    return data;
  }
}