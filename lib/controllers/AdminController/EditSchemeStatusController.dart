
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Data/AppDialoge.dart';
import '../../Utils/Api.dart';
import '../../models/AdminModels/CustomerListModel.dart';
import '../../models/AdminModels/CustomerListModel.dart' as GetSchemeLIstModel;
import 'AddSchemeController.dart';

class EditSchemeController extends GetxController {
  var isLoading = false.obs;
  var currentSchemeStatus = "1".obs;
  var isDetailLoading = false.obs;

  // Store scheme details
  var schemeDetailData = <String, dynamic>{}.obs;

  // Method to get current scheme status
  Future<void> getCurrentSchemeStatus({required String schemeId}) async {
    try {
      // Get from the existing scheme list data since scheme detail API doesn't return status
      final schemeController = Get.find<AddSchemeController>();
      final schemeList = schemeController.getSchemeListModel.value.data ?? [];

      // Find the scheme in the list using dynamic to avoid type conflicts
      dynamic currentScheme;
      for (var scheme in schemeList) {
        if (scheme.id == schemeId) {
          currentScheme = scheme;
          break;
        }
      }

      if (currentScheme != null && currentScheme.status != null) {
        String apiStatus = currentScheme.status;
        if (apiStatus == "In-active" || apiStatus == "0") {
          currentSchemeStatus.value = "0";
        } else if (apiStatus == "Active" || apiStatus == "1") {
          currentSchemeStatus.value = "1";
        } else {
          currentSchemeStatus.value = apiStatus;
        }
        debugPrint('Current scheme status from list: $apiStatus -> ${currentSchemeStatus.value}');
      } else {
        // If not found in list, default to active
        currentSchemeStatus.value = "1";
        debugPrint('Scheme not found in list, defaulting to active');
      }
    } catch (e) {
      debugPrint("Error getting scheme status: $e");
      currentSchemeStatus.value = "1";
    }
  }
// Update your EditSchemeController - fix the getSchemeDetail method

  Future<void> getSchemeDetail({required String schemeId}) async {
    isDetailLoading.value = true;
    try {
      final response = await API.instance.get(
        endPoint: "${APIEndPoints.getSchemeId}/$schemeId",
        params: {},
        isHeader: true,
      );

      var data = jsonDecode(response.body);
      var status = data['status'];
      var message = data['message'];

      debugPrint('Scheme Detail Response: $data');

      if (status == "success") {
        // Store the scheme data
        if (data['data'] != null && data['data'] is List && data['data'].isNotEmpty) {
          schemeDetailData.value = Map<String, dynamic>.from(data['data'][0]);
          debugPrint('Scheme details stored: ${schemeDetailData.value}');

          // Debug: Print all fields to see what we're getting
          schemeDetailData.value.forEach((key, value) {
            debugPrint('Field: $key = $value (type: ${value.runtimeType})');
          });
        }
      } else {
        Appdialogs.showToast(message ?? 'Failed to load scheme details');
      }
    } catch (e, stackTrace) {
      debugPrint('Error in getSchemeDetail: $e');
      debugPrint('Stack trace: $stackTrace');
      Appdialogs.showToast("Error fetching scheme details: ${e.toString()}");
    } finally {
      isDetailLoading.value = false;
    }
  }

  Map<String, dynamic> getSchemeFormData() {
    return schemeDetailData.value;
  }

  // Check if scheme data is loaded
  bool get isSchemeDataLoaded => schemeDetailData.value.isNotEmpty;

  // Method to toggle scheme status
  Future<void> toggleSchemeStatus({required String schemeId}) async {
    try {
      // Toggle between active (1) and inactive (0)
      String newStatus = currentSchemeStatus.value == "0" ? "1" : "0";

      debugPrint('Toggling scheme status from ${currentSchemeStatus.value} to $newStatus');

      await updateSchemeStatus(schemeId: schemeId, updateStatus: newStatus);

      // Update current status locally
      currentSchemeStatus.value = newStatus;

      // Show success message
      Appdialogs.showToast(
          newStatus == "1"
              ? "Scheme activated successfully"
              : "Scheme de-activated successfully"
      );
    } catch (e) {
      debugPrint("Error toggling scheme status: $e");
      Appdialogs.showToast("Error updating scheme status");
    }
  }

  Future<void> updateSchemeStatus(
      {required String schemeId, required String updateStatus}) async {
    isLoading.value = true;

    Map<String, dynamic> body = {};

    var endPoints = '$schemeId/$updateStatus';

    try {
      final response = await API.instance.get(
          endPoint: APIEndPoints.updateSchemeStatus + "/$endPoints",
          params: body,
          isHeader: true);

      var data = jsonDecode(response.body);
      var status = data['status'];
      var message = data['message'];
      var responseCode = data['response_code'];

      if (status == "success" && responseCode == 200) {
        Appdialogs.showToast(message);
        // Update local status
        currentSchemeStatus.value = updateStatus;
        Get.back();

        // Refresh the scheme list using the existing controller instance
        final schemeController = Get.find<AddSchemeController>();
        schemeController.getSchemeList();
      } else {
        Appdialogs.showToast(message);
      }
    } catch (e, stackTrace) {
      debugPrint(e.toString());
      Appdialogs.showToast("Error updating scheme status");
    } finally {
      isLoading.value = false;
    }
  }

  // Clear scheme data when done
  void clearSchemeData() {
    schemeDetailData.value = {};
  }
}