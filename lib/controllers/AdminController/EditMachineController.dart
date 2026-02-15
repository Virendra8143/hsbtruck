//
// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
//
// import '../../Data/AppDialoge.dart';
// import '../../Utils/Api.dart';
// import '../../models/AdminModels/GetMachineListModel.dart';
// import 'AddMachineController.dart';
// import 'GetMachineListController.dart';
// import '../../../utils/api_endpoints.dart';
//
// /// Model for individual nozzle input
// class NozzleData {
//   final TextEditingController nozzleNumberController = TextEditingController();
//   final TextEditingController readingController = TextEditingController();
//   final selectedType = ''.obs;
//
//   void dispose() {
//     nozzleNumberController.dispose();
//     readingController.dispose();
//   }
// }
//
// class EditMachineController extends GetxController {
//   var isLoading = false.obs;
//   var machineId = ''.obs;
//
//   // Form controllers
//   final makeMachineTypeController = TextEditingController();
//   final modelSerialController = TextEditingController();
//   final masSerialNoController = TextEditingController();
//   final noOfNozzleController = TextEditingController();
//   final startDateController = TextEditingController();
//   final endDateController = TextEditingController();
//
//   // Nozzle input list
//   RxList<NozzleData> nozzles = <NozzleData>[].obs;
//
//   /// Update machine status (for delete/active/de-active)
//   /// Update machine status (for delete/active/de-active)
//   void updateMachineStatus({required String machineId, required String updateStatus}) async {
//     isLoading.value = true;
//
//     try {
//       // Build the endpoint with ID and status in the URL path
//       final endpoint = "/update-machine-status/$machineId/$updateStatus";
//
//       print('=== UPDATE MACHINE STATUS ===');
//       print('Machine ID: $machineId');
//       print('Status: $updateStatus');
//       print('Endpoint: $endpoint');
//
//       final response = await API.instance.get(
//         endPoint: endpoint,
//         isHeader: true,
//       );
//
//       print('Response status code: ${response.statusCode}');
//       print('Response body: ${response.body}');
//
//       if (response.statusCode == 200) {
//         final data = jsonDecode(response.body);
//         final status = data['status'];
//         final message = data['message'] ?? 'Status updated successfully';
//
//         if (status == "success" || status == true) {
//           Appdialogs.showToast(message);
//           // Refresh machine list
//           Get.find<AddMachineController>().getMachine();
//         } else {
//           Appdialogs.showToast(message ?? "Failed to update status");
//         }
//       } else {
//         Appdialogs.showToast("Server error: ${response.statusCode}");
//       }
//     } catch (e) {
//       debugPrint("UpdateMachineStatus Error: $e");
//       Appdialogs.showToast("Something went wrong: ${e.toString()}");
//     } finally {
//       isLoading.value = false;
//     }
//   }
//
//   /// Toggle machine status between active and deactive
//   /// Toggle machine status between active and deactive
//   void toggleMachineStatus({required String machineId, required String currentStatus}) async {
//     isLoading.value = true;
//
//     try {
//       // Determine new status (toggle between active and deactive)
//       String newStatus = currentStatus == "1" ? "0" : "1";
//
//       // Build the endpoint with ID and status in the URL path
//       final endpoint = "/update-machine-status/$machineId/$newStatus";
//
//       print('=== TOGGLE MACHINE STATUS ===');
//       print('Machine ID: $machineId');
//       print('Current Status: $currentStatus');
//       print('New Status: $newStatus');
//       print('Endpoint: $endpoint');
//
//       final response = await API.instance.get(
//         endPoint: endpoint,
//         isHeader: true,
//       );
//
//       print('Response status code: ${response.statusCode}');
//       print('Response body: ${response.body}');
//
//       if (response.statusCode == 200) {
//         final data = jsonDecode(response.body);
//         final status = data['status'];
//         final message = data['message'] ?? 'Status updated successfully';
//
//         if (status == "success" || status == true) {
//           Appdialogs.showToast("Machine ${newStatus == "1" ? "activated" : "deactivated"} successfully");
//           // Refresh machine list
//           Get.find<AddMachineController>().getMachine();
//         } else {
//           Appdialogs.showToast(message ?? "Failed to update status");
//         }
//       } else {
//         Appdialogs.showToast("Server error: ${response.statusCode}");
//       }
//     } catch (e) {
//       debugPrint("ToggleMachineStatus Error: $e");
//       Appdialogs.showToast("Something went wrong: ${e.toString()}");
//     } finally {
//       isLoading.value = false;
//     }
//   }
//
//   /// Set edit data
//   void setEditData(String id, Map<String, dynamic> machineData) {
//     machineId.value = id;
//
//     print('=== SETTING EDIT DATA ===');
//     print('Machine ID: $id');
//     print('Machine Data: $machineData');
//
//     // Populate form fields
//     makeMachineTypeController.text = machineData['make_machine_type']?.toString() ?? '';
//     modelSerialController.text = machineData['modal_serial']?.toString() ?? '';
//     masSerialNoController.text = machineData['mas_serial_no']?.toString() ?? '';
//     noOfNozzleController.text = machineData['no_of_nozzle']?.toString() ?? '0';
//     startDateController.text = machineData['stumping_start_date']?.toString() ?? '';
//     endDateController.text = machineData['stumping_end_date']?.toString() ?? '';
//
//     // Update nozzles based on count
//     final nozzleCount = int.tryParse(noOfNozzleController.text) ?? 0;
//     print('Creating $nozzleCount nozzles');
//     updateNozzles(nozzleCount);
//
//     // Populate nozzle data
//     _populateNozzleData(machineData);
//   }
//
//   /// Populate nozzle data from existing machine
//   void _populateNozzleData(Map<String, dynamic> machineData) {
//     final nozzleCount = int.tryParse(noOfNozzleController.text) ?? 0;
//     print('Populating $nozzleCount nozzles');
//
//     for (int i = 0; i < nozzleCount && i < nozzles.length; i++) {
//       final index = i + 1;
//       final nozzle = nozzles[i];
//
//       final nozzleNumber = machineData['nozzle_number_$index']?.toString();
//       final nozzleType = machineData['nozzle_type_$index']?.toString();
//       final nozzleReading = machineData['nozzle_reading_$index']?.toString();
//
//       print('Nozzle $index - Number: $nozzleNumber, Type: $nozzleType, Reading: $nozzleReading');
//
//       // Set values
//       nozzle.nozzleNumberController.text = nozzleNumber ?? 'N${index}';
//       nozzle.selectedType.value = nozzleType ?? 'Petrol';
//       nozzle.readingController.text = nozzleReading ?? '0.0';
//     }
//
//     update();
//     print('=== EDIT DATA SET COMPLETE ===');
//   }
//
//   /// Clear and rebuild nozzles based on selected count
//   void updateNozzles(int count) {
//     print('Updating nozzles to count: $count');
//
//     // Dispose existing controllers
//     for (var nozzle in nozzles) {
//       nozzle.dispose();
//     }
//
//     nozzles.clear();
//     if (count > 0) {
//       for (int i = 0; i < count; i++) {
//         nozzles.add(NozzleData());
//       }
//     }
//     update();
//     print('Nozzles updated: ${nozzles.length}');
//   }
//
//   /// Prepare request body for update
//   Map<String, dynamic> _prepareRequestBody() {
//     final nozzleCount = int.tryParse(noOfNozzleController.text.trim()) ?? 0;
//
//     final body = {
//       "make_machine_type": makeMachineTypeController.text.trim(),
//       "modal_serial": modelSerialController.text.trim(),
//       "mas_serial_no": masSerialNoController.text.trim(),
//       "no_of_nozzle": noOfNozzleController.text.trim(),
//       "stumping_start_date": startDateController.text.trim(),
//       "stumping_end_date": endDateController.text.trim(),
//     };
//
//     // Add nozzle data for all nozzles based on the count
//     for (int i = 0; i < nozzleCount; i++) {
//       final index = i + 1;
//
//       String nozzleNumber = '';
//       String nozzleType = '';
//       String nozzleReading = '';
//
//       if (i < nozzles.length) {
//         final nozzle = nozzles[i];
//         nozzleNumber = nozzle.nozzleNumberController.text.trim();
//         nozzleType = nozzle.selectedType.value;
//         nozzleReading = nozzle.readingController.text.trim();
//       }
//
//       body.addAll({
//         "nozzle_number_$index": nozzleNumber,
//         "nozzle_type_$index": nozzleType,
//         "nozzle_reading_$index": nozzleReading,
//       });
//     }
//
//     print('Update request body: $body');
//     return body;
//   }
//
//   /// Update machine API call
//   void updateMachine() async {
//     isLoading.value = true;
//     update();
//
//     try {
//       final body = _prepareRequestBody();
//       body['id'] = machineId.value;
//
//       print('=== UPDATE MACHINE API CALL ===');
//       print('Machine ID: ${machineId.value}');
//       print('Request body: $body');
//
//       final response = await API.instance.post(
//         endPoint: APIEndPoints.updateMachine,
//         params: body,
//         isHeader: true,
//       );
//
//       final data = jsonDecode(response.body);
//       final status = data['status'];
//       final message = data['message'];
//
//       if (status == "success") {
//         Appdialogs.showToast(message);
//         // Refresh machine list
//         Get.find<AddMachineController>().getMachine();
//         Get.back(); // Close the edit screen
//       } else {
//         Appdialogs.showToast(message);
//       }
//     } catch (e) {
//       debugPrint("UpdateMachine Error: $e");
//       Appdialogs.showToast("Something went wrong.");
//     } finally {
//       isLoading.value = false;
//       update();
//     }
//   }
//
//   /// Clear form and reset state
//   void clearForm() {
//     makeMachineTypeController.clear();
//     modelSerialController.clear();
//     masSerialNoController.clear();
//     noOfNozzleController.clear();
//     startDateController.clear();
//     endDateController.clear();
//
//     for (var nozzle in nozzles) {
//       nozzle.nozzleNumberController.clear();
//       nozzle.readingController.clear();
//       nozzle.selectedType.value = '';
//     }
//
//     nozzles.clear();
//     machineId.value = '';
//     update();
//   }
//
//   @override
//   void onClose() {
//     // Dispose controllers
//     makeMachineTypeController.dispose();
//     modelSerialController.dispose();
//     masSerialNoController.dispose();
//     noOfNozzleController.dispose();
//     startDateController.dispose();
//     endDateController.dispose();
//
//     for (var nozzle in nozzles) {
//       nozzle.dispose();
//     }
//
//     super.onClose();
//   }
// }
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Data/AppDialoge.dart';
import '../../Utils/Api.dart';
import 'AddMachineController.dart';
import '../../../utils/api_endpoints.dart';

