import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Data/AppDialoge.dart';
import '../../Utils/Api.dart';
import '../../models/Truck/ExpenseListModel.dart';

class ExpenseListController extends GetxController {
  var isLoading = false.obs;
  var expenseList = <ExpenseListModel>[].obs;
  RxString searchText = "".obs;


  var selectedType = "0".obs;

  @override
  void onInit() {
    super.onInit();
    getExpenseList(type: "0");
  }

  Future<void> getExpenseList({required String type}) async {
    isLoading.value = true;

    try {
      final endPoint = "${APIEndPoints.GetExpenseList}/$type";

      debugPrint("Expense List Endpoint: $endPoint");

      final response = await API.instance.get(
        endPoint: endPoint,
        isHeader: true,
      );

      debugPrint("Status Code: ${response.statusCode}");
      debugPrint("Body: ${response.body}");

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        if (data["status"] == "success") {
          final List list = data["data"] ?? [];
          expenseList.value =
              list.map((e) => ExpenseListModel.fromJson(e)).toList();
        } else {
          expenseList.clear();
          Appdialogs.showToast(data["message"] ?? "Failed to load expense list");
        }
      } else {
        expenseList.clear();
        Appdialogs.showToast("Server error: ${response.statusCode}");
      }
    } catch (e) {
      expenseList.clear();
      debugPrint("Expense List Error: $e");
      Appdialogs.showToast("Error: $e");
    } finally {
      isLoading.value = false;
    }
  }

  void changeType(String typeId) {
    selectedType.value = typeId;
    getExpenseList(type: typeId);
  }
}
