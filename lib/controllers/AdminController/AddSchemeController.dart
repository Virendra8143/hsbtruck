//
// import 'dart:async';
// import 'dart:convert';
//
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
//
// import '../../Data/AppDialoge.dart';
// import '../../Utils/Api.dart';
// import '../../models/AdminModels/GetSchemeLIstModel.dart';
// import '../../models/AdminModels/GetSchemeNameModel.dart';
//
// class AddSchemeController extends GetxController {
//   var nameController = TextEditingController();
//   var isLoading = false.obs;
//   var isSchemeListLoading = false.obs; // Separate loading state for scheme list
//   var schemeName = [].obs;
//
//   var selectedSchemeName = ''.obs;
//   var selectedSchemeId = ''.obs;
//   var selectedVehicleType = ''.obs;
//   var selectedProductType = ''.obs;
//   var selectedGift = ''.obs;
//   var selectedQty = ''.obs;
//   final productNameController = TextEditingController();
//
//   // For editing
//   var isEditMode = false.obs;
//   var editingSchemeId = ''.obs;
//
//   var getSchemeNameListModel = GetSchemeNameModel().obs;
//   var getSchemeListModel = GetSchemeLIstModel().obs;
//
//   // Dynamic lists for dropdowns
//   var vehicleTypes = <String>[].obs;
//   var productTypes = <String>[].obs;
//   var selectedGiftId = ''.obs;
//   var selectedGiftQty = ''.obs;
//   void createSchemeName({required String name}) async {
//     isLoading.value = true;
//
//     if (name.isEmpty) {
//       Get.snackbar('Error', 'Scheme name is required.');
//       isLoading.value = false;
//       return;
//     }
//
//     Map<String, dynamic> body = {"name": name};
//
//     final response = await API.instance.post(
//         endPoint: APIEndPoints.createSchemeName, params: body, isHeader: true);
//
//     isLoading.value = false;
//     try {
//       var data = jsonDecode(response.body);
//       var status = data['status'];
//       var message = data['message'];
//
//       if (status == "success") {
//         Appdialogs.showToast(message);
//         nameController.clear();
//
//         // Automatically refresh the scheme names list after creating a new one
//         getSchemeName();
//       } else {
//         Appdialogs.showToast(message);
//       }
//     } catch (e) {
//       debugPrint(e.toString());
//     }
//   }
//
//   void getSchemeName() async {
//     isLoading.value = true;
//
//     Map<String, dynamic> body = {};
//
//     final response = await API.instance.get(
//         endPoint: APIEndPoints.getSchemeName, params: body, isHeader: true);
//
//     isLoading.value = false;
//     try {
//       var data = jsonDecode(response.body);
//       var status = data['status'];
//       var message = data['message'];
//
//       if (status == "success") {
//         getSchemeNameListModel.value = GetSchemeNameModel.fromJson(data);
//       } else {
//         Appdialogs.showToast(message);
//       }
//     } catch (e) {
//       debugPrint(e.toString());
//     }
//   }
//
//   void getVehicleTypes() async {
//     try {
//       final response = await API.instance.get(
//           endPoint: APIEndPoints.getVehicleTypes, params: {}, isHeader: true);
//
//       var data = jsonDecode(response.body);
//       var status = data['status'];
//
//       if (status == "success" && data['data'] != null) {
//         vehicleTypes.value = List<String>.from(data['data']);
//       } else {
//         // Fallback to default values if API fails
//         vehicleTypes.value = ['Car', 'Bike', 'Truck', 'Bus', 'Van'];
//       }
//     } catch (e) {
//       debugPrint('Error getting vehicle types: $e');
//       // Fallback to default values
//       vehicleTypes.value = ['Car', 'Bike', 'Truck', 'Bus', 'Van'];
//     }
//   }
//
//   void getProductTypes() async {
//     try {
//       final response = await API.instance.get(
//           endPoint: APIEndPoints.getProductTypes, params: {}, isHeader: true);
//
//       var data = jsonDecode(response.body);
//       var status = data['status'];
//
//       if (status == "success" && data['data'] != null) {
//         productTypes.value = List<String>.from(data['data']);
//       } else {
//         // Fallback to default values if API fails
//         productTypes.value = ['Petrol', 'Diesel', 'Lube', 'Power'];
//       }
//     } catch (e) {
//       debugPrint('Error getting product types: $e');
//       // Fallback to default values
//       productTypes.value = ['Petrol', 'Diesel', 'Lube', 'Power'];
//     }
//   }
//
//   void addScheme() async {
//     // Validate inputs before API call
//     if (selectedSchemeId.value.isEmpty) {
//       Appdialogs.showToast('Please select a scheme name');
//       return;
//     }
//     if (selectedVehicleType.value.isEmpty) {
//       Appdialogs.showToast('Please select a vehicle type');
//       return;
//     }
//     if (selectedProductType.value.isEmpty) {
//       Appdialogs.showToast('Please select a product');
//       return;
//     }
//     // liter_range or qty may be optional per API; enforce presence if your UI requires
//     // If both are empty, prompt user
//     if ((selectedQty.value.isEmpty) && (selectedGift.value.isEmpty)) {
//       // At least one of qty or gifts can be provided; adjust rule as needed
//       // Here we only warn if everything is empty
//       // Not returning to allow empty fields if API permits
//     }
//
//     isLoading.value = true;
//
//     Map<String, dynamic> body = {
//       "scheme_id": selectedSchemeId.value,
//       "vehicle_type": selectedVehicleType.value,
//       "product": selectedProductType.value,
//       "liter_range": selectedQty.value,
//       "gifts": selectedGift.value,
//       "qty": selectedQty.value,
//     };
//
//     // Add id parameter for updates
//     if (isEditMode.value && editingSchemeId.value.isNotEmpty) {
//       body['id'] = editingSchemeId.value;
//     }
//
//     final response = await API.instance.post(
//         endPoint: APIEndPoints.addUpdateScheme, params: body, isHeader: true);
//
//     isLoading.value = false;
//     try {
//       var data = jsonDecode(response.body);
//       var status = data['status'];
//       var message = data['message'];
//
//       if (status == "success") {
//         Appdialogs.showToast(message);
//
//         // Clear form
//         clearForm();
//
//         // Refresh the scheme list
//         getSchemeList();
//       } else {
//         Appdialogs.showToast(message);
//       }
//     } catch (e) {
//       debugPrint(e.toString());
//     }
//   }
//
//   void getSchemeList({String? searchText}) async {
//     // Use separate loading state for scheme list
//     isSchemeListLoading.value = true;
//
//     Map<String, dynamic> params = {};
//
//     // Build endpoint and params based on search text
//     String endpoint = APIEndPoints.getSchemeList;
//     if (searchText != null && searchText.isNotEmpty) {
//       endpoint = APIEndPoints.getSchemeListSearch;
//       params['search'] = searchText;
//     }
//
//     final response = await API.instance.get(
//         endPoint: endpoint, params: params, isHeader: true);
//
//     isSchemeListLoading.value = false;
//     try {
//       var data = jsonDecode(response.body);
//       var status = data['status'];
//       var message = data['message'];
//
//       if (status == "success") {
//         getSchemeListModel.value = GetSchemeLIstModel.fromJson(data);
//       } else {
//         Appdialogs.showToast(message);
//         // Clear the list if error occurs
//         getSchemeListModel.value = GetSchemeLIstModel();
//       }
//     } catch (e) {
//       debugPrint(e.toString());
//       // Clear the list if error occurs
//       getSchemeListModel.value = GetSchemeLIstModel();
//     }
//   }
//
//   // Add debounce functionality for search
//   void searchSchemes(String searchText) {
//     // Cancel any existing timer
//     if (_debounceTimer != null) {
//       _debounceTimer!.cancel();
//     }
//
//     // Start new timer
//     _debounceTimer = Timer(Duration(milliseconds: 500), () {
//       getSchemeList(searchText: searchText);
//     });
//   }
//
//   Timer? _debounceTimer;
// // In your AddSchemeController.dart - Add this method
// //
// // In AddSchemeController.dart - Fix the updateScheme method
// //   Method to get scheme details for editing
//   // Add this method to your AddSchemeController
//   Future<void> getSchemeDetail({required String schemeId}) async {
//     print('Getting scheme detail for ID: $schemeId');
//     isLoading.value = true;
//
//     try {
//       Map<String, dynamic> body = {};
//
//       final response = await API.instance.get(
//           endPoint: APIEndPoints.getSchemeId + schemeId,
//           params: body,
//           isHeader: true);
//
//       var data = jsonDecode(response.body);
//       var status = data['status'];
//       var message = data['message'];
//
//       // ADD DEBUG PRINT
//       print('Scheme Detail API Response: ${jsonEncode(data)}');
//
//       if (status == "success" && data['data'] != null && data['data'].isNotEmpty) {
//         print('Scheme detail loaded successfully');
//         var schemeData = data['data'][0];
//
//         // Set edit mode
//         isEditMode.value = true;
//         editingSchemeId.value = schemeId;
//
//         // Populate form fields
//         selectedSchemeName.value = schemeData['name']?.toString() ?? '';
//         selectedSchemeId.value = schemeData['id']?.toString() ?? '';
//         selectedVehicleType.value = schemeData['vehicle_type']?.toString() ?? '';
//
//         // FIX: Handle product field mapping
//         String productValue = schemeData['product']?.toString() ?? '';
//         print('Raw product value from API: $productValue');
//
//         // Map numeric product values to actual product names
//         if (productValue.isNotEmpty) {
//           switch (productValue) {
//             case '0':
//               selectedProductType.value = 'Petrol';
//               break;
//             case '1':
//               selectedProductType.value = 'Diesel';
//               break;
//             case '2':
//               selectedProductType.value = 'Lube';
//               break;
//             case '3':
//               selectedProductType.value = 'Power';
//               break;
//             default:
//             // If it's not a number, use the value as is
//               selectedProductType.value = productValue;
//           }
//         } else {
//           selectedProductType.value = '';
//         }
//
//         print('Mapped product value: ${selectedProductType.value}');
//
//         // Handle Gift dropdown value
//         String giftValue = schemeData['gifts']?.toString() ?? '';
//         List<String> giftOptions = ['Gift1', 'Gift2', 'Gift3', 'cup']; // Added 'cup' from your API response
//         if (giftOptions.contains(giftValue)) {
//           selectedGift.value = giftValue;
//         } else {
//           selectedGift.value = '';
//           if (giftValue.isNotEmpty) {
//             print('Gift value "$giftValue" not found in dropdown items');
//           }
//         }
//
//         // Handle Qty dropdown value - only set if not empty
//         String qtyValue = schemeData['qty']?.toString() ?? '';
//         if (qtyValue.isNotEmpty) {
//           List<String> qtyOptions = ['1', '2', '3', '4'];
//           if (qtyOptions.contains(qtyValue)) {
//             selectedQty.value = qtyValue;
//           } else {
//             selectedQty.value = '';
//             print('Qty value "$qtyValue" not found in dropdown items');
//           }
//         } else {
//           selectedQty.value = '';
//         }
//
//         // Handle liter range
//         selectedQty.value = schemeData['liter_range']?.toString() ?? '';
//
//         productNameController.text = schemeData['product_name']?.toString() ?? '';
//
//         print('Form populated with scheme data');
//         print('Product: ${selectedProductType.value}');
//         print('Gifts: ${selectedGift.value}');
//         print('Qty: ${selectedQty.value}');
//         print('Liter Range: ${schemeData['liter_range']}');
//       } else {
//         print('Failed to load scheme details: $message');
//         Appdialogs.showToast(message ?? "Failed to load scheme details");
//       }
//     } catch (e, stackTrace) {
//       print('Error loading scheme details: $e');
//       print('Stack trace: $stackTrace');
//       Appdialogs.showToast("Error loading scheme details: ${e.toString()}");
//     } finally {
//       isLoading.value = false;
//     }
//   }
//   // Future<void> getSchemeDetail({required String schemeId}) async {
//   //   print('Getting scheme detail for ID: $schemeId');
//   //   isLoading.value = true;
//   //
//   //   try {
//   //     Map<String, dynamic> body = {};
//   //
//   //     final response = await API.instance.get(
//   //         endPoint: APIEndPoints.getSchemeId + schemeId,
//   //         params: body,
//   //         isHeader: true);
//   //
//   //     var data = jsonDecode(response.body);
//   //     var status = data['status'];
//   //     var message = data['message'];
//   //
//   //     if (status == "success" && data['data'] != null && data['data'].isNotEmpty) {
//   //       print('Scheme detail loaded successfully');
//   //       var schemeData = data['data'][0]; // Access first element of the array
//   //
//   //       // Set edit mode
//   //       isEditMode.value = true;
//   //       editingSchemeId.value = schemeId;
//   //
//   //       // Populate form fields
//   //       selectedSchemeName.value = schemeData['name']?.toString() ?? '';
//   //       selectedSchemeId.value = schemeData['id']?.toString() ?? ''; // Changed from 'scheme_id' to 'id'
//   //       selectedVehicleType.value = schemeData['vehicle_type']?.toString() ?? '';
//   //
//   //       // Format product type to match dropdown items (add " KL" suffix if it's a number)
//   //       String productValue = schemeData['product']?.toString() ?? '';
//   //       if (productValue.isNotEmpty && RegExp(r'^\d+$').hasMatch(productValue)) {
//   //         productValue += ' KL';
//   //       }
//   //       // Validate that the value exists in the dropdown items
//   //       List<String> productTypes = ['Petrol', 'Diesel', 'Lube', 'Power'];
//   //       if (productTypes.contains(productValue)) {
//   //         selectedProductType.value = productValue;
//   //       } else {
//   //         selectedProductType.value = '';
//   //         print('Product type value "$productValue" not found in dropdown items');
//   //       }
//   //
//   //       // Validate Gift dropdown value
//   //       String giftValue = schemeData['gifts']?.toString() ?? '';
//   //       List<String> giftOptions = ['Gift1', 'Gift2', 'Gift3'];
//   //       if (giftOptions.contains(giftValue)) {
//   //         selectedGift.value = giftValue;
//   //       } else {
//   //         selectedGift.value = '';
//   //         if (giftValue.isNotEmpty) {
//   //           print('Gift value "$giftValue" not found in dropdown items');
//   //         }
//   //       }
//   //
//   //       // Validate Qty dropdown value
//   //       String qtyValue = schemeData['qty']?.toString() ?? '';
//   //       List<String> qtyOptions = ['1', '2', '3', '4'];
//   //       if (qtyOptions.contains(qtyValue)) {
//   //         selectedQty.value = qtyValue;
//   //       } else {
//   //         selectedQty.value = '';
//   //         if (qtyValue.isNotEmpty) {
//   //           print('Qty value "$qtyValue" not found in dropdown items');
//   //         }
//   //       }
//   //       productNameController.text = schemeData['product_name']?.toString() ?? '';
//   //
//   //       print('Form populated with scheme data');
//   //     } else {
//   //       print('Failed to load scheme details: $message');
//   //       Appdialogs.showToast(message ?? "Failed to load scheme details");
//   //     }
//   //   } catch (e, stackTrace) {
//   //     print('Error loading scheme details: $e');
//   //     print('Stack trace: $stackTrace');
//   //     Appdialogs.showToast("Error loading scheme details: ${e.toString()}");
//   //   } finally {
//   //     isLoading.value = false;
//   //   }
//   // }
// // In AddSchemeController - Replace your getSchemeDetail method with this:
// //
// //
// //   Clear form and reset to add mode
//   void clearForm() {
//     isEditMode.value = false;
//     editingSchemeId.value = '';
//     selectedSchemeName.value = '';
//     selectedSchemeId.value = '';
//     selectedVehicleType.value = '';
//     selectedProductType.value = '';
//     selectedGift.value = '';
//     selectedQty.value = '';
//     productNameController.clear();
//   }
//
//   @override
//   void onClose() {
//     nameController.dispose();
//     productNameController.dispose();
//     _debounceTimer?.cancel();
//     super.onClose();
//   }
// }
import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Data/AppDialoge.dart';
import '../../Utils/Api.dart';
import '../../models/AdminModels/GetSchemeLIstModel.dart';
import '../../models/AdminModels/GetSchemeNameModel.dart';

