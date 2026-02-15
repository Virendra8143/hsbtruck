class TankerListModel {
  String? status;
  int? responseCode;
  List<TankerData>? data; // This should be List<TankerData>
  String? message;

  TankerListModel({this.status, this.responseCode, this.data, this.message});

  TankerListModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    responseCode = json['response_code'];
    if (json['data'] != null) {
      data = <TankerData>[];
      json['data'].forEach((v) {
        data!.add(TankerData.fromJson(v));
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

class TankerData {
  String? id;
  String? registrationNumber;
  String? tankerType;
  String? capacity;
  String? calibrationNumber;
  String? status;
  String? createdDate;

  TankerData({
    this.id,
    this.registrationNumber,
    this.tankerType,
    this.capacity,
    this.calibrationNumber,
    this.status,
    this.createdDate,
  });

  TankerData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    registrationNumber = json['registration_number'];
    tankerType = json['tanker_type'];
    capacity = json['capacity'];
    calibrationNumber = json['calibration_number'];
    status = json['status'];
    createdDate = json['created_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['registration_number'] = registrationNumber;
    data['tanker_type'] = tankerType;
    data['capacity'] = capacity;
    data['calibration_number'] = calibrationNumber;
    data['status'] = status;
    data['created_date'] = createdDate;
    return data;
  }
}