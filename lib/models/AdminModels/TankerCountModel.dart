class TankerCountModel {
  String? status;
  int? responseCode;
  List<Map<String, dynamic>>? data;
  String? message;

  TankerCountModel({this.status, this.responseCode, this.data, this.message});

  TankerCountModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    responseCode = json['response_code'];
    if (json['data'] != null) {
      data = <Map<String, dynamic>>[];
      json['data'].forEach((v) {
        data!.add(Map<String, dynamic>.from(v));
      });
    }
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['response_code'] = responseCode;
    if (this.data != null) {
      data['data'] = this.data;
    }
    data['message'] = message;
    return data;
  }

  // Helper methods to get specific counts
  int? get totalTankers {
    if (data != null && data!.isNotEmpty) {
      return data![0]['total'];
    }
    return null;
  }

  int? get abcTankers {
    if (data != null && data!.length > 1) {
      return data![1]['Abc'];
    }
    return null;
  }

  int? get petrolTankers {
    if (data != null && data!.length > 2) {
      return data![2]['Petrol'];
    }
    return null;
  }
}