class AddSchemeController extends GetxController {
  var nameController = TextEditingController();
  var isLoading = false.obs;
  var isSchemeListLoading = false.obs;
  var schemeName = [].obs;

  var selectedSchemeName = ''.obs;
  var selectedSchemeId = ''.obs;
  var selectedVehicleType = ''.obs;
  var selectedProductType = ''.obs;
  var selectedGift = ''.obs;
  var selectedQty = ''.obs;
  final productNameController = TextEditingController();

  // For editing
  var isEditMode = false.obs;
  var editingSchemeId = ''.obs;

  var getSchemeNameListModel = GetSchemeNameModel().obs;
  var getSchemeListModel = GetSchemeLIstModel().obs;

  // Dynamic lists for dropdowns
  var vehicleTypes = <String>[].obs;
  var productTypes = <String>[].obs;
  var selectedGiftId = ''.obs;
  var selectedGiftQty = ''.obs;

  Timer? _debounceTimer;

  @override
  void onInit() {
    super.onInit();
    // Initialize dropdown values
    getVehicleTypes();
    getProductTypes();
  }

  void createSchemeName({required String name}) async {
    isLoading.value = true;

    if (name.isEmpty) {
      Get.snackbar('Error', 'Scheme name is required.');
      isLoading.value = false;
      return;
    }

    Map<String, dynamic> body = {"name": name};

    final response = await API.instance.post(
        endPoint: APIEndPoints.createSchemeName, params: body, isHeader: true);

    isLoading.value = false;
    try {
      var data = jsonDecode(response.body);
      var status = data['status'];
      var message = data['message'];

      if (status == "success") {
        Appdialogs.showToast(message);
        nameController.clear();
        getSchemeName();
      } else {
        Appdialogs.showToast(message);
      }
    } catch (e) {
      debugPrint('Create Scheme Name Error: $e');
      Appdialogs.showToast('Error creating scheme name');
    }
  }

