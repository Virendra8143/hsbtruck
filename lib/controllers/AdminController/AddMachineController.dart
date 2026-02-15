
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Data/AppDialoge.dart';
import '../../Utils/Api.dart';
import '../../models/AdminModels/GetMachineListModel.dart';



class NozzleData {
  final TextEditingController nozzleNumberController = TextEditingController();
  final TextEditingController readingController = TextEditingController();
  RxString selectedType = ''.obs;
}

class AddMachineController extends GetxController {
  var isLoading = false.obs;
  var isEditMode = false.obs;
  var machineId = ''.obs;

  // Form controllers
  final makeMachineTypeController = TextEditingController();
  final modelSerialController = TextEditingController();
  final masSerialNoController = TextEditingController();
  final noOfNozzleController = TextEditingController();
  final startDateController = TextEditingController();
  final endDateController = TextEditingController();

  // Nozzle input list
  RxList<NozzleData> nozzles = <NozzleData>[].obs;

  // Machine list model
  var getMachineModel = GetMachineListModel().obs;

  /// Set edit mode with existing data
  // void setEditMode(String id, Map<String, dynamic> machineData) {
  //   isEditMode.value = true;
  //   machineId.value = id;
  //
  //   // Populate form fields
  //   makeMachineTypeController.text = machineData['make_machine_type'] ?? '';
  //   modelSerialController.text = machineData['modal_serial'] ?? '';
  //   masSerialNoController.text = machineData['mas_serial_no'] ?? '';
  //   noOfNozzleController.text = machineData['no_of_nozzle']?.toString() ?? '';
  //   startDateController.text = machineData['stumping_start_date'] ?? '';
  //   endDateController.text = machineData['stumping_end_date'] ?? '';
  //
  //   // Update nozzles based on count
  //   final nozzleCount = int.tryParse(noOfNozzleController.text) ?? 0;
  //   updateNozzles(nozzleCount);
  //
  //   // Populate nozzle data after a delay to ensure UI is built
  //   Future.delayed(Duration(milliseconds: 100), () {
  //     _populateNozzleData(machineData);
  //   });
  // }
  /// Set edit mode with existing data - SIMPLIFIED
  void setEditMode(String id, Map<String, dynamic> machineData) {
    machineId.value = id;

    print('=== SETTING EDIT DATA ===');
    print('Machine ID: $id');

    // Simply populate the form fields
    makeMachineTypeController.text = machineData['make_machine_type']?.toString() ?? '';
    modelSerialController.text = machineData['modal_serial']?.toString() ?? '';
    masSerialNoController.text = machineData['mas_serial_no']?.toString() ?? '';
    noOfNozzleController.text = machineData['no_of_nozzle']?.toString() ?? '0';
    startDateController.text = machineData['stumping_start_date']?.toString() ?? '';
    endDateController.text = machineData['stumping_end_date']?.toString() ?? '';

    // Update nozzles based on count
    final nozzleCount = int.tryParse(noOfNozzleController.text) ?? 0;
    updateNozzles(nozzleCount);

    // Populate nozzle data
    _populateNozzleData(machineData);
  }

  /// Populate nozzle data from existing machine
  void _populateNozzleData(Map<String, dynamic> machineData) {
    final nozzleCount = int.tryParse(noOfNozzleController.text) ?? 0;

    for (int i = 0; i < nozzleCount; i++) {
      final index = i + 1;
      if (index < nozzles.length) {
        final nozzle = nozzles[i];
        nozzle.nozzleNumberController.text = machineData['nozzle_number_$index'] ?? '';
        nozzle.selectedType.value = machineData['nozzle_type_$index'] ?? '';
        nozzle.readingController.text = machineData['nozzle_reading_$index']?.toString() ?? '';
      }
    }
  }

  /// Clear and reset to add mode
  void resetToAddMode() {
    isEditMode.value = false;
    machineId.value = '';
    _clearFormFields();
  }

  /// Clear and rebuild nozzles based on selected count
  void updateNozzles(int count) {
    // Dispose existing controllers
    for (var nozzle in nozzles) {
      nozzle.nozzleNumberController.dispose();
      nozzle.readingController.dispose();
    }

    nozzles.clear();
    if (count > 0) {
      for (int i = 0; i < count; i++) {
        nozzles.add(NozzleData());
      }
    }
  }

