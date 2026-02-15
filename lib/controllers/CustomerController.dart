import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import '../Data/AppDialoge.dart';
import '../Utils/Api.dart';
import '../Utils/Const.dart';
import '../Utils/Preference.dart';
import '../models/CustomerModel/CustomerAddResponseModel.dart';
import '../models/CustomerModel/CustomerDetailModel.dart';
import '../models/CustomerModel/CustomerListModel.dart';


class CustomerController extends GetxController {
  // Form Controllers
  var nameController = TextEditingController();
  var phoneController = TextEditingController();
  var aadharController = TextEditingController();
  var searchController = TextEditingController();

  // State Variables
  var isLoading = false.obs;
  var isSavingCustomer = false.obs;
  var isUpdatingStatus = false.obs;
  var isLoadingDetail = false.obs;

  // Image Handling
  var aadharFrontImage = Rx<File?>(null);
  var aadharBackImage = Rx<File?>(null);
  final ImagePicker picker = ImagePicker();

  // Data Lists - Use CustomerDetailData for both list and detail
  var customerList = <CustomerDetailData>[].obs;
  var filteredCustomerList = <CustomerDetailData>[].obs;
  var customerDetail = CustomerDetailModel().obs;
  var selectedProducts = <String>[].obs;
  var allProducts = <String>[].obs;

  // Pagination
  var currentPage = 1.obs;
  var totalPages = 1.obs;
  var hasMoreData = true.obs;
  var isRefreshing = false.obs;
  var isLoadMore = false.obs;

  // Search
  var searchText = ''.obs;
  var errorMessage = ''.obs;

  // Selected Customer for editing
  var selectedCustomerId = ''.obs;
  var isEditMode = false.obs;

  @override
  void onInit() {
    super.onInit();
    getCustomerList();
    loadProducts();

    // Listen to search changes with debounce
    debounce(searchText, (_) => searchCustomers(searchText.value),
        time: Duration(milliseconds: 500));
  }

  // Load products from your existing product API
  void loadProducts() async {
    try {
      // This is a placeholder - you should fetch from your product API
      // Example: allProducts.addAll(['1', '2', '3', '4']);
      // Or use your existing product controller
      debugPrint('Products loaded for customer selection');
    } catch (e) {
      debugPrint('Error loading products: $e');
    }
  }

