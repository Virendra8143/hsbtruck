// models/AdminModels/GiftModels.dart

class GiftListModel {
  String? status;
  int? responseCode;
  List<GiftData>? data;
  String? message;

  GiftListModel({this.status, this.responseCode, this.data, this.message});

  GiftListModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    responseCode = json['response_code'];
    if (json['data'] != null) {
      data = <GiftData>[];
      json['data'].forEach((v) {
        data!.add(GiftData.fromJson(v));
      });
    }
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['response_code'] = responseCode;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['message'] = message;
    return data;
  }
}

class GiftData {
  String? id;
  String? name;
  String? quantity;
  String? type; // Add this field
  String? status;
  String? createdDate;
  String? updatedDate;

  GiftData({
    this.id,
    this.name,
    this.quantity,
    this.type, // Add this
    this.status,
    this.createdDate,
    this.updatedDate,
  });

  GiftData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    quantity = json['quantity'];
    type = json['type']; // Add this
    status = json['status'];
    createdDate = json['created_date'];
    updatedDate = json['updated_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['quantity'] = quantity;
    data['type'] = type; // Add this
    data['status'] = status;
    data['created_date'] = createdDate;
    data['updated_date'] = updatedDate;
    return data;
  }
}

class GiftDetailModel {
  String? status;
  int? responseCode;
  List<GiftData>? data;
  String? message;

  GiftDetailModel({this.status, this.responseCode, this.data, this.message});

  GiftDetailModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    responseCode = json['response_code'];
    if (json['data'] != null) {
      data = <GiftData>[];
      json['data'].forEach((v) {
        data!.add(GiftData.fromJson(v));
      });
    }
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['response_code'] = responseCode;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['message'] = message;
    return data;
  }
}

class GiftCreateUpdateModel {
  String? status;
  int? responseCode;
  bool? data;
  String? message;

  GiftCreateUpdateModel({this.status, this.responseCode, this.data, this.message});

  GiftCreateUpdateModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    responseCode = json['response_code'];
    data = json['data'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['response_code'] = responseCode;
    data['data'] = this.data;
    data['message'] = message;
    return data;
  }
}