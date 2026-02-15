import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/SuperAdminModel/updateadminstatusmodel.dart';


class UpdateAdminStatusController extends GetxController {
  var isLoading = false.obs;
  var adminId = Rxn<int>(); // Nullable admin ID
  var adminStatus = "".obs; // Stores admin status

  // Fetch access token from SharedPreferences
  Future<String?> getAccessToken() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      return prefs.getString('accessToken');
    } catch (e) {
      print("❌ Error fetching access token: $e");
      return null;
    }
  }

  // Function to update admin status
  Future<void> updateAdminStatus(int id, String status) async {
    isLoading.value = true;

    Uri url = Uri.parse("https://hsb.bugsbon.com/api/update-admin-status/$id/$status");

    try {
      final token = await getAccessToken();
      if (token == null || token.isEmpty) {
        Get.snackbar('Error', 'Not authenticated. Please log in.');
        isLoading.value = false;
        return;
      }

      final headers = {
        'access_token': token,
      };

      final response = await http.get(url, headers: headers);

      print("🔄 Sending GET request to: $url");
      print("📌 Headers: $headers");
      print("📩 Response Status Code: ${response.statusCode}");
      print("📩 Response Body: ${response.body}");
      print("admin id : ${adminId}, admin status: ${status}");

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        final updateResponse = UpdateAdminStatus.fromJson(jsonData);

        if (updateResponse.status == 'success') {
          Get.snackbar('Success', updateResponse.message ?? 'Admin status updated successfully');

          // ✅ Update local admin status
          adminStatus.value = status;
          update();
        } else {
          Get.snackbar('Error', updateResponse.message ?? 'Failed to update admin status');
        }
      } else {
        try {
          final errorData = jsonDecode(response.body);
          Get.snackbar('Error', errorData['error'] ?? 'Failed to update admin status');
        } catch (_) {
          Get.snackbar('Error', 'Unexpected response format.');
        }
      }
    } catch (e) {
      print("❌ Exception: $e");
      Get.snackbar('Error', 'An unexpected error occurred: $e');
    } finally {
      isLoading.value = false;
    }
  }

  // Function to set admin data
  void setAdminData(int? id, String status) {
    if (id == null) {
      print("⚠️ Attempted to set adminId to null!");
      Get.snackbar("Error", "Invalid admin ID.");
      return;
    }

    adminId.value = id;
    adminStatus.value = status;
  }
}