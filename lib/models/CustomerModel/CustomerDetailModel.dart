class CustomerDetailModel {
  String? status;
  String? message;
  CustomerDetailData? data;

  CustomerDetailModel({this.status, this.message, this.data});

  factory CustomerDetailModel.fromJson(Map<String, dynamic> json) {
    return CustomerDetailModel(
      status: json['status']?.toString(),
      message: json['message']?.toString(),
      data: json['data'] != null ? CustomerDetailData.fromJson(json['data']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class CustomerDetailData {
  String? id;
  String? name;
  String? phone;
  String? aadharNumber;
  String? products;
  String? aadharFrontImage;
  String? aadharBackImage;
  String? status;
  String? createdAt;
  String? updatedAt;

  CustomerDetailData({
    this.id,
    this.name,
    this.phone,
    this.aadharNumber,
    this.products,
    this.aadharFrontImage,
    this.aadharBackImage,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  factory CustomerDetailData.fromJson(Map<String, dynamic> json) {
    return CustomerDetailData(
      id: json['id']?.toString(),
      name: json['name']?.toString(),
      phone: json['phone']?.toString(),
      aadharNumber: json['aadhar_number']?.toString(),
      products: json['products']?.toString(),
      aadharFrontImage: json['aadhar_front_image']?.toString(),
      aadharBackImage: json['aadhar_back_image']?.toString(),
      status: json['status']?.toString(),
      createdAt: json['created_at']?.toString(),
      updatedAt: json['updated_at']?.toString(),
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['phone'] = phone;
    data['aadhar_number'] = aadharNumber;
    data['products'] = products;
    data['aadhar_front_image'] = aadharFrontImage;
    data['aadhar_back_image'] = aadharBackImage;
    data['status'] = status;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }

  // CopyWith method
  CustomerDetailData copyWith({
    String? id,
    String? name,
    String? phone,
    String? aadharNumber,
    String? products,
    String? aadharFrontImage,
    String? aadharBackImage,
    String? status,
    String? createdAt,
    String? updatedAt,
  }) {
    return CustomerDetailData(
      id: id ?? this.id,
      name: name ?? this.name,
      phone: phone ?? this.phone,
      aadharNumber: aadharNumber ?? this.aadharNumber,
      products: products ?? this.products,
      aadharFrontImage: aadharFrontImage ?? this.aadharFrontImage,
      aadharBackImage: aadharBackImage ?? this.aadharBackImage,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  // Helper methods
  List<String> getProductIds() {
    if (products == null || products!.isEmpty) {
      return [];
    }
    return products!.split(',').map((id) => id.trim()).where((id) => id.isNotEmpty).toList();
  }

  bool hasAadharImages() {
    return (aadharFrontImage != null && aadharFrontImage!.isNotEmpty) ||
        (aadharBackImage != null && aadharBackImage!.isNotEmpty);
  }

  bool isActive() {
    return status?.toLowerCase() == 'active';
  }

  bool isTrashed() {
    return status?.toLowerCase() == 'trash';
  }
}