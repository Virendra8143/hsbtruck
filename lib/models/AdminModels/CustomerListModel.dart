  class CustomerListModel {
    String? status;
    int? responseCode;
    List<Data>? data;
    String? message;

    CustomerListModel({this.status, this.responseCode, this.data, this.message});

    CustomerListModel.fromJson(Map<String, dynamic> json) {
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
    String? name;
    String? companyType;
    String? phone;
    String? gstNumber;
    String? status;

    Data(
        {this.id,
          this.name,
          this.companyType,
          this.phone,
          this.gstNumber,
          this.status});

    Data.fromJson(Map<String, dynamic> json) {
      id = json['id'];
      name = json['name'];
      companyType = json['company_type'];
      phone = json['phone'];
      gstNumber = json['gst_number'] ?? '';
      status = json['status'];
    }

    Map<String, dynamic> toJson() {
      final Map<String, dynamic> data = new Map<String, dynamic>();
      data['id'] = this.id;
      data['name'] = this.name;
      data['company_type'] = this.companyType;
      data['phone'] = this.phone;
      data['gst_number'] = this.gstNumber;
      data['status'] = this.status;
      return data;
    }
  }
