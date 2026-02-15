class GetSchemeLIstModel {
  String? status;
  int? responseCode;
  List<Data>? data;
  String? message;

  GetSchemeLIstModel({this.status, this.responseCode, this.data, this.message});

  GetSchemeLIstModel.fromJson(Map<String, dynamic> json) {
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
  String? name;
  String? vehicleType;
  String? product;
  String? literRange;
  String? gifts;
  String? qty;
  String? status;
  String? createdDate;
  String? updatedDate;
  String? productCode;
  String? productName;

  Data(
      {this.id,
        this.name,
        this.vehicleType,
        this.product,
        this.literRange,
        this.gifts,
        this.qty,
        this.status,
        this.createdDate,
        this.updatedDate,
        this.productCode,
        this.productName});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    vehicleType = json['vehicle_type'];
    product = json['product'];
    literRange = json['liter_range'];
    gifts = json['gifts'];
    qty = json['qty'];
    status = json['status'];
    createdDate = json['created_date'];
    updatedDate = json['updated_date'];
    productCode = json['product_code'];
    productName = json['product_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['vehicle_type'] = this.vehicleType;
    data['product'] = this.product;
    data['liter_range'] = this.literRange;
    data['gifts'] = this.gifts;
    data['qty'] = this.qty;
    data['status'] = this.status;
    data['created_date'] = this.createdDate;
    data['updated_date'] = this.updatedDate;
    data['product_code'] = this.productCode;
    data['product_name'] = this.productName;
    return data;
  }
}
