import 'CustomerDetailModel.dart';

class CustomerListModel {
  String? status;
  String? message;
  List<CustomerDetailData>? data;
  int? currentPage;
  int? lastPage;
  int? total;
  int? perPage;
  int? from;
  int? to;

  CustomerListModel({
    this.status,
    this.message,
    this.data,
    this.currentPage,
    this.lastPage,
    this.total,
    this.perPage,
    this.from,
    this.to,
  });

  factory CustomerListModel.fromJson(Map<String, dynamic> json) {
    List<CustomerDetailData> dataList = [];
    if (json['data'] != null && json['data'] is List) {
      dataList = (json['data'] as List)
          .map((i) => CustomerDetailData.fromJson(i))
          .toList();
    }

    return CustomerListModel(
      status: json['status']?.toString(),
      message: json['message']?.toString(),
      data: dataList,
      currentPage: json['current_page'] != null
          ? int.tryParse(json['current_page'].toString()) ?? 1
          : 1,
      lastPage: json['last_page'] != null
          ? int.tryParse(json['last_page'].toString()) ?? 1
          : 1,
      total: json['total'] != null
          ? int.tryParse(json['total'].toString()) ?? 0
          : 0,
      perPage: json['per_page'] != null
          ? int.tryParse(json['per_page'].toString()) ?? 10
          : 10,
      from: json['from'] != null
          ? int.tryParse(json['from'].toString()) ?? 0
          : 0,
      to: json['to'] != null
          ? int.tryParse(json['to'].toString()) ?? 0
          : 0,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['current_page'] = currentPage;
    data['last_page'] = lastPage;
    data['total'] = total;
    data['per_page'] = perPage;
    data['from'] = from;
    data['to'] = to;
    return data;
  }

  // Get total pages
  int get totalPages => lastPage ?? 1;
}