import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';


import '../../Data/AppDialoge.dart';
import '../../Utils/Api.dart';
import '../../Utils/StatusCodes.dart';
import '../../models/AdminModels/GetToatlStaffModel.dart';
import '../../models/AdminModels/StaffDetailModel.dart';
import '../../models/AdminModels/StaffListModel.dart';

class StaffController extends GetxController {
  var isLoading = false.obs;
  var getTotalStaffModel = GetToatlStaffModel().obs;
  var staffListModel = StaffListModel().obs;
  var staffDetailModel = StaffDetailModel().obs;

  var phoneController = TextEditingController();
  var salaryController = TextEditingController();
  var addressController = TextEditingController();
  var nameController = TextEditingController();
  var aadharController = TextEditingController();

  // Change from numeric to string to match UI
  var shiftValue = "".obs;
  var roleValue = "".obs;
  var selectedAccess = <String>[].obs;

  // var imageList = <File>[].obs;

  var staffType = "0".obs;
  var selectedFilter = "All Staff".obs;
  var currentStaffStatus = "1".obs;
  Rx<File?> aadharFrontImage = Rx<File?>(null);
  Rx<File?> aadharBackImage = Rx<File?>(null);

  RxList<File> imageList = <File>[].obs;

  final RxList<String> selectedAccessList = <String>[].obs;

  // Search functionality
  Timer? _debounceTimer;

  final Rx<String?> selectedShift = Rx<String?>(null);
  final Rx<String?> selectedRole = Rx<String?>(null);

  final Map<String, String> shiftMapping = {
    'Day Shift': '1',
    'Night Shift': '2',
    '24 Hour Shift': '0'
  };

  final Map<String, String> roleMapping = {
    'Manager': '3', 
    'Employee': '4', 
    'Truck Driver': '5'
  };

  // For editing
  var isEditMode = false.obs;
  var editingStaffId = ''.obs;

  // @override
  // void onInit() {
  //   super.onInit();
  //   getTotalStaff();
  //   getStaffList();
  // }

  @override
  void onClose() {
    _debounceTimer?.cancel();
    phoneController.dispose();
    salaryController.dispose();
    addressController.dispose();
    nameController.dispose();
    aadharController.dispose();
    super.onClose();
  }

  void updateSelectedAccess(List<String> access) {
    selectedAccessList.clear();
    selectedAccessList.addAll(access);
  }


  void updateShift(String? shift) {
    selectedShift.value = shift;
  }

  void updateRole(String? role) {
    selectedRole.value = role;
  }

  void setAadharFrontImage(File image) {
    aadharFrontImage.value = image;

    if (imageList.isEmpty) {
      imageList.add(image);
    } else if (imageList.length == 1) {
      imageList[0] = image;
    } else {
      imageList.insert(0, image);
    }
  }

  void setAadharBackImage(File image) {
    aadharBackImage.value = image;

    if (imageList.isEmpty) {
      imageList.add(image);
    } else if (imageList.length == 1 && aadharFrontImage.value != null) {
      imageList.add(image);
    } else if (imageList.length == 1) {
      imageList.insert(0, File('')); // Placeholder
      imageList[1] = image;
    } else if (imageList.length >= 2) {
      // Update existing back image
      imageList[1] = image;
    }
  }

