

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../Data/AppDialoge.dart';
import '../../Utils/Api.dart';
import '../../models/AdminModels/GiftModel.dart';


class GiftController extends GetxController {
  var isLoading = false.obs;
  var isDetailLoading = false.obs;
  var isAddLoading = false.obs;
  var isUpdateLoading = false.obs;

  var giftListModel = GiftListModel().obs;
  var giftDetailModel = GiftDetailModel().obs;

  RxList<GiftData> gifts = <GiftData>[].obs;

  // Text controllers for form fields
  var nameController = TextEditingController();
  var quantityController = TextEditingController();

  // Gift type management
  var selectedGiftType = Rxn<String>();

  // Gift types list
  final List<Map<String, String>> giftTypes = [
    {'value': 'cashier', 'label': 'Cashier'},
    {'value': 'gift_hamper', 'label': 'Gift Hamper'},
  ];

  // For editing
  var isEditMode = false.obs;
  var editingGiftId = ''.obs;

  // Search
  var searchController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    getGiftsList();
  }

  @override
  void onClose() {
    nameController.dispose();
    quantityController.dispose();
    searchController.dispose();
    super.onClose();
  }

  // Gift type methods
  void updateGiftType(String? type) {
    selectedGiftType.value = type;
    debugPrint('Selected gift type: $type');
  }

  String getGiftTypeDisplayName(String? value) {
    if (value == null) return '';
    try {
      var type = giftTypes.firstWhere(
            (type) => type['value'] == value,
        orElse: () => {'label': value},
      );
      return type['label']!;
    } catch (e) {
      return value;
    }
  }

  // Get gifts list
  void getGiftsList() async {
    isLoading.value = true;

    try {
      final response = await API.instance.get(
        endPoint: APIEndPoints.getGiftsList,
        params: {},
        isHeader: true,
      );

      var data = jsonDecode(response.body);
      var status = data['status'];
      var message = data['message'];

      debugPrint('Gifts List Response: $data');

      if (status == "success") {
        giftListModel.value = GiftListModel.fromJson(data);
        gifts.value = giftListModel.value.data ?? [];

        debugPrint('Gifts loaded: ${gifts.length}');
      } else {
        Appdialogs.showToast(message ?? 'Failed to load gifts');
      }
    } catch (e, stackTrace) {
      debugPrint('Error in getGiftsList: $e');
      debugPrint('Stack trace: $stackTrace');
      Appdialogs.showToast("Error fetching gifts list: ${e.toString()}");
    } finally {
      isLoading.value = false;
    }
  }

  // Search gifts
  void searchGifts(String query) async {
    isLoading.value = true;

    try {
      Map<String, dynamic> params = {};
      if (query.isNotEmpty) {
        params['search'] = query;
      }

      final response = await API.instance.get(
        endPoint: APIEndPoints.searchGifts,
        params: params,
        isHeader: true,
      );

      var data = jsonDecode(response.body);
      var status = data['status'];
      var message = data['message'];

      debugPrint('Search Gifts Response: $data');

      if (status == "success") {
        giftListModel.value = GiftListModel.fromJson(data);
        gifts.value = giftListModel.value.data ?? [];
      } else {
        Appdialogs.showToast(message ?? 'Search failed');
      }
    } catch (e, stackTrace) {
      debugPrint('Error in searchGifts: $e');
      debugPrint('Stack trace: $stackTrace');
      Appdialogs.showToast("Error searching gifts: ${e.toString()}");
    } finally {
      isLoading.value = false;
    }
  }

  // Get gift detail by ID
  void getGiftDetail(String giftId) async {
    isDetailLoading.value = true;

    try {
      final response = await API.instance.get(
        endPoint: "${APIEndPoints.getGiftDetail}/$giftId",
        params: {},
        isHeader: true,
      );

      var data = jsonDecode(response.body);
      var status = data['status'];
      var message = data['message'];

      debugPrint('Gift Detail Response: $data');

      if (status == "success") {
        giftDetailModel.value = GiftDetailModel.fromJson(data);

        // Set edit mode and populate form for editing
        isEditMode.value = true;
        editingGiftId.value = giftId;
        _populateFormFields();
      } else {
        Appdialogs.showToast(message ?? 'Failed to load gift details');
      }
    } catch (e, stackTrace) {
      debugPrint('Error in getGiftDetail: $e');
      debugPrint('Stack trace: $stackTrace');
      Appdialogs.showToast("Error fetching gift detail: ${e.toString()}");
    } finally {
      isDetailLoading.value = false;
    }
  }

  // Method to populate form fields for editing
  void _populateFormFields() {
    final giftData = giftDetailModel.value.data?[0];
    if (giftData == null) return;

    nameController.text = giftData.name ?? '';
    quantityController.text = giftData.quantity ?? '';

    debugPrint('Form populated for editing - Gift ID: ${giftData.id}');
  }

  // Add gift
  Future<bool> addGift() async {
    try {
      isAddLoading.value = true;

      // Validate required fields
      if (nameController.text.isEmpty) {
        Appdialogs.showToast("Please enter gift name");
        isAddLoading.value = false;
        return false;
      }

      if (selectedGiftType.value == null || selectedGiftType.value!.isEmpty) {
        Appdialogs.showToast("Please select gift type");
        isAddLoading.value = false;
        return false;
      }

      Map<String, dynamic> params = {
        'name': nameController.text,
        'type': selectedGiftType.value,
        'quantity': quantityController.text.isEmpty ? "0" : quantityController.text,
      };

      debugPrint('Add Gift Request: $params');

      final response = await API.instance.post(
        endPoint: APIEndPoints.addGift,
        params: params,
        isHeader: true,
      );

      var data = jsonDecode(response.body);
      var status = data['status'];
      var message = data['message'];

      debugPrint('Add Gift Response: $data');

      if (status == "success") {
        Appdialogs.showToast(message ?? 'Gift added successfully');
        getGiftsList();
        clearForm();
        return true;
      } else {
        Appdialogs.showToast(message ?? 'Failed to add gift');
        return false;
      }
    } catch (e, stackTrace) {
      debugPrint('Error in addGift: $e');
      debugPrint('Stack trace: $stackTrace');
      Appdialogs.showToast("Error adding gift: ${e.toString()}");
      return false;
    } finally {
      isAddLoading.value = false;
    }
  }
