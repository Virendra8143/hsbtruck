//
// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:http/http.dart' as http;
//
// import '../Data/AppDialoge.dart';
// import '../Screens/Admin/AdminDashboard.dart';
// import '../Utils/Api.dart';
// import '../Utils/Const.dart';
// import '../Utils/Preference.dart';
// import '../models/LoginUserModel.dart';
//
//
//
// class LoginController extends GetxController {
//   var workIdController = TextEditingController().obs;
//   var passwordController = TextEditingController().obs;
//
//   var loginUserModel = LoginUserModel().obs;
//
//   final formKey = GlobalKey<FormState>();
//   RxBool proccessing = false.obs;
//
//   var isCheckedValue = true.obs;
//
//   // loginUser() async {
//   //   if (formKey.currentState!.validate()) {
//   //     try {
//   //       proccessing.value = true;
//   //       Map<String, dynamic> bodydata = {
//   //         "work_id": workIdController.value.text,
//   //         "password": passwordController.value.text,
//   //       };
//   //
//   //       final response = await API.instance
//   //           .post(endPoint: APIEndPoints.EmployeeLogin, params: bodydata);
//   //
//   //       var data = jsonDecode(response.body);
//   //       var status = data['status'];
//   //       var message = data['message'];
//   //
//   //       if (data['status'] == 'success' && data['response_code'] == 200) {
//   //         await Preference.saveSharedPrefString(
//   //             KEY_TOKEN, data['data']['access_token']);
//   //         await Preference.saveSharedPrefBool(KEY_LOGIN, true);
//   //
//   //         // Save user name and ID to SharedPreferences
//   //         await Preference.saveSharedPrefString(
//   //             'user_name', data['data']['name'] ?? '');
//   //         await Preference.saveSharedPrefString(
//   //             'user_id', data['data']['id']?.toString() ?? '');
//   //
//   //         Appdialogs.showToast(message ?? '');
//   //         loginUserModel.value =
//   //             LoginUserModel.fromJson(json.decode(response.body));
//   //
//   //         proccessing.value = false;
//   //         Get.offAll(() => AdminDashBoard());
//   //       } else  {
//   //         Appdialogs.showToast(message ?? '');
//   //         proccessing.value = false;
//   //       }
//   //
//   //     } catch (e) {
//   //       proccessing.value = false;
//   //       throw Exception(e);
//   //     }
//   //   }
//   // }
//   loginUser() async {
//     if (formKey.currentState!.validate()) {
//       try {
//         proccessing.value = true;
//         Map<String, dynamic> bodydata = {
//           "work_id": workIdController.value.text,
//           "password": passwordController.value.text,
//         };
//
//         final response = await API.instance
//             .post(endPoint: APIEndPoints.EmployeeLogin, params: bodydata);
//
//         var data = jsonDecode(response.body);
//         var status = data['status'];
//         var message = data['message'];
//
//         // Print response for debugging
//         print('[Employee Login] Response: ${response.body}');
//
//         if (data['status'] == 'success' && data['response_code'] == 200) {
//           // ✅ ID SAVE KARO DONO KEYS MEIN (IMPORTANT)
//           final userData = data['data'];
//
//           // 1. 'id' key mein save karo (Profile screen ke liye)
//           await Preference.saveSharedPrefString('id', userData['id']?.toString() ?? '');
//
//           // 2. 'user_id' key mein bhi save karo (existing code ke liye)
//           await Preference.saveSharedPrefString('user_id', userData['id']?.toString() ?? '');
//
//           // 3. Token save karo
//           await Preference.saveSharedPrefString(KEY_TOKEN, userData['access_token']);
//           await Preference.saveSharedPrefBool(KEY_LOGIN, true);
//
//           // 4. Name aur work_id save karo
//           await Preference.saveSharedPrefString('user_name', userData['name'] ?? '');
//           await Preference.saveSharedPrefString('work_id', userData['work_id'] ?? '');
//
//           // Debug prints
//           print('[Employee Login] ✅ User ID saved: ${userData['id']}');
//           print('[Employee Login] ✅ Token saved: ${userData['access_token']}');
//           print('[Employee Login] ✅ Name saved: ${userData['name']}');
//
//           // Check karo ID save hua ya nahi
//           final savedId = await Preference.getSharedPref('id');
//           print('[Employee Login] 📱 Saved ID check: $savedId');
//
//           Appdialogs.showToast(message ?? 'Login successful');
//           loginUserModel.value = LoginUserModel.fromJson(json.decode(response.body));
//
//           proccessing.value = false;
//           Get.offAll(() => AdminDashBoard());
//         } else {
//           Appdialogs.showToast(message ?? 'Login failed');
//           proccessing.value = false;
//         }
//
//       } catch (e) {
//         proccessing.value = false;
//         print('[Employee Login] Error: $e');
//         Appdialogs.showToast('Login failed: $e');
//       }
//     }
//   }
//
// }

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../Data/AppDialoge.dart';
import '../Screens/Admin/AdminDashboard.dart';
import '../Utils/Api.dart';
import '../Utils/Const.dart';
import '../Utils/Preference.dart';
import '../models/LoginUserModel.dart';

