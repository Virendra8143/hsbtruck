import 'dart:convert';
import 'package:get/get.dart';

import '../../Data/AppDialoge.dart';
import '../../Utils/Api.dart';
import '../../models/AdminModels/CustomerDetailModel.dart';

class CustomerDetailController extends GetxController {
  var isLoading = false.obs;
  var customerDetailModel = CustomerDetailModel().obs;

  Future<void> getCustomerDetail({required String customerId}) async {
    print('Getting customer detail for ID: $customerId');
    isLoading.value = true;
    
    try {
      Map<String, dynamic> body = {};

      final response = await API.instance.get(
          endPoint: APIEndPoints.getCreditCustomerId + customerId,
          params: body,
          isHeader: true);

      var data = jsonDecode(response.body);
      var status = data['status'];
      var message = data['message'];

      if (status == "success" && data['data'] != null && data['data'].isNotEmpty) {
        print('Customer detail loaded successfully');
        customerDetailModel.value = CustomerDetailModel.fromJson(data);
      } else {
        print('Failed to load customer details: $message');
        Appdialogs.showToast(message ?? "Failed to load customer details");
      }
    } catch (e, stackTrace) {
      print('Error loading customer details: $e');
      print('Stack trace: $stackTrace');
      Appdialogs.showToast("Error loading customer details: ${e.toString()}");
    } finally {
      isLoading.value = false;
    }
  }

  void clearCustomerDetail() {
    customerDetailModel.value = CustomerDetailModel();
  }

  @override
  void onClose() {
    clearCustomerDetail();
    super.onClose();
  }
}