/// Model for individual nozzle input
class NozzleData {
  final TextEditingController nozzleNumberController = TextEditingController();
  final TextEditingController readingController = TextEditingController();
  final selectedType = ''.obs;

  void dispose() {
    nozzleNumberController.dispose();
    readingController.dispose();
  }
}

class EditMachineController extends GetxController {
  var isLoading = false.obs;
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

  /// Toggle machine status between active and deactive
  Future<void> toggleMachineStatus({required String machineId, required String currentStatus}) async {
    isLoading.value = true;

    try {
      // Determine new status (toggle between active and deactive)
      String newStatus = currentStatus == "1" ? "0" : "1";

      // Build the endpoint with ID and status in the URL path
      final endpoint = "/update-machine-status/$machineId/$newStatus";

      print('=== TOGGLE MACHINE STATUS ===');
      print('Machine ID: $machineId');
      print('Current Status: $currentStatus');
      print('New Status: $newStatus');
      print('Endpoint: $endpoint');

      final response = await API.instance.get(
        endPoint: endpoint,
        isHeader: true,
      );

      print('Response status code: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final status = data['status'];
        final message = data['message'] ?? 'Status updated successfully';

        if (status == "success" || status == true) {
          Appdialogs.showToast("Machine ${newStatus == "1" ? "activated" : "deactivated"} successfully");
          // Refresh machine list
         Get.find<AddMachineController>().getMachine();
        } else {
          Appdialogs.showToast(message ?? "Failed to update status");
        }
      } else {
        Appdialogs.showToast("Server error: ${response.statusCode}");
      }
    } catch (e) {
      debugPrint("ToggleMachineStatus Error: $e");
      Appdialogs.showToast("Something went wrong: ${e.toString()}");
    } finally {
      isLoading.value = false;
    }
  }

