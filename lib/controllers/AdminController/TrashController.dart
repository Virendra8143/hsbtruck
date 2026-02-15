import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Data/AppDialoge.dart';
import '../../Utils/Api.dart';

class TrashController extends GetxController {
  var isLoading = false.obs;
  var isRestoring = false.obs;
  var trashItems = [].obs;

  Future<void> getTrashList() async {
    isLoading.value = true;
    try {
      final response = await API.instance.get(
        endPoint: APIEndPoints.trashList,
        params: {},
        isHeader: true,
      );
      final data = jsonDecode(response.body);
      if (data['status'] == 'success') {
        trashItems.value = data['data'] ?? [];
      } else {
        Appdialogs.showToast(data['message'] ?? 'Failed to load trash');
      }
    } catch (e) {
      debugPrint('Error loading trash list: $e');
      Appdialogs.showToast('Error loading trash list');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> restoreItem({required String id, required String trashType}) async {
    isRestoring.value = true;
    try {
      final endpoint = APIEndPoints.restoreItem + "$id/$trashType";
      final response = await API.instance.get(
        endPoint: endpoint,
        params: {},
        isHeader: true,
      );
      final data = jsonDecode(response.body);
      final status = data['status'];
      final message = data['message'] ?? '';
      if (status == 'success') {
        Appdialogs.showToast(message.isNotEmpty ? message : 'Item restored successfully');
        await getTrashList();
      } else {
        Appdialogs.showToast(message.isNotEmpty ? message : 'Failed to restore item');
      }
    } catch (e) {
      debugPrint('Error restoring item: $e');
      Appdialogs.showToast('Error restoring item');
    } finally {
      isRestoring.value = false;
    }
  }
}



