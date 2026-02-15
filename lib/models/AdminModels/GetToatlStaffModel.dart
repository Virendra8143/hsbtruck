class GetToatlStaffModel {
  String? status;
  int? responseCode;
  List<Data>? data;
  String? message;

  GetToatlStaffModel({this.status, this.responseCode, this.data, this.message});

  GetToatlStaffModel.fromJson(Map<String, dynamic> json) {
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
  int? totalManager;
  int? activeManager;
  int? inactiveManager;
  int? totalEmployee;
  int? activeEmployee;
  int? inactiveEmployee;
  int? totalTruck;
  int? activeTruck;
  int? inactiveTruck;

  Data(
      {this.totalManager,
        this.activeManager,
        this.inactiveManager,
        this.totalEmployee,
        this.activeEmployee,
        this.inactiveEmployee,
        this.totalTruck,
        this.activeTruck,
        this.inactiveTruck});

  Data.fromJson(Map<String, dynamic> json) {
    totalManager = json['total_manager'];
    activeManager = json['active_manager'];
    inactiveManager = json['inactive_manager'];
    totalEmployee = json['total_employee'];
    activeEmployee = json['active_employee'];
    inactiveEmployee = json['inactive_employee'];
    totalTruck = json['total_truck'];
    activeTruck = json['active_truck'];
    inactiveTruck = json['inactive_truck'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['total_manager'] = this.totalManager;
    data['active_manager'] = this.activeManager;
    data['inactive_manager'] = this.inactiveManager;
    data['total_employee'] = this.totalEmployee;
    data['active_employee'] = this.activeEmployee;
    data['inactive_employee'] = this.inactiveEmployee;
    data['total_truck'] = this.totalTruck;
    data['active_truck'] = this.activeTruck;
    data['inactive_truck'] = this.inactiveTruck;
    return data;
  }
}