  /// Update machine status (for delete)
  Future<void> updateMachineStatus({required String machineId, required String updateStatus}) async {
    isLoading.value = true;

    try {
      // Build the endpoint with ID and status in the URL path
      final endpoint = "/update-machine-status/$machineId/$updateStatus";

      print('=== UPDATE MACHINE STATUS ===');
      print('Machine ID: $machineId');
      print('Status: $updateStatus');
      print('Endpoint: $endpoint');

      final response = await API.instance.get(
        endPoint: endpoint,
        isHeader: true,
      );

      print('Response status code: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final status = data['status'];
        final message = data['message'] ?? 'Status updated successfully';

        if (status == "success" || status == true) {
          Appdialogs.showToast("Machine deleted successfully");
          // Refresh machine list
           Get.find<AddMachineController>().getMachine();
        } else {
          Appdialogs.showToast(message ?? "Failed to delete machine");
        }
      } else {
        Appdialogs.showToast("Server error: ${response.statusCode}");
      }
    } catch (e) {
      debugPrint("UpdateMachineStatus Error: $e");
      Appdialogs.showToast("Something went wrong: ${e.toString()}");
    } finally {
      isLoading.value = false;
    }
  }

  /// Set edit data
  void setEditData(String id, Map<String, dynamic> machineData) {
    machineId.value = id;

    print('=== SETTING EDIT DATA ===');
    print('Machine ID: $id');
    print('Machine Data: $machineData');

    // Populate form fields
    makeMachineTypeController.text = machineData['make_machine_type']?.toString() ?? '';
    modelSerialController.text = machineData['modal_serial']?.toString() ?? '';
    masSerialNoController.text = machineData['mas_serial_no']?.toString() ?? '';
    noOfNozzleController.text = machineData['no_of_nozzle']?.toString() ?? '0';
    startDateController.text = machineData['stumping_start_date']?.toString() ?? '';
    endDateController.text = machineData['stumping_end_date']?.toString() ?? '';

    // Update nozzles based on count
    final nozzleCount = int.tryParse(noOfNozzleController.text) ?? 0;
    print('Creating $nozzleCount nozzles');
    updateNozzles(nozzleCount);

    // Populate nozzle data
    _populateNozzleData(machineData);
  }

