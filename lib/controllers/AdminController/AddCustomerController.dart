import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:signature/signature.dart';
import '../../Data/AppDialoge.dart';
import '../../Utils/Api.dart';
import '../../models/AdminModels/CustomerDetailModel.dart';
import 'CreditCoustomerController.dart';

class AddCustomerController extends GetxController {
  // Text Controllers
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final aadharController = TextEditingController();
  final gstController = TextEditingController();
  final timePeriodController = TextEditingController();
  final amountLimitController = TextEditingController();
  final interestRateController = TextEditingController();

  var isLoading = false.obs;
  var selectedCompanyType = Rxn<String>();
  var selectedProductsList = <String>[].obs;
  var aadharFrontImageUrl = ''.obs;
  var aadharBackImageUrl = ''.obs;
  var aadharFrontImage = Rxn<File>();
  var aadharBackImage = Rxn<File>();

  // ===================== SIGNATURE =====================
  final signatureController = SignatureController(
    penStrokeWidth: 3,
    penColor: Colors.black,
    exportBackgroundColor: Colors.white,
  );

  var signatureBytes = Rxn<Uint8List>(); // PNG bytes
  var isSignatureAdded = false.obs;
  // =====================================================

  // For editing
  var isEditMode = false.obs;
  var editingCustomerId = ''.obs;
  var customerDetailModel = CustomerDetailModel().obs;

  // Dropdown options
  final companyTypes = [
    'Proprietorship',
    'Partnership',
    'Private Limited',
    'Public Limited'
  ];

  final products = [
    'Product 1',
    'Product 2',
    'Product 3',
    'Product 4'
  ];

  final companyTypeMapping = {
    'Proprietorship': 'Proprietorship',
    'Partnership': 'Partnership',
    'Private Limited': 'Private Limited',
    'Public Limited': 'Public Limited',
  };

  final productMapping = {
    'Product 1': '1',
    'Product 2': '2',
    'Product 3': '3',
    'Product 4': '4',
  };

  @override
  void onClose() {
    nameController.dispose();
    phoneController.dispose();
    aadharController.dispose();
    gstController.dispose();
    timePeriodController.dispose();
    amountLimitController.dispose();
    interestRateController.dispose();

    signatureController.dispose();

    super.onClose();
  }

  void clear() {
    nameController.clear();
    phoneController.clear();
    aadharController.clear();
    gstController.clear();
    timePeriodController.clear();
    amountLimitController.clear();
    interestRateController.clear();

    selectedCompanyType.value = null;
    selectedProductsList.clear();

    aadharFrontImage.value = null;
    aadharBackImage.value = null;

    signatureController.clear();
    signatureBytes.value = null;
    isSignatureAdded.value = false;

    isEditMode.value = false;
    editingCustomerId.value = '';
  }

  // ===================== SIGNATURE METHODS =====================
  Future<void> saveSignature() async {
    try {
      if (signatureController.isEmpty) {
        Appdialogs.showToast("Please add signature");
        return;
      }

      final data = await signatureController.toPngBytes();
      if (data != null) {
        signatureBytes.value = data;
        isSignatureAdded.value = true;
        Appdialogs.showToast("Signature saved");
      }
    } catch (e) {
      Appdialogs.showToast("Error saving signature");
    }
  }

  void clearSignature() {
    signatureController.clear();
    signatureBytes.value = null;
    isSignatureAdded.value = false;
  }

  // ✅ Convert signature bytes to file
  Future<File?> _signatureBytesToFile(Uint8List bytes) async {
    try {
      final Directory tempDir = Directory.systemTemp;

      final String filePath =
          "${tempDir.path}/signature_${DateTime.now().millisecondsSinceEpoch}.png";

      final file = File(filePath);
      await file.writeAsBytes(bytes);
      return file;
    } catch (e) {
      debugPrint("Signature file create error: $e");
      return null;
    }
  }
  // =============================================================

  // Method to get customer details for editing
  Future<void> getCustomerDetail({required String customerId}) async {
    debugPrint('Getting customer detail for ID: $customerId');
    isLoading.value = true;

    try {
      Map<String, dynamic> body = {};

      final response = await API.instance.get(
        endPoint: APIEndPoints.getCreditCustomerId + customerId,
        params: body,
        isHeader: true,
      );

      var data = jsonDecode(response.body);
      var status = data['status'];
      var message = data['message'];

      if (status == "success" &&
          data['data'] != null &&
          data['data'].isNotEmpty) {
        debugPrint('Customer detail loaded successfully');
        customerDetailModel.value = CustomerDetailModel.fromJson(data);

        // Set edit mode
        isEditMode.value = true;
        editingCustomerId.value = customerId;

        // Populate form fields
        _populateFormFields();
      } else {
        debugPrint('Failed to load customer details: $message');
        Appdialogs.showToast(message ?? "Failed to load customer details");
      }
    } catch (e, stackTrace) {
      debugPrint('Error loading customer details: $e');
      debugPrint('Stack trace: $stackTrace');
      Appdialogs.showToast("Error loading customer details: ${e.toString()}");
    } finally {
      isLoading.value = false;
    }
  }