  Future<void> addStaff() async {
    try {
      isLoading.value = true;

      if (aadharFrontImage.value == null || aadharBackImage.value == null) {
        Appdialogs.showToast("Please select both Aadhar card images");
        isLoading.value = false;
        return;
      }

      if (selectedAccessList.isEmpty) {
        Appdialogs.showToast("Please select at least one access type");
        isLoading.value = false;
        return;
      }

      if (selectedShift.value == null) {
        Appdialogs.showToast("Please select a shift");
        isLoading.value = false;
        return;
      }

      if (selectedRole.value == null) {
        Appdialogs.showToast("Please select a role");
        isLoading.value = false;
        return;
      }

      final String shiftApiValue = shiftMapping[selectedShift.value!] ?? '1';
      final String roleApiValue = roleMapping[selectedRole.value!] ?? '3';

      Map<String, dynamic> body = {
        'name': nameController.text,
        'phone': phoneController.text,
        'salary': salaryController.text,
        'address': addressController.text,
        'aadhar_number': aadharController.text,
        'shift': shiftApiValue,
        'access': selectedAccessList.join(','),
        'role': roleApiValue,
      };

      debugPrint('Request Body: $body');
      debugPrint('Images: ${imageList.length}');

      List<File> sortedImages = [];
      if (aadharFrontImage.value != null) {
        sortedImages.add(aadharFrontImage.value!);
      }
      if (aadharBackImage.value != null) {
        sortedImages.add(aadharBackImage.value!);
      }

      final response = await API.instance.multipleImages(
        endPoint: APIEndPoints.addStaff,
        params: body,
        fileParams: 'files',
        file: sortedImages,
      );

      var data = jsonDecode(response.body);
      var status = data['status'];
      var message = data['message'];

      if (status == "success") {
        Appdialogs.showToast(message);
        getStaffList();
        getTotalStaff();
         clear();
        Get.back();
      } else {
        Appdialogs.showToast(message);
      }
    } catch (e, stackTrace) {
      debugPrint(stackTrace.toString());
      debugPrint(e.toString());
      Appdialogs.showToast("Error: ${e.toString()}");
    } finally {
      isLoading.value = false;
    }
  }
  Future<void> toggleStaffStatus({required String staffId}) async {
    try {
      // Toggle between active (1) and inactive (0)
      String newStatus = currentStaffStatus.value == "0" ? "1" : "0";

      debugPrint('Toggling status from ${currentStaffStatus.value} to $newStatus');

      await updateStaffStatus(staffId: staffId, status: newStatus);

      // Update current status locally
      currentStaffStatus.value = newStatus;

      // Show success message
      Appdialogs.showToast(
          newStatus == "1"
              ? "Staff activated successfully"
              : "Staff de-activated successfully"
      );
    } catch (e) {
      debugPrint("Error toggling staff status: $e");
      Appdialogs.showToast("Error updating staff status");
    }
  }
  Future<void> updateStaff({required String staffId, String? updateStatus}) async {
    isLoading.value = true;

    try {
      // Validate required fields for staff update
      if (nameController.text.isEmpty ||
          phoneController.text.isEmpty ||
          addressController.text.isEmpty) {
        Appdialogs.showToast("Please fill all required fields");
        isLoading.value = false;
        return;
      }

      // Convert UI values to API values
      String shiftApiValue = shiftMapping[selectedShift.value] ?? selectedShift.value ?? '';
      String roleApiValue = roleMapping[selectedRole.value] ?? selectedRole.value ?? '';

      Map<String, dynamic> body = {
        'id': staffId,
        'name': nameController.text.trim(),
        'phone': phoneController.text.trim(),
        'address': addressController.text.trim(),
        'salary': salaryController.text.trim(),
        'aadhar': aadharController.text.trim(),
        'access': selectedAccessList.join(','),
        'shift': shiftApiValue,
        'role': roleApiValue,
      };

      // Add status parameter if provided
      if (updateStatus != null) {
        body['status'] = updateStatus;
      }

      debugPrint('Update Staff Request Body: $body');
      debugPrint('Images count: ${imageList.length}');

      // Prepare images for upload
      List<File> sortedImages = [];
      if (aadharFrontImage.value != null) {
        sortedImages.add(aadharFrontImage.value!);
      }
      if (aadharBackImage.value != null) {
        sortedImages.add(aadharBackImage.value!);
      }

      final response = await API.instance.multipleImages(
        endPoint: APIEndPoints.updateStaff,
        params: body,
        fileParams: 'files',
        file: sortedImages,
      );

      var data = jsonDecode(response.body);
      var status = data['status'];
      var message = data['message'];

      if (status == "success") {
        Appdialogs.showToast(message);
        // Refresh data
        getStaffList();
        getTotalStaff();
        clear();
        Get.back();
      } else {
        Appdialogs.showToast(message);
      }
    } catch (e, stackTrace) {
      debugPrint('Update Staff Error: $e');
      debugPrint('Stack Trace: $stackTrace');
      Appdialogs.showToast("Error updating staff: ${e.toString()}");
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> updateStaffStatus({required String staffId, required String status}) async {
    isLoading.value = true;
    try {
      final endpoint = "${APIEndPoints.updateStaffStatus}$staffId/$status";
      debugPrint('Update Staff Status Endpoint: $endpoint');

      final response = await API.instance.get(
          endPoint: endpoint,
          params: {},
          isHeader: true
      );

      var data = jsonDecode(response.body);
      var apiStatus = data['status'];
      var message = data['message'];

      if (apiStatus == "success") {
        Appdialogs.showToast(message);
        // Refresh both staff list and totals
        getStaffList(type: staffType.value);
        getTotalStaff();

        // Update local status
        currentStaffStatus.value = status;
      } else {
        Appdialogs.showToast(message);
      }
    } catch (e, stackTrace) {
      debugPrint('Update Staff Status Error: $e');
      debugPrint('Stack Trace: $stackTrace');
      Appdialogs.showToast("Error updating staff status: ${e.toString()}");
    } finally {
      isLoading.value = false;
    }
  }

// NEW: Improved method to toggle staff status directly


// Convenience helper to map actions to status codes and call updateStaffStatus
  Future<void> updateStaffStatusByAction({
    required String staffId,
    required String action,
  }) async {
    try {
      // Using the correct status codes: 0 => in-active, 1 => active, 2 => trash, 9 => delete
      final code = StatusCodes.getStatusCode(action);
      if (code == null) {
        Appdialogs.showToast('Invalid action: $action');
        return;
      }

      debugPrint('Updating staff $staffId with action: $action -> status: $code');

      await updateStaffStatus(staffId: staffId, status: code);

      // Show appropriate message based on action
      switch (action.toLowerCase()) {
        case 'activate':
          Appdialogs.showToast("Staff activated successfully");
          break;
        case 'deactivate':
          Appdialogs.showToast("Staff de-activated successfully");
          break;
        case 'trash':
          Appdialogs.showToast("Staff moved to trash successfully");
          break;
        case 'delete':
          Appdialogs.showToast("Staff permanently deleted");
          break;
      }

    } catch (e) {
      debugPrint("Error in updateStaffStatusByAction: $e");
      Appdialogs.showToast("Error performing action: $action");
    }
  }

// NEW: Method to handle multiple status updates with confirmation
  Future<void> updateStaffStatusWithConfirmation({
    required String staffId,
    required String status,
    required String confirmationMessage,
  }) async {
    // You can show a confirmation dialog here if needed
    // For now, directly update the status
    await updateStaffStatus(staffId: staffId, status: status);
  }
  // Future<void> updateStaff({required String staffId, String? updateStatus}) async {
  //   isLoading.value = true;
  //
  //   try {
  //     String shiftApiValue = selectedShift.value ?? '';
  //     String roleApiValue = selectedRole.value ?? '';
  //
  //     Map<String, dynamic> body = {
  //       'id': staffId,
  //       'name': nameController.text,
  //       'phone': phoneController.text,
  //       'address': addressController.text,
  //       'salary': salaryController.text,
  //       'aadhar': aadharController.text,
  //       'access': selectedAccessList.join(','),
  //       'shift': shiftApiValue,
  //       'role': roleApiValue,
  //     };
  //
  //     // Add status parameter if provided
  //     if (updateStatus != null) {
  //       body['status'] = updateStatus;
  //     }
  //
  //     debugPrint('Update Request Body: $body');
  //     debugPrint('Images: ${imageList.length}');
  //
  //     List<File> sortedImages = [];
  //     if (aadharFrontImage.value != null) {
  //       sortedImages.add(aadharFrontImage.value!);
  //     }
  //     if (aadharBackImage.value != null) {
  //       sortedImages.add(aadharBackImage.value!);
  //     }
  //
  //     final response = await API.instance.multipleImages(
  //       endPoint: APIEndPoints.updateStaff,
  //       params: body,
  //       fileParams: 'files',
  //       file: sortedImages,
  //     );
  //
  //     var data = jsonDecode(response.body);
  //     var status = data['status'];
  //     var message = data['message'];
  //
  //     if (status == "success") {
  //       Appdialogs.showToast(message);
  //       getStaffList();
  //       getTotalStaff();
  //       clear();
  //       Get.back();
  //     } else {
  //       Appdialogs.showToast(message);
  //     }
  //   } catch (e, stackTrace) {
  //     debugPrint(stackTrace.toString());
  //     debugPrint(e.toString());
  //     Appdialogs.showToast("Error: ${e.toString()}");
  //   } finally {
  //     isLoading.value = false;
  //   }
  // }
  //
  // Future<void> updateStaffStatus({required String staffId, required String status}) async {
  //   isLoading.value = true;
  //   try {
  //     final endpoint = APIEndPoints.updateStaffStatus + "$staffId/$status";
  //     final response = await API.instance.get(endPoint: endpoint, params: {}, isHeader: true);
  //
  //     var data = jsonDecode(response.body);
  //     var apiStatus = data['status'];
  //     var message = data['message'];
  //
  //     if (apiStatus == "success") {
  //       Appdialogs.showToast(message);
  //       getStaffList(type: staffType.value);
  //       getTotalStaff();
  //     } else {
  //       Appdialogs.showToast(message);
  //     }
  //   } catch (e) {
  //     debugPrint(e.toString());
  //     Appdialogs.showToast("Error updating staff status: ${e.toString()}");
  //   } finally {
  //     isLoading.value = false;
  //   }
  // }
  //
  // // Convenience helper to map actions to status codes and call updateStaffStatus
  // Future<void> updateStaffStatusByAction({
  //   required String staffId,
  //   required String action,
  // }) async {
  //   // Using the correct status codes: 0 => in-active, 1 => active, 2 => trash, 9 => delete
  //   final code = StatusCodes.getStatusCode(action);
  //   if (code == null) {
  //     Appdialogs.showToast('Invalid action: $action');
  //     return;
  //   }
  //   await updateStaffStatus(staffId: staffId, status: code);
  // }

  void getTotalStaff() async {
    isLoading.value = true;

    Map<String, dynamic> body = {};

    final response = await API.instance
        .get(endPoint: APIEndPoints.totalStaff, params: body, isHeader: true);

    isLoading.value = false;
    try {
      var data = jsonDecode(response.body);
      var status = data['status'];
      var message = data['message'];

      if (status == "success") {
        getTotalStaffModel.value =
            GetToatlStaffModel.fromJson(json.decode(response.body));
      } else {
        Appdialogs.showToast(message);
      }
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  void getStaffList({String type = "0", String search = ""}) async {
    isLoading.value = true;

    try {
      String endpoint;
      Map<String, dynamic> params = {};

      if (search.isNotEmpty) {
        // When searching, append search term to the endpoint path
        endpoint = "${APIEndPoints.getStaffList}/$type/$search";
      } else {
        // When not searching, use the regular endpoint
        endpoint = "${APIEndPoints.getStaffList}/$type";
      }

      final response = await API.instance.get(
          endPoint: endpoint,
          params: params,
          isHeader: true);

      var data = jsonDecode(response.body);
      var status = data['status'];
      var message = data['message'];

      if (status == "success") {
        staffListModel.value =
            StaffListModel.fromJson(jsonDecode(response.body));
      } else {
        Appdialogs.showToast(message);
      }
    } catch (e, stackTrace) {
      stackTrace.printError();
      debugPrint(e.toString());
      Appdialogs.showToast("Error: ${e.toString()}");
    } finally {
      isLoading.value = false;
    }
  }
  // Add these improved methods to your StaffController class
// NEW: Method to get current staff status for editing
  Future<void> getCurrentStaffStatus({required String staffId}) async {
    try {
      Map<String, dynamic> body = {};

      final response = await API.instance.get(
          endPoint: APIEndPoints.getStaffDetail + staffId,
          params: body,
          isHeader: true);

      var data = jsonDecode(response.body);
      var status = data['status'];

      if (status == "success") {
        var staffDetail = StaffDetailModel.fromJson(jsonDecode(response.body));
        if (staffDetail.data != null && staffDetail.data!.isNotEmpty) {
          // Convert "In-active" to "0" and "Active" to "1"
          String apiStatus = staffDetail.data![0].status ?? "Active";
          if (apiStatus == "In-active") {
            currentStaffStatus.value = "0";
          } else if (apiStatus == "Active") {
            currentStaffStatus.value = "1";
          } else {
            currentStaffStatus.value = apiStatus; // fallback
          }
          debugPrint('Current staff status loaded: $apiStatus -> ${currentStaffStatus.value}');
        }
      }
    } catch (e) {
      debugPrint("Error getting staff status: $e");
      currentStaffStatus.value = "1";
    }
  }
  Future<void> getStaffDetail({required String staffId}) async {
    print('Getting staff detail for ID: $staffId');

    // Set loading to true at the start
    isLoading.value = true;

    try {
      Map<String, dynamic> body = {};

      final response = await API.instance.get(
          endPoint: APIEndPoints.getStaffDetail + staffId,
          params: body,
          isHeader: true);

      print('Staff detail API call: ${APIEndPoints.getStaffDetail + staffId}');
      print('Staff detail response: ${response.body}');

      var data = jsonDecode(response.body);
      var status = data['status'];
      var message = data['message'];

      if (status == "success") {
        staffDetailModel.value = StaffDetailModel.fromJson(jsonDecode(response.body));
        print('Staff detail loaded successfully');
        
        // Set edit mode
        isEditMode.value = true;
        editingStaffId.value = staffId;
        
        // Populate form fields for editing
        _populateFormFields();
      } else {
        print('Staff detail error: $message');
        Appdialogs.showToast(message);
      }
    } catch (e) {
      print('Staff detail exception: $e');
      debugPrint(e.toString());
      Appdialogs.showToast("Error loading staff details: ${e.toString()}");
    } finally {
      print('Setting loading to false in getStaffDetail');
      isLoading.value = false;
    }
  }

  // Method to populate form fields for editing
  void _populateFormFields() {
    final staffData = staffDetailModel.value.data?[0];
    if (staffData == null) return;

    // Populate text controllers
    nameController.text = staffData.name ?? '';
    phoneController.text = staffData.phone ?? '';
    addressController.text = staffData.address ?? '';
    salaryController.text = staffData.salary ?? '';
    aadharController.text = staffData.aadharNumber ?? '';

    // Map role value from API to UI display
    String? roleDisplay;
    String roleValue = staffData.role ?? '';
    for (var entry in roleMapping.entries) {
      if (entry.value == roleValue || entry.key == roleValue) {
        roleDisplay = entry.key;
        break;
      }
    }
    selectedRole.value = roleDisplay;

    // Map shift value from API to UI display  
    String? shiftDisplay;
    String shiftValue = staffData.shift ?? '';
    for (var entry in shiftMapping.entries) {
      if (entry.value == shiftValue || entry.key == shiftValue) {
        shiftDisplay = entry.key;
        break;
      }
    }
    selectedShift.value = shiftDisplay;

    // Parse access permissions (comma-separated string to list)
    if (staffData.access != null && staffData.access!.isNotEmpty) {
      List<String> accessList = staffData.access!.split(',').map((e) => e.trim()).toList();
      selectedAccessList.clear();
      selectedAccessList.addAll(accessList);
    } else {
      selectedAccessList.clear();
    }

    print('Form populated with staff data for editing');
    print('Role: ${selectedRole.value}, Shift: ${selectedShift.value}');
    print('Access: ${selectedAccessList.join(', ')}');
  }


  void clear() {
    try {
      // Clear text controllers
      nameController.clear();
      phoneController.clear();
      addressController.clear();
      salaryController.clear();
      aadharController.clear();

      // Clear reactive variables
      selectedAccessList.clear();
      selectedAccess.clear();
      selectedShift.value = null;
      selectedRole.value = null;

      // Clear legacy variables that might still be used
      shiftValue.value = "";
      roleValue.value = "";

      // Clear images (don't delete files, just clear references)
      aadharFrontImage.value = null;
      aadharBackImage.value = null;
      imageList.clear();

      // Clear edit mode flags
      isEditMode.value = false;
      editingStaffId.value = '';

      // Reset current staff status
      currentStaffStatus.value = "1";

      print('Form data cleared successfully');
    } catch (e) {
      print('Error clearing form data: $e');
      // Don't show toast for clear errors, just log them
    }
  }
  // void clear() {
  //   try {
  //     // Clear text controllers
  //     nameController.clear();
  //     phoneController.clear();
  //     addressController.clear();
  //     salaryController.clear();
  //     aadharController.clear();
  //
  //     // Clear reactive variables
  //     selectedAccessList.clear();
  //     selectedAccess.clear();
  //     selectedShift.value = null;
  //     selectedRole.value = null;
  //
  //     // Clear legacy variables that might still be used
  //     shiftValue.value = "";
  //     roleValue.value = "";
  //
  //     // Clear images (don't delete files, just clear references)
  //     aadharFrontImage.value = null;
  //     aadharBackImage.value = null;
  //     imageList.clear();
  //
  //     // Clear edit mode flags
  //     isEditMode.value = false;
  //     editingStaffId.value = '';
  //
  //     print('Form data cleared successfully');
  //   } catch (e) {
  //     print('Error clearing form data: $e');
  //     // Don't show toast for clear errors, just log them
  //   }
  // }

// Add this method to properly handle shift mapping for editing
  String getShiftDisplayValue(String? apiValue) {
    if (apiValue == null) return '';

    switch (apiValue) {
      case '0':
        return '24 Hour Shift';
      case '1':
        return 'Day Shift';
      case '2':
        return 'Night Shift';
      default:
        return '';
    }
  }

// Add this method to properly handle role mapping for editing
  String getRoleDisplayValue(String? apiValue) {
    if (apiValue == null) return '';

    switch (apiValue) {
      case '3':
        return 'Manager';
      case '4':
        return 'Pump Worker';
      default:
        return '';
    }
  }



  void searchStaff(String searchText) {
    // Cancel any existing timer
    if (_debounceTimer != null) {
      _debounceTimer!.cancel();
    }

    // Start new timer with 500ms delay
    _debounceTimer = Timer(Duration(milliseconds: 500), () {
      getStaffList(type: staffType.value, search: searchText);
    });
  }

  void updateStaffFilter(String filterType, String filterName) {
    staffType.value = filterType;
    selectedFilter.value = filterName;
    // Refresh the list with new filter
    getStaffList(type: filterType);
  }
}
