// controllers/WorkRecordController.dart
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../Utils/Api.dart';
import 'WorkRecordModel.dart';



class WorkRecordController extends GetxController {
  var workRecordModel = WorkRecordModel().obs;
  var isLoading = false.obs;
  var errorMessage = ''.obs;
  var selectedDate = DateTime.now().toIso8601String().split('T')[0].obs;
  var hasData = false.obs;

  String? selectedEmployeeId;
  String? selectedEmployeeName;
  String? selectedAttendanceDate;

  @override
  void onInit() {
    super.onInit();
    debugPrint('WorkRecordController initialized');
  }

  @override
  void onClose() {
    debugPrint('WorkRecordController closed');
    super.onClose();
  }

  // Helper getter to get the first work record data
  WorkRecordData? get workRecordData {
    final dataList = workRecordModel.value.data;
    return dataList != null && dataList.isNotEmpty ? dataList.first : null;
  }

  // Helper getter to get work records list
  List<WorkRecord> get workRecords {
    return workRecordData?.records ?? [];
  }

  // Helper to get opening reading as string
  String get openingReadingString {
    final reading = workRecordData?.openingReading;
    if (reading == null) return '0';
    return reading.toString();
  }

  // Helper to get closing reading as string
  String get closingReadingString {
    final reading = workRecordData?.closingReading;
    if (reading == null) return '0';
    return reading.toString();
  }

  Future<void> getEmployeeWorkDetails(String employeeId, {String? date}) async {
    if (employeeId.isEmpty) {
      errorMessage.value = 'Employee ID is required';
      hasData.value = false;
      return;
    }

    // Prevent duplicate calls
    if (isLoading.value) return;

    isLoading.value = true;
    errorMessage.value = '';
    hasData.value = false;

    try {
      final params = {
        'employee_id': employeeId,
        'date': date ?? selectedDate.value,
      };

      debugPrint('Fetching work details for employee: $employeeId, date: ${date ?? selectedDate.value}');
      debugPrint('Params: $params');

      final response = await API.instance.post(
        endPoint: '/employee-work-details',
        params: params,
        isHeader: true,
      );

      isLoading.value = false;

      // Debug the response
      debugPrint('Work Details API Response: ${response.body}');

      final data = jsonDecode(response.body);
      final status = data['status'];
      final message = data['message'] ?? '';

      if (status == "success") {
        try {
          workRecordModel.value = WorkRecordModel.fromJson(data);

          // Check if we have data
          final dataList = workRecordModel.value.data;
          if (dataList != null && dataList.isNotEmpty) {
            final workData = dataList.first;
            hasData.value = true;

            debugPrint('✅ Successfully loaded work details for employee: $employeeId');
            debugPrint('✅ Date: ${workData.date}');
            debugPrint('✅ Opening Reading: ${workData.openingReading} (type: ${workData.openingReading.runtimeType})');
            debugPrint('✅ Closing Reading: ${workData.closingReading} (type: ${workData.closingReading.runtimeType})');
            debugPrint('✅ Total Records: ${workData.records?.length ?? 0}');

            if (workData.records != null && workData.records!.isNotEmpty) {
              debugPrint('✅ Records found:');
              for (var record in workData.records!) {
                debugPrint('   - ${record.productName}: ${record.totalQty} Ltr, ₹${record.totalAmount}');
              }
            } else {
              debugPrint('⚠️ No records found for this date');
            }
          } else {
            debugPrint('⚠️ No work data found in response');
            hasData.value = false;
            errorMessage.value = 'No work data available for selected date';
          }
        } catch (parseError, parseStack) {
          debugPrint('❌ Error parsing response: $parseError');
          debugPrint('Parse stack: $parseStack');
          errorMessage.value = 'Error parsing work details: $parseError';
          hasData.value = false;
        }
      } else {
        errorMessage.value = message;
        workRecordModel.value = WorkRecordModel(data: []);
        hasData.value = false;
        debugPrint('❌ Error loading work details: $message');
      }
    } catch (e, stackTrace) {
      isLoading.value = false;
      errorMessage.value = 'Failed to load work details: ${e.toString()}';
      workRecordModel.value = WorkRecordModel(data: []);
      hasData.value = false;
      debugPrint('❌ Error in getEmployeeWorkDetails: $e');
      debugPrint('StackTrace: $stackTrace');
    }
  }

  void clearWorkRecords() {
    workRecordModel.value = WorkRecordModel(data: []);
    errorMessage.value = '';
    hasData.value = false;
  }

  // Set selected employee and date
  void setSelectedEmployee(String employeeId, String employeeName, {String? date}) {
    selectedEmployeeId = employeeId;
    selectedEmployeeName = employeeName;
    if (date != null) {
      selectedAttendanceDate = date;
      selectedDate.value = date;
    }
    debugPrint('Set employee: $employeeId, name: $employeeName, date: ${date ?? selectedDate.value}');
  }

  // Calculate total quantity
  double getTotalQuantity() {
    if (workRecords.isEmpty) return 0.0;

    return workRecords.fold(0.0, (sum, record) {
      try {
        return sum + (double.tryParse(record.totalQty?.replaceAll(',', '') ?? '0') ?? 0);
      } catch (e) {
        return sum;
      }
    });
  }

  // Calculate total amount
  double getTotalAmount() {
    if (workRecords.isEmpty) return 0.0;

    return workRecords.fold(0.0, (sum, record) {
      try {
        return sum + (double.tryParse(record.totalAmount?.replaceAll(',', '') ?? '0') ?? 0);
      } catch (e) {
        return sum;
      }
    });
  }

  // Format date for display
  String formatDate(String? dateString) {
    if (dateString == null) return 'N/A';
    try {
      final date = DateTime.parse(dateString);
      return '${_getDayName(date.weekday)} ${date.day}/${date.month}/${date.year}';
    } catch (e) {
      return dateString;
    }
  }

  String _getDayName(int weekday) {
    switch (weekday) {
      case 1: return 'Mon';
      case 2: return 'Tue';
      case 3: return 'Wed';
      case 4: return 'Thu';
      case 5: return 'Fri';
      case 6: return 'Sat';
      case 7: return 'Sun';
      default: return '';
    }
  }

  // Check if date has work records
  bool hasWorkRecordsForDate(String? date) {
    if (date == null) return false;
    final workData = workRecordData;
    if (workData?.date == date && workRecords.isNotEmpty) {
      return true;
    }
    return false;
  }
}