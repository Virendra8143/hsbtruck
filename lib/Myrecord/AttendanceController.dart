import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../Utils/Api.dart';
import 'Attendance.dart';


class AttendanceController extends GetxController {
  var attendanceModel = AttendanceModel().obs;
  var isLoading = false.obs;
  var errorMessage = ''.obs;
  var selectedMonthYear = 'January 2026'.obs;

  String? selectedEmployeeId;
  String? selectedEmployeeName;

  // Helper getter to get the first attendance data
  AttendanceData? get attendanceData {
    final dataList = attendanceModel.value.data;
    return dataList != null && dataList.isNotEmpty ? dataList.first : null;
  }

  // Helper getter to get attendance list
  List<AttendanceDay> get attendanceList {
    return attendanceData?.attendance ?? [];
  }

  @override
  void onInit() {
    super.onInit();
  }

  Future<void> getEmployeeAttendance(String employeeId, {String? date}) async {
    if (employeeId.isEmpty) {
      errorMessage.value = 'Employee ID is required';
      return;
    }

    isLoading.value = true;
    errorMessage.value = '';

    try {
      // Use today's date if no date provided
      final selectedDate = date ?? DateTime.now().toIso8601String().split('T')[0];

      final params = {
        'employee_id': employeeId,
        'date': selectedDate,
      };

      debugPrint('Fetching attendance for employee: $employeeId, date: $selectedDate');
      debugPrint('Params: $params');

      final response = await API.instance.post(
        endPoint: '/employee-attendance-list',
        params: params,
        isHeader: true,
      );

      isLoading.value = false;

      final data = jsonDecode(response.body);
      final status = data['status'];
      final message = data['message'] ?? '';

      if (status == "success") {
        attendanceModel.value = AttendanceModel.fromJson(data);

        // Debug the loaded data
        final dataList = attendanceModel.value.data;
        if (dataList != null && dataList.isNotEmpty) {
          final attendanceData = dataList.first;
          debugPrint('✅ Attendance loaded successfully');
          debugPrint('✅ Total Days: ${attendanceData.totalDays}');
          debugPrint('✅ Total Present: ${attendanceData.totalPresent}');
          debugPrint('✅ Total Absent: ${attendanceData.totalAbsent}');
          debugPrint('✅ Total Leaves: ${attendanceData.totalLeaves}');
          debugPrint('✅ Total Future Days: ${attendanceData.totalFutureDays}');
          debugPrint('✅ Attendance records: ${attendanceData.attendance?.length ?? 0}');

          // Log some sample attendance data
          if (attendanceData.attendance != null && attendanceData.attendance!.isNotEmpty) {
            for (var i = 0; i < min(3, attendanceData.attendance!.length); i++) {
              final day = attendanceData.attendance![i];
              debugPrint('   Day ${day.day} (${day.currentDate}): is_present = ${day.isPresent}');
            }
          }
        }
      } else {
        errorMessage.value = message;
        attendanceModel.value = AttendanceModel(data: []);
        debugPrint('❌ Error loading attendance: $message');
      }
    } catch (e, stackTrace) {
      isLoading.value = false;
      errorMessage.value = 'Failed to load attendance: ${e.toString()}';
      attendanceModel.value = AttendanceModel(data: []);
      debugPrint('❌ Error in getEmployeeAttendance: $e');
      debugPrint('StackTrace: $stackTrace');
    }
  }

  void clearAttendance() {
    attendanceModel.value = AttendanceModel(data: []);
    errorMessage.value = '';
  }

  // Get attendance status color based on is_present value
  Color getAttendanceColor(int? isPresent) {
    switch (isPresent) {
      case 1: // Present
        return Colors.green.shade600;
      case 2: // Absent
        return Colors.red.shade400;
      case 0: // Future date
        return Colors.grey.shade300;
      default:
        return Colors.grey.shade300;
    }
  }

  // Get text color based on attendance status
  Color getAttendanceTextColor(int? isPresent) {
    return isPresent == 0 ? Colors.black : Colors.white;
  }

  // Get attendance status text
  String getAttendanceStatusText(int? isPresent) {
    switch (isPresent) {
      case 1:
        return 'Present';
      case 2:
        return 'Absent';
      case 0:
        return 'Future Date';
      default:
        return 'Unknown';
    }
  }

  // Get attendance icon based on status
  IconData? getAttendanceIcon(int? isPresent) {
    switch (isPresent) {
      case 1:
        return Icons.check_circle;
      case 2:
        return Icons.cancel;
      case 0:
        return Icons.calendar_today;
      default:
        return null;
    }
  }

  // Get attendance icon color
  Color getAttendanceIconColor(int? isPresent) {
    switch (isPresent) {
      case 1:
        return Colors.white;
      case 2:
        return Colors.white;
      case 0:
        return Colors.grey.shade600;
      default:
        return Colors.grey.shade600;
    }
  }

  // Set selected employee
  void setSelectedEmployee(String employeeId, String employeeName) {
    selectedEmployeeId = employeeId;
    selectedEmployeeName = employeeName;
  }

  // Generate month-year list based on current date
  List<String> getMonthYearList() {
    final now = DateTime.now();
    final months = [
      'January', 'February', 'March', 'April', 'May', 'June',
      'July', 'August', 'September', 'October', 'November', 'December'
    ];

    final currentMonth = now.month;
    final currentYear = now.year;

    List<String> monthYearList = [];

    // Generate list for current month and 3 previous months
    for (int i = 0; i < 4; i++) {
      int monthIndex = currentMonth - i - 1;
      int year = currentYear;

      if (monthIndex < 0) {
        monthIndex += 12;
        year -= 1;
      }

      monthYearList.add('${months[monthIndex]} $year');
    }

    return monthYearList;
  }

  // Get current month year
  String getCurrentMonthYear() {
    final now = DateTime.now();
    final months = [
      'January', 'February', 'March', 'April', 'May', 'June',
      'July', 'August', 'September', 'October', 'November', 'December'
    ];
    return '${months[now.month - 1]} ${now.year}';
  }

  // Parse month year string to DateTime
  DateTime? parseMonthYear(String monthYear) {
    try {
      final parts = monthYear.split(' ');
      if (parts.length != 2) return null;

      final months = {
        'January': 1, 'February': 2, 'March': 3, 'April': 4, 'May': 5, 'June': 6,
        'July': 7, 'August': 8, 'September': 9, 'October': 10, 'November': 11, 'December': 12
      };

      final month = months[parts[0]];
      final year = int.tryParse(parts[1]);

      if (month == null || year == null) return null;

      return DateTime(year, month, 1);
    } catch (e) {
      return null;
    }
  }
}