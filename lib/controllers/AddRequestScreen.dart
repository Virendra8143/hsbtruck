// controllers/EmployeeRequestController.dart
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../Data/AppDialoge.dart';
import '../Utils/Api.dart';
import '../Utils/Preference.dart';



class EmployeeRequestController extends GetxController {
  // Form fields
  var purpose = ''.obs;
  var description = ''.obs;
  var amount = ''.obs;

  // Controllers for text fields to persist state across rebuilds
  final purposeController = TextEditingController();
  final descriptionController = TextEditingController();
  final amountController = TextEditingController();

  // Focus nodes
  final purposeFocus = FocusNode();
  final descriptionFocus = FocusNode();
  final amountFocus = FocusNode();

  // State management
  var isLoading = false.obs;
  var isSubmitting = false.obs;

  // Form validation
  var purposeError = ''.obs;
  var descriptionError = ''.obs;
  var amountError = ''.obs;

  // Reset form
  void resetForm() {
    purpose.value = '';
    description.value = '';
    amount.value = '';
    purposeController.clear();
    descriptionController.clear();
    amountController.clear();
    clearErrors();
  }

  // Clear validation errors
  void clearErrors() {
    purposeError.value = '';
    descriptionError.value = '';
    amountError.value = '';
  }

  // Validate form
  bool validateForm() {
    clearErrors();
    bool isValid = true;

    debugPrint('Validating form:');
    debugPrint('Purpose: "${purpose.value}"');
    debugPrint('Description: "${description.value}"');
    debugPrint('Amount: "${amount.value}"');

    if (purpose.value.trim().isEmpty) {
      purposeError.value = 'Please enter purpose';
      isValid = false;
    }

    if (description.value.trim().isEmpty) {
      descriptionError.value = 'Please enter description';
      isValid = false;
    }

    if (amount.value.trim().isEmpty) {
      amountError.value = 'Please enter amount';
      isValid = false;
    } else {
      // Validate amount format
      final amountValue = double.tryParse(amount.value);
      if (amountValue == null || amountValue <= 0) {
        amountError.value = 'Please enter a valid amount';
        isValid = false;
      }
    }

    return isValid;
  }

  // Submit request
  Future<bool> submitRequest() async {
    debugPrint('submitRequest() called');
    if (!validateForm()) {
      debugPrint('submitRequest early return: Validation failed');
      return false;
    }

    isSubmitting.value = true;

    try {
      // Get user ID from preferences
      final userId = await Preference.getUserId();
      debugPrint('Retrieved userId: "$userId"');

      if (userId == null || userId.isEmpty) {
        debugPrint('Error: userId is null or empty');
        Appdialogs.showToast('User not logged in');
        isSubmitting.value = false;
        return false;
      }

      // Prepare request parameters
      Map<String, dynamic> params = {
        "purpose": purpose.value,
        "description": description.value,
        "amount": amount.value,
        "user_id": userId,
      };

      // Print the API request parameters
      debugPrint('--- API Request Parameters ---');
      debugPrint(jsonEncode(params));

      final response = await API.instance.post(
        endPoint: APIEndPoints.AddRequest,
        params: params,
        isHeader: true,
      );

      // Print the API response
      debugPrint('--- API Response ---');
      debugPrint('Status Code: ${response.statusCode}');
      debugPrint('Body: ${response.body}');

      if (response.statusCode == 200) {
        try {
          final data = jsonDecode(response.body);

          if (data['status'] == "success") {
            Appdialogs.showToast(data['message'] ?? 'Request submitted successfully');

            // Reset form on success
            resetForm();
            return true;
          } else {
            final errorMsg = data['message'] ?? 'Failed to submit request';
            Appdialogs.showToast(errorMsg);
            return false;
          }
        } catch (e) {
          debugPrint('Error parsing response: $e');
          Appdialogs.showToast('Error parsing response');
          return false;
        }
      } else {
        Appdialogs.showToast('Failed to submit request. Status: ${response.statusCode}');
        return false;
      }
    } catch (e) {
      debugPrint('Error submitting request: $e');
      Appdialogs.showToast('Error: $e');
      return false;
    } finally {
      isSubmitting.value = false;
    }
  }

  // Get user info for debugging
  Future<void> debugUserInfo() async {
    final userId = await Preference.getUserId();
    final userName = await Preference.getUserName();
    final userRole = await Preference.getUserRole();

    debugPrint('User ID: $userId');
    debugPrint('User Name: $userName');
    debugPrint('User Role: $userRole');
  }

  @override
  void onClose() {
    purposeController.dispose();
    descriptionController.dispose();
    amountController.dispose();
    purposeFocus.dispose();
    descriptionFocus.dispose();
    amountFocus.dispose();
    super.onClose();
  }
}