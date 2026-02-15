import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Data/AppDialoge.dart';
import '../../Utils/Api.dart';
import '../../models/AdminModels/GetMachineDetailModel.dart';

class GetMachineDetailController extends GetxController {
  var isLoading = false.obs;
  var getMachineDetailModel = GetMachineDetailModel().obs;

  Future<void> getMachineDetail({required String machineId}) async {
    isLoading.value = true;

    Map<String, dynamic> body = {};

    try {
      final response = await API.instance.get(
          endPoint: APIEndPoints.getMachineId + machineId,
          params: body,
          isHeader: true);

      var data = jsonDecode(response.body);
      var status = data['status'];
      var message = data['message'];
      var responseCode = data['response_code'];

      if (status == "success" && responseCode == 200) {
        getMachineDetailModel.value.data == null;

        getMachineDetailModel.value =
            GetMachineDetailModel.fromJson(json.decode(response.body));
      } else {
        Appdialogs.showToast(message);
      }
    } catch (e, stackTrace) {
      debugPrint(e.toString());
      Appdialogs.showToast("Error loading product details");
    } finally {
      isLoading.value = false;
    }
  }
}
