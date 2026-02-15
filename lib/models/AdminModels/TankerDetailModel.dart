class TankerDetailModel {
  String? status;
  int? responseCode;
  List<TankerDetailData>? data;
  String? message;

  TankerDetailModel({this.status, this.responseCode, this.data, this.message});

  TankerDetailModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    responseCode = json['response_code'];
    if (json['data'] != null) {
      data = <TankerDetailData>[];
      json['data'].forEach((v) {
        data!.add(TankerDetailData.fromJson(v));
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

class TankerDetailData {
  String? id;
  String? branchId;
  String? registrationNumber;
  String? tankerType;
  String? capacity;
  String? fitnessCertNo;
  String? fitnessCertExpDate;
  String? pollutionControlCertNo;
  String? pollutionControlCertExpDate;
  String? insurancePolicyNumber;
  String? insuranceExpDate;
  String? rcDoc;
  String? calibrationNumber; // ADD THIS FIELD
  String? calibrationDate;
  String? calibrationExpDate;
  String? permitNumber;
  String? explosiveExpDate;
  String? otherCert;
  String? status;
  String? createdBy;
  String? createdDate;
  String? updatedDate;
  String? crewId;
  String? crewDriverName;
  String? crewDriverLicenseNo;
  String? crewLicenseExpDate;
  String? crewMobile;
  String? crewAadharNumber;
  String? crewAadharDoc;
  String? crewGatePassDoc;
  String? crewGatePassExpDate;
  String? crewTraningCardDoc;
  String? crewTraningCardExpDate;
  String? crewHazardousGoodsDoc;
  String? crewHazardousGoodsExpDate;
  String? crewHelperName;
  String? crewHelperMobile;
  String? crewHelperAadharDoc;
  String? crewRemark;
  String? crewStatus;
  String? crewCreatedDate;

  TankerDetailData({
    this.id,
    this.branchId,
    this.registrationNumber,
    this.tankerType,
    this.capacity,
    this.fitnessCertNo,
    this.fitnessCertExpDate,
    this.pollutionControlCertNo,
    this.pollutionControlCertExpDate,
    this.insurancePolicyNumber,
    this.insuranceExpDate,
    this.rcDoc,
    this.calibrationNumber, // ADD THIS FIELD
    this.calibrationDate,
    this.calibrationExpDate,
    this.permitNumber,
    this.explosiveExpDate,
    this.otherCert,
    this.status,
    this.createdBy,
    this.createdDate,
    this.updatedDate,
    this.crewId,
    this.crewDriverName,
    this.crewDriverLicenseNo,
    this.crewLicenseExpDate,
    this.crewMobile,
    this.crewAadharNumber,
    this.crewAadharDoc,
    this.crewGatePassDoc,
    this.crewGatePassExpDate,
    this.crewTraningCardDoc,
    this.crewTraningCardExpDate,
    this.crewHazardousGoodsDoc,
    this.crewHazardousGoodsExpDate,
    this.crewHelperName,
    this.crewHelperMobile,
    this.crewHelperAadharDoc,
    this.crewRemark,
    this.crewStatus,
    this.crewCreatedDate,
  });

  TankerDetailData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    branchId = json['branch_id'];
    registrationNumber = json['registration_number'];
    tankerType = json['tanker_type'];
    capacity = json['capacity'];
    fitnessCertNo = json['fitness_cert_no'];
    fitnessCertExpDate = json['fitness_cert_exp_date'];
    pollutionControlCertNo = json['pollution_control_cert_no'];
    pollutionControlCertExpDate = json['pollution_control_cert_exp_date'];
    insurancePolicyNumber = json['insurance_policy_number'];
    insuranceExpDate = json['insurance_exp_date'];
    rcDoc = json['rc_doc'];
    calibrationNumber = json['calibration_number']; // ADD THIS FIELD
    calibrationDate = json['calibration_date'];
    permitNumber = json['permit_number'];
    explosiveExpDate = json['explosive_exp_date'];
    calibrationExpDate = json['calibration_exp_date'];
    otherCert = json['other_cert'];
    status = json['status'];
    createdBy = json['created_by'];
    createdDate = json['created_date'];
    updatedDate = json['updated_date'];
    crewId = json['crew_id'];
    crewDriverName = json['crew_driver_name'];
    crewDriverLicenseNo = json['crew_driver_license_no'];
    crewLicenseExpDate = json['crew_license_exp_date'];
    crewMobile = json['crew_mobile'];
    crewAadharNumber = json['crew_aadhar_number'];
    crewAadharDoc = json['crew_aadhar_doc'];
    crewGatePassDoc = json['crew_gate_pass_doc'];
    crewGatePassExpDate = json['crew_gate_pass_exp_date'];
    crewTraningCardDoc = json['crew_traning_card_doc'];
    crewTraningCardExpDate = json['crew_traning_card_exp_date'];
    crewHazardousGoodsDoc = json['crew_hazardous_goods_doc'];
    crewHazardousGoodsExpDate = json['crew_hazardous_goods_exp_date'];
    crewHelperName = json['crew_helper_name'];
    crewHelperMobile = json['crew_helper_mobile'];
    crewHelperAadharDoc = json['crew_helper_aadhar_doc'];
    crewRemark = json['crew_remark'];
    crewStatus = json['crew_status'];
    crewCreatedDate = json['crew_created_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['branch_id'] = branchId;
    data['registration_number'] = registrationNumber;
    data['tanker_type'] = tankerType;
    data['capacity'] = capacity;
    data['fitness_cert_no'] = fitnessCertNo;
    data['fitness_cert_exp_date'] = fitnessCertExpDate;
    data['pollution_control_cert_no'] = pollutionControlCertNo;
    data['pollution_control_cert_exp_date'] = pollutionControlCertExpDate;
    data['insurance_policy_number'] = insurancePolicyNumber;
    data['insurance_exp_date'] = insuranceExpDate;
    data['rc_doc'] = rcDoc;
    data['calibration_number'] = calibrationNumber; // ADD THIS FIELD
    data['calibration_date'] = calibrationDate;
    data['permit_number'] = permitNumber;
    data['explosive_exp_date'] = explosiveExpDate;
    data['calibration_exp_date'] = calibrationExpDate;
    data['other_cert'] = otherCert;
    data['status'] = status;
    data['created_by'] = createdBy;
    data['created_date'] = createdDate;
    data['updated_date'] = updatedDate;
    data['crew_id'] = crewId;
    data['crew_driver_name'] = crewDriverName;
    data['crew_driver_license_no'] = crewDriverLicenseNo;
    data['crew_license_exp_date'] = crewLicenseExpDate;
    data['crew_mobile'] = crewMobile;
    data['crew_aadhar_number'] = crewAadharNumber;
    data['crew_aadhar_doc'] = crewAadharDoc;
    data['crew_gate_pass_doc'] = crewGatePassDoc;
    data['crew_gate_pass_exp_date'] = crewGatePassExpDate;
    data['crew_traning_card_doc'] = crewTraningCardDoc;
    data['crew_traning_card_exp_date'] = crewTraningCardExpDate;
    data['crew_hazardous_goods_doc'] = crewHazardousGoodsDoc;
    data['crew_hazardous_goods_exp_date'] = crewHazardousGoodsExpDate;
    data['crew_helper_name'] = crewHelperName;
    data['crew_helper_mobile'] = crewHelperMobile;
    data['crew_helper_aadhar_doc'] = crewHelperAadharDoc;
    data['crew_remark'] = crewRemark;
    data['crew_status'] = crewStatus;
    data['crew_created_date'] = crewCreatedDate;
    return data;
  }
}
