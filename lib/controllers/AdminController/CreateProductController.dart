
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Data/AppDialoge.dart';
import '../../Utils/Api.dart';
import '../../models/AdminModels/GetProductNameModel.dart';
import 'GetProductListController.dart';

class CreateProductController extends GetxController {
  var nameController = TextEditingController();
  var isLoading = false.obs;
  var selectedUnitOfMeasure = 'Litre'.obs;
  var getProductNameModel = GetProductNameModel().obs;
  var isSavingProduct = false.obs;

  @override
  void onInit() {
    super.onInit();
    selectedUnitOfMeasure.value = 'Litre';
  }

  void createProductName({required String name}) async {
    isLoading.value = true;

    if (name.isEmpty) {
      Get.snackbar(
        'Error',
        'Product name is required.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      isLoading.value = false;
      return;
    }

    Map<String, dynamic> body = {"name": name};

    try {
      final response = await API.instance.post(
        endPoint: APIEndPoints.createProductName,
        params: body,
        isHeader: true,
      );

      isLoading.value = false;

      var data = jsonDecode(response.body);
      var status = data['status'];
      var message = data['message'];

      if (status == "success") {
        Appdialogs.showToast(message);
        Get.back();
        getProductName(); // Refresh the product list
        nameController.clear();
        selectedUnitOfMeasure.value = 'Litre';
      } else {
        Appdialogs.showToast('Error: $message');
      }
    } catch (e, stackTrace) {
      isLoading.value = false;
      debugPrint('Error in createProductName: $e');
      debugPrint('StackTrace: $stackTrace');
      Get.snackbar(
        'Error',
        'Failed to create product. Please try again.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  void getProductName() async {
    isLoading.value = true;

    Map<String, dynamic> body = {};

    try {
      final response = await API.instance.get(
        endPoint: APIEndPoints.getProductName,
        params: body,
        isHeader: true,
      );

      isLoading.value = false;

      var data = jsonDecode(response.body);
      var status = data['status'];
      var message = data['message'];

      if (status == "success") {
        getProductNameModel.value = GetProductNameModel.fromJson(data);
        debugPrint('Successfully loaded ${getProductNameModel.value.data?.length ?? 0} products');
      } else {
        Appdialogs.showToast('Error loading products: $message');
      }
    } catch (e, stackTrace) {
      isLoading.value = false;
      debugPrint('Error in getProductName: $e');
      debugPrint('StackTrace: $stackTrace');
      Get.snackbar(
        'Error',
        'Failed to load products. Please check your connection.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  void addUpdateProduct({
    required String productId,
    required String brand,
    required String unitOfMeasure,
    required String perPrice,
    required String storageCapacity,
    required String qtyInStock,
    required String minQtyAlert,
    required String description,
    required String supplierName,
  }) async {
    isSavingProduct.value = true;

    try {
      // Enhanced validation
      final validationError = _validateProductData(
        productId: productId,
        brand: brand,
        unitOfMeasure: unitOfMeasure,
        perPrice: perPrice,
        storageCapacity: storageCapacity,
        qtyInStock: qtyInStock,
        minQtyAlert: minQtyAlert,
      );

      if (validationError != null) {
        Get.snackbar(
          'Validation Error',
          validationError,
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.orange,
          colorText: Colors.white,
          duration: Duration(seconds: 3),
        );
        isSavingProduct.value = false;
        return;
      }

      // FIX: Provide default value for storage_capacity when Pices is selected
      String finalStorageCapacity = storageCapacity;
      if (unitOfMeasure == 'Pices' && storageCapacity.isEmpty) {
        finalStorageCapacity = '0'; // Default value for Pices
      }

      // Prepare request body
      Map<String, dynamic> body = {
        "product_category_id": productId,
        "brand": brand,
        "unit_of_measure": unitOfMeasure,
        "per_price": perPrice,
        "storage_capacity": finalStorageCapacity, // Use the fixed value
        "qty_in_stock": qtyInStock,
        "min_qty_alert": minQtyAlert,
        "description": description,
        "supplier_name": supplierName,
      };

      debugPrint('=== API REQUEST ===');
      debugPrint('Endpoint: ${APIEndPoints.addProduct}');
      debugPrint('Body: $body');

      final response = await API.instance.post(
        endPoint: APIEndPoints.addProduct,
        params: body,
        isHeader: true,
      );

      debugPrint('=== API RESPONSE ===');
      debugPrint('Status Code: ${response.statusCode}');
      debugPrint('Response Body: ${response.body}');

      // Check if response is HTML error page before parsing as JSON
      if (response.body.trim().startsWith('<!DOCTYPE') ||
          response.body.trim().startsWith('<html>')) {
        throw Exception('Server returned HTML error page. Check API endpoint.');
      }

      isSavingProduct.value = false;

      final data = jsonDecode(response.body);
      final status = data['status']?.toString().toLowerCase();
      final message = data['message']?.toString() ?? 'Unknown response';

      if (status == "success") {
        Appdialogs.showToast(message);

        // Refresh product lists
        _refreshProductData();

        Get.back(); // Close the bottom sheet/dialog

        Get.snackbar(
          'Success',
          'Product saved successfully!',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: Colors.white,
          duration: Duration(seconds: 2),
        );
      } else {
        Appdialogs.showToast('Failed: $message');
        Get.snackbar(
          'Error',
          message,
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } catch (e, stackTrace) {
      isSavingProduct.value = false;
      debugPrint('❌ Error in addUpdateProduct: $e');
      debugPrint('StackTrace: $stackTrace');

      // More specific error messages
      if (e.toString().contains('HTML') || e.toString().contains('<!DOCTYPE')) {
        Get.snackbar(
          'Server Error',
          'Database error occurred. Please contact support.',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
          duration: Duration(seconds: 5),
        );
      } else if (e.toString().contains('FormatException')) {
        Get.snackbar(
          'Server Error',
          'Unexpected response from server. Please try again.',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
          duration: Duration(seconds: 5),
        );
      } else {
        Get.snackbar(
          'Network Error',
          'Failed to save product. Please check your connection and try again.',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
          duration: Duration(seconds: 4),
        );
      }
    }
  }

  String? _validateProductData({
    required String productId,
    required String brand,
    required String unitOfMeasure,
    required String perPrice,
    required String storageCapacity,
    required String qtyInStock,
    required String minQtyAlert,
  }) {
    if (productId.isEmpty) return 'Please select a product';
    if (brand.isEmpty) return 'Brand is required';
    if (unitOfMeasure.isEmpty) return 'Unit of measure is required';
    if (perPrice.isEmpty) return 'Price is required';

    // Validate price format
    final price = double.tryParse(perPrice);
    if (price == null || price <= 0) {
      return 'Please enter a valid price greater than 0';
    }

    // Only validate storage capacity if Litres is selected
    if (unitOfMeasure == 'Litres' && storageCapacity.isEmpty) {
      return 'Storage capacity is required for Litres';
    }

    // Quantity validation for Pieces
    if (unitOfMeasure == 'Pices') {
      if (qtyInStock.isEmpty) {
        return 'Quantity in stock is required for Pieces';
      }
      final qty = int.tryParse(qtyInStock);
      if (qty == null || qty < 0) {
        return 'Please enter a valid quantity for stock';
      }
    }

    // Validate minimum stock alert if provided
    if (minQtyAlert.isNotEmpty) {
      final minStock = int.tryParse(minQtyAlert);
      if (minStock == null || minStock < 0) {
        return 'Please enter a valid minimum stock level';
      }
    }

    return null;
  }

  void _refreshProductData() {
    // Refresh product names list
    getProductName();

    // Refresh product list if the controller exists
    try {
      final productController = Get.find<GetProductController>();
      productController.refreshAllData();
    } catch (e) {
      debugPrint('GetProductController not found, skipping refresh: $e');
      // Controller might not be initialized yet, that's okay
    }
  }

  // Method to clear form data
  void clearFormData() {
    nameController.clear();
    selectedUnitOfMeasure.value = 'Litre';
  }

  @override
  void onClose() {
    nameController.dispose();
    super.onClose();
  }
}