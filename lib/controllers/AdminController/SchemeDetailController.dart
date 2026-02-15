import 'dart:convert';
import 'package:get/get.dart';

import '../../Data/AppDialoge.dart';
import '../../Utils/Api.dart';
import '../../models/AdminModels/GetSchmeDetailModel.dart';

class SchemeDetailController extends GetxController {
  var isLoading = false.obs;
  var schemeDetailModel = GetSchmeDetailModel().obs;

  Future<void> getSchemeDetail({required String schemeId}) async {
    print('Getting scheme detail for ID: $schemeId');
    isLoading.value = true;
    
    try {
      Map<String, dynamic> body = {};

      final response = await API.instance.get(
          endPoint: APIEndPoints.getSchemeId + schemeId,
          params: body,
          isHeader: true);

      var data = jsonDecode(response.body);
      var status = data['status'];
      var message = data['message'];

      if (status == "success" && data['data'] != null && data['data'].isNotEmpty) {
        print('Scheme detail loaded successfully');
        schemeDetailModel.value = GetSchmeDetailModel.fromJson(data);
      } else {
        print('Failed to load scheme details: $message');
        Appdialogs.showToast(message ?? "Failed to load scheme details");
      }
    } catch (e, stackTrace) {
      print('Error loading scheme details: $e');
      print('Stack trace: $stackTrace');
      Appdialogs.showToast("Error loading scheme details: ${e.toString()}");
    } finally {
      isLoading.value = false;
    }
  }

  void clearSchemeDetail() {
    schemeDetailModel.value = GetSchmeDetailModel();
  }

  @override
  void onClose() {
    clearSchemeDetail();
    super.onClose();
  }
}