
import 'dart:convert';

class Machine {
  final String makeMachineType;
  final String modelSerial;
  final String masSerialNo;
  final int noOfNozzle;
  final String stumpingStartDate;
  final String stumpingEndDate;

  // Nozzle data for up to 4 nozzles
  final String? nozzleNumber1;
  final String? nozzleType1;
  final String? nozzleReading1;

  final String? nozzleNumber2;
  final String? nozzleType2;
  final String? nozzleReading2;

  final String? nozzleNumber3;
  final String? nozzleType3;
  final String? nozzleReading3;

  final String? nozzleNumber4;
  final String? nozzleType4;
  final String? nozzleReading4;

  Machine({
    required this.makeMachineType,
    required this.modelSerial,
    required this.masSerialNo,
    required this.noOfNozzle,
    required this.stumpingStartDate,
    required this.stumpingEndDate,
    this.nozzleNumber1,
    this.nozzleType1,
    this.nozzleReading1,
    this.nozzleNumber2,
    this.nozzleType2,
    this.nozzleReading2,
    this.nozzleNumber3,
    this.nozzleType3,
    this.nozzleReading3,
    this.nozzleNumber4,
    this.nozzleType4,
    this.nozzleReading4,
  });

  // Factory constructor to create instance from JSON
  factory Machine.fromJson(Map<String, dynamic> json) {
    return Machine(
      makeMachineType: json['make_machine_type'] ?? '',
      modelSerial: json['modal_serial'] ?? '',
      masSerialNo: json['mas_serial_no'] ?? '',
      noOfNozzle: int.tryParse(json['no_of_nozzle']?.toString() ?? '0') ?? 0,
      stumpingStartDate: json['stumping_start_date'] ?? '',
      stumpingEndDate: json['stumping_end_date'] ?? '',
      nozzleNumber1: json['nozzle_number_1'],
      nozzleType1: json['nozzle_type_1'],
      nozzleReading1: json['nozzle_reading_1']?.toString(),
      nozzleNumber2: json['nozzle_number_2'],
      nozzleType2: json['nozzle_type_2'],
      nozzleReading2: json['nozzle_reading_2']?.toString(),
      nozzleNumber3: json['nozzle_number_3'],
      nozzleType3: json['nozzle_type_3'],
      nozzleReading3: json['nozzle_reading_3']?.toString(),
      nozzleNumber4: json['nozzle_number_4'],
      nozzleType4: json['nozzle_type_4'],
      nozzleReading4: json['nozzle_reading_4']?.toString(),
    );
  }

  // Convert to JSON for API requests
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    // Basic machine info
    data['make_machine_type'] = makeMachineType;
    data['modal_serial'] = modelSerial;
    data['mas_serial_no'] = masSerialNo;
    data['no_of_nozzle'] = noOfNozzle.toString();
    data['stumping_start_date'] = stumpingStartDate;
    data['stumping_end_date'] = stumpingEndDate;

    // Nozzle data - only include nozzles that exist based on noOfNozzle
    if (noOfNozzle >= 1) {
      data['nozzle_number_1'] = nozzleNumber1;
      data['nozzle_type_1'] = nozzleType1;
      data['nozzle_reading_1'] = nozzleReading1;
    }

    if (noOfNozzle >= 2) {
      data['nozzle_number_2'] = nozzleNumber2;
      data['nozzle_type_2'] = nozzleType2;
      data['nozzle_reading_2'] = nozzleReading2;
    }

    if (noOfNozzle >= 3) {
      data['nozzle_number_3'] = nozzleNumber3;
      data['nozzle_type_3'] = nozzleType3;
      data['nozzle_reading_3'] = nozzleReading3;
    }

    if (noOfNozzle >= 4) {
      data['nozzle_number_4'] = nozzleNumber4;
      data['nozzle_type_4'] = nozzleType4;
      data['nozzle_reading_4'] = nozzleReading4;
    }

    return data;
  }

  // Method to get nozzle data as a list for easier UI handling
  List<Map<String, String?>> getNozzlesAsList() {
    final List<Map<String, String?>> nozzles = [];

    if (noOfNozzle >= 1) {
      nozzles.add({
        'number': nozzleNumber1,
        'type': nozzleType1,
        'reading': nozzleReading1,
      });
    }

    if (noOfNozzle >= 2) {
      nozzles.add({
        'number': nozzleNumber2,
        'type': nozzleType2,
        'reading': nozzleReading2,
      });
    }

    if (noOfNozzle >= 3) {
      nozzles.add({
        'number': nozzleNumber3,
        'type': nozzleType3,
        'reading': nozzleReading3,
      });
    }

    if (noOfNozzle >= 4) {
      nozzles.add({
        'number': nozzleNumber4,
        'type': nozzleType4,
        'reading': nozzleReading4,
      });
    }

    return nozzles;
  }

  // Method to update nozzle data
  Machine copyWith({
    String? makeMachineType,
    String? modelSerial,
    String? masSerialNo,
    int? noOfNozzle,
    String? stumpingStartDate,
    String? stumpingEndDate,
    String? nozzleNumber1,
    String? nozzleType1,
    String? nozzleReading1,
    String? nozzleNumber2,
    String? nozzleType2,
    String? nozzleReading2,
    String? nozzleNumber3,
    String? nozzleType3,
    String? nozzleReading3,
    String? nozzleNumber4,
    String? nozzleType4,
    String? nozzleReading4,
  }) {
    return Machine(
      makeMachineType: makeMachineType ?? this.makeMachineType,
      modelSerial: modelSerial ?? this.modelSerial,
      masSerialNo: masSerialNo ?? this.masSerialNo,
      noOfNozzle: noOfNozzle ?? this.noOfNozzle,
      stumpingStartDate: stumpingStartDate ?? this.stumpingStartDate,
      stumpingEndDate: stumpingEndDate ?? this.stumpingEndDate,
      nozzleNumber1: nozzleNumber1 ?? this.nozzleNumber1,
      nozzleType1: nozzleType1 ?? this.nozzleType1,
      nozzleReading1: nozzleReading1 ?? this.nozzleReading1,
      nozzleNumber2: nozzleNumber2 ?? this.nozzleNumber2,
      nozzleType2: nozzleType2 ?? this.nozzleType2,
      nozzleReading2: nozzleReading2 ?? this.nozzleReading2,
      nozzleNumber3: nozzleNumber3 ?? this.nozzleNumber3,
      nozzleType3: nozzleType3 ?? this.nozzleType3,
      nozzleReading3: nozzleReading3 ?? this.nozzleReading3,
      nozzleNumber4: nozzleNumber4 ?? this.nozzleNumber4,
      nozzleType4: nozzleType4 ?? this.nozzleType4,
      nozzleReading4: nozzleReading4 ?? this.nozzleReading4,
    );
  }

  @override
  String toString() {
    return 'Machine(makeMachineType: $makeMachineType, modelSerial: $modelSerial, masSerialNo: $masSerialNo, noOfNozzle: $noOfNozzle, stumpingStartDate: $stumpingStartDate, stumpingEndDate: $stumpingEndDate)';
  }
}