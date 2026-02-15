
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Data/AppDialoge.dart';
import '../../Utils/Api.dart';
import '../../models/AdminModels/GetProductModel.dart';
import '../../../utils/api_endpoints.dart';
import 'GetProductListController.dart';

class EditProductController extends GetxController {
  var isLoading = false.obs;
  var productId = ''.obs;

  // Form controllers
  final productNameController = TextEditingController();
  final productCategoryIdController = TextEditingController();
  final brandController = TextEditingController();
  final unitOfMeasureController = TextEditingController();
  final perPriceController = TextEditingController();
  final storageCapacityController = TextEditingController();
  final qtyInStockController = TextEditingController();
  final minQtyAlertController = TextEditingController();
  final descriptionController = TextEditingController();
  final supplierNameController = TextEditingController();
  void setEditData(String id, Map<String, dynamic> productData) {
    try {
      print('=== SETTING PRODUCT EDIT DATA ===');
      print('Product ID received: $id');
      print('Product Data: $productData');

      productId.value = id.isNotEmpty ? id : productData['product_id']?.toString() ?? '';
      print('Product ID stored in controller: ${productId.value}');

      _clearFormFieldsOnly();

      // 🟢 CRITICAL FIX: Populate product name from productData
      productNameController.text = _getSafeString(productData['name']);
      print('🟢 Product Name set to: ${productNameController.text}'); // Debug log

      // Populate other form fields
      productCategoryIdController.text = _getSafeString(
          productData['product_category_id'] ?? productData['product_id'] ?? id
      );
      brandController.text = _getSafeString(productData['brand']);
      unitOfMeasureController.text = _getSafeString(productData['unit_of_measure']);
      perPriceController.text = _getSafeString(productData['per_price']);
      storageCapacityController.text = _getSafeString(productData['storage_capacity']);
      qtyInStockController.text = _getSafeString(productData['qty_in_stock']);
      minQtyAlertController.text = _getSafeString(productData['min_qty_alert']);
      descriptionController.text = _getSafeString(productData['description']);
      supplierNameController.text = _getSafeString(productData['supplier_name']);

      print('=== FIELD VALUES SET ===');
      print('🟢 Product Name: ${productNameController.text}'); // This should now show "MS"
      print('Product ID in controller: ${productId.value}');
      print('Product Category ID: ${productCategoryIdController.text}');
      print('Brand: ${brandController.text}');
      print('Unit of Measure: ${unitOfMeasureController.text}');
      print('Price: ${perPriceController.text}');
      print('Storage Capacity: ${storageCapacityController.text}');
      print('Qty in Stock: ${qtyInStockController.text}');
      print('Min Qty Alert: ${minQtyAlertController.text}');
      print('Description: ${descriptionController.text}');
      print('Supplier: ${supplierNameController.text}');

      update();
    } catch (e, stackTrace) {
      print('❌ Error in setEditData: $e');
      print('StackTrace: $stackTrace');
      Get.snackbar(
        'Error',
        'Failed to load product data',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }
  // void setEditData(String id, Map<String, dynamic> productData) {
  //   try {
  //     print('=== SETTING PRODUCT EDIT DATA ===');
  //     print('Product ID received: $id');
  //     print('Product Data: $productData');
  //     productNameController.text = _getSafeString(productData['name']);
  //     productId.value = id.isNotEmpty ? id : productData['product_id']?.toString() ?? '';
  //     print('Product ID stored in controller: ${productId.value}');
  //
  //     _clearFormFieldsOnly();
  //
  //     // Populate form fields
  //     productCategoryIdController.text = _getSafeString(
  //         productData['product_category_id'] ?? productData['product_id'] ?? id
  //     );
  //     brandController.text = _getSafeString(productData['brand']);
  //     unitOfMeasureController.text = _getSafeString(productData['unit_of_measure']);
  //     perPriceController.text = _getSafeString(productData['per_price']);
  //     storageCapacityController.text = _getSafeString(productData['storage_capacity']);
  //     qtyInStockController.text = _getSafeString(productData['qty_in_stock']);
  //     minQtyAlertController.text = _getSafeString(productData['min_qty_alert']);
  //     descriptionController.text = _getSafeString(productData['description']);
  //     supplierNameController.text = _getSafeString(productData['supplier_name']);
  //
  //     print('=== FIELD VALUES SET ===');
  //     print('Product Name: ${productNameController.text}');
  //     print('Product ID in controller: ${productId.value}');
  //     print('Product Category ID: ${productCategoryIdController.text}');
  //     print('Brand: ${brandController.text}');
  //     print('Unit of Measure: ${unitOfMeasureController.text}');
  //     print('Price: ${perPriceController.text}');
  //     print('Storage Capacity: ${storageCapacityController.text}');
  //     print('Qty in Stock: ${qtyInStockController.text}');
  //     print('Min Qty Alert: ${minQtyAlertController.text}');
  //     print('Description: ${descriptionController.text}');
  //     print('Supplier: ${supplierNameController.text}');
  //
  //     update();
  //   } catch (e, stackTrace) {
  //     print('❌ Error in setEditData: $e');
  //     print('StackTrace: $stackTrace');
  //     Get.snackbar(
  //       'Error',
  //       'Failed to load product data',
  //       snackPosition: SnackPosition.BOTTOM,
  //       backgroundColor: Colors.red,
  //       colorText: Colors.white,
  //     );
  //   }
  // }

  void _clearFormFieldsOnly() {
    productNameController.clear();
    productCategoryIdController.clear();
    brandController.clear();
    unitOfMeasureController.clear();
    perPriceController.clear();
    storageCapacityController.clear();
    qtyInStockController.clear();
    minQtyAlertController.clear();
    descriptionController.clear();
    supplierNameController.clear();
  }
  String _getSafeString(dynamic value) {
    if (value == null) return '';
    if (value is String) return value;
    if (value is num) return value.toString();
    return value.toString();
  }
  // String _getSafeString(dynamic value) {
  //   if (value == null) return '';
  //   if (value is String) return value;
  //   if (value is num) return value.toString();
  //   return value.toString();
  // }

  /// VALIDATE REQUIRED FIELDS
  /// VALIDATE REQUIRED FIELDS
  // bool _validateRequiredFields() {
  //   if (productNameController.text.trim().isEmpty) { // NEW
  //     Appdialogs.showToast("Product name is required");
  //     return false;
  //   }
  //   if (productCategoryIdController.text.trim().isEmpty) {
  //     Appdialogs.showToast("Product category is required");
  //     return false;
  //   }
  //   if (unitOfMeasureController.text.trim().isEmpty) {
  //     Appdialogs.showToast("Unit of measure is required"); // ← Updated message
  //     return false;
  //   }
  //   if (perPriceController.text.trim().isEmpty) {
  //     Appdialogs.showToast("Price is required");
  //     return false;
  //   }
  //   return true;
  // }
  bool _validateRequiredFields() {
    if (productNameController.text.trim().isEmpty) {
      Appdialogs.showToast("Product name is required");
      return false;
    }
    if (productCategoryIdController.text.trim().isEmpty) {
      Appdialogs.showToast("Product category is required");
      return false;
    }
    if (unitOfMeasureController.text.trim().isEmpty) {
      Appdialogs.showToast("Unit of measure is required");
      return false;
    }
    if (perPriceController.text.trim().isEmpty) {
      Appdialogs.showToast("Price is required");
      return false;
    }
    return true;
  }
  /// Prepare request body for update - ENHANCED VALIDATION

  /// Prepare request body for update - ENHANCED VALIDATION
  ///
  Map<String, dynamic> _prepareRequestBody() {
    print('🔍 Preparing request - Product ID: "${productId.value}"');

    if (productId.value.isEmpty) {
      print('❌ CRITICAL ERROR: Product ID is EMPTY!');
      Get.snackbar(
        'Error',
        'Product ID is missing. Cannot update product.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      throw Exception('Product ID is required');
    }

    // Validate required fields - ADD NAME VALIDATION
    if (!_validateRequiredFields()) {
      throw Exception('Required fields are missing');
    }

    final body = {
      "product_id": productId.value,
      "name": productNameController.text.trim(), // 🟢 ADD THIS LINE
      "product_category_id": productCategoryIdController.text.trim(),
      "brand": brandController.text.trim(),
      "unit_of_measure": unitOfMeasureController.text.trim(),
      "per_price": perPriceController.text.trim(),
      "storage_capacity": storageCapacityController.text.trim(),
      "qty_in_stock": qtyInStockController.text.trim(),
      "min_qty_alert": minQtyAlertController.text.trim(),
      "description": descriptionController.text.trim(),
      "supplier_name": supplierNameController.text.trim(),
    };

    // Remove empty fields that might cause issues
    body.removeWhere((key, value) => value.toString().isEmpty);

    print('✅ Final request body: $body');
    return body;
  }
  // Map<String, dynamic> _prepareRequestBody() {
  //   print('🔍 Preparing request - Product ID: "${productId.value}"');
  //
  //   if (productId.value.isEmpty) {
  //     print('❌ CRITICAL ERROR: Product ID is EMPTY!');
  //     Get.snackbar(
  //       'Error',
  //       'Product ID is missing. Cannot update product.',
  //       snackPosition: SnackPosition.BOTTOM,
  //       backgroundColor: Colors.red,
  //       colorText: Colors.white,
  //     );
  //     throw Exception('Product ID is required');
  //   }
  //
  //   // Validate required fields
  //   if (!_validateRequiredFields()) {
  //     throw Exception('Required fields are missing');
  //   }
  //
  //   // CORRECTED: Use the exact field names that API expects
  //   final body = {
  //     "name": productNameController.text.trim(),
  //     "product_id": productId.value,
  //     "product_category_id": productCategoryIdController.text.trim(), // ← FIXED
  //     "brand": brandController.text.trim(),
  //     "unit_of_measure": unitOfMeasureController.text.trim(),        // ← FIXED
  //     "per_price": perPriceController.text.trim(),                   // ← FIXED
  //     "storage_capacity": storageCapacityController.text.trim(),
  //     "qty_in_stock": qtyInStockController.text.trim(),
  //     "min_qty_alert": minQtyAlertController.text.trim(),
  //     "description": descriptionController.text.trim(),
  //     "supplier_name": supplierNameController.text.trim(),
  //   };
  //
  //   // Remove empty fields that might cause issues
  //   body.removeWhere((key, value) => value.toString().isEmpty);
  //
  //   print('✅ Final request body: $body');
  //   return body;
  // }
  /// Update product API call
  // void updateProduct() async {
  //   if (productId.value.isEmpty) {
  //     print('❌ ERROR: Cannot update product - Product ID is empty!');
  //     Get.snackbar(
  //       'Error',
  //       'Product ID is missing. Cannot update product.',
  //       snackPosition: SnackPosition.BOTTOM,
  //       backgroundColor: Colors.red,
  //       colorText: Colors.white,
  //     );
  //     return;
  //   }
  //
  //   isLoading.value = true;
  //   update();
  //
  //   try {
  //     final body = _prepareRequestBody();
  //
  //     print('=== UPDATE PRODUCT API CALL ===');
  //     print('Product ID: ${productId.value}');
  //     print('Endpoint: ${APIEndPoints.updateproduct}');
  //     print('Request body: $body');
  //
  //     final response = await API.instance.post(
  //       endPoint: APIEndPoints.updateproduct,
  //       params: body,
  //       isHeader: true,
  //     );
  //
  //     print('📡 API Response Status Code: ${response.statusCode}');
  //     print('📡 API Response Body: ${response.body}');
  //
  //     if (response.statusCode == 200) {
  //       final data = jsonDecode(response.body);
  //       final status = data['status'];
  //       final message = data['message'];
  //
  //       if (status == "success") {
  //         Appdialogs.showToast(message ?? "Product updated successfully");
  //         // Refresh product list
  //         Get.find<GetProductController>().getProduct();
  //         Get.back(); // Close the edit screen
  //       } else {
  //         Appdialogs.showToast(message ?? "Failed to update product");
  //       }
  //     } else {
  //       print('❌ HTTP Error: ${response.statusCode}');
  //       Appdialogs.showToast("Server error: ${response.statusCode}");
  //     }
  //   } catch (e) {
  //     debugPrint("UpdateProduct Error: $e");
  //     Appdialogs.showToast("Something went wrong: $e");
  //   } finally {
  //     isLoading.value = false;
  //     update();
  //   }
  // }
  void updateProduct() async {
    if (productId.value.isEmpty) {
      print('❌ ERROR: Cannot update product - Product ID is empty!');
      return;
    }

    isLoading.value = true;
    update();

    try {
      final body = _prepareRequestBody();

      print('=== UPDATE PRODUCT API CALL ===');
      print('Product ID: ${productId.value}');
      print('🟢 NAME BEING SENT TO API: "${body['name']}"');
      print('Full request body: $body');

      final response = await API.instance.post(
        endPoint: APIEndPoints.updateproduct,
        params: body,
        isHeader: true,
      );

      print('📡 API Response Status Code: ${response.statusCode}');
      print('📡 API Response Body: ${response.body}');

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final status = data['status'];
        final message = data['message'];

        if (status == "success") {
          Appdialogs.showToast(message ?? "Product updated successfully");

          // Refresh the product list
          Get.find<GetProductController>().getProduct();

          Get.back(); // Close the edit screen
        } else {
          Appdialogs.showToast(message ?? "Failed to update product");
        }
      } else {
        print('❌ HTTP Error: ${response.statusCode}');
        Appdialogs.showToast("Server error: ${response.statusCode}");
      }
    } catch (e) {
      debugPrint("UpdateProduct Error: $e");
      Appdialogs.showToast("Something went wrong: $e");
    } finally {
      isLoading.value = false;
      update();
    }
  }
  /// UPDATE PRODUCT STATUS METHOD - ENHANCED
  /// UPDATE PRODUCT STATUS METHOD - USING GET REQUEST
  /// UPDATE PRODUCT STATUS METHOD - USING CORRECT ENDPOINT FORMAT
  /// UPDATE PRODUCT STATUS METHOD - USING CORRECT ENDPOINT FORMAT
  /// UPDATE PRODUCT STATUS METHOD - USING CORRECT ENDPOINT FORMAT
  void updateProductStatus({
    required String productId,
    required String updateStatus,
  }) async {
    try {
      // Show loading
      Get.dialog(
        const Center(child: CircularProgressIndicator()),
        barrierDismissible: false,
      );

      print('=== UPDATE PRODUCT STATUS API CALL ===');
      print('Product ID: $productId');
      print('Status: $updateStatus');

      // Construct the endpoint with path parameters
      final endpoint = "/update-product-status/$productId/$updateStatus";

      print('✅ Endpoint: $endpoint');

      // Make the API call
      final response = await API.instance.get(
        endPoint: endpoint,
        params: {},
        isHeader: true,
      );

      print('📡 API Response Status Code: ${response.statusCode}');
      print('📡 API Response Body: ${response.body}');

      Get.back(); // Close loading dialog

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final status = data['status'];
        final message = data['message'];

        if (status == "success") {
          // Show appropriate message based on status
          switch (updateStatus) {
            case "1":
              Appdialogs.showToast("Product activated successfully");
              break;
            case "0":
              Appdialogs.showToast("Product deactivated successfully");
              break;
            case "9":
              Appdialogs.showToast("Product deleted successfully");
              break;
            default:
              Appdialogs.showToast(message ?? "Operation completed successfully");
          }

          // FIX: Remove await and just call the method
          Get.find<GetProductController>().getProduct();

          // Close any open dialogs or bottom sheets
          if (Get.isDialogOpen ?? false) Get.back();
          if (Get.isBottomSheetOpen ?? false) Get.back();

          // Show snackbar for better user feedback
          Get.snackbar(
            updateStatus == "1" ? "Activated" : "Deactivated",
            updateStatus == "1"
                ? "Product has been activated"
                : "Product has been deactivated and will appear grey",
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: updateStatus == "1" ? Colors.green : Colors.orange,
            colorText: Colors.white,
            duration: Duration(seconds: 2),
          );
        } else {
          Appdialogs.showToast(message ?? "Failed to update product status");
        }
      } else {
        print('❌ HTTP Error: ${response.statusCode}');
        Appdialogs.showToast("Server error: ${response.statusCode}");
      }
    } catch (e) {
      if (Get.isDialogOpen ?? false) Get.back();
      debugPrint("UpdateProductStatus Error: $e");
      Appdialogs.showToast("Something went wrong while updating product status: $e");
    }
  }

  /// Clear form and reset state
  void clearForm() {
    productId.value = '';
    _clearFormFieldsOnly();
    update();
  }

  @override
  void onClose() {
    productNameController.dispose();
    productCategoryIdController.dispose();
    brandController.dispose();
    unitOfMeasureController.dispose();
    perPriceController.dispose();
    storageCapacityController.dispose();
    qtyInStockController.dispose();
    minQtyAlertController.dispose();
    descriptionController.dispose();
    supplierNameController.dispose();
    super.onClose();
  }
}

