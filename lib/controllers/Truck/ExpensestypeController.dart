import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Data/AppDialoge.dart';
import '../../Utils/Api.dart';
import '../../models/Truck/ExpensestypeModel.dart';


class ExpenseTypeController extends GetxController {
  var isLoading = false.obs;

  // list from api
  var expenseTypeList = <ExpenseTypeModel>[].obs;

  // selected expense type id
  var selectedExpenseTypeId = "".obs;

  // selected expense type title (for UI)
  var selectedExpenseTypeTitle = "".obs;

  Future<void> getExpenseTypes() async {
    isLoading.value = true;

    try {
      debugPrint("Calling Expense Type API...");

      final response = await API.instance.get(
        endPoint: APIEndPoints.GetExpenseType,
        isHeader: true,
      );

      debugPrint("--- Expense Type API Response ---");
      debugPrint("Status Code: ${response.statusCode}");
      debugPrint("Body: ${response.body}");

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        if (data["status"] == "success") {
          final List list = data["data"] ?? [];

          expenseTypeList.value =
              list.map((e) => ExpenseTypeModel.fromJson(e)).toList();

          // Auto select first value (optional)
          if (expenseTypeList.isNotEmpty) {
            selectedExpenseTypeId.value = expenseTypeList[0].id;
            selectedExpenseTypeTitle.value = expenseTypeList[0].title;
          }
        } else {
          Appdialogs.showToast(data["message"] ?? "Failed to load expense type");
        }
      } else {
        Appdialogs.showToast("Server error: ${response.statusCode}");
      }
    } catch (e) {
      debugPrint("Error in getExpenseTypes: $e");
      Appdialogs.showToast("Error: $e");
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onInit() {
    super.onInit();
    getExpenseTypes();
  }
}
