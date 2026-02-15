
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../Data/AppDialoge.dart';
import '../../Utils/Api.dart';
import '../../Utils/Const.dart';
import '../../Utils/Preference.dart';
import '../../models/AdminModels/TankerCountModel.dart';
import '../../models/AdminModels/TankerDetailModel.dart';
import '../../models/AdminModels/TankerListModel.dart';

class TankerController extends GetxController {
  var isLoading = false.obs;
  var isCountLoading = false.obs;
  var isDetailLoading = false.obs;
  var isAddLoading = false.obs;
  var isUpdateLoading = false.obs;
  var isCrewLoading = false.obs;
  var existingRcDocUrl = ''.obs;
  var existingOtherCertUrl = ''.obs;
  var tankerListModel = TankerListModel().obs;
  var tankerDetailModel = TankerDetailModel().obs;
  var tankerCountModel = TankerCountModel().obs;

  // FIXED: Changed from TankerListModel to TankerData
  RxList<TankerData> tankers = <TankerData>[].obs;

  // Text controllers for form fields
  var registrationNumberController = TextEditingController();
  var capacityController = TextEditingController();
  var fitnessCertNoController = TextEditingController();
  var pollutionControlCertNoController = TextEditingController();
  var insurancePolicyNumberController = TextEditingController();
  var permitNumberController = TextEditingController();
  var calibrationNumberController = TextEditingController();

  // Date controllers
  var fitnessCertExpDateController = TextEditingController();
  var pollutionControlCertExpDateController = TextEditingController();
  var insuranceExpDateController = TextEditingController();
  var calibrationDateController = TextEditingController();
  var calibrationExpDateController = TextEditingController(); // ADDED: Calibration expiry date
  var explosiveExpDateController = TextEditingController();

  // Selected values
  var selectedFitnessCertExpDate = Rxn<String>();
  var selectedPollutionControlCertExpDate = Rxn<String>();
  var selectedInsuranceExpDate = Rxn<String>();
  var selectedCalibrationDate = Rxn<String>();
  var selectedCalibrationExpDate = Rxn<String>(); // ADDED: Calibration expiry date
  var selectedExplosiveExpDate = Rxn<String>();

  // File variables
  Rx<File?> rcDocFile = Rx<File?>(null);
  Rx<File?> otherCertFile = Rx<File?>(null);
  Rx<File?> rcDocImage = Rx<File?>(null);
  Rx<File?> otherCertImage = Rx<File?>(null);

  // For editing
  var isEditMode = false.obs;
  var editingTankerId = ''.obs;

  // Crew member controllers
  var driverNameController = TextEditingController();
  var driverLicenseNoController = TextEditingController();
  var mobileController = TextEditingController();
  var aadharNumberController = TextEditingController();
  var helperNameController = TextEditingController();
  var helperMobileController = TextEditingController();
  var remarkController = TextEditingController();

  // Crew member date selections
  var selectedLicenseExpDate = Rxn<String>();
  var selectedGatePassExpDate = Rxn<String>();
  var selectedTraningCardExpDate = Rxn<String>();
  var selectedHazardousGoodsExpDate = Rxn<String>();

  // Crew member files
  Rx<File?> aadharDocFile = Rx<File?>(null);
  Rx<File?> traningCardDocFile = Rx<File?>(null);
  Rx<File?> gatePassDocFile = Rx<File?>(null);
  Rx<File?> hazardousGoodsDocFile = Rx<File?>(null);
  Rx<File?> helperAadharDocFile = Rx<File?>(null);

  @override
  void onInit() {
    super.onInit();
    refreshAllData();
  }

  @override
  void onClose() {
    // Dispose controllers
    registrationNumberController.dispose();
    capacityController.dispose();
    fitnessCertNoController.dispose();
    pollutionControlCertNoController.dispose();
    insurancePolicyNumberController.dispose();
    permitNumberController.dispose();
    calibrationNumberController.dispose();

    // Dispose date controllers
    fitnessCertExpDateController.dispose();
    pollutionControlCertExpDateController.dispose();
    insuranceExpDateController.dispose();
    calibrationDateController.dispose();
    calibrationExpDateController.dispose(); // ADDED: Dispose calibration expiry date controller
    explosiveExpDateController.dispose();

    // Dispose crew controllers
    driverNameController.dispose();
    driverLicenseNoController.dispose();
    mobileController.dispose();
    aadharNumberController.dispose();
    helperNameController.dispose();
    helperMobileController.dispose();
    remarkController.dispose();
    super.onClose();
  }