// Add this method to your GiftController class

// Delete gift permanently

  // Update gift
  Future<bool> updateGift() async {
    try {
      isUpdateLoading.value = true;

      // Validate required fields
      if (nameController.text.isEmpty) {
        Appdialogs.showToast("Please enter gift name");
        isUpdateLoading.value = false;
        return false;
      }

      if (selectedGiftType.value == null || selectedGiftType.value!.isEmpty) {
        Appdialogs.showToast("Please select gift type");
        isUpdateLoading.value = false;
        return false;
      }

      if (editingGiftId.value.isEmpty) {
        Appdialogs.showToast("Gift ID not found");
        isUpdateLoading.value = false;
        return false;
      }

      Map<String, dynamic> params = {
        'id': editingGiftId.value,
        'name': nameController.text,
        'type': selectedGiftType.value,
        'quantity': quantityController.text.isEmpty ? "0" : quantityController.text,
      };

      debugPrint('Update Gift Request: $params');

      final response = await API.instance.post(
        endPoint: APIEndPoints.updateGift,
        params: params,
        isHeader: true,
      );

      var data = jsonDecode(response.body);
      var status = data['status'];
      var message = data['message'];

      debugPrint('Update Gift Response: $data');

      if (status == "success") {
        Appdialogs.showToast(message ?? 'Gift updated successfully');
        getGiftsList();
        clearForm();
        return true;
      } else {
        Appdialogs.showToast(message ?? 'Failed to update gift');
        return false;
      }
    } catch (e, stackTrace) {
      debugPrint('Error in updateGift: $e');
      debugPrint('Stack trace: $stackTrace');
      Appdialogs.showToast("Error updating gift: ${e.toString()}");
      return false;
    } finally {
      isUpdateLoading.value = false;
    }
  }

  // Update gift status
  // In your GiftController class, update the delete method:

// Delete gift permanently using status update (set status to "9" for deletion)
  Future<bool> deleteGiftPermanently(String giftId) async {
    try {
      isUpdateLoading.value = true;

      // Use status "9" for permanent deletion, similar to schemes
      final endpoint = "${APIEndPoints.updateGiftStatus}/$giftId/9";
      debugPrint('Delete Gift Endpoint: $endpoint');

      final response = await API.instance.get(
        endPoint: endpoint,
        params: {},
        isHeader: true,
      );

      var data = jsonDecode(response.body);
      var apiStatus = data['status'];
      var message = data['message'];
      var responseCode = data['response_code'];

      debugPrint('Delete Gift Response: $data');

      if (apiStatus == "success" && responseCode == 200) {
        Appdialogs.showToast(message ?? 'Gift deleted successfully');
        // Refresh gifts list
        getGiftsList();
        return true;
      } else {
        Appdialogs.showToast(message ?? data['error'] ?? 'Delete failed');
        return false;
      }
    } catch (e, stackTrace) {
      debugPrint('Delete Gift Error: $e');
      debugPrint('Stack Trace: $stackTrace');
      Appdialogs.showToast("Error deleting gift: ${e.toString()}");
      return false;
    } finally {
      isUpdateLoading.value = false;
    }
  }

