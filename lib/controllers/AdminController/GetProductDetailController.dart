import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Data/AppDialoge.dart';
import '../../Utils/Api.dart';
import '../../models/AdminModels/GetProducsDetailModel.dart';

class GetProductDetailController extends GetxController {
  var isLoading = false.obs;
  var getProductDetailModel = GetProductDetailModel().obs;

  Future<void> getProductDetail({required String productId}) async {

    isLoading.value = true;

    Map<String, dynamic> body = {};

    try {
      final response = await API.instance.get(
          endPoint: APIEndPoints.getProductId + productId,
          params: body,
          isHeader: true);

      var data = jsonDecode(response.body);
      var status = data['status'];
      var message = data['message'];
      var responseCode = data['response_code'];

      if (status == "success" && responseCode == 200) {
        getProductDetailModel.value.data == null;

        getProductDetailModel.value =
            GetProductDetailModel.fromJson(json.decode(response.body));
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
