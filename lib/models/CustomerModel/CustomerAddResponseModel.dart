class CustomerAddResponseModel {
  String? status;
  String? message;
  dynamic data; // Change from CustomerResponseData? to dynamic

  CustomerAddResponseModel({this.status, this.message, this.data});

  factory CustomerAddResponseModel.fromJson(Map<String, dynamic> json) {
    return CustomerAddResponseModel(
      status: json['status']?.toString(),
      message: json['message']?.toString(),
      data: json['data'], // Just assign directly, don't try to parse as CustomerResponseData
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    data['data'] = this.data;
    return data;
  }
}

// You can keep this class for when data is actually an object
class CustomerResponseData {
  String? id;
  String? name;
  String? phone;
  String? aadharNumber;
  String? products;
  String? aadharFrontImage;
  String? aadharBackImage;
  String? status;
  String? createdAt;

  CustomerResponseData({
    this.id,
    this.name,
    this.phone,
    this.aadharNumber,
    this.products,
    this.aadharFrontImage,
    this.aadharBackImage,
    this.status,
    this.createdAt,
  });

  factory CustomerResponseData.fromJson(Map<String, dynamic> json) {
    return CustomerResponseData(
      id: json['id']?.toString(),
      name: json['name']?.toString(),
      phone: json['phone']?.toString(),
      aadharNumber: json['aadhar_number']?.toString(),
      products: json['products']?.toString(),
      aadharFrontImage: json['aadhar_front_image']?.toString(),
      aadharBackImage: json['aadhar_back_image']?.toString(),
      status: json['status']?.toString(),
      createdAt: json['created_at']?.toString(),
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
    return data;
  }
}