  /// Fetch machine list
  void getMachine() async {
    isLoading.value = true;
    try {
      final response = await API.instance.get(
        endPoint: APIEndPoints.getMachineList,
        isHeader: true,
      );

      final data = jsonDecode(response.body);
      final status = data['status'];
      final message = data['message'];

      if (status == "success") {
        getMachineModel.value = GetMachineListModel.fromJson(data);
      } else {
        Appdialogs.showToast(message);
      }
    } catch (e) {
      debugPrint("GetMachine Error: $e");
      Appdialogs.showToast("Something went wrong.");
    } finally {
      isLoading.value = false;
    }
  }

  /// Prepare request body for add/update
  Map<String, dynamic> _prepareRequestBody() {
    final body = {
      "make_machine_type": makeMachineTypeController.text.trim(),
      "modal_serial": modelSerialController.text.trim(),
      "mas_serial_no": masSerialNoController.text.trim(),
      "no_of_nozzle": noOfNozzleController.text.trim(),
      "stumping_start_date": startDateController.text.trim(),
      "stumping_end_date": endDateController.text.trim(),
    };

    // Add nozzle data
    for (int i = 0; i < nozzles.length; i++) {
      final nozzle = nozzles[i];
      final index = i + 1;

      body.addAll({
        "nozzle_number_$index": nozzle.nozzleNumberController.text.trim(),
        "nozzle_type_$index": nozzle.selectedType.value,
        "nozzle_reading_$index": nozzle.readingController.text.trim(),
      });
    }

    return body;
  }

  /// Add machine API call
  void addMachine() async {
    isLoading.value = true;

    try {
      final body = _prepareRequestBody();

      final response = await API.instance.post(
        endPoint: APIEndPoints.addMachine,
        params: body,
        isHeader: true,
      );

      final data = jsonDecode(response.body);
      final status = data['status'];
      final message = data['message'];

      if (status == "success") {
        Appdialogs.showToast(message);
        getMachine();
        _clearFormFields();
        Get.back(); // Close modal/dialog if any
      } else {
        Appdialogs.showToast(message);
      }
    } catch (e) {
      debugPrint("AddMachine Error: $e");
      Appdialogs.showToast("Something went wrong.");
    } finally {
      isLoading.value = false;
    }
  }

  /// Update machine API call
  void updateMachine() async {
    isLoading.value = true;

    try {
      final body = _prepareRequestBody();
      body['id'] = machineId.value;

      final response = await API.instance.post(
        endPoint: APIEndPoints.updateMachine,
        params: body,
        isHeader: true,
      );

      final data = jsonDecode(response.body);
      final status = data['status'];
      final message = data['message'];

      if (status == "success") {
        Appdialogs.showToast(message);
        getMachine();
        _clearFormFields();
        Get.back(); // Close modal/dialog if any
      } else {
        Appdialogs.showToast(message);
      }
    } catch (e) {
      debugPrint("UpdateMachine Error: $e");
      Appdialogs.showToast("Something went wrong.");
    } finally {
      isLoading.value = false;
    }
  }

  /// Submit form (handles both add and update)
  void submitForm() {
    if (isEditMode.value) {
      updateMachine();
    } else {
      addMachine();
    }
  }

  /// Clear form and reset state
  void _clearFormFields() {
    makeMachineTypeController.clear();
    modelSerialController.clear();
    masSerialNoController.clear();
    noOfNozzleController.clear();
    startDateController.clear();
    endDateController.clear();

    for (var nozzle in nozzles) {
      nozzle.nozzleNumberController.clear();
      nozzle.readingController.clear();
      nozzle.selectedType.value = '';
    }

    nozzles.clear();
    isEditMode.value = false;
    machineId.value = '';
  }

  @override
  void onClose() {
    // Dispose controllers
    makeMachineTypeController.dispose();
    modelSerialController.dispose();
    masSerialNoController.dispose();
    noOfNozzleController.dispose();
    startDateController.dispose();
    endDateController.dispose();

    for (var nozzle in nozzles) {
      nozzle.nozzleNumberController.dispose();
      nozzle.readingController.dispose();
    }

    super.onClose();
  }
}