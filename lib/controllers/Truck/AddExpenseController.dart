import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Data/AppDialoge.dart';
import '../../Utils/Api.dart';
import '../../Utils/Preference.dart';
import 'ExpensestypeController.dart';

class AddExpenseController extends GetxController {
  final placeController = TextEditingController();
  final amountController = TextEditingController();
  final remarkController = TextEditingController();

  var isSubmitting = false.obs;

  // validation errors
  var placeError = "".obs;
  var amountError = "".obs;

  void clearErrors() {
    placeError.value = "";
    amountError.value = "";
  }

  bool validateForm(ExpenseTypeController expenseTypeController) {
    clearErrors();
    bool isValid = true;

    // Expense Type check
    if (expenseTypeController.selectedExpenseTypeTitle.value.trim().isEmpty) {
      Appdialogs.showToast("Please select expense type");
      isValid = false;
    }

    // Place check
    if (placeController.text.trim().isEmpty) {
      placeError.value = "Please enter place";
      isValid = false;
    }

    // Amount check
    if (amountController.text.trim().isEmpty) {
      amountError.value = "Please enter amount";
      isValid = false;
    } else {
      final amount = double.tryParse(amountController.text.trim());
      if (amount == null || amount <= 0) {
        amountError.value = "Please enter valid amount";
        isValid = false;
      }
    }

    return isValid;
  }

  Future<bool> addExpense({
    required ExpenseTypeController expenseTypeController,
  }) async {
    if (!validateForm(expenseTypeController)) return false;

    isSubmitting.value = true;

    try {
      // ✅ tanker_id = login user id
      final tankerId = await Preference.getUserId();

      if (tankerId == null || tankerId.toString().isEmpty) {
        Appdialogs.showToast("User not logged in");
        return false;
      }

      final params = {
        "tanker_id": tankerId.toString(),
        // "expense_type": expenseTypeController.selectedExpenseTypeTitle.value,
        "expense_type": expenseTypeController.selectedExpenseTypeId.value,

        "place": placeController.text.trim(),
        "amount": amountController.text.trim(),
        "remark": remarkController.text.trim(), // optional
      };

      debugPrint("---- Add Expense Params ----");
      debugPrint(jsonEncode(params));

      final response = await API.instance.post(
        endPoint: APIEndPoints.AddExpense,
        params: params,
        isHeader: true,
      );

      debugPrint("---- Add Expense Response ----");
      debugPrint("Status Code: ${response.statusCode}");
      debugPrint("Body: ${response.body}");

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        if (data["status"] == "success") {
          Appdialogs.showToast(data["message"] ?? "Expense added");

          // reset
          placeController.clear();
          amountController.clear();
          remarkController.clear();

          return true;
        } else {
          Appdialogs.showToast(data["message"] ?? "Failed to add expense");
          return false;
        }
      } else {
        Appdialogs.showToast("Server error: ${response.statusCode}");
        return false;
      }
    } catch (e) {
      debugPrint("Error addExpense: $e");
      Appdialogs.showToast("Error: $e");
      return false;
    } finally {
      isSubmitting.value = false;
    }
  }

  @override
  void onClose() {
    placeController.dispose();
    amountController.dispose();
    remarkController.dispose();
    super.onClose();
  }
}
