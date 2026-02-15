// ignore_for_file: file_names

import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart';

import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../Authentication/LoginScreen.dart';
import '../Data/AppDialoge.dart';

import 'Const.dart';
import 'Preference.dart';

class API {
  API._privateConstructor();

  bool kIsStagingURL = false;
  static final API instance = API._privateConstructor();

  String get kBaseURL {
    if (kIsStagingURL) {
      return 'https://hsb.bugsbon.com/api';
    } else {
      return 'https://hsb.bugsbon.com/api';
    }
  }

  String get documentsUrl {
    if (kIsStagingURL) {
      return 'https://hsb.bugsbon.com/assets/user-documents/';
    } else {
      return 'https://hsb.bugsbon.com/assets/user-documents/';
    }
  }

  String get crewDocumentsUrl {
    if (kIsStagingURL) {
      return 'https://hsb.bugsbon.com/assets/crewmember-documents/';
    } else {
      return 'https://hsb.bugsbon.com/assets/crewmember-documents/';
    }
  }

  Future<Map<String, dynamic>> constParams({
    required Map<String, dynamic> body,
  }) async {
    // var fcm_token = await Preference.getSharedPref(KEY_FCM_TOKEN);
    //
    // body['device_id'] = fcm_token ?? 'KEY_DEVICE_ID';
    // body['device_details'] = KEY_DEVICE_INFO;
    // body['app_version'] = KEY_BUILD_NUMBER;
    // body['api_version'] = KEY_API_VERSION;
    // if (!kIsWeb) {
    //   body['device_type'] = (Platform.isAndroid) ? 'android' : 'ios';
    // }
    // body['debug_mode'] = (kDebugMode) ? 'true' : 'false';

    return body;
  }

  String internetConnectPoorBody = 'Internet connection is poor.';
  int internetConnectPoorCode = 1111;

  int apiExceptionCode = 1112;

  Future<bool> _checkInternet() async {
    try {
      final connectivityResult = await (Connectivity().checkConnectivity());
      if (connectivityResult[0] == ConnectivityResult.mobile) {
        return true;
      } else if (connectivityResult[0] == ConnectivityResult.wifi) {
        return true;
      } else {
        return false;
      }
    } catch (error) {
      return false;
    }
  }

  checkInternetSlow(http.Response response) {
    Future.delayed(const Duration(seconds: 1), () {
      if (response.statusCode == 1111) {
        Get.snackbar('Alert', 'Poor internet connection');
      }
    });
  }

  Future<http.Response> post(
      {required String endPoint,
      required Map<String, dynamic> params,
      bool isHeader = false}) async {
    if (!await _checkInternet()) {
      return http.Response("No internet connection", 0);
    }

    final url = Uri.parse(kBaseURL + endPoint);
    var token = await Preference.getSharedPref(KEY_TOKEN);

    Map<String, String> header = {};
    if (isHeader) {
      header = {
        'access_token': '$token',
      };
    }

    var bodyNew = await constParams(body: params);

    debugPrint(url.toString());
    debugPrint(bodyNew.toString());

    try {
      final response =
          await http.post(url, body: bodyNew, headers: header).timeout(
        const Duration(seconds: 20),
        onTimeout: () {
          return http.Response(
              internetConnectPoorBody, internetConnectPoorCode);
        },
      );

      log("header$header\nparam=${jsonEncode(params)}\n\nstatusCode=${response.statusCode}");
      log('Response :- ${response.body}');

      checkInternetSlow(response);

      // if (response.statusCode == 503) {
      //   Get.offAll(ServerError());
      // }

      final data = json.decode(response.body);

      final status = data['status'];

      if (status == 0) {
        Appdialogs.showToast(data['message']);
      } else if (status == 2) {
        SharedPreferences sharedPreferences =
            await SharedPreferences.getInstance();
        await sharedPreferences.clear();
        // firebaseToken;
        Get.offAll(LoginScreen());
      }

      return response;
    } catch (error) {
      debugPrint('Error is:- ${error.toString()}');

      final response = http.Response(error.toString(), apiExceptionCode);
      return response;
    }
  }