  void _populateFormFields() {
    final customerData = customerDetailModel.value.data?[0];
    if (customerData == null) return;
    aadharFrontImageUrl.value = customerData.aadharFrontImage ?? '';
    aadharBackImageUrl.value = customerData.aadharBackImage ?? '';
    nameController.text = customerData.name ?? '';
    phoneController.text = customerData.phone ?? '';
    aadharController.text = customerData.aadharNumber ?? '';
    gstController.text = customerData.gstNumber ?? '';
    timePeriodController.text = customerData.timePeriod ?? '';
    amountLimitController.text = customerData.amountLimit ?? '';
    interestRateController.text = customerData.interestRate ?? '';

    // Set company type
    String companyType = customerData.companyType ?? '';
    if (companyTypes.contains(companyType)) {
      selectedCompanyType.value = companyType;
    } else {
      selectedCompanyType.value = null;
    }

    // Set products
    String productsString = customerData.products ?? '';
    if (productsString.isNotEmpty) {
      List<String> productIds = productsString.split(',');
      selectedProductsList.clear();

      for (String productId in productIds) {
        String trimmedId = productId.trim();
        String? productName;

        for (var entry in productMapping.entries) {
          if (entry.value == trimmedId) {
            productName = entry.key;
            break;
          }
        }

        if (productName != null && products.contains(productName)) {
          selectedProductsList.add(productName);
        }
      }
    }

    // Signature auto fill not possible (only local)
  }

  // Image handling
  void setAadharFrontImage(File image) {
    aadharFrontImage.value = image;
  }

  void setAadharBackImage(File image) {
    aadharBackImage.value = image;
  }

  bool validateForm() {
    if (nameController.text.trim().isEmpty) {
      Appdialogs.showToast("Please enter customer name");
      return false;
    }

    if (phoneController.text.trim().isEmpty) {
      Appdialogs.showToast("Please enter phone number");
      return false;
    }

    if (phoneController.text.trim().length != 10) {
      Appdialogs.showToast("Please enter valid 10-digit phone number");
      return false;
    }

    if (selectedCompanyType.value == null) {
      Appdialogs.showToast("Please select company type");
      return false;
    }

    if (aadharController.text.trim().isEmpty) {
      Appdialogs.showToast("Please enter Aadhar number");
      return false;
    }

    if (aadharController.text.trim().length != 12) {
      Appdialogs.showToast("Please enter valid 12-digit Aadhar number");
      return false;
    }

    if (selectedProductsList.isEmpty) {
      Appdialogs.showToast("Please select at least one product");
      return false;
    }

    if (timePeriodController.text.trim().isEmpty) {
      Appdialogs.showToast("Please enter time period");
      return false;
    }

    if (amountLimitController.text.trim().isEmpty) {
      Appdialogs.showToast("Please enter amount limit");
      return false;
    }

    if (interestRateController.text.trim().isEmpty) {
      Appdialogs.showToast("Please enter interest rate");
      return false;
    }

    if (aadharFrontImage.value == null || aadharBackImage.value == null) {
      Appdialogs.showToast("Please select both Aadhar card images");
      return false;
    }

    // Signature optional
    return true;
  }

  Future<void> addCustomer() async {
    try {
      if (!validateForm()) return;

      isLoading.value = true;

      final String companyTypeApiValue =
          companyTypeMapping[selectedCompanyType.value!] ?? 'Proprietorship';

      final List<String> productApiValues = selectedProductsList
          .map((product) => productMapping[product] ?? '1')
          .toList();

      Map<String, dynamic> body = {
        'name': nameController.text.trim(),
        'company_type': companyTypeApiValue,
        'phone': phoneController.text.trim(),
        'aadhar_number': aadharController.text.trim(),
        'products': productApiValues.join(','),
        'time_period': timePeriodController.text.trim(),
        'amount_limit': amountLimitController.text.trim(),
        'interest_rate': interestRateController.text.trim(),
      };

      if (isEditMode.value && editingCustomerId.value.isNotEmpty) {
        body['id'] = editingCustomerId.value;
      }

      if (gstController.text.trim().isNotEmpty) {
        body['gst_number'] = gstController.text.trim();
      }

      debugPrint('Request Body: $body');
      debugPrint('Edit Mode: ${isEditMode.value}');
      debugPrint(
          'Images: Front - ${aadharFrontImage.value?.path}, Back - ${aadharBackImage.value?.path}');

      // ✅ Add files list
      List<File> sortedImages = [];

      if (aadharFrontImage.value != null) {
        sortedImages.add(aadharFrontImage.value!);
      }

      if (aadharBackImage.value != null) {
        sortedImages.add(aadharBackImage.value!);
      }

      // ✅ Add signature as 3rd file
      if (signatureBytes.value != null) {
        File? signatureFile = await _signatureBytesToFile(signatureBytes.value!);
        if (signatureFile != null) {
          sortedImages.add(signatureFile);
          debugPrint("Signature file added: ${signatureFile.path}");
        }
      }

      String endpoint = isEditMode.value
          ? APIEndPoints.updateCreditCustomer
          : APIEndPoints.addCreditCustomer;

      http.Response response;

      if (sortedImages.isNotEmpty) {
        response = await API.instance.multipleImages(
          endPoint: endpoint,
          params: body,
          fileParams: 'files',
          file: sortedImages,
        );
      } else {
        response = await API.instance.post(
          endPoint: endpoint,
          params: body,
          isHeader: true,
        );
      }

      var data = jsonDecode(response.body);
      var status = data['status'];
      var message = data['message'];

      if (status == "success") {
        Appdialogs.showToast(message);
        CreditCoustomerController().getCreditCustomerList();
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

  void toggleProductSelection(String product) {
    if (selectedProductsList.contains(product)) {
      selectedProductsList.remove(product);
    } else {
      selectedProductsList.add(product);
    }
  }

  bool isProductSelected(String product) {
    return selectedProductsList.contains(product);
  }
}