  // 1. Add Customer API
  Future<void> addCustomer({
    required String name,
    required String phone,
    required String aadharNumber,
    required List<String> products,
  }) async {
    isSavingCustomer.value = true;

    try {
      // Validation
      final validationError = _validateCustomerData(
        name: name,
        phone: phone,
        aadharNumber: aadharNumber,
        products: products,
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
        isSavingCustomer.value = false;
        return;
      }

      // Prepare images list
      List<File> images = [];
      if (aadharFrontImage.value != null) {
        images.add(aadharFrontImage.value!);
      }
      if (aadharBackImage.value != null) {
        images.add(aadharBackImage.value!);
      }

      // Prepare params
      Map<String, dynamic> params = {
        'name': name,
        'phone': phone,
        'aadhar_number': aadharNumber,
        'products': products.join(','),
      };

      debugPrint('=== ADD CUSTOMER REQUEST ===');
      debugPrint('Endpoint: add-customer');
      debugPrint('Params: $params');
      debugPrint('Images count: ${images.length}');

      // Use multipleImages API method for image uploads
      final response = await API.instance.multipleImages(
        endPoint: '/add-customer',
        params: params,
        fileParams: 'aadhar_images',
        file: images.isNotEmpty ? images : null,
      );

      debugPrint('=== ADD CUSTOMER RESPONSE ===');
      debugPrint('Status Code: ${response.statusCode}');
      debugPrint('Response Body: ${response.body}');

      // In CustomerController.dart, update the addCustomer response handling:
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final addResponse = CustomerAddResponseModel.fromJson(data);
        final status = addResponse.status?.toLowerCase();
        final message = addResponse.message ?? 'Unknown response';

        if (status == "success") {
          Appdialogs.showToast(message);

          // Clear form
          clearFormData();

          // Refresh customer list
          refreshList();

          Get.back();

          Get.snackbar(
            'Success',
            'Customer added successfully!',
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

      } else if (response.statusCode == 401) {
        // Handle unauthorized
        Appdialogs.showToast('Session expired. Please login again.');
        Get.offAllNamed('/login');
      } else {
        throw Exception('Failed to add customer. Status code: ${response.statusCode}');
      }
    } catch (e, stackTrace) {
      isSavingCustomer.value = false;
      debugPrint('❌ Error in addCustomer: $e');
      debugPrint('StackTrace: $stackTrace');

      String errorMsg = 'Failed to add customer. Please try again.';
      if (e.toString().contains('TimeoutException')) {
        errorMsg = 'Request timeout. Please check your internet connection.';
      } else if (e.toString().contains('SocketException')) {
        errorMsg = 'No internet connection. Please check your network.';
      }

      Get.snackbar(
        'Error',
        errorMsg,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
        duration: Duration(seconds: 4),
      );
    } finally {
      isSavingCustomer.value = false;
    }
  }

  // 2. Update Customer API
  Future<void> updateCustomer({
    required String customerId,
    required String name,
    required String phone,
    required String aadharNumber,
    required List<String> products,
  }) async {
    isSavingCustomer.value = true;

    try {
      // Validation
      final validationError = _validateCustomerData(
        name: name,
        phone: phone,
        aadharNumber: aadharNumber,
        products: products,
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
        isSavingCustomer.value = false;
        return;
      }

      // Prepare images list
      List<File> images = [];
      if (aadharFrontImage.value != null) {
        images.add(aadharFrontImage.value!);
      }
      if (aadharBackImage.value != null) {
        images.add(aadharBackImage.value!);
      }

      // Prepare params with customer ID
      Map<String, dynamic> params = {
        'id': customerId,
        'name': name,
        'phone': phone,
        'aadhar_number': aadharNumber,
        'products': products.join(','),
      };

      debugPrint('=== UPDATE CUSTOMER REQUEST ===');
      debugPrint('Endpoint: update-customer');
      debugPrint('Params: $params');
      debugPrint('Images count: ${images.length}');

      // Use multipleImages API method
      final response = await API.instance.multipleImages(
        endPoint: '/update-customer',
        params: params,
        fileParams: 'aadhar_images',
        file: images.isNotEmpty ? images : null,
      );

      debugPrint('=== UPDATE CUSTOMER RESPONSE ===');
      debugPrint('Status Code: ${response.statusCode}');
      debugPrint('Response Body: ${response.body}');

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final addResponse = CustomerAddResponseModel.fromJson(data);
        final status = addResponse.status?.toLowerCase();
        final message = addResponse.message ?? 'Unknown response';

        if (status == "success") {
          Appdialogs.showToast(message);

          // Refresh customer list and detail
          refreshList();
          if (customerId.isNotEmpty) {
            getCustomerDetail(customerId);
          }

          // Reset edit mode
          isEditMode.value = false;
          selectedCustomerId.value = '';

          Get.back();

          Get.snackbar(
            'Success',
            'Customer updated successfully!',
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
      } else if (response.statusCode == 401) {
        Appdialogs.showToast('Session expired. Please login again.');
        Get.offAllNamed('/login');
      } else {
        throw Exception('Failed to update customer. Status code: ${response.statusCode}');
      }
    } catch (e, stackTrace) {
      isSavingCustomer.value = false;
      debugPrint('❌ Error in updateCustomer: $e');
      debugPrint('StackTrace: $stackTrace');

      String errorMsg = 'Failed to update customer. Please try again.';
      if (e.toString().contains('TimeoutException')) {
        errorMsg = 'Request timeout. Please check your internet connection.';
      }

      Get.snackbar(
        'Error',
        errorMsg,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
        duration: Duration(seconds: 4),
      );
    } finally {
      isSavingCustomer.value = false;
    }
  }

  // 3. Get Single Customer Detail
  Future<void> getCustomerDetail(String customerId) async {
    isLoadingDetail.value = true;

    try {
      final response = await API.instance.get(
        endPoint: '/get-customer/$customerId',
        params: {},
        isHeader: true,
      );

      debugPrint('=== GET CUSTOMER DETAIL RESPONSE ===');
      debugPrint('Status Code: ${response.statusCode}');
      debugPrint('Response Body: ${response.body}');

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        customerDetail.value = CustomerDetailModel.fromJson(data);
        final status = customerDetail.value.status?.toLowerCase();
        final message = customerDetail.value.message ?? 'Unknown response';

        if (status == "success") {
          // Populate form fields for editing
          if (customerDetail.value.data != null) {
            nameController.text = customerDetail.value.data!.name ?? '';
            phoneController.text = customerDetail.value.data!.phone ?? '';
            aadharController.text = customerDetail.value.data!.aadharNumber ?? '';

            // Parse products
            if (customerDetail.value.data!.products != null &&
                customerDetail.value.data!.products!.isNotEmpty) {
              selectedProducts.value = customerDetail.value.data!.getProductIds();
            }

            // Set edit mode
            isEditMode.value = true;
            selectedCustomerId.value = customerId;
          }

          debugPrint('Successfully loaded customer detail');
        } else {
          errorMessage.value = 'Error loading customer: $message';
          Appdialogs.showToast(errorMessage.value);
        }
      } else if (response.statusCode == 401) {
        Appdialogs.showToast('Session expired. Please login again.');
        Get.offAllNamed('/login');
      } else if (response.statusCode == 404) {
        errorMessage.value = 'Customer not found';
        Appdialogs.showToast(errorMessage.value);
      } else {
        throw Exception('Failed to get customer detail. Status code: ${response.statusCode}');
      }
    } catch (e, stackTrace) {
      errorMessage.value = 'Failed to load customer details. Please try again.';
      debugPrint('❌ Error in getCustomerDetail: $e');
      debugPrint('StackTrace: $stackTrace');

      Get.snackbar(
        'Error',
        errorMessage.value,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoadingDetail.value = false;
    }
  }

  // 4. Get Customer List with Search
  // 4. Get Customer List with Search - UPDATED with correct endpoint
  Future<void> getCustomerList({String search = '', int page = 1, bool loadMore = false}) async {
    if (!loadMore) {
      if (page == 1) {
        isLoading.value = true;
        errorMessage.value = '';
      } else {
        isRefreshing.value = true;
      }
    } else {
      isLoadMore.value = true;
    }

    try {
      Map<String, dynamic> params = {
        'page': page.toString(),
      };

      // Add search parameter if provided
      if (search.isNotEmpty) {
        params['search'] = search;
      }

      // Use CORRECT endpoint: getCustomerList = "/get-customer-list/seaarch"
      final response = await API.instance.get(
        endPoint: APIEndPoints.getCustomerList, // This is "/get-customer-list/seaarch"
        params: params,
        isHeader: true,
      );

      debugPrint('=== GET CUSTOMER LIST RESPONSE ===');
      debugPrint('Status Code: ${response.statusCode}');
      debugPrint('Response Body: ${response.body}');

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final customerListModel = CustomerListModel.fromJson(data);
        final status = customerListModel.status?.toLowerCase();
        final message = customerListModel.message ?? 'Unknown response';

        if (status == "success") {
          if (page == 1) {
            customerList.clear();
            filteredCustomerList.clear();
          }

          if (customerListModel.data != null && customerListModel.data!.isNotEmpty) {
            customerList.addAll(customerListModel.data! as Iterable<CustomerDetailData>);
            filteredCustomerList.assignAll(customerList);

            // Update pagination info
            currentPage.value = page;
            totalPages.value = customerListModel.lastPage ?? 1;
            hasMoreData.value = page < (customerListModel.lastPage ?? 1);

            errorMessage.value = '';

            debugPrint('✅ Successfully loaded ${customerListModel.data?.length ?? 0} customers');
          } else if (page == 1) {
            errorMessage.value = 'No customers found';
            debugPrint('ℹ️ No customers found in the database');
          }
        } else {
          errorMessage.value = 'Error loading customers: $message';
          if (page == 1) {
            Appdialogs.showToast(errorMessage.value);
          }
          debugPrint('❌ API Error: $message');
        }
      } else if (response.statusCode == 401) {
        Appdialogs.showToast('Session expired. Please login again.');
        Get.offAllNamed('/login');
      } else {
        errorMessage.value = 'Server error: ${response.statusCode}';
        debugPrint('❌ Server error: ${response.statusCode}');
      }
    } catch (e, stackTrace) {
      errorMessage.value = 'Network error: $e';
      debugPrint('❌ Network Error in getCustomerList: $e');
      debugPrint('StackTrace: $stackTrace');

      if (page == 1 && !loadMore) {
        Get.snackbar(
          'Error',
          errorMessage.value,
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } finally {
      isLoading.value = false;
      isRefreshing.value = false;
      isLoadMore.value = false;
    }
  }

  // 5. Update Customer Status
  // 5. Update Customer Status - UPDATED
  Future<void> updateCustomerStatus(String customerId, String status) async {
    isUpdatingStatus.value = true;

    try {
      String statusCode = '1'; // Default to active

      if (status.toLowerCase() == 'inactive') {
        statusCode = '2';
      } else if (status.toLowerCase() == 'trash') {
        statusCode = '3';
      }

      final response = await API.instance.get(
        endPoint: '${APIEndPoints.updateCustomerStatus}$customerId/$statusCode',
        params: {},
        isHeader: true,
      );

      debugPrint('=== UPDATE STATUS RESPONSE ===');
      debugPrint('Status Code: ${response.statusCode}');
      debugPrint('Response Body: ${response.body}');

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        // Parse response directly without using the model
        final apiStatus = data['status']?.toString().toLowerCase();
        final message = data['message']?.toString() ?? 'Status updated';

        if (apiStatus == "success") {
          Appdialogs.showToast(message);

          // Update local customer status
          final index = customerList.indexWhere((customer) => customer.id == customerId);
          if (index != -1) {
            customerList[index] = customerList[index].copyWith(status: status);
            customerList.refresh();

            final filteredIndex = filteredCustomerList.indexWhere((customer) => customer.id == customerId);
            if (filteredIndex != -1) {
              filteredCustomerList[filteredIndex] = filteredCustomerList[filteredIndex].copyWith(status: status);
              filteredCustomerList.refresh();
            }
          }

          Get.snackbar(
            'Success',
            'Status updated to ${status.toUpperCase()}',
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.green,
            colorText: Colors.white,
            duration: Duration(seconds: 2),
          );

          debugPrint('✅ Status updated successfully to: $status');
        } else {
          Appdialogs.showToast('Failed: $message');
          Get.snackbar(
            'Error',
            message,
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.red,
            colorText: Colors.white,
          );
          debugPrint('❌ Status update failed: $message');
        }
      } else if (response.statusCode == 401) {
        Appdialogs.showToast('Session expired. Please login again.');
        Get.offAllNamed('/login');
      } else if (response.statusCode == 404) {
        Appdialogs.showToast('Customer not found');
      } else {
        errorMessage.value = 'Server error: ${response.statusCode}';
        debugPrint('❌ Server error: ${response.statusCode}');
      }
    } catch (e, stackTrace) {
      debugPrint('❌ Error in updateCustomerStatus: $e');
      debugPrint('StackTrace: $stackTrace');

      Get.snackbar(
        'Error',
        'Failed to update status. Please try again.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
        duration: Duration(seconds: 4),
      );
    } finally {
      isUpdatingStatus.value = false;
    }
  }

// Add this method to CustomerController for debugging
  Future<void> debugAPI() async {
    print('=== DEBUGGING CUSTOMER API ===');
    print('Current endpoint: ${APIEndPoints.getCustomerList}');

    // Test the exact URL
    final testUrl = 'https://hsb.bugsbon.com/api/get-customer-list/seaarch?page=1';
    print('Testing URL: $testUrl');

    try {
      final response = await http.get(
        Uri.parse(testUrl),
        headers: {
          'access_token': await Preference.getSharedPref(KEY_TOKEN) ?? '',
        },
      );

      print('Response Status: ${response.statusCode}');
      print('Response Headers: ${response.headers}');
      print('Response Body: ${response.body}');

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['data'] is List) {
          print('Data is a list with ${(data['data'] as List).length} items');
          if ((data['data'] as List).isEmpty) {
            print('⚠️ List is empty - No customers in database');
          } else {
            print('✅ Customers found');
            print('First customer: ${data['data'][0]}');
          }
        }
      }
    } catch (e) {
      print('Error testing API: $e');
    }

    print('=== END DEBUG ===');
  }
  // Search Customers
  void searchCustomers(String query) {
    searchText.value = query;

    if (query.isEmpty) {
      filteredCustomerList.assignAll(customerList);
    } else {
      filteredCustomerList.assignAll(
          customerList.where((customer) {
            final name = customer.name?.toLowerCase() ?? '';
            final phone = customer.phone?.toLowerCase() ?? '';
            final aadhar = customer.aadharNumber?.toLowerCase() ?? '';
            final searchTerm = query.toLowerCase();

            return name.contains(searchTerm) ||
                phone.contains(searchTerm) ||
                aadhar.contains(searchTerm);
          }).toList()
      );
    }
  }