  Future<http.Response> get(
      {required String endPoint,
      Map<String, dynamic>? params,
      bool isHeader = false}) async {
    if (!await _checkInternet()) {
      return http.Response("No internet connection", 0);
    }

    var queryParams = '';
    if (params != null && params.isNotEmpty) {
      var bodyNew = await constParams(body: params);
      queryParams = '?' +
          Uri(
              queryParameters: bodyNew
                  .map((key, value) => MapEntry(key, value.toString()))).query;
    }

    final url = Uri.parse(kBaseURL + endPoint + queryParams);
    var token = await Preference.getSharedPref(KEY_TOKEN);

    Map<String, String> header = {};
    if (isHeader) {
      header = {
        'access_token': '$token',
      };
    }

    debugPrint('GET URL: ${url.toString()}');
    if (params != null) {
      debugPrint('GET Params: ${params.toString()}');
    }

    try {
      final response = await http.get(url, headers: header).timeout(
        const Duration(seconds: 20),
        onTimeout: () {
          return http.Response(
              internetConnectPoorBody, internetConnectPoorCode);
        },
      );

      log("header$header\n\nstatusCode=${response.statusCode}");
      log('Response :- ${response.body}');

      checkInternetSlow(response);

      // if (response.statusCode == 503) {
      //   Get.offAll(ServerError());
      // }

      final data = json.decode(response.body);

      final status = data['status'];

      if (status == 0) {
        Appdialogs.showToast(data['message']);
      } else if (status == 2) {
        SharedPreferences sharedPreferences =
            await SharedPreferences.getInstance();
        await sharedPreferences.clear();
        // firebaseToken;
        Get.offAll(LoginScreen());
      }

      return response;
    } catch (error) {
      debugPrint('Error is:- ${error.toString()}');

      final response = http.Response(error.toString(), apiExceptionCode);
      return response;
    }
  }

  Future<http.Response> postImage({
    required String endPoint,
    required Map<String, dynamic> params,
    required String fileParams,
    required File? file,
  }) async {
    if (!await _checkInternet()) {
      return http.Response("No internet connection", 0);
    }

    final url = Uri.parse('$kBaseURL$endPoint');
    var token = await Preference.getSharedPref(KEY_TOKEN);

    // var bodyNew = await constParams(body: params);

    final request = http.MultipartRequest('POST', url);

    request.headers['Authorization'] = 'Bearer $token';

    params.forEach((key, value) {
      request.fields[key] = value;
    });

    debugPrint('Token :- $token');
    debugPrint('URL :- $url');
    debugPrint('params :- ${params.toString()}');

    try {
      if (file!.path.isNotEmpty) {
        request.files
            .add(await http.MultipartFile.fromPath(fileParams, file.path));
      }

      final response = await request.send();

      final res = await http.Response.fromStream(response).timeout(
        const Duration(minutes: 1),
        onTimeout: () {
          return http.Response('Internet connection is poor.', 1111);
        },
      );

      final data = json.decode(res.body);

      debugPrint('data :- ${data.toString()}');

      final status = data['status'];

      if (status == 2) {
        SharedPreferences sharedPreferences =
            await SharedPreferences.getInstance();
        await sharedPreferences.clear();
        // firebaseToken;
        Get.offAll(LoginScreen());
      }

      return res;
    } catch (error) {
      debugPrint('Error is:- ${error.toString()}');
      final response = http.Response(error.toString(), apiExceptionCode);
      return response;
    }
  }

  Future<http.Response> multiplePostImage({
    required String endPoint,
    required Map<String, dynamic> params,
    required String fileParams,
    // required String imageParams,
    required File? file,
    // required File? image,
  }) async {
    if (!await _checkInternet()) {
      return http.Response("", 0);
    }

    final url = Uri.parse('$kBaseURL$endPoint');

    var tokenAPI = await Preference.getSharedPref(KEY_TOKEN);
    // var bodyNew = await constParams(body: params);

    final request = http.MultipartRequest('POST', url);

    request.headers['Content-Type'] = 'multipart/form-data';
    request.headers['Authorization'] = '$tokenAPI';

    params.forEach((key, value) {
      request.fields[key] = value;
    });
// image!.path.isNotEmpty
    try {
      if (file!.path.isNotEmpty) {
        request.files
            .add(await http.MultipartFile.fromPath(fileParams, file.path));
        // request.files
        //     .add(await http.MultipartFile.fromPath(imageParams, image.path));
      }

      debugPrint('URL :- $url');
      debugPrint('params :- $params');

      final response = await request.send();

      debugPrint('${response.request.toString()}');
      debugPrint('${response.stream.toString()}');

      final res = await http.Response.fromStream(response).timeout(
        const Duration(minutes: 1),
        onTimeout: () {
          return http.Response('Internet connection is poor.', 1111);
        },
      );

      final data = json.decode(res.body);

      final status = data['status']; // Fixed: use 'status' instead of 'statusCode' for consistency

      if (status == 2) {
        SharedPreferences sharedPreferences =
            await SharedPreferences.getInstance();
        await sharedPreferences.clear();
        // firebaseToken;
        Get.offAll(LoginScreen());
      }

      return res;
    } catch (error) {
      final response = http.Response(error.toString(), apiExceptionCode);
      return response;
    }
  }

