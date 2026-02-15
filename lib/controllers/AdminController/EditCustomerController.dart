
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Data/AppDialoge.dart';
import '../../Utils/Api.dart';
import 'CreditCoustomerController.dart';

class EditCustomerController extends GetxController {
  var isLoading = false.obs;
  var currentCustomerStatus = "Active".obs;

  // Method to get current customer status
  Future<void> getCurrentCustomerStatus({required String customerId}) async {
    try {
      final customerController = Get.find<CreditCoustomerController>();
      final customerList = customerController.customerList.value?.data ?? [];

      // Find the customer in the list
      dynamic currentCustomer;
      for (var customer in customerList) {
        if (customer.id == customerId) {
          currentCustomer = customer;
          break;
        }
      }

      if (currentCustomer != null && currentCustomer.status != null) {
        String apiStatus = currentCustomer.status;
        currentCustomerStatus.value = apiStatus;
        debugPrint('Current customer status from list: $apiStatus');
      } else {
        currentCustomerStatus.value = "Active";
        debugPrint('Customer not found in list, defaulting to Active');
      }
    } catch (e) {
      debugPrint("Error getting customer status: $e");
      currentCustomerStatus.value = "Active";
    }
  }

  // Method to toggle customer status
  Future<void> toggleCustomerStatus({required String customerId}) async {
    try {
      // Determine current status and what to toggle to
      String currentStatus = currentCustomerStatus.value.toLowerCase();
      String newApiStatus;
      String newDisplayStatus;

      if (currentStatus.contains("in-active") || currentStatus.contains("inactive")) {
        // Currently inactive, so activate (send 1)
        newApiStatus = "1";
        newDisplayStatus = "Active";
      } else {
        // Currently active, so deactivate (send 0)
        newApiStatus = "0";
        newDisplayStatus = "In-active";
      }

      debugPrint('Toggling customer status from ${currentCustomerStatus.value} to $newDisplayStatus (API: $newApiStatus)');

      await updateCustomerStatus(customerId: customerId, updateStatus: newApiStatus);

      // Update current status locally
      currentCustomerStatus.value = newDisplayStatus;

      // Show success message
      Appdialogs.showToast(
          newDisplayStatus == "Active"
              ? "Customer activated successfully"
              : "Customer de-activated successfully"
      );
    } catch (e) {
      debugPrint("Error toggling customer status: $e");
      Appdialogs.showToast("Error updating customer status");
    }
  }

  Future<void> updateCustomerStatus(
      {required String customerId, required String updateStatus}) async {
    isLoading.value = true;

    try {
      final endpoint = APIEndPoints.updateCreditCustomerStatus + "/$customerId/$updateStatus";
      final response = await API.instance.get(
          endPoint: endpoint,
          params: {},
          isHeader: true);

      var data = jsonDecode(response.body);

      if (data['status'] == "success" || data['status'] == true || data['response_code'] == 200) {
        Appdialogs.showToast(data['message'] ?? "Status updated successfully");
        // Refresh the customer list
        final customerController = Get.find<CreditCoustomerController>();
        customerController.getCreditCustomerList();

        // Update local status immediately based on what we sent
        String newDisplayStatus = updateStatus == "1" ? "Active" : "In-active";
        currentCustomerStatus.value = newDisplayStatus;
        Get.back();
      } else {
        Appdialogs.showToast(data['error'] ?? data['message'] ?? "Failed to update status");
      }
    } catch (e) {
      print('Error updating customer status: $e');
      Appdialogs.showToast("Error updating customer status: ${e.toString()}");
    } finally {
      isLoading.value = false;
    }
  }
}