  // Save or Update Customer (combined method)
  Future<void> saveOrUpdateCustomer({
    String? customerId,
    required String name,
    required String phone,
    required String aadharNumber,
    required List<String> products,
  }) async {
    if (isEditMode.value && customerId != null) {
      await updateCustomer(
        customerId: customerId,
        name: name,
        phone: phone,
        aadharNumber: aadharNumber,
        products: products,
      );
    } else {
      await addCustomer(
        name: name,
        phone: phone,
        aadharNumber: aadharNumber,
        products: products,
      );
    }
  }

  // Image Picker Methods
  Future<void> pickAadharFrontImage() async {
    try {
      final pickedFile = await picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 80,
        maxWidth: 1024,
      );

      if (pickedFile != null) {
        aadharFrontImage.value = File(pickedFile.path);
        debugPrint('Front image selected: ${pickedFile.path}');
      }
    } catch (e) {
      debugPrint('Error picking front image: $e');
      Get.snackbar(
        'Error',
        'Failed to pick image. Please try again.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }
  int getInactiveCustomersCount() {
    return customerList.where((customer) => customer.status?.toLowerCase() == 'inactive').length;
  }
  Future<void> pickAadharBackImage() async {
    try {
      final pickedFile = await picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 80,
        maxWidth: 1024,
      );

      if (pickedFile != null) {
        aadharBackImage.value = File(pickedFile.path);
        debugPrint('Back image selected: ${pickedFile.path}');
      }
    } catch (e) {
      debugPrint('Error picking back image: $e');
      Get.snackbar(
        'Error',
        'Failed to pick image. Please try again.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  // Clear images
  void clearAadharFrontImage() {
    aadharFrontImage.value = null;
  }

  void clearAadharBackImage() {
    aadharBackImage.value = null;
  }

  // Validation
  String? _validateCustomerData({
    required String name,
    required String phone,
    required String aadharNumber,
    required List<String> products,
  }) {
    if (name.isEmpty) return 'Name is required';
    if (phone.isEmpty) return 'Phone number is required';
    if (aadharNumber.isEmpty) return 'Aadhar number is required';
    if (products.isEmpty) return 'At least one product is required';

    // Name validation (at least 2 characters)
    if (name.length < 2) {
      return 'Name must be at least 2 characters';
    }

    // Phone validation (10 digits)
    if (!RegExp(r'^[0-9]{10}$').hasMatch(phone)) {
      return 'Please enter a valid 10-digit phone number';
    }

    // Aadhar validation (12 digits)
    if (!RegExp(r'^[0-9]{12}$').hasMatch(aadharNumber)) {
      return 'Please enter a valid 12-digit Aadhar number';
    }

    return null;
  }

  // Clear form data
  void clearFormData() {
    nameController.clear();
    phoneController.clear();
    aadharController.clear();
    selectedProducts.clear();
    aadharFrontImage.value = null;
    aadharBackImage.value = null;
    errorMessage.value = '';
    isEditMode.value = false;
    selectedCustomerId.value = '';
  }

  // Load customer data for editing
  void loadCustomerForEdit(CustomerDetailData customer) {
    nameController.text = customer.name ?? '';
    phoneController.text = customer.phone ?? '';
    aadharController.text = customer.aadharNumber ?? '';

    if (customer.products != null && customer.products!.isNotEmpty) {
      selectedProducts.value = customer.getProductIds();
    }

    isEditMode.value = true;
    selectedCustomerId.value = customer.id ?? '';
  }

  // Refresh data
  void refreshList() {
    searchText.value = '';
    searchController.clear();
    currentPage.value = 1;
    hasMoreData.value = true;
    getCustomerList();
  }

  // Load more data for pagination
  void loadMoreData() {
    if (!isLoading.value && hasMoreData.value && !isRefreshing.value && !isLoadMore.value) {
      getCustomerList(
        search: searchText.value,
        page: currentPage.value + 1,
        loadMore: true,
      );
    }
  }

  // Toggle product selection
  void toggleProduct(String productId) {
    if (selectedProducts.contains(productId)) {
      selectedProducts.remove(productId);
    } else {
      selectedProducts.add(productId);
    }
    selectedProducts.refresh();
  }

  // Get status color
// In CustomerController.dart
  Color getStatusColor(String? status) {
    if (status == null) return Colors.grey;

    switch (status.toLowerCase()) {
      case 'active':
        return Colors.green;
      case 'inactive':
        return Colors.grey; // Grey for inactive
      case 'trash':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  String getStatusText(String? status) {
    if (status == null) return 'Unknown';

    switch (status.toLowerCase()) {
      case 'active':
        return 'Active';
      case 'inactive':
        return 'Inactive'; // Show "Inactive" text
      case 'trash':
        return 'Trashed';
      default:
        return status;
    }
  }

  // Get status icon
  IconData getStatusIcon(String? status) {
    if (status == null) return Icons.help_outline;

    switch (status.toLowerCase()) {
      case 'active':
        return Icons.check_circle;
      case 'inactive':
        return Icons.pause_circle;
      case 'trash':
        return Icons.delete;
      default:
        return Icons.help_outline;
    }
  }

  // Check if customer is active
  bool isCustomerActive(CustomerDetailData customer) {
    return customer.status?.toLowerCase() == 'active';
  }

  // Check if customer is in trash
  bool isCustomerTrashed(CustomerDetailData customer) {
    return customer.status?.toLowerCase() == 'trash';
  }

  // Delete customer (move to trash)
  Future<void> deleteCustomer(String customerId) async {
    await updateCustomerStatus(customerId, 'trash');
  }

  // Restore customer from trash
  Future<void> restoreCustomer(String customerId) async {
    await updateCustomerStatus(customerId, 'active');
  }

  // Get customer by ID
  CustomerDetailData? getCustomerById(String customerId) {
    return customerList.firstWhereOrNull((customer) => customer.id == customerId);
  }

  // Get total customers count
  int getTotalCustomers() {
    return customerList.length;
  }

  // Get active customers count
  int getActiveCustomersCount() {
    return customerList.where((customer) => isCustomerActive(customer)).length;
  }

  // Get trashed customers count
  int getTrashedCustomersCount() {
    return customerList.where((customer) => isCustomerTrashed(customer)).length;
  }

  // Prepare customer data for API
  Map<String, dynamic> prepareCustomerData({
    required String name,
    required String phone,
    required String aadharNumber,
    required List<String> products,
  }) {
    return {
      'name': name,
      'phone': phone,
      'aadhar_number': aadharNumber,
      'products': products.join(','),
    };
  }

  @override
  void onClose() {
    nameController.dispose();
    phoneController.dispose();
    aadharController.dispose();
    searchController.dispose();
    super.onClose();
  }
}