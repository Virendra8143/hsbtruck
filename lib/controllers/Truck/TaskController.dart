import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Data/AppDialoge.dart';
import '../../Utils/Api.dart';
import '../../models/Truck/TaskModel.dart';

class TaskListController extends GetxController {
  var isLoading = false.obs;
  var taskList = <TaskModel>[].obs;

  RxString searchText = "".obs;

  @override
  void onInit() {
    super.onInit();
    getTaskList();
  }

  Future<void> getTaskList({String? search}) async {
    isLoading.value = true;

    try {
      final endPoint = APIEndPoints.GetTaskList;

      debugPrint("Task List Endpoint: $endPoint");

      final params = <String, dynamic>{};

      if (search != null && search.trim().isNotEmpty) {
        params["search"] = search.trim();
      }

      final response = await API.instance.get(
        endPoint: endPoint,
        params: params,
        isHeader: true,
      );

      debugPrint("Status Code: ${response.statusCode}");
      debugPrint("Body: ${response.body}");

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        if (data["status"] == "success") {
          final List list = data["data"] ?? [];
          taskList.value = list.map((e) => TaskModel.fromJson(e)).toList();
        } else {
          taskList.clear();
          Appdialogs.showToast(data["message"] ?? "Failed to load task list");
        }
      } else {
        taskList.clear();
        Appdialogs.showToast("Server error: ${response.statusCode}");
      }
    } catch (e) {
      taskList.clear();
      debugPrint("Task List Error: $e");
      Appdialogs.showToast("Error: $e");
    } finally {
      isLoading.value = false;
    }
  }

  void onSearchChanged(String value) {
    searchText.value = value;
    getTaskList(search: value);
  }
}