// Also update the status update method to handle deletion status
  Future<bool> updateGiftStatus(String giftId, String status) async {
    try {
      isUpdateLoading.value = true;

      final endpoint = "${APIEndPoints.updateGiftStatus}/$giftId/$status";
      debugPrint('Update Gift Status Endpoint: $endpoint');

      final response = await API.instance.get(
        endPoint: endpoint,
        params: {},
        isHeader: true,
      );

      var data = jsonDecode(response.body);
      var apiStatus = data['status'];
      var message = data['message'];
      var responseCode = data['response_code'];

      debugPrint('Status Update Response: $data');

      if (apiStatus == "success" && responseCode == 200) {
        String actionText = '';
        switch (status) {
          case "1":
            actionText = 'activated';
            break;
          case "0":
            actionText = 'deactivated';
            break;
          case "9":
            actionText = 'deleted';
            break;
          default:
            actionText = 'updated';
        }

        Appdialogs.showToast(message ?? 'Gift $actionText successfully');
        // Refresh gifts list
        getGiftsList();
        return true;
      } else {
        Appdialogs.showToast(message ?? data['error'] ?? 'Update failed');
        return false;
      }
    } catch (e, stackTrace) {
      debugPrint('Update Gift Status Error: $e');
      debugPrint('Stack Trace: $stackTrace');
      Appdialogs.showToast("Error updating gift status: ${e.toString()}");
      return false;
    } finally {
      isUpdateLoading.value = false;
    }
  }

  // Convenience methods for status updates
  Future<bool> activateGift(String giftId) async {
    return await updateGiftStatus(giftId, "1");
  }

  Future<bool> deactivateGift(String giftId) async {
    return await updateGiftStatus(giftId, "0");
  }

  // Get status display text
  String getStatusDisplayText(String? status) {
    switch (status) {
      case "1":
        return "Active";
      case "0":
        return "Inactive";
      default:
        return "Unknown";
    }
  }

  // Get status color
  Color getStatusColor(String? status) {
    switch (status) {
      case "1":
        return Colors.green;
      case "0":
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  // Clear form
  void clearForm() {
    nameController.clear();
    quantityController.clear();
    selectedGiftType.value = null;
    isEditMode.value = false;
    editingGiftId.value = '';

    debugPrint('Gift form cleared');
  }

  // Refresh data
  void refreshData() {
    getGiftsList();
  }

  // Search with debounce
  void onSearchChanged(String query) {
    if (query.isEmpty) {
      getGiftsList();
    } else {
      searchGifts(query);
    }
  }

  // Prepare for editing
  void prepareForEdit(String giftId) {
    getGiftDetail(giftId);
  }

  // Prepare for adding new gift
  void prepareForAdd() {
    clearForm();
    isEditMode.value = false;
  }

  // Submit form (handles both add and update)
  Future<bool> submitForm() async {
    if (isEditMode.value) {
      return await updateGift();
    } else {
      return await addGift();
    }
  }

  // Get form title
  String getFormTitle() {
    return isEditMode.value ? 'Edit Gift' : 'Add Gift';
  }

  // Get submit button text
  String getSubmitButtonText() {
    return isEditMode.value ? 'Update Gift' : 'Add Gift';
  }

  // Check if any loading operation is in progress
  bool get isAnyLoading {
    return isLoading.value ||
        isAddLoading.value ||
        isUpdateLoading.value ||
        isDetailLoading.value;
  }

  // Get gift by ID
  GiftData? getGiftById(String id) {
    try {
      return gifts.firstWhere((gift) => gift.id == id);
    } catch (e) {
      return null;
    }
  }

  // Get active gifts only
  List<GiftData> get activeGifts {
    return gifts.where((gift) => gift.status == "1").toList();
  }

  // Get inactive gifts only
  List<GiftData> get inactiveGifts {
    return gifts.where((gift) => gift.status == "0").toList();
  }

  // Get gifts count
  int get totalGiftsCount => gifts.length;
  int get activeGiftsCount => activeGifts.length;
  int get inactiveGiftsCount => inactiveGifts.length;
}