  void getSchemeName() async {
    isLoading.value = true;

    Map<String, dynamic> body = {};

    final response = await API.instance.get(
        endPoint: APIEndPoints.getSchemeName, params: body, isHeader: true);

    isLoading.value = false;
    try {
      var data = jsonDecode(response.body);
      var status = data['status'];
      var message = data['message'];

      if (status == "success") {
        getSchemeNameListModel.value = GetSchemeNameModel.fromJson(data);
      } else {
        Appdialogs.showToast(message);
      }
    } catch (e) {
      debugPrint('Get Scheme Name Error: $e');
      Appdialogs.showToast('Error loading scheme names');
    }
  }

  void getVehicleTypes() async {
    try {
      final response = await API.instance.get(
          endPoint: APIEndPoints.getVehicleTypes, params: {}, isHeader: true);

      var data = jsonDecode(response.body);
      var status = data['status'];

      if (status == "success" && data['data'] != null) {
        vehicleTypes.value = List<String>.from(data['data']);
      } else {
        vehicleTypes.value = ['Car', 'Bike', 'Truck', 'Bus', 'Van'];
      }
    } catch (e) {
      debugPrint('Error getting vehicle types: $e');
      vehicleTypes.value = ['Car', 'Bike', 'Truck', 'Bus', 'Van'];
    }
  }