  // File management methods
  void setRcDocFile(File file) {
    rcDocFile.value = file;
  }

  void setOtherCertFile(File file) {
    otherCertFile.value = file;
  }

  void setRcDocImage(File file) {
    rcDocImage.value = file;
    rcDocFile.value = file;
  }

  void setOtherCertImage(File file) {
    otherCertImage.value = file;
    otherCertFile.value = file;
  }

  // Clear method
  void clear() {
    clearTankerForm();
    clearCrewForm();
  }

  // Crew member file management
  void setAadharDocFile(File file) {
    aadharDocFile.value = file;
  }

  void setTraningCardDocFile(File file) {
    traningCardDocFile.value = file;
  }

  void setGatePassDocFile(File file) {
    gatePassDocFile.value = file;
  }

  void setHazardousGoodsDocFile(File file) {
    hazardousGoodsDocFile.value = file;
  }

  void setHelperAadharDocFile(File file) {
    helperAadharDocFile.value = file;
  }

  // Get tanker list method
  void getTankerList({String type = "0", String search = ""}) async {
    isLoading.value = true;

    try {
      String endpoint;
      Map<String, dynamic> params = {};

      if (search.isNotEmpty) {
        endpoint = "${APIEndPoints.getTankerList}/$type/search";
        params['search'] = search;
      } else {
        endpoint = "${APIEndPoints.getTankerList}/$type";
      }

      final response = await API.instance.get(
          endPoint: endpoint,
          params: params,
          isHeader: true);

      var data = jsonDecode(response.body);
      var status = data['status'];
      var message = data['message'];

      if (status == "success") {
        tankerListModel.value = TankerListModel.fromJson(data);
        tankers.value = tankerListModel.value.data ?? [];
      } else {
        Appdialogs.showToast(message);
      }
    } catch (e, stackTrace) {
      debugPrint('Error in getTankerList: $e');
      debugPrint('Stack trace: $stackTrace');
      Appdialogs.showToast("Error fetching tanker list: ${e.toString()}");
    } finally {
      isLoading.value = false;
    }
  }

  // Get total tanker count
  void getTankerCount() async {
    isCountLoading.value = true;

    try {
      Map<String, dynamic> body = {};

      final response = await API.instance.get(
          endPoint: APIEndPoints.getTotalTanker,
          params: body,
          isHeader: true);

      var data = jsonDecode(response.body);
      var status = data['status'];
      var message = data['message'];

      if (status == "success") {
        tankerCountModel.value = TankerCountModel.fromJson(data);
      } else {
        Appdialogs.showToast(message);
      }
    } catch (e, stackTrace) {
      debugPrint('Error in getTankerCount: $e');
      debugPrint('Stack trace: $stackTrace');
      Appdialogs.showToast("Error fetching tanker count: ${e.toString()}");
    } finally {
      isCountLoading.value = false;
    }
  }

  // Get tanker detail by ID
  void getTankerDetail(String tankerId) async {
    isDetailLoading.value = true;

    try {
      Map<String, dynamic> body = {};

      final response = await API.instance.get(
          endPoint: "${APIEndPoints.getTankerDetail}/$tankerId",
          params: body,
          isHeader: true);

      var data = jsonDecode(response.body);
      var status = data['status'];
      var message = data['message'];

      if (status == "success") {
        tankerDetailModel.value = TankerDetailModel.fromJson(data);

        // Set edit mode and populate form for editing
        isEditMode.value = true;
        editingTankerId.value = tankerId;
        _populateFormFields();
      } else {
        Appdialogs.showToast(message);
      }
    } catch (e, stackTrace) {
      debugPrint('Error in getTankerDetail: $e');
      debugPrint('Stack trace: $stackTrace');
      Appdialogs.showToast("Error fetching tanker detail: ${e.toString()}");
    } finally {
      isDetailLoading.value = false;
    }
  }