  Future<http.Response> multipleImages({
    required String endPoint,
    required Map<String, dynamic> params,
    required String fileParams,
    required List<File>? file,
  }) async {
    if (!await _checkInternet()) {
      return http.Response("No internet connection", 0);
    }

    final url = Uri.parse('$kBaseURL$endPoint');
    var tokenAPI = await Preference.getSharedPref(KEY_TOKEN);

    final request = http.MultipartRequest('POST', url);
    request.headers['access_token'] = '$tokenAPI';

    // Add all text parameters
    params.forEach((key, value) {
      request.fields[key] = value;
    });

    try {
      // Add images with specific parameter names the API expects
      if (file != null && file.isNotEmpty) {
        if (file.length >= 1) {
          // First file is aadhar_front_image
          request.files.add(await http.MultipartFile.fromPath(
              'aadhar_front_image', file[0].path));
        }

        if (file.length >= 2) {
          // Second file is aadhar_back_image
          request.files.add(await http.MultipartFile.fromPath(
              'aadhar_back_image', file[1].path));
        }
      }

      debugPrint('API URL: $url');
      debugPrint('API Params: $params');
      if (file != null) {
        debugPrint('API Files count: ${file.length}');
        for (int i = 0; i < file.length; i++) {
          debugPrint('File $i: ${file[i].path}');
        }
      }

      final streamedResponse = await request.send();

      final res = await http.Response.fromStream(streamedResponse).timeout(
        const Duration(minutes: 1),
        onTimeout: () {
          return http.Response('Internet connection is poor.', 1111);
        },
      );

      debugPrint('API Response status code: ${res.statusCode}');
      debugPrint('API Response body: ${res.body}');

      try {
        final data = json.decode(res.body);
        debugPrint('API Response decoded: $data');

        final status = data['status'];

        if (status == 2) {
          SharedPreferences sharedPreferences =
              await SharedPreferences.getInstance();
          await sharedPreferences.clear();
          Get.offAll(LoginScreen());
        }
      } catch (e) {
        debugPrint('Error parsing response: ${e.toString()}');
      }

      return res;
    } catch (error) {
      debugPrint('Error in API call: ${error.toString()}');
      final response = http.Response(error.toString(), apiExceptionCode);
      return response;
    }
  }
}

class APIEndPoints {
  // Authentication Endpoints
  static const String login = "/login";
  static const String adminLogin = "/admin-login";
  static const String ManagerLogin = "/manager-login";
  static const String TruckLogin = "/truck-login";
  static const String EmployeeLogin = "/employee-login";
  static const String imageBaseUrl = "https://yourdomain.com/uploads/";
  // Branch Endpoints
  static const String createBranch = "/create-branch";
  static const String getBranchList = "/get-branch-list";
  static const String updateBranchList = "/update-branch";
  static const String getBranch = "/get-branch/id";
  static const String branchSearchList = "/get-branch-list/searchvalue";
  static const String updateBranchStatus =
      "/update-admin-status/id/status"; // active inactive

  // Admin Endpoints
  static const String createAdmin = "/create-admin";
  static const String getAdminList = "/get-admin-list";
  static const String updateAdmin = "/update-admin";

