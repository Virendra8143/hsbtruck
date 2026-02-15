class ProductGraphModel {
  String? status;
  int? responseCode;
  List<Data>? data;
  String? message;

  ProductGraphModel({this.status, this.responseCode, this.data, this.message});

  ProductGraphModel.fromJson(Map<String, dynamic> json) {
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
  String? date;
  int? qty;
  int? amount;

  Data({this.date, this.qty, this.amount});

  Data.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    qty = json['qty'];
    amount = json['amount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['date'] = this.date;
    data['qty'] = this.qty;
    data['amount'] = this.amount;
    return data;
  }
}