  // Method to populate form fields for editing
  void _populateFormFields() {
    final tankerData = tankerDetailModel.value.data?[0];
    if (tankerData == null) return;

    // Populate text controllers
    registrationNumberController.text = tankerData.registrationNumber ?? '';
    capacityController.text = tankerData.capacity ?? '';
    fitnessCertNoController.text = tankerData.fitnessCertNo ?? '';
    pollutionControlCertNoController.text = tankerData.pollutionControlCertNo ?? '';
    insurancePolicyNumberController.text = tankerData.insurancePolicyNumber ?? '';
    permitNumberController.text = tankerData.permitNumber ?? '';
    calibrationNumberController.text = tankerData.calibrationNumber ?? '';

    // Set date controllers
    fitnessCertExpDateController.text = tankerData.fitnessCertExpDate ?? '';
    pollutionControlCertExpDateController.text = tankerData.pollutionControlCertExpDate ?? '';
    insuranceExpDateController.text = tankerData.insuranceExpDate ?? '';
    calibrationDateController.text = tankerData.calibrationDate ?? '';
    calibrationExpDateController.text = tankerData.calibrationExpDate ?? ''; // ADDED: Calibration expiry date
    explosiveExpDateController.text = tankerData.explosiveExpDate ?? '';

    // Set date observables
    selectedFitnessCertExpDate.value = tankerData.fitnessCertExpDate;
    selectedPollutionControlCertExpDate.value = tankerData.pollutionControlCertExpDate;
    selectedInsuranceExpDate.value = tankerData.insuranceExpDate;
    selectedCalibrationDate.value = tankerData.calibrationDate;
    selectedCalibrationExpDate.value = tankerData.calibrationExpDate; // ADDED: Calibration expiry date
    selectedExplosiveExpDate.value = tankerData.explosiveExpDate;

    debugPrint('Form populated for editing');
  }

  // Update tanker status
  Future<bool> updateTankerStatus(String tankerId, String status) async {
    try {
      isUpdateLoading.value = true;

      // Use GET method with endpoint: /update-tanker-status/id/status
      final endpoint = "${APIEndPoints.updateTankerStatus}/$tankerId/$status";
      debugPrint('Update Tanker Status Endpoint: $endpoint');

      final response = await API.instance.get(
        endPoint: endpoint,
        params: {}, // Empty params since ID and status are in URL
        isHeader: true,
      );

      var data = jsonDecode(response.body);
      var apiStatus = data['status'];
      var message = data['message'];

      debugPrint('Status Update Response: $data');

      if (apiStatus == "success") {
        Appdialogs.showToast(message);
        // Refresh tanker data
        refreshAllData();
        return true;
      } else {
        Appdialogs.showToast(message ?? data['error'] ?? 'Update failed');
        return false;
      }
    } catch (e, stackTrace) {
      debugPrint('Update Tanker Status Error: $e');
      debugPrint('Stack Trace: $stackTrace');
      Appdialogs.showToast("Error updating tanker status: ${e.toString()}");
      return false;
    } finally {
      isUpdateLoading.value = false;
    }
  }

  // Convenience methods
  Future<bool> activateTanker(String tankerId) async {
    return await updateTankerStatus(tankerId, "1");
  }