  //Product
  static const String createProductName = "/create-product-name";
  static const String addProduct = "/add-product";
  static const String updateproduct = "/update-product";
  static const String getProductName = "/get-product-name";
  static const String getProductId = "/get-product/";
  static const String getProductList = "/get-product-list";
  static const String getProductCount = "/product-count";
  static const String getProductListSearch = "/get-product-list/search";
  static const String updateProductStatus = "/update-product-status";
  static const String productGraph = "/product-graph";
  static const String exportReports = "/export-report-product";
  static const String getLowStockProductList = "/get-low-stock-product-list";

  //Machine
  static const String addMachine = "/add-machine";
  static const String updateMachine = "/update-machine";
  static const String getMachineId = "/get-machine/";
  static const String getMachineList = "/get-machine-list";
  static const String getMachineListSearch = "/get-machine-list/search";
  static const String updateMachineStatus = "/update-machine-status";

  static const String getAdmin = "/get-admin/1"; // get single detail
  static const String adminSearchList =
      "/get-admin-list/search"; // search within list
  static const String updateAdminStatus =
      "/update-admin-status/id/status"; // active/inactive

  // Trash Endpoints
  static const String trashList = "/get-trash-list";

  // Staff
  static const String addStaff = "/add-staff";
  static const String updateStaff = "/update-staff";
  static const String getStaffDetail = "/get-staff/";
  static const String getStaffList = "/get-staff-list";
  static const String updateStaffStatus = "/update-staff-status/";
  static const String totalStaff = "/total-staff";
  static const String AddRequest = "/add-request";

  //Add Scheme

  static const String createSchemeName = "/create-scheme-name";

  static const String getSchemeName = "/get-scheme-name";
  static const String addUpdateScheme = "/add-update-scheme";
  static const String getSchemeId = "/get-scheme/";
  static const String getSchemeListSearch = "/get-scheme-list/search";
  static const String updateSchemeStatus = "/update-scheme-status";
  static const String getSchemeList = "/get-scheme-list";

  // Gift
  static const String addGift = "/add-gifts";
  static const String updateGift = "/update-gifts";
  static const String updateGiftStatus = "/update-gift-status"; // /id/status
  static const String getGiftDetail = "/get-gift-details"; // /id
  static const String searchGifts = "/gifts-list/search"; // search parameter
  static const String getGiftsList = "/get-gifts-list";

  //create customer
  static const String addCreditCustomer = "/add-credit-customer";
  static const String updateCreditCustomer = "/update-credit-customer";
  static const String getCreditCustomerId = "/get-credit-customer/";
  static const String getCreditCustomerList = "/get-credit-customer-list";
  static const String updateCreditCustomerStatus =
      "/update-credit-customer-status";
  static const String creditCustomerProductList =
      "/credit-customer-product-list/"; // id

  // Tanker(Admin)
  static const String addTanker = "/add-tanker";
  static const String updateTanker = "/update-tanker";
  static const String getTankerList = "/get-tanker-list";
  static const String getTotalTanker = "/get-total-tanker";
  static const String getTankerDetail = "/get-tanker-detail/"; // id
  static const String addCrewMember = "/add-crew-member";
  static const String getTankerTypes = "/get-tanker-types";
// In your Api.dart file - CORRECTED
  static const String updateTankerStatus = "/update-tanker-status";
  // Tasks
  static const String addTask = "/add-task";

  // Trash / Restore
  static const String restoreItem = "/restore-item/"; // id/type

  //addition

  static const String getVehicleTypes = "/getVehicleTypes";
  static const String getProductTypes = "/getProductTypes";

  // lube api Export report
  static const String getLubeList = "/get-lube-list";
// Customer Endpoints - CORRECTED
  // Customer Endpoints - CORRECTED
  static const String addCustomer = "/add-customer";
  static const String updateCustomer = "/update-customer";
  static const String getCustomer = "/get-customer/"; // /id
  static const String getCustomerList = "/get-customer-list/"; // CORRECT: For listing customers (page & search optional)
  static const String updateCustomerStatus = "/update-customer-status/"; // /id/status
// Remove or comment out the searchCustomers endpoint since it's the same as getCustomerList
// static const String searchCustomers = "/get-customer-list/search"; // REMOVE THIS

  static const String getProfile = "/profile/id";
  static const String GetExpenseType = "/get-expense-type";
  static const String AddExpense = "/add-expense";
  static const String GetExpenseList = "/get-expense-list";
  static const String GetTaskList = "/get-task-list";






}



