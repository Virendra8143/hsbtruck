// models/AttendanceModel.dart
import 'dart:convert';

class AttendanceModel {
  String? status;
  int? responseCode;
  List<AttendanceData>? data; // Changed from single object to list
  String? message;

  AttendanceModel({
    this.status,
    this.responseCode,
    this.data,
    this.message,
  });

  factory AttendanceModel.fromJson(Map<String, dynamic> json) {
    var dataList = json['data'] as List?;

    return AttendanceModel(
      status: json['status'],
      responseCode: json['response_code'],
      data: dataList != null
          ? dataList.map((item) => AttendanceData.fromJson(item)).toList()
          : [],
      message: json['message'],
    );
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

class AttendanceData {
  int? totalDays;
  int? totalFutureDays;
  int? totalPresent;
  int? totalAbsent;
  int? totalLeaves;
  List<AttendanceDay>? attendance;

  AttendanceData({
    this.totalDays,
    this.totalFutureDays,
    this.totalPresent,
    this.totalAbsent,
    this.totalLeaves,
    this.attendance,
  });

  factory AttendanceData.fromJson(Map<String, dynamic> json) {
    var attendanceList = json['attendance'] as List?;
    return AttendanceData(
      totalDays: json['total_days'],
      totalFutureDays: json['total_future_days'],
      totalPresent: json['total_present'],
      totalAbsent: json['total_absent'],
      totalLeaves: json['total_leaves'],
      attendance: attendanceList != null
          ? attendanceList.map((item) => AttendanceDay.fromJson(item)).toList()
          : [],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['total_days'] = totalDays;
    data['total_future_days'] = totalFutureDays;
    data['total_present'] = totalPresent;
    data['total_absent'] = totalAbsent;
    data['total_leaves'] = totalLeaves;
    if (attendance != null) {
      data['attendance'] = attendance!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class AttendanceDay {
  int? day;
  String? currentDate;
  int? isPresent;

  AttendanceDay({
    this.day,
    this.currentDate,
    this.isPresent,
  });

  factory AttendanceDay.fromJson(Map<String, dynamic> json) {
    return AttendanceDay(
      day: json['day'],
      currentDate: json['current_date'],
      isPresent: json['is_present'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['day'] = day;
    data['current_date'] = currentDate;
    data['is_present'] = isPresent;
    return data;
  }
}