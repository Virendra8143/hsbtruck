import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Data/AppDialoge.dart';
import '../../Utils/Api.dart';
import '../../Utils/api_endpoints.dart';
import 'StaffController.dart';

class EditStaffController extends GetxController {
  var isLoading = false.obs;

  Future<void> updateStaffStatus(
      {required String staffId, required String updateStatus}) async {
    isLoading.value = true;

    Map<String, dynamic> body = {};

    var endPoints = '$staffId/$updateStatus';

    try {
      final response = await API.instance.get(
          endPoint: APIEndPoints.updateStaffStatus + endPoints,
          params: body,
          isHeader: true);

      var data = jsonDecode(response.body);
      var status = data['status'];
      var message = data['message'];
      var responseCode = data['response_code'];

      if (status == "success" && responseCode == 200) {
        Appdialogs.showToast(message);
        Get.back();
        Get.back();
        // Refresh the staff list using the existing controller instance
        final staffController = Get.find<StaffController>();
        staffController.getStaffList();
        staffController.getTotalStaff();

      } else {
        Appdialogs.showToast(message);
      }
    } catch (e, stackTrace) {
      debugPrint(e.toString());
      Appdialogs.showToast("Error updating staff status");
    } finally {
      isLoading.value = false;
    }
  }
} 