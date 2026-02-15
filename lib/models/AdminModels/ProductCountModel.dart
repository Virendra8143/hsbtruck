// class ProductCountModel {
//   String? status;
//   int? responseCode;
//   List<Data>? data;
//   String? message;
//
//   ProductCountModel({this.status, this.responseCode, this.data, this.message});
//
//   ProductCountModel.fromJson(Map<String, dynamic> json) {
//     status = json['status'];
//     responseCode = json['response_code'];
//     if (json['data'] != null) {
//       data = <Data>[];
//       json['data'].forEach((v) {
//         data!.add(new Data.fromJson(v));
//       });
//     }
//     message = json['message'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['status'] = this.status;
//     data['response_code'] = this.responseCode;
//     if (this.data != null) {
//       data['data'] = this.data!.map((v) => v.toJson()).toList();
//     }
//     data['message'] = this.message;
//     return data;
//   }
// }
//
// class Data {
//   int? all;
//   int? lowStok;
//
//   Data({this.all, this.lowStok});
//
//   Data.fromJson(Map<String, dynamic> json) {
//     all = json['all'];
//     lowStok = json['low_stok'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['all'] = this.all;
//     data['low_stok'] = this.lowStok;
//     return data;
//   }
// }
class ProductCountModel {
  String? status;
  int? responseCode;
  List<ProductCountData>? data;
  String? message;

  ProductCountModel({this.status, this.responseCode, this.data, this.message});

  ProductCountModel.fromJson(Map<String, dynamic> json) {
    status = json['status']?.toString() ?? '';
    responseCode = json['response_code'] ?? 0;
    if (json['data'] != null) {
      data = <ProductCountData>[];
      json['data'].forEach((v) {
        data!.add(ProductCountData.fromJson(v));
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

class ProductCountData {
  int? all;
  int? lowStok;

  ProductCountData({this.all, this.lowStok});

  ProductCountData.fromJson(Map<String, dynamic> json) {
    all = json['all'] ?? 0;
    lowStok = json['low_stok'] ?? 0;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['all'] = all ?? 0;
    data['low_stok'] = lowStok ?? 0;
    return data;
  }
}
