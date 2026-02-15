
class CustomerDetailModel {
  String? status;
  int? responseCode;
  List<CustomerData>? data;
  String? message;

  CustomerDetailModel({
    this.status,
    this.responseCode,
    this.data,
    this.message,
  });

  factory CustomerDetailModel.fromJson(Map<String, dynamic> json) {
    return CustomerDetailModel(
      status: json['status']?.toString(),
      responseCode: json['response_code'] is int
          ? json['response_code']
          : int.tryParse(json['response_code']?.toString() ?? ''),
      data: json['data'] == null
          ? []
          : (json['data'] is List
          ? (json['data'] as List)
          .map((e) => CustomerData.fromJson(e))
          .toList()
          : [CustomerData.fromJson(json['data'])]),
      message: json['message']?.toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "status": status,
      "response_code": responseCode,
      "data": data?.map((e) => e.toJson()).toList(),
      "message": message,
    };
  }
}
class CustomerData {
  String? id;
  String? name;
  String? companyType;
  String? phone;
  String? aadharNumber;
  String? gstNumber;
  String? products;
  String? timePeriod;
  String? amountLimit;
  String? interestRate;
  String? status;
  String? createdDate;

  String? aadharFrontImage;
  String? aadharBackImage;

  // ✅ SIGNATURE
  String? signatureImage;

  CustomerData({
    this.id,
    this.name,
    this.companyType,
    this.phone,
    this.aadharNumber,
    this.gstNumber,
    this.products,
    this.timePeriod,
    this.amountLimit,
    this.interestRate,
    this.status,
    this.createdDate,
    this.aadharFrontImage,
    this.aadharBackImage,
    this.signatureImage,
  });

  factory CustomerData.fromJson(Map<String, dynamic> json) {
    return CustomerData(
      id: json['id']?.toString(),
      name: json['name']?.toString(),
      companyType: json['company_type']?.toString(),
      phone: json['phone']?.toString(),
      aadharNumber: json['aadhar_number']?.toString(),
      gstNumber: json['gst_number']?.toString(),
      products: json['products']?.toString(),
      timePeriod: json['time_period']?.toString(),
      amountLimit: json['amount_limit']?.toString(),
      interestRate: json['interest_rate']?.toString(),
      status: json['status']?.toString(),
      createdDate: json['created_date']?.toString(),
      aadharFrontImage: json['aadhar_front_image']?.toString(),
      aadharBackImage: json['aadhar_back_image']?.toString(),

      // ✅ FIX
      signatureImage: json['signature_image']?.toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
      "company_type": companyType,
      "phone": phone,
      "aadhar_number": aadharNumber,
      "gst_number": gstNumber,
      "products": products,
      "time_period": timePeriod,
      "amount_limit": amountLimit,
      "interest_rate": interestRate,
      "status": status,
      "created_date": createdDate,
      "aadhar_front_image": aadharFrontImage,
      "aadhar_back_image": aadharBackImage,

      // ✅ FIX
      "signature_image": signatureImage,
    };
  }
}