  void getProductTypes() async {
    try {
      final response = await API.instance.get(
          endPoint: APIEndPoints.getProductTypes, params: {}, isHeader: true);

      var data = jsonDecode(response.body);
      var status = data['status'];

      if (status == "success" && data['data'] != null) {
        productTypes.value = List<String>.from(data['data']);
      } else {
        productTypes.value = ['Petrol', 'Diesel', 'Lube', 'Power'];
      }
    } catch (e) {
      debugPrint('Error getting product types: $e');
      productTypes.value = ['Petrol', 'Diesel', 'Lube', 'Power'];
    }
  }

  void addScheme() async {
    // Validate inputs before API call
    if (selectedSchemeId.value.isEmpty) {
      Appdialogs.showToast('Please select a scheme name');
      return;
    }
    if (selectedVehicleType.value.isEmpty) {
      Appdialogs.showToast('Please select a vehicle type');
      return;
    }
    if (selectedProductType.value.isEmpty) {
      Appdialogs.showToast('Please select a product');
      return;
    }
    if (selectedQty.value.isEmpty) {
      Appdialogs.showToast('Please select quantity');
      return;
    }
    isLoading.value = true;

    // Map product name back to numeric value for API
    String productValue = selectedProductType.value;
    String apiProductValue = _mapProductNameToApiValue(productValue);

    Map<String, dynamic> body = {
      "scheme_id": selectedSchemeId.value,
      "vehicle_type": selectedVehicleType.value,
      "product": apiProductValue,
      "liter_range": selectedQty.value,
      "gifts": selectedGift.value,
      "qty": selectedQty.value,
    };

    // Add id parameter for updates
    if (isEditMode.value && editingSchemeId.value.isNotEmpty) {
      body['id'] = editingSchemeId.value;
    }

    print('Add/Update Scheme Body: $body');

    final response = await API.instance.post(
        endPoint: APIEndPoints.addUpdateScheme, params: body, isHeader: true);

    isLoading.value = false;
    try {
      var data = jsonDecode(response.body);
      var status = data['status'];
      var message = data['message'];

      if (status == "success") {
        Appdialogs.showToast(message);
        clearForm();
        getSchemeList();
      } else {
        Appdialogs.showToast(message);
      }
    } catch (e) {
      debugPrint('Add Scheme Error: $e');
      Appdialogs.showToast('Error adding scheme');
    }
  }

