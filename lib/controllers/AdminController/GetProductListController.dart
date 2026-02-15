import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';


import '../../Data/AppDialoge.dart';
import '../../Utils/Api.dart';
import '../../models/AdminModels/GetProductModel.dart';
import '../../models/AdminModels/LowStockProductListModel.dart';
import '../../models/AdminModels/ProductCountModel.dart';
import '../../models/AdminModels/ProductGraphModel.dart';

class GetProductController extends GetxController {
  var isLoading = false.obs;
  var isCountLoading = false.obs;
  var isLowStockLoading = false.obs;
  var isGraphLoading = false.obs;

  var getProductModel = GetProductModel().obs;
  var getProductCountModel = ProductCountModel().obs;
  var getLowStockProductModel = LowStockProductListModel().obs;
  var productGraphModel = ProductGraphModel().obs;

  List products = [].obs;

  void getProduct() async {
    isLoading.value = true;

    Map<String, dynamic> body = {};

    final response = await API.instance.get(
        endPoint: APIEndPoints.getProductList, params: body, isHeader: true);

    isLoading.value = false;
    try {
      var data = jsonDecode(response.body);
      var status = data['status'];
      var message = data['message'];

      if (status == "success") {
        getProductModel.value =
            GetProductModel.fromJson(json.decode(response.body));
      } else {
        Appdialogs.showToast(message);
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  void getProductCount() async {
    isCountLoading.value = true;

    Map<String, dynamic> body = {};

    final response = await API.instance.get(
        endPoint: APIEndPoints.getProductCount, params: body, isHeader: true);

    isCountLoading.value = false;
    try {
      var data = jsonDecode(response.body);
      var status = data['status'];
      var message = data['message'];

      if (status == "success") {
        getProductCountModel.value =
            ProductCountModel.fromJson(json.decode(response.body));
      } else {
        Appdialogs.showToast(message);
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  void getLowStockProducts() async {
    isLowStockLoading.value = true;

    Map<String, dynamic> body = {};

    final response = await API.instance.get(
        endPoint: APIEndPoints.getLowStockProductList, params: body, isHeader: true);

    isLowStockLoading.value = false;
    try {
      var data = jsonDecode(response.body);
      var status = data['status'];
      var message = data['message'];

      if (status == "success") {
        getLowStockProductModel.value =
            LowStockProductListModel.fromJson(json.decode(response.body));
      } else {
        Appdialogs.showToast(message);
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }


  void getProductGraph({
    required String productId,
    required String startDate,
    required String endDate,
  }) async {
    isGraphLoading.value = true;

    Map<String, dynamic> body = {
      "product_id": productId,
      "start_date": startDate,
      "end_date": endDate,
    };

    final response = await API.instance.post(
        endPoint: APIEndPoints.productGraph,  isHeader: true, params: body);

    isGraphLoading.value = false;
    try {
      var data = jsonDecode(response.body);
      var status = data['status'];
      var message = data['message'];

      if (status == "success") {
        productGraphModel.value = ProductGraphModel.fromJson(json.decode(response.body));
      } else {
        Appdialogs.showToast(message);
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }


  void refreshAllData() {
    getProduct();
    getProductCount();
    getLowStockProducts();
  }
}