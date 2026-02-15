// models/AdminModels/GetLubeModel.dart
class GetLubeModel {
  String? status;
  int? responseCode;
  List<LubeData>? data;
  String? message;

  GetLubeModel({
    this.status,
    this.responseCode,
    this.data,
    this.message,
  });

  GetLubeModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    responseCode = json['response_code'];
    if (json['data'] != null) {
      data = <LubeData>[];
      json['data'].forEach((v) {
        data!.add(LubeData.fromJson(v));
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

class LubeData {
  String? id; // Changed from int? to String?
  String? code;
  String? name;
  String? brand;
  String? createdAt;
  String? updatedAt;

  LubeData({
    this.id,
    this.code,
    this.name,
    this.brand,
    this.createdAt,
    this.updatedAt,
  });

  LubeData.fromJson(Map<String, dynamic> json) {
    id = json['id']?.toString(); // Convert to string to handle both string and int
    code = json['code'];
    name = json['name'];
    brand = json['brand'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['code'] = code;
    data['name'] = name;
    data['brand'] = brand;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}