  void getSchemeList({String? searchText}) async {
    isSchemeListLoading.value = true;

    Map<String, dynamic> params = {};

    String endpoint = APIEndPoints.getSchemeList;
    if (searchText != null && searchText.isNotEmpty) {
      endpoint = APIEndPoints.getSchemeListSearch;
      params['search'] = searchText;
    }

    final response = await API.instance.get(
        endPoint: endpoint, params: params, isHeader: true);

    isSchemeListLoading.value = false;
    try {
      var data = jsonDecode(response.body);
      var status = data['status'];
      var message = data['message'];

      if (status == "success") {
        getSchemeListModel.value = GetSchemeLIstModel.fromJson(data);
      } else {
        Appdialogs.showToast(message);
        getSchemeListModel.value = GetSchemeLIstModel();
      }
    } catch (e) {
      debugPrint('Get Scheme List Error: $e');
      getSchemeListModel.value = GetSchemeLIstModel();
    }
  }

  void searchSchemes(String searchText) {
    if (_debounceTimer != null) {
      _debounceTimer!.cancel();
    }

    _debounceTimer = Timer(Duration(milliseconds: 500), () {
      getSchemeList(searchText: searchText);
    });
  }

  // Helper function to map product names to API values
  String _mapProductNameToApiValue(String productName) {
    switch (productName) {
      case 'Petrol':
        return '0';
      case 'Diesel':
        return '1';
      case 'Lube':
        return '2';
      case 'Power':
        return '3';
      default:
        return productName;
    }
  }

