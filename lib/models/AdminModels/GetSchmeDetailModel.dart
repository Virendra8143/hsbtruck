class GetSchmeDetailModel {
  String? status;
  int? responseCode;
  List<Data>? data;
  String? message;

  GetSchmeDetailModel(
      {this.status, this.responseCode, this.data, this.message});

  GetSchmeDetailModel.fromJson(Map<String, dynamic> json) {
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
  String? createdDate;
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
      this.createdDate,
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
    createdDate = json['created_date'];
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
    data['created_date'] = this.createdDate;
    data['product_code'] = this.productCode;
    data['product_name'] = this.productName;
    return data;
  }
}