class LoginController extends GetxController {
  var workIdController = TextEditingController().obs;
  var passwordController = TextEditingController().obs;

  var loginUserModel = LoginUserModel().obs;

  final formKey = GlobalKey<FormState>();
  RxBool proccessing = false.obs;
  var isCheckedValue = true.obs;

  loginUser() async {
    if (formKey.currentState!.validate()) {
      try {
        proccessing.value = true;
        Map<String, dynamic> bodydata = {
          "work_id": workIdController.value.text,
          "password": passwordController.value.text,
        };

        print('[Employee] Login API call...');
        final response = await API.instance
            .post(endPoint: APIEndPoints.TruckLogin, params: bodydata);

        var data = jsonDecode(response.body);
        var status = data['status'];
        var message = data['message'];

        // Print full response for debugging
        print('[Employee] Login Response: ${response.body}');

        if (data['status'] == 'success' && data['response_code'] == 200) {
          final userData = data['data'];

          // 🚨🚨🚨 ID SAVE KARO YAHAN 🚨🚨🚨
          if (userData['id'] != null) {
            // 'id' key mein save karo (Profile screen ke liye)
            await Preference.saveSharedPrefString('id', userData['id'].toString());
            print('[Employee] ✅ ID saved in "id" key: ${userData['id']}');
          } else {
            print('[Employee] ❌ ERROR: id field is null in response');
            print('[Employee] Available keys: ${userData.keys}');
          }

          // 'user_id' key mein bhi save karo
          if (userData['id'] != null) {
            await Preference.saveSharedPrefString('user_id', userData['id'].toString());
          }

          // Token save karo
          if (userData['access_token'] != null) {
            await Preference.saveSharedPrefString(KEY_TOKEN, userData['access_token']);
            print('[Employee] ✅ Token saved: ${userData['access_token']}');
          }

          await Preference.saveSharedPrefBool(KEY_LOGIN, true);

          // Name aur work_id save karo
          if (userData['name'] != null) {
            await Preference.saveSharedPrefString('user_name', userData['name']);
            print('[Employee] ✅ Name saved: ${userData['name']}');
          }

          if (userData['work_id'] != null) {
            await Preference.saveSharedPrefString('work_id', userData['work_id']);
            print('[Employee] ✅ Work ID saved: ${userData['work_id']}');
          }

          // Debug: Check karo ID save hua ya nahi
          final savedId = await Preference.getSharedPref('id');
          final savedUserId = await Preference.getSharedPref('user_id');
          print('[Employee] 📱 Check - ID from "id" key: $savedId');
          print('[Employee] 📱 Check - ID from "user_id" key: $savedUserId');

          Appdialogs.showToast(message ?? 'Login successful');
          loginUserModel.value = LoginUserModel.fromJson(json.decode(response.body));

          proccessing.value = false;
          Get.offAll(() => AdminDashBoard());
        } else {
          Appdialogs.showToast(message ?? 'Login failed');
          proccessing.value = false;
        }

      } catch (e) {
        proccessing.value = false;
        print('[Employee] Login Error: $e');
        Appdialogs.showToast('Login failed: $e');
      }
    }
  }

  // Debug function
  Future<void> checkSavedData() async {
    print('=== CHECKING SAVED EMPLOYEE DATA ===');
    final id = await Preference.getSharedPref('id');
    final userId = await Preference.getSharedPref('user_id');
    final name = await Preference.getSharedPref('user_name');
    final workId = await Preference.getSharedPref('work_id');
    final token = await Preference.getSharedPref(KEY_TOKEN);

    print('ID (id key): $id');
    print('ID (user_id key): $userId');
    print('Name: $name');
    print('Work ID: $workId');
    print('Token: $token');

    Get.snackbar(
      'Debug',
      'ID: ${id ?? "NULL"}\nUser_ID: ${userId ?? "NULL"}',
      duration: Duration(seconds: 5),
    );
  }
}