  // Helper function to map API values to product names
  String _mapApiValueToProductName(String apiValue) {
    switch (apiValue) {
      case '0':
        return 'Petrol';
      case '1':
        return 'Diesel';
      case '2':
        return 'Lube';
      case '3':
        return 'Power';
      default:
        return apiValue;
    }
  }

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

      // Debug print
      print('Scheme Detail API Response: ${jsonEncode(data)}');

      if (status == "success" && data['data'] != null && data['data'].isNotEmpty) {
        print('Scheme detail loaded successfully');
        var schemeData = data['data'][0];

        // Set edit mode
        isEditMode.value = true;
        editingSchemeId.value = schemeId;

        // Populate form fields
        selectedSchemeName.value = schemeData['name']?.toString() ?? '';
        selectedSchemeId.value = schemeData['id']?.toString() ?? '';
        selectedVehicleType.value = schemeData['vehicle_type']?.toString() ?? '';

        // FIX: Handle product field mapping using helper function
        String productValue = schemeData['product']?.toString() ?? '';
        print('Raw product value from API: $productValue');

        // Map numeric product values to actual product names
        selectedProductType.value = _mapApiValueToProductName(productValue);
        print('Mapped product value: ${selectedProductType.value}');

        // Handle Gift dropdown value
        String giftValue = schemeData['gifts']?.toString() ?? '';
        List<String> giftOptions = ['Gift1', 'Gift2', 'Gift3', 'cup'];
        if (giftOptions.contains(giftValue)) {
          selectedGift.value = giftValue;
        } else {
          selectedGift.value = '';
          if (giftValue.isNotEmpty) {
            print('Gift value "$giftValue" not found in dropdown items');
          }
        }

        // Handle Qty dropdown value - only set if not empty
        String qtyValue = schemeData['qty']?.toString() ?? '';
        if (qtyValue.isNotEmpty) {
          List<String> qtyOptions = ['1', '2', '3', '4'];
          if (qtyOptions.contains(qtyValue)) {
            selectedQty.value = qtyValue;
          } else {
            selectedQty.value = '';
            print('Qty value "$qtyValue" not found in dropdown items');
          }
        } else {
          selectedQty.value = '';
        }

        // Handle liter range
        selectedQty.value = schemeData['liter_range']?.toString() ?? '';

        productNameController.text = schemeData['product_name']?.toString() ?? '';

        print('Form populated with scheme data');
        print('Product: ${selectedProductType.value}');
        print('Gifts: ${selectedGift.value}');
        print('Qty: ${selectedQty.value}');
        print('Liter Range: ${schemeData['liter_range']}');
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

  void clearForm() {
    isEditMode.value = false;
    editingSchemeId.value = '';
    selectedSchemeName.value = '';
    selectedSchemeId.value = '';
    selectedVehicleType.value = '';
    selectedProductType.value = '';
    selectedGift.value = '';
    selectedQty.value = '';
    productNameController.clear();
  }

  @override
  void onClose() {
    nameController.dispose();
    productNameController.dispose();
    _debounceTimer?.cancel();
    super.onClose();
  }
}