class GetMachineDetailModel {
  String? status;
  int? responseCode;
  List<Data>? data;
  String? message;

  GetMachineDetailModel(
      {this.status, this.responseCode, this.data, this.message});

  GetMachineDetailModel.fromJson(Map<String, dynamic> json) {
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
  String? id;
  String? userId;
  String? branchId;
  String? code;
  String? makeMachineType;
  String? modalSerial;
  String? masSerialNo;
  String? noOfNozzle;
  String ? nozzle_reading_1;
  String ? nozzle_reading_2;
  String ? nozzle_reading_3;
  String ? nozzle_reading_4;
  String? nozzleProperty;  // This should be String? to match the server response
  String? nozzleType1;
  String? nozzleType2;
  String? nozzleType3;
  String? nozzleType4;
  String? openingReading;
  String? status;
  String? createdDate;
  String? updatedDate;  // Changed from Null? to String?

  Data({
    this.id,
    this.userId,
    this.branchId,
    this.code,
    this.makeMachineType,
    this.modalSerial,
    this.masSerialNo,
    this.noOfNozzle,
    this.nozzle_reading_1,
    this.nozzle_reading_2,
    this.nozzle_reading_3,
    this.nozzle_reading_4,
    this.nozzleProperty,
    this.nozzleType1,
    this.nozzleType2,
    this.nozzleType3,
    this.nozzleType4,
    this.openingReading,
    this.status,
    this.createdDate,
    this.updatedDate,
  });

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    branchId = json['branch_id'];
    code = json['code'];
    makeMachineType = json['make_machine_type'];
    modalSerial = json['modal_serial'];
    masSerialNo = json['mas_serial_no'];
    noOfNozzle = json['no_of_nozzle'];
    nozzleProperty = json['nozzle_property'];
    nozzle_reading_1 = json['nozzle_reading_1'];
    nozzle_reading_2 = json['nozzle_reading_2'];
    nozzle_reading_3 = json['nozzle_reading_3'];
    nozzle_reading_4 = json['nozzle_reading_4'];
    nozzleType1 = json['nozzle_type_1'];
    nozzleType2 = json['nozzle_type_2'];
    nozzleType3 = json['nozzle_type_3'];
    nozzleType4 = json['nozzle_type_4'];
    openingReading = json['opening_reading'];
    status = json['status'];
    createdDate = json['created_date'];
    updatedDate = json['updated_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['branch_id'] = this.branchId;
    data['code'] = this.code;
    data['make_machine_type'] = this.makeMachineType;
    data['modal_serial'] = this.modalSerial;
    data['mas_serial_no'] = this.masSerialNo;
    data['no_of_nozzle'] = this.noOfNozzle;
    data['nozzle_property'] = this.nozzleProperty;
    data['nozzle_reading_1'] = this.nozzle_reading_1;
    data['nozzle_reading_2'] = this.nozzle_reading_2;
    data['nozzle_reading_3'] = this.nozzle_reading_3;
    data['nozzle_reading_4'] = this.nozzle_reading_4;
    data['nozzle_type_1'] = this.nozzleType1;
    data['nozzle_type_2'] = this.nozzleType2;
    data['nozzle_type_3'] = this.nozzleType3;
    data['nozzle_type_4'] = this.nozzleType4;
    data['opening_reading'] = this.openingReading;
    data['status'] = this.status;
    data['created_date'] = this.createdDate;
    data['updated_date'] = this.updatedDate;
    return data;
  }
}