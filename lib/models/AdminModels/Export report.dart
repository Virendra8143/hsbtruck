class ExportReportModel {
  String? status;
  int? responseCode;
  String? data;
  String? message;

  ExportReportModel({
    this.status,
    this.responseCode,
    this.data,
    this.message,
  });

  ExportReportModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    responseCode = json['response_code'];
    data = json['data'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['response_code'] = responseCode;
    data['data'] = this.data;
    data['message'] = message;
    return data;
  }
}