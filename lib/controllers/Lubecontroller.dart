import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../Utils/Api.dart';
import '../models/Lubemodel.dart';

class GetLubeListController extends GetxController {
  var getLubeModel = GetLubeModel().obs;
  var isLoading = false.obs;
  var errorMessage = ''.obs;

  @override
  void onInit() {
    super.onInit();
  }
  LubeData? getLubeByUniqueValue(String uniqueValue) {
    return (getLubeModel.value.data ?? []).firstWhereOrNull(
          (lube) => lube.id?.toString() == uniqueValue,
    );
  }
// In GetLubeListController.dart - update the getLubeList method
// controllers/AdminController/GetLubeListController.dart
  Future<void> getLubeList(String productId) async {
    if (productId.isEmpty) {
      errorMessage.value = 'Product ID is required';
      return;
    }

    isLoading.value = true;
    errorMessage.value = '';

    try {
      final response = await API.instance.get(
        endPoint: '/get-lube-list/$productId',
        params: {},
        isHeader: true,
      );

      isLoading.value = false;

      // Debug the response
      debugPrint('Lube API Response: ${response.body}');

      final data = jsonDecode(response.body);
      final status = data['status'];
      final message = data['message'] ?? '';

      if (status == "success") {
        getLubeModel.value = GetLubeModel.fromJson(data);
        debugPrint('Successfully loaded ${getLubeModel.value.data?.length ?? 0} lubes');

        // Debug the loaded data
        if (getLubeModel.value.data != null) {
          for (var lube in getLubeModel.value.data!) {
            debugPrint('Lube: ${lube.name} (ID: ${lube.id})');
          }
        }
      } else {
        errorMessage.value = message;
        getLubeModel.value = GetLubeModel(data: []);
        debugPrint('Error loading lube list: $message');
      }
    } catch (e, stackTrace) {
      isLoading.value = false;
      errorMessage.value = 'Failed to load lube list: ${e.toString()}';
      getLubeModel.value = GetLubeModel(data: []);
      debugPrint('Error in getLubeList: $e');
      debugPrint('StackTrace: $stackTrace');
    }
  }

  void clearLubeList() {
    getLubeModel.value = GetLubeModel(data: []);
    errorMessage.value = '';
  }

  // Get lube names for dropdown
  List<String> getLubeNames() {
    return (getLubeModel.value.data ?? [])
        .map((lube) => lube.name ?? '')
        .where((name) => name.isNotEmpty)
        .toList();
  }

  // Get lube by name
  LubeData? getLubeByName(String name) {
    return (getLubeModel.value.data ?? []).firstWhereOrNull(
          (lube) => lube.name == name,
    );
  }
}