  Future<bool> deactivateTanker(String tankerId) async {
    return await updateTankerStatus(tankerId, "0");
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

  // Fixed addTanker method with calibration expiry date
  Future<bool> addTanker() async {
    try {
      isAddLoading.value = true;

      // Validate required fields
      if (registrationNumberController.text.isEmpty) {
        Appdialogs.showToast("Please enter registration number");
        isAddLoading.value = false;
        return false;
      }

      if (capacityController.text.isEmpty) {
        Appdialogs.showToast("Please enter capacity");
        isAddLoading.value = false;
        return false;
      }

      // Validate calibration number (required by API)
      if (calibrationNumberController.text.isEmpty) {
        Appdialogs.showToast("Please enter calibration number");
        isAddLoading.value = false;
        return false;
      }

      if (rcDocFile.value == null) {
        Appdialogs.showToast("Please select RC document");
        isAddLoading.value = false;
        return false;
      }

      // Use the correct endpoint
      final String completeUrl = API.instance.kBaseURL + APIEndPoints.addTanker;

      // Create a multipart request
      var request = http.MultipartRequest('POST', Uri.parse(completeUrl));

      // Get token for authorization
      var token = await Preference.getSharedPref(KEY_TOKEN);

      // Add headers
      request.headers['access_token'] = '$token';

      // Add REQUIRED fields
      request.fields['registration_number'] = registrationNumberController.text;
      request.fields['capacity'] = capacityController.text;
      request.fields['calibration_number'] = calibrationNumberController.text;

      // Add optional fields only if they have values
      if (fitnessCertNoController.text.isNotEmpty) {
        request.fields['fitness_cert_no'] = fitnessCertNoController.text;
      }
      if (fitnessCertExpDateController.text.isNotEmpty) {
        request.fields['fitness_cert_exp_date'] = fitnessCertExpDateController.text;
      }
      if (pollutionControlCertNoController.text.isNotEmpty) {
        request.fields['pollution_control_cert_no'] = pollutionControlCertNoController.text;
      }
      if (pollutionControlCertExpDateController.text.isNotEmpty) {
        request.fields['pollution_control_cert_exp_date'] = pollutionControlCertExpDateController.text;
      }
      if (insurancePolicyNumberController.text.isNotEmpty) {
        request.fields['insurance_policy_number'] = insurancePolicyNumberController.text;
      }
      if (insuranceExpDateController.text.isNotEmpty) {
        request.fields['insurance_exp_date'] = insuranceExpDateController.text;
      }
      // ADDED: Calibration expiry date field
      if (calibrationExpDateController.text.isNotEmpty) {
        request.fields['calibration_exp_date'] = calibrationExpDateController.text;
      }
      if (permitNumberController.text.isNotEmpty) {
        request.fields['permit_number'] = permitNumberController.text;
      }
      if (explosiveExpDateController.text.isNotEmpty) {
        request.fields['explosive_exp_date'] = explosiveExpDateController.text;
      }

      debugPrint('=== TANKER CREATE REQUEST ===');
      debugPrint('URL: $completeUrl');
      debugPrint('Fields: ${request.fields}');

      // Add RC document (mandatory)
      if (rcDocFile.value != null) {
        request.files.add(await http.MultipartFile.fromPath(
          'rc_doc',
          rcDocFile.value!.path,
        ));
        debugPrint('RC Document: ${rcDocFile.value!.path}');
      }

      // Add other certificate (optional)
      if (otherCertFile.value != null) {
        request.files.add(await http.MultipartFile.fromPath(
          'other_cert',
          otherCertFile.value!.path,
        ));
        debugPrint('Other Certificate: ${otherCertFile.value!.path}');
      }

      debugPrint('Total files: ${request.files.length}');

      // Send the request
      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);

      debugPrint('Response status: ${response.statusCode}');
      debugPrint('Response body: ${response.body}');

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);

        // Handle both string and boolean status
        var status = data['status'];
        var message = data['message'] ?? data['error'] ?? 'Unknown response';

        if (status == true || status == "success") {
          Appdialogs.showToast(message.toString());
          getTankerList();
          getTankerCount();
          clearTankerForm();
          Get.back();
          return true;
        } else {
          Appdialogs.showToast(message.toString());
          return false;
        }
      } else if (response.statusCode == 400) {
        // Handle validation errors
        var data = jsonDecode(response.body);
        var message = data['message'] ?? 'Validation error';
        Appdialogs.showToast(message.toString());
        return false;
      } else {
        Appdialogs.showToast("Server error: ${response.statusCode}");
        return false;
      }
    } catch (e, stackTrace) {
      debugPrint('Error in addTanker: $e');
      debugPrint('Stack trace: $stackTrace');
      Appdialogs.showToast("Error adding tanker: ${e.toString()}");
      return false;
    } finally {
      isAddLoading.value = false;
    }
  }

  // Update tanker with calibration expiry date
  Future<bool> updateTanker(String id) async {
    try {
      isUpdateLoading.value = true;

      // Validate required fields
      if (registrationNumberController.text.isEmpty) {
        Appdialogs.showToast("Please enter registration number");
        isUpdateLoading.value = false;
        return false;
      }

      if (capacityController.text.isEmpty) {
        Appdialogs.showToast("Please enter capacity");
        isUpdateLoading.value = false;
        return false;
      }

      // Validate calibration number (required by API)
      if (calibrationNumberController.text.isEmpty) {
        Appdialogs.showToast("Please enter calibration number");
        isUpdateLoading.value = false;
        return false;
      }

      Map<String, dynamic> params = {
        'id': id,
        'registration_number': registrationNumberController.text,
        'capacity': capacityController.text,
        'fitness_cert_no': fitnessCertNoController.text,
        'fitness_cert_exp_date': fitnessCertExpDateController.text,
        'pollution_control_cert_no': pollutionControlCertNoController.text,
        'pollution_control_cert_exp_date': pollutionControlCertExpDateController.text,
        'insurance_policy_number': insurancePolicyNumberController.text,
        'insurance_exp_date': insuranceExpDateController.text,
        'calibration_number': calibrationNumberController.text,
        'calibration_date': calibrationDateController.text,
        'calibration_exp_date': calibrationExpDateController.text, // ADDED: Calibration expiry date
        'permit_number': permitNumberController.text,
        'explosive_exp_date': explosiveExpDateController.text,
      };

      debugPrint('Update Request Body: $params');

      http.Response response;

      // Check if any files are provided
      if (rcDocFile.value != null || otherCertFile.value != null) {
        List<File> sortedFiles = [];
        if (rcDocFile.value != null) {
          sortedFiles.add(rcDocFile.value!);
        }
        if (otherCertFile.value != null) {
          sortedFiles.add(otherCertFile.value!);
        }

        debugPrint('Files to upload: ${sortedFiles.length}');

        response = await API.instance.multipleImages(
          endPoint: APIEndPoints.updateTanker,
          params: params,
          fileParams: 'files',
          file: sortedFiles,
        );
      } else {
        response = await API.instance.post(
          endPoint: APIEndPoints.updateTanker,
          params: params,
          isHeader: true,
        );
      }

      var data = jsonDecode(response.body);
      var status = data['status'];
      var message = data['message'];

      if (status == "success") {
        Appdialogs.showToast(message);
        getTankerList();
        getTankerCount();
        clearTankerForm();
        Get.back();
        return true;
      } else {
        Appdialogs.showToast(message);
        return false;
      }
    } catch (e, stackTrace) {
      debugPrint('Error in updateTanker: $e');
      debugPrint('Stack trace: $stackTrace');
      Appdialogs.showToast("Error updating tanker: ${e.toString()}");
      return false;
    } finally {
      isUpdateLoading.value = false;
    }
  }

  // Add crew member
  // Future<bool> addCrewMember(String tankerId) async {
  //   try {
  //     isCrewLoading.value = true;
  //
  //     // Validate required fields
  //     if (driverNameController.text.isEmpty) {
  //       Appdialogs.showToast("Please enter driver name");
  //       isCrewLoading.value = false;
  //       return false;
  //     }
  //
  //     if (driverLicenseNoController.text.isEmpty) {
  //       Appdialogs.showToast("Please enter driver license number");
  //       isCrewLoading.value = false;
  //       return false;
  //     }
  //
  //     if (mobileController.text.isEmpty) {
  //       Appdialogs.showToast("Please enter mobile number");
  //       isCrewLoading.value = false;
  //       return false;
  //     }
  //
  //     if (aadharNumberController.text.isEmpty) {
  //       Appdialogs.showToast("Please enter Aadhar number");
  //       isCrewLoading.value = false;
  //       return false;
  //     }
  //
  //     // Validate required files
  //     if (aadharDocFile.value == null || traningCardDocFile.value == null ||
  //         gatePassDocFile.value == null || hazardousGoodsDocFile.value == null) {
  //       Appdialogs.showToast("Please select all required documents");
  //       isCrewLoading.value = false;
  //       return false;
  //     }
  //
  //     Map<String, dynamic> params = {
  //       'tanker_id': tankerId,
  //       'driver_name': driverNameController.text,
  //       'driver_license_no': driverLicenseNoController.text,
  //       'mobile': mobileController.text,
  //       'aadhar_number': aadharNumberController.text,
  //       'license_exp_date': selectedLicenseExpDate.value ?? '',
  //       'gate_pass_exp_date': selectedGatePassExpDate.value ?? '',
  //       'traning_card_exp_date': selectedTraningCardExpDate.value ?? '',
  //       'hazardous_goods_exp_date': selectedHazardousGoodsExpDate.value ?? '',
  //     };
  //
  //     // Add optional fields if provided
  //     if (helperNameController.text.isNotEmpty) {
  //       params['helper_name'] = helperNameController.text;
  //     }
  //     if (helperMobileController.text.isNotEmpty) {
  //       params['helper_mobile'] = helperMobileController.text;
  //     }
  //     if (remarkController.text.isNotEmpty) {
  //       params['remark'] = remarkController.text;
  //     }
  //
  //     debugPrint('Crew Request Body: $params');
  //
  //     // Create sorted files list
  //     List<File> sortedFiles = [];
  //     if (aadharDocFile.value != null) {
  //       sortedFiles.add(aadharDocFile.value!);
  //     }
  //     if (traningCardDocFile.value != null) {
  //       sortedFiles.add(traningCardDocFile.value!);
  //     }
  //     if (gatePassDocFile.value != null) {
  //       sortedFiles.add(gatePassDocFile.value!);
  //     }
  //     if (hazardousGoodsDocFile.value != null) {
  //       sortedFiles.add(hazardousGoodsDocFile.value!);
  //     }
  //     if (helperAadharDocFile.value != null) {
  //       sortedFiles.add(helperAadharDocFile.value!);
  //     }
  //
  //     debugPrint('Files to upload: ${sortedFiles.length}');
  //
  //     final response = await API.instance.multipleImages(
  //       endPoint: APIEndPoints.addCrewMember,
  //       params: params,
  //       fileParams: 'files',
  //       file: sortedFiles,
  //     );
  //
  //     var data = jsonDecode(response.body);
  //     var status = data['status'];
  //     var message = data['message'];
  //
  //     if (status == "success") {
  //       Appdialogs.showToast(message);
  //       clearCrewForm();
  //       Get.back();
  //       return true;
  //     } else {
  //       Appdialogs.showToast(message);
  //       return false;
  //     }
  //   } catch (e, stackTrace) {
  //     debugPrint('Error in addCrewMember: $e');
  //     debugPrint('Stack trace: $stackTrace');
  //     Appdialogs.showToast("Error adding crew member: ${e.toString()}");
  //     return false;
  //   } finally {
  //     isCrewLoading.value = false;
  //   }
  // }
