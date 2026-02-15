import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../../Data/AppDialoge.dart';
import '../../Screens/Admin/CreditCustomer/CreateCustomer.dart';
import '../../Utils/Api.dart';
import '../../models/AdminModels/CustomerListModel.dart';

class CreditCoustomerController extends GetxController {
  var nameController = TextEditingController();
  var isLoading = false.obs;


  Rx<CustomerListModel?> customerList = Rx<CustomerListModel?>(null);


  void getCreditCustomerList({String searchText = ''}) async {
    isLoading.value = true;
    try {
      final endpoint = searchText.isNotEmpty
          ? "${APIEndPoints.getCreditCustomerList}/$searchText"
          : APIEndPoints.getCreditCustomerList;

      final response = await API.instance.get(
        endPoint: endpoint,
        isHeader: true,
      );

      final data = jsonDecode(response.body);
      if (data['status'] == "success") {
        customerList.value = CustomerListModel.fromJson(data);
      } else {
        Appdialogs.showToast(data['message']);
        customerList.value = null;
      }
    } catch (e) {
      debugPrint("Error: $e");
      Appdialogs.showToast("Failed to load customer list");
      customerList.value = null;
    } finally {
      isLoading.value = false;
    }
  }


  // void getCreditCustomerList() async {
  //   isLoading.value = true;
  //
  //   try {
  //     Map<String, dynamic> body = {};
  //
  //     final response = await API.instance.get(
  //         endPoint: APIEndPoints.getCreditCustomerList,
  //         params: body,
  //         isHeader: true);
  //
  //     var data = jsonDecode(response.body);
  //     var status = data['status'];
  //     var message = data['message'];
  //
  //     if (status == "success") {
  //       // Parse and store the customer list
  //       customerList.value = CustomerListModel.fromJson(data);
  //
  //       // Optional: Show success message
  //       // Appdialogs.showToast(message);
  //
  //       debugPrint(
  //           "Customer list loaded successfully: ${customerList.value?.data?.length} customers");
  //     } else {
  //       Appdialogs.showToast(message);
  //       // Clear the list on error
  //       customerList.value = null;
  //     }
  //   } catch (e, stackTrace) {
  //     debugPrint("Error in getCreditCustomerList: ${e.toString()}");
  //     debugPrint("StackTrace: ${stackTrace.toString()}");
  //
  //     // Clear the list on error
  //     customerList.value = null;
  //
  //     // Show error message to user
  //     Appdialogs.showToast("Failed to load customer list");
  //   } finally {
  //     isLoading.value = false;
  //   }
  // }

  // Helper methods for getting counts
  int getActiveCustomersCount() {
    final data = customerList.value?.data;
    if (data == null) return 0;
    return data
        .where((customer) => customer.status?.toLowerCase() == 'active')
        .length;
  }

  int getInactiveCustomersCount() {
    final data = customerList.value?.data;
    if (data == null) return 0;
    return data
        .where((customer) => customer.status?.toLowerCase() == 'inactive')
        .length;
  }

  int getTotalCustomersCount() {
    return customerList.value?.data?.length ?? 0;
  }

  // Method to refresh the list
  void refreshCustomerList() {
    getCreditCustomerList();
  }

  @override
  void onClose() {
    nameController.dispose();
    super.onClose();
  }
}
