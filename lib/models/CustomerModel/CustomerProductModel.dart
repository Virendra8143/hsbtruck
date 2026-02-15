class CustomerProductModel {
  String? productId;
  String? productName;
  String? quantity;
  String? price;
  String? total;

  CustomerProductModel({
    this.productId,
    this.productName,
    this.quantity,
    this.price,
    this.total,
  });

  factory CustomerProductModel.fromJson(Map<String, dynamic> json) {
    return CustomerProductModel(
      productId: json['product_id']?.toString(),
      productName: json['product_name']?.toString(),
      quantity: json['quantity']?.toString(),
      price: json['price']?.toString(),
      total: json['total']?.toString(),
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['product_id'] = productId;
    data['product_name'] = productName;
    data['quantity'] = quantity;
    data['price'] = price;
    data['total'] = total;
    return data;
  }
}

class CustomerProductsResponse {
  String? status;
  String? message;
  String? customerId;
  String? customerName;
  List<CustomerProductModel>? products;

  CustomerProductsResponse({
    this.status,
    this.message,
    this.customerId,
    this.customerName,
    this.products,
  });

  factory CustomerProductsResponse.fromJson(Map<String, dynamic> json) {
    List<CustomerProductModel> productsList = [];
    if (json['products'] != null && json['products'] is List) {
      productsList = (json['products'] as List)
          .map((i) => CustomerProductModel.fromJson(i))
          .toList();
    }

    return CustomerProductsResponse(
      status: json['status']?.toString(),
      message: json['message']?.toString(),
      customerId: json['customer_id']?.toString(),
      customerName: json['customer_name']?.toString(),
      products: productsList,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    data['customer_id'] = customerId;
    data['customer_name'] = customerName;
    if (products != null) {
      data['products'] = products!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}