// Add crew member with file uploads
  Future<bool> addCrewMember(String tankerId) async {
    try {
      isCrewLoading.value = true;

      // Validate required fields
      if (driverNameController.text.isEmpty) {
        Appdialogs.showToast("Please enter driver name");
        isCrewLoading.value = false;
        return false;
      }

      if (driverLicenseNoController.text.isEmpty) {
        Appdialogs.showToast("Please enter driver license number");
        isCrewLoading.value = false;
        return false;
      }

      if (mobileController.text.isEmpty) {
        Appdialogs.showToast("Please enter mobile number");
        isCrewLoading.value = false;
        return false;
      }

      if (aadharNumberController.text.isEmpty) {
        Appdialogs.showToast("Please enter Aadhar number");
        isCrewLoading.value = false;
        return false;
      }

      // Create multipart request
      final String completeUrl = API.instance.kBaseURL + APIEndPoints.addCrewMember;
      var request = http.MultipartRequest('POST', Uri.parse(completeUrl));

      // Get token for authorization
      var token = await Preference.getSharedPref(KEY_TOKEN);

      // Add headers
      request.headers['access_token'] = '$token';

      // Add required fields
      request.fields['tanker_id'] = tankerId;
      request.fields['driver_name'] = driverNameController.text;
      request.fields['driver_license_no'] = driverLicenseNoController.text;
      request.fields['mobile'] = mobileController.text;
      request.fields['aadhar_number'] = aadharNumberController.text;

      // Add optional fields if they have values
      if (helperNameController.text.isNotEmpty) {
        request.fields['helper_name'] = helperNameController.text;
      }
      if (helperMobileController.text.isNotEmpty) {
        request.fields['helper_mobile'] = helperMobileController.text;
      }
      if (remarkController.text.isNotEmpty) {
        request.fields['remark'] = remarkController.text;
      }
      if (selectedLicenseExpDate.value != null) {
        request.fields['license_exp_date'] = selectedLicenseExpDate.value!;
      }
      if (selectedGatePassExpDate.value != null) {
        request.fields['gate_pass_exp_date'] = selectedGatePassExpDate.value!;
      }
      if (selectedTraningCardExpDate.value != null) {
        request.fields['traning_card_exp_date'] = selectedTraningCardExpDate.value!;
      }
      if (selectedHazardousGoodsExpDate.value != null) {
        request.fields['hazardous_goods_exp_date'] = selectedHazardousGoodsExpDate.value!;
      }

      debugPrint('=== CREW MEMBER CREATE REQUEST ===');
      debugPrint('URL: $completeUrl');
      debugPrint('Fields: ${request.fields}');

      // Add files
      if (aadharDocFile.value != null) {
        request.files.add(await http.MultipartFile.fromPath(
          'aadhar_doc',
          aadharDocFile.value!.path,
        ));
      }
      if (traningCardDocFile.value != null) {
        request.files.add(await http.MultipartFile.fromPath(
          'traning_card_doc',
          traningCardDocFile.value!.path,
        ));
      }
      if (gatePassDocFile.value != null) {
        request.files.add(await http.MultipartFile.fromPath(
          'gate_pass_doc',
          gatePassDocFile.value!.path,
        ));
      }
      if (hazardousGoodsDocFile.value != null) {
        request.files.add(await http.MultipartFile.fromPath(
          'hazardous_goods_doc',
          hazardousGoodsDocFile.value!.path,
        ));
      }
      if (helperAadharDocFile.value != null) {
        request.files.add(await http.MultipartFile.fromPath(
          'helper_aadhar_doc',
          helperAadharDocFile.value!.path,
        ));
      }

      debugPrint('Total files: ${request.files.length}');

      // Send the request
      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);

      debugPrint('Response status: ${response.statusCode}');
      debugPrint('Response body: ${response.body}');

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        var status = data['status'];
        var message = data['message'] ?? data['error'] ?? 'Unknown response';

        if (status == true || status == "success") {
          Appdialogs.showToast(message.toString());
          clearCrewForm();
          Get.back();
          return true;
        } else {
          Appdialogs.showToast(message.toString());
          return false;
        }
      } else {
        Appdialogs.showToast("Server error: ${response.statusCode}");
        return false;
      }
    } catch (e, stackTrace) {
      debugPrint('Error in addCrewMember: $e');
      debugPrint('Stack trace: $stackTrace');
      Appdialogs.showToast("Error adding crew member: ${e.toString()}");
      return false;
    } finally {
      isCrewLoading.value = false;
    }
  }
  // Method to refresh all tanker data
  void refreshAllData() {
    getTankerList();
    getTankerCount();
  }

  // Search tankers with debounce
  void searchTankers(String query) {
    getTankerList(search: query);
  }

  // Get tankers by type
  void getTankersByType(String type) {
    getTankerList(type: type);
  }

  // Clear tanker form
  void clearTankerForm() {
    registrationNumberController.clear();
    capacityController.clear();
    fitnessCertNoController.clear();
    pollutionControlCertNoController.clear();
    insurancePolicyNumberController.clear();
    permitNumberController.clear();
    calibrationNumberController.clear();
    existingRcDocUrl.value = '';
    existingOtherCertUrl.value = '';
    // Clear date controllers
    fitnessCertExpDateController.clear();
    pollutionControlCertExpDateController.clear();
    insuranceExpDateController.clear();
    calibrationDateController.clear();
    calibrationExpDateController.clear(); // ADDED: Clear calibration expiry date
    explosiveExpDateController.clear();

    // Clear selected values
    selectedFitnessCertExpDate.value = null;
    selectedPollutionControlCertExpDate.value = null;
    selectedInsuranceExpDate.value = null;
    selectedCalibrationDate.value = null;
    selectedCalibrationExpDate.value = null; // ADDED: Clear calibration expiry date observable
    selectedExplosiveExpDate.value = null;

    // Clear file references
    rcDocFile.value = null;
    otherCertFile.value = null;
    rcDocImage.value = null;
    otherCertImage.value = null;

    // Clear edit mode flags
    isEditMode.value = false;
    editingTankerId.value = '';
  }

  // Clear crew form
  void clearCrewForm() {
    driverNameController.clear();
    driverLicenseNoController.clear();
    mobileController.clear();
    aadharNumberController.clear();
    helperNameController.clear();
    helperMobileController.clear();
    remarkController.clear();

    // Clear selected values
    selectedLicenseExpDate.value = null;
    selectedGatePassExpDate.value = null;
    selectedTraningCardExpDate.value = null;
    selectedHazardousGoodsExpDate.value = null;

    // Clear file references
    aadharDocFile.value = null;
    traningCardDocFile.value = null;
    gatePassDocFile.value = null;
    hazardousGoodsDocFile.value = null;
    helperAadharDocFile.value = null;
  }

  // Clear all data
  void clearData() {
    tankers.clear();
    tankerListModel.value = TankerListModel();
    tankerDetailModel.value = TankerDetailModel();
    tankerCountModel.value = TankerCountModel();
    clearTankerForm();
    clearCrewForm();
  }
}