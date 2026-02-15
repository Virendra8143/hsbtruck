class GetMachineListModel {
  String? status;
  int? responseCode;
  List<Data>? data;
  String? message;

  GetMachineListModel(
      {this.status, this.responseCode, this.data, this.message});

  GetMachineListModel.fromJson(Map<String, dynamic> json) {
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
  String? nozzleProperty;

  // ADD THESE MISSING FIELDS:
  String? stumpingStartDate;
  String? stumpingEndDate;
  String? nozzleNumber1;
  String? nozzleNumber2;
  String? nozzleNumber3;
  String? nozzleNumber4;
  String? nozzleReading1;
  String? nozzleReading2;
  String? nozzleReading3;
  String? nozzleReading4;

  String? nozzleType1;
  String? nozzleType2;
  String? nozzleType3;
  String? nozzleType4;
  String? openingReading;
  String? status;
  String? createdDate;
  String? updatedDate;

  Data({
    this.id,
    this.userId,
    this.branchId,
    this.code,
    this.makeMachineType,
    this.modalSerial,
    this.masSerialNo,
    this.noOfNozzle,
    this.nozzleProperty,

    // ADD THESE:
    this.stumpingStartDate,
    this.stumpingEndDate,
    this.nozzleNumber1,
    this.nozzleNumber2,
    this.nozzleNumber3,
    this.nozzleNumber4,
    this.nozzleReading1,
    this.nozzleReading2,
    this.nozzleReading3,
    this.nozzleReading4,

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

    // ADD THESE LINES:
    stumpingStartDate = json['stumping_start_date'];
    stumpingEndDate = json['stumping_end_date'];
    nozzleNumber1 = json['nozzle_number_1'];
    nozzleNumber2 = json['nozzle_number_2'];
    nozzleNumber3 = json['nozzle_number_3'];
    nozzleNumber4 = json['nozzle_number_4'];
    nozzleReading1 = json['nozzle_reading_1'];
    nozzleReading2 = json['nozzle_reading_2'];
    nozzleReading3 = json['nozzle_reading_3'];
    nozzleReading4 = json['nozzle_reading_4'];

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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['branch_id'] = this.branchId;
    data['code'] = this.code;
    data['make_machine_type'] = this.makeMachineType;
    data['modal_serial'] = this.modalSerial;
    data['mas_serial_no'] = this.masSerialNo;
    data['no_of_nozzle'] = this.noOfNozzle;
    data['nozzle_property'] = this.nozzleProperty;

    // ADD THESE LINES:
    data['stumping_start_date'] = this.stumpingStartDate;
    data['stumping_end_date'] = this.stumpingEndDate;
    data['nozzle_number_1'] = this.nozzleNumber1;
    data['nozzle_number_2'] = this.nozzleNumber2;
    data['nozzle_number_3'] = this.nozzleNumber3;
    data['nozzle_number_4'] = this.nozzleNumber4;
    data['nozzle_reading_1'] = this.nozzleReading1;
    data['nozzle_reading_2'] = this.nozzleReading2;
    data['nozzle_reading_3'] = this.nozzleReading3;
    data['nozzle_reading_4'] = this.nozzleReading4;

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