  /// Populate nozzle data from existing machine
  void _populateNozzleData(Map<String, dynamic> machineData) {
    final nozzleCount = int.tryParse(noOfNozzleController.text) ?? 0;
    print('Populating $nozzleCount nozzles');

    for (int i = 0; i < nozzleCount && i < nozzles.length; i++) {
      final index = i + 1;
      final nozzle = nozzles[i];

      final nozzleNumber = machineData['nozzle_number_$index']?.toString();
      final nozzleType = machineData['nozzle_type_$index']?.toString();
      final nozzleReading = machineData['nozzle_reading_$index']?.toString();

      print('Nozzle $index - Number: $nozzleNumber, Type: $nozzleType, Reading: $nozzleReading');

      // Set values
      nozzle.nozzleNumberController.text = nozzleNumber ?? 'N${index}';
      nozzle.selectedType.value = nozzleType ?? 'Petrol';
      nozzle.readingController.text = nozzleReading ?? '0.0';
    }

    update();
    print('=== EDIT DATA SET COMPLETE ===');
  }

  /// Clear and rebuild nozzles based on selected count
  void updateNozzles(int count) {
    print('Updating nozzles to count: $count');

    // Dispose existing controllers
    for (var nozzle in nozzles) {
      nozzle.dispose();
    }

    nozzles.clear();
    if (count > 0) {
      for (int i = 0; i < count; i++) {
        nozzles.add(NozzleData());
      }
    }
    update();
    print('Nozzles updated: ${nozzles.length}');
  }

  /// Prepare request body for update
  Map<String, dynamic> _prepareRequestBody() {
    final nozzleCount = int.tryParse(noOfNozzleController.text.trim()) ?? 0;

    final body = {
      "make_machine_type": makeMachineTypeController.text.trim(),
      "modal_serial": modelSerialController.text.trim(),
      "mas_serial_no": masSerialNoController.text.trim(),
      "no_of_nozzle": noOfNozzleController.text.trim(),
      "stumping_start_date": startDateController.text.trim(),
      "stumping_end_date": endDateController.text.trim(),
    };

    // Add nozzle data for all nozzles based on the count
    for (int i = 0; i < nozzleCount; i++) {
      final index = i + 1;

      String nozzleNumber = '';
      String nozzleType = '';
      String nozzleReading = '';

      if (i < nozzles.length) {
        final nozzle = nozzles[i];
        nozzleNumber = nozzle.nozzleNumberController.text.trim();
        nozzleType = nozzle.selectedType.value;
        nozzleReading = nozzle.readingController.text.trim();
      }

      body.addAll({
        "nozzle_number_$index": nozzleNumber,
        "nozzle_type_$index": nozzleType,
        "nozzle_reading_$index": nozzleReading,
      });
    }

    print('Update request body: $body');
    return body;
  }

  /// Update machine API call
  void updateMachine() async {
    isLoading.value = true;
    update();

    try {
      final body = _prepareRequestBody();
      body['id'] = machineId.value;

      print('=== UPDATE MACHINE API CALL ===');
      print('Machine ID: ${machineId.value}');
      print('Request body: $body');

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
        // Refresh machine list
        Get.find<AddMachineController>().getMachine();
        Get.back(); // Close the edit screen
      } else {
        Appdialogs.showToast(message);
      }
    } catch (e) {
      debugPrint("UpdateMachine Error: $e");
      Appdialogs.showToast("Something went wrong.");
    } finally {
      isLoading.value = false;
      update();
    }
  }

  /// Clear form and reset state
  void clearForm() {
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
    machineId.value = '';
    update();
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
      nozzle.dispose();
    }

    super.onClose();
  }
}