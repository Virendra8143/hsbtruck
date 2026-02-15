
class GetProductModel {
  String? status;
  int? responseCode;
  List<Data>? data;
  String? message;

  GetProductModel({this.status, this.responseCode, this.data, this.message});

  GetProductModel.fromJson(Map<String, dynamic> json) {
    status = json['status']?.toString() ?? '';
    responseCode = json['response_code'] ?? 0;
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    } else {
      data = [];
    }
    message = json['message']?.toString() ?? '';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status ?? '';
    data['response_code'] = responseCode ?? 0;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['message'] = message ?? '';
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
    id = json['id']?.toString() ?? '';
    code = json['code']?.toString() ?? '';
    name = json['name']?.toString() ?? '';
    brand = json['brand']?.toString() ?? '';
    unitOfMeasure = json['unit_of_measure']?.toString() ?? '';
    perPrice = json['per_price']?.toString() ?? '';
    storageCapacity = json['storage_capacity']?.toString() ?? '';
    qtyInStock = json['qty_in_stock']?.toString() ?? '';
    minQtyAlert = json['min_qty_alert']?.toString() ?? '';
    description = json['description']?.toString() ?? '';
    supplierName = json['supplier_name']?.toString() ?? '';
    status = json['status']?.toString() ?? '';
    createdDate = json['created_date']?.toString() ?? '';
    updatedDate = json['updated_date']?.toString() ?? '';
    inStock = json['in_stock']?.toString() ?? '';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id ?? '';
    data['code'] = code ?? '';
    data['name'] = name ?? '';
    data['brand'] = brand ?? '';
    data['unit_of_measure'] = unitOfMeasure ?? '';
    data['per_price'] = perPrice ?? '';
    data['storage_capacity'] = storageCapacity ?? '';
    data['qty_in_stock'] = qtyInStock ?? '';
    data['min_qty_alert'] = minQtyAlert ?? '';
    data['description'] = description ?? '';
    data['supplier_name'] = supplierName ?? '';
    data['status'] = status ?? '';
    data['created_date'] = createdDate ?? '';
    data['updated_date'] = updatedDate ?? '';
    data['in_stock'] = inStock ?? '';
    return data;
  }
}
