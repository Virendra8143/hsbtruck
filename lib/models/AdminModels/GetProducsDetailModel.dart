
class GetProductDetailModel {
  String? status;
  int? responseCode;
  List<Data>? data;
  String? message;

  GetProductDetailModel({
    this.status,
    this.responseCode,
    this.data,
    this.message,
  });

  GetProductDetailModel.fromJson(Map<String, dynamic> json) {
    status = json['status'] ?? '';
    responseCode = json['response_code'] ?? 0;
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    } else {
      data = [];
    }
    message = json['message'] ?? '';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
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
  String? code;
  String? name;
  String? brand;
  String? unitOfMeasure;
  String? perPrice;
  String? storageCapacity;
  String? qtyInStock;
  String? minQtyAlert;
  String? description;
  String? supplierName;
  String? status;
  String? createdDate;
  String? updatedDate;
  String? inStock;

  Data({
    this.id,
    this.code,
    this.name,
    this.brand,
    this.unitOfMeasure,
    this.perPrice,
    this.storageCapacity,
    this.qtyInStock,
    this.minQtyAlert,
    this.description,
    this.supplierName,
    this.status,
    this.createdDate,
    this.updatedDate,
    this.inStock,
  });

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? '';
    code = json['code'] ?? '';
    name = json['name'] ?? '';
    brand = json['brand'] ?? '';
    unitOfMeasure = json['unit_of_measure'] ?? '';
    perPrice = json['per_price'] ?? '';
    storageCapacity = json['storage_capacity'] ?? '';
    qtyInStock = json['qty_in_stock'] ?? '';
    minQtyAlert = json['min_qty_alert'] ?? '';
    description = json['description'] ?? '';
    supplierName = json['supplier_name'] ?? '';
    status = json['status'] ?? '';
    createdDate = json['created_date'] ?? '';
    updatedDate = json['updated_date'] ?? '';
    inStock = json['in_stock'] ?? '';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['code'] = code;
    data['name'] = name;
    data['brand'] = brand;
    data['unit_of_measure'] = unitOfMeasure;
    data['per_price'] = perPrice;
    data['storage_capacity'] = storageCapacity;
    data['qty_in_stock'] = qtyInStock;
    data['min_qty_alert'] = minQtyAlert;
    data['description'] = description;
    data['supplier_name'] = supplierName;
    data['status'] = status;
    data['created_date'] = createdDate;
    data['updated_date'] = updatedDate;
    data['in_stock'] = inStock;
    return data;
  }
}

