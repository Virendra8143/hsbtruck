//
// import 'dart:io';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:get/get.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:intl/intl.dart';
//
// import '../../../controllers/AdminController/TankerController.dart';
// import '../../../utils/colors.dart';
//
// // Input formatters to remove special characters and spaces
// class AlphanumericInputFormatter extends TextInputFormatter {
//   @override
//   TextEditingValue formatEditUpdate(
//       TextEditingValue oldValue,
//       TextEditingValue newValue,
//       ) {
//     // Remove spaces and special characters, keep only alphanumeric
//     String filteredText = newValue.text.replaceAll(RegExp(r'[^a-zA-Z0-9]'), '');
//
//     return TextEditingValue(
//       text: filteredText.toUpperCase(),
//       selection: TextSelection.collapsed(offset: filteredText.length),
//     );
//   }
// }
//
// class NumericInputFormatter extends TextInputFormatter {
//   @override
//   TextEditingValue formatEditUpdate(
//       TextEditingValue oldValue,
//       TextEditingValue newValue,
//       ) {
//     // Remove everything except numbers
//     String filteredText = newValue.text.replaceAll(RegExp(r'[^0-9]'), '');
//
//     return TextEditingValue(
//       text: filteredText,
//       selection: TextSelection.collapsed(offset: filteredText.length),
//     );
//   }
// }
//
// class CreateTanker extends StatefulWidget {
//   final String? tankerId;
//
//   const CreateTanker({super.key, this.tankerId});
//
//   @override
//   State<CreateTanker> createState() => _CreateTankerState();
// }
//
// class _CreateTankerState extends State<CreateTanker> {
//   final _formKey = GlobalKey<FormState>();
//   final TankerController _tankerController = Get.find<TankerController>();
//   final ImagePicker _picker = ImagePicker();
//
//   // Add calibration number controller (separate from calibration date)
//   var calibrationNumberController = TextEditingController();
//
//   @override
//   void initState() {
//     super.initState();
//
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       if (widget.tankerId != null) {
//         // Load tanker details for editing
//         _tankerController.getTankerDetail(widget.tankerId!);
//       } else {
//         // Clear form when creating new tanker
//         _tankerController.clearTankerForm();
//       }
//     });
//   }
//
//   @override
//   void dispose() {
//     calibrationNumberController.dispose();
//     super.dispose();
//   }
//
//   // Validation methods
//   String? _validateRequired(String? value, String fieldName) {
//     if (value == null || value.trim().isEmpty) {
//       return '$fieldName is required';
//     }
//     return null;
//   }
//
//   String? _validateRegistrationNumber(String? value) {
//     if (value == null || value.trim().isEmpty) {
//       return 'Registration number is required';
//     }
//     if (value.length < 6) {
//       return 'Registration number must be at least 6 characters';
//     }
//     return null;
//   }
//
//   String? _validateCapacity(String? value) {
//     if (value == null || value.trim().isEmpty) {
//       return 'Capacity is required';
//     }
//     final capacity = int.tryParse(value);
//     if (capacity == null || capacity <= 0) {
//       return 'Enter a valid capacity';
//     }
//     return null;
//   }
//
//   String? _validateDate(String? value, String fieldName) {
//     if (value == null || value.trim().isEmpty) {
//       return '$fieldName is required';
//     }
//     try {
//       final date = DateFormat('yyyy-MM-dd').parse(value);
//       // Allow current date and future dates
//       if (date.isBefore(DateTime.now().subtract(Duration(days: 1)))) {
//         return '$fieldName cannot be in the past';
//       }
//     } catch (e) {
//       return 'Enter a valid date (YYYY-MM-DD)';
//     }
//     return null;
//   }
//
//   String? _validateDropdown(String? value, String fieldName) {
//     if (value == null || value.isEmpty) {
//       return '$fieldName is required';
//     }
//     return null;
//   }
//
//   String? _validateFileUpload(File? file, String fieldName) {
//     if (file == null) {
//       return '$fieldName is required';
//     }
//     return null;
//   }
//
//   // Enhanced validation for registration number with no special characters
//   String? _validateRegistrationNumberEnhanced(String? value) {
//     if (value == null || value.trim().isEmpty) {
//       return 'Registration number is required';
//     }
//
//     // Check for special characters or spaces
//     if (RegExp(r'[^a-zA-Z0-9]').hasMatch(value)) {
//       return 'Registration number cannot contain spaces or special characters';
//     }
//
//     if (value.length < 6) {
//       return 'Registration number must be at least 6 characters';
//     }
//
//     if (value.length > 15) {
//       return 'Registration number cannot exceed 15 characters';
//     }
//
//     return null;
//   }
//
//   // Enhanced validation for certificate numbers
//   String? _validateCertificateNumber(String? value, String fieldName) {
//     if (value == null || value.trim().isEmpty) {
//       return '$fieldName is required';
//     }
//
//     // Check for special characters or spaces
//     if (RegExp(r'[^a-zA-Z0-9]').hasMatch(value)) {
//       return '$fieldName cannot contain spaces or special characters';
//     }
//
//     if (value.length < 3) {
//       return '$fieldName must be at least 3 characters';
//     }
//
//     if (value.length > 20) {
//       return '$fieldName cannot exceed 20 characters';
//     }
//
//     return null;
//   }
//
//   // Date picker - Updated to use controller's observable values
//   Future<void> _selectDate(BuildContext context, String dateType) async {
//     final DateTime? picked = await showDatePicker(
//       context: context,
//       initialDate: DateTime.now(),
//       firstDate: DateTime.now(),
//       lastDate: DateTime(2040),
//       builder: (context, child) {
//         return Theme(
//           data: Theme.of(context).copyWith(
//             colorScheme: ColorScheme.light(
//               primary: AppColors.primary,
//               onPrimary: Colors.white,
//               surface: Colors.white,
//               onSurface: Colors.black,
//             ),
//           ),
//           child: child!,
//         );
//       },
//     );
//
//     if (picked != null) {
//       final formattedDate = DateFormat('yyyy-MM-dd').format(picked);
//       setState(() {
//         switch (dateType) {
//           case 'fitness_cert_exp_date':
//             _tankerController.fitnessCertExpDateController.text = formattedDate;
//             _tankerController.selectedFitnessCertExpDate.value = formattedDate;
//             break;
//           case 'pollution_control_cert_exp_date':
//             _tankerController.pollutionControlCertExpDateController.text = formattedDate;
//             _tankerController.selectedPollutionControlCertExpDate.value = formattedDate;
//             break;
//           case 'insurance_exp_date':
//             _tankerController.insuranceExpDateController.text = formattedDate;
//             _tankerController.selectedInsuranceExpDate.value = formattedDate;
//             break;
//           case 'calibration_date':
//             _tankerController.calibrationDateController.text = formattedDate;
//             _tankerController.selectedCalibrationDate.value = formattedDate;
//             break;
//           case 'calibration_exp_date':
//             _tankerController.calibrationExpDateController.text = formattedDate;
//             _tankerController.selectedCalibrationExpDate.value = formattedDate;
//             break;
//           case 'explosive_exp_date':
//             _tankerController.explosiveExpDateController.text = formattedDate;
//             _tankerController.selectedExplosiveExpDate.value = formattedDate;
//             break;
//         }
//       });
//     }
//   }
//
//   // File picker - Updated to use controller's methods
//   Future<void> _pickFile(bool isRcDoc) async {
//     try {
//       final XFile? pickedFile = await _picker.pickImage(
//         source: ImageSource.gallery,
//         imageQuality: 80,
//       );
//
//       if (pickedFile != null) {
//         final file = File(pickedFile.path);
//         if (isRcDoc) {
//           _tankerController.setRcDocImage(file);
//         } else {
//           _tankerController.setOtherCertImage(file);
//         }
//         setState(() {});
//       }
//     } catch (e) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Error picking file: ${e.toString()}')),
//       );
//     }
//   }
//
//   // Submit form - Updated to use controller's addTanker or updateTanker method
// // Update the _submitForm method in CreateTanker.dart
//   Future<void> _submitForm() async {
//     if (!_formKey.currentState!.validate()) {
//       return;
//     }
//
//     // Validate required fields
//     if (_tankerController.calibrationNumberController.text.isEmpty) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Please enter calibration number')),
//       );
//       return;
//     }
//
//     // Validate RC document upload only for new tankers
//     if (!_tankerController.isEditMode.value && _tankerController.rcDocImage.value == null) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Please upload RC Document')),
//       );
//       return;
//     }
//
//     // Use appropriate method based on edit mode
//     if (_tankerController.isEditMode.value) {
//       await _tankerController.updateTanker(_tankerController.editingTankerId.value);
//     } else {
//       await _tankerController.addTanker();
//     }
//   }
//
//   // Build calibration number field
//   // In CreateTanker.dart - Update the calibration number field
//   Widget _buildCalibrationNumberField() {
//     return TextFormField(
//       controller: _tankerController.calibrationNumberController,
//       inputFormatters: [
//         AlphanumericInputFormatter(),
//         LengthLimitingTextInputFormatter(20),
//       ],
//       decoration: InputDecoration(
//         labelText: "Calibration Number *", // ADDED: Asterisk to show it's required
//         hintText: "e.g. CAL123456",
//         helperText: "Only letters and numbers allowed - REQUIRED FIELD",
//         enabledBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(12),
//           borderSide: BorderSide(color: AppColors.primary, width: 1),
//         ),
//         focusedBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(12),
//           borderSide: BorderSide(color: AppColors.primary, width: 2),
//         ),
//         errorBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(12),
//           borderSide: BorderSide(color: Colors.red, width: 1),
//         ),
//         focusedErrorBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(12),
//           borderSide: BorderSide(color: Colors.red, width: 2),
//         ),
//       ),
//       validator: (value) {
//         if (value == null || value.trim().isEmpty) {
//           return 'Calibration number is required'; // ADDED: Validation
//         }
//         return null;
//       },
//     );
//   }
//   Widget _buildCalibrationExpiryDateField() {
//     return TextFormField(
//       controller: _tankerController.calibrationExpDateController,
//       readOnly: true,
//       decoration: InputDecoration(
//         labelText: "Calibration Expiry Date",
//         hintText: 'Select date',
//         suffixIcon: Icon(Icons.calendar_today, color: AppColors.primary),
//         enabledBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(12),
//           borderSide: BorderSide(color: AppColors.primary, width: 1),
//         ),
//         focusedBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(12),
//           borderSide: BorderSide(color: AppColors.primary, width: 2),
//         ),
//         errorBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(12),
//           borderSide: BorderSide(color: Colors.red, width: 1),
//         ),
//         focusedErrorBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(12),
//           borderSide: BorderSide(color: Colors.red, width: 2),
//         ),
//       ),
//       onTap: () => _selectDate(context, 'calibration_exp_date'),
//     );
//   }
//   // Build calibration date field
//   Widget _buildCalibrationDateField() {
//     return TextFormField(
//       controller: _tankerController.calibrationDateController,
//       readOnly: true,
//       decoration: InputDecoration(
//         labelText: "Calibration Date",
//         hintText: 'Select date',
//         suffixIcon: Icon(Icons.calendar_today, color: AppColors.primary),
//         enabledBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(12),
//           borderSide: BorderSide(color: AppColors.primary, width: 1),
//         ),
//         focusedBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(12),
//           borderSide: BorderSide(color: AppColors.primary, width: 2),
//         ),
//         errorBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(12),
//           borderSide: BorderSide(color: Colors.red, width: 1),
//         ),
//         focusedErrorBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(12),
//           borderSide: BorderSide(color: Colors.red, width: 2),
//         ),
//       ),
//       onTap: () => _selectDate(context, 'calibration_date'),
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final size = MediaQuery.of(context).size;
//
//     return Container(
//       height: size.height * 0.95,
//       width: size.width * 0.99,
//       child: Form(
//         key: _formKey,
//         child: Column(
//           children: [
//             SizedBox(height: 2),
//             Container(
//               height: 5,
//               width: 53,
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(5),
//                 color: AppColors.alert,
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.only(left: 15, right: 8, bottom: 8, top: 20),
//               child: Row(
//                 children: [
//                   Container(
//                     height: 62,
//                     width: 62,
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(12),
//                       color: AppColors.primary,
//                     ),
//                     child: SvgPicture.asset(
//                       'assets/images/Tanker3.svg',
//                       color: AppColors.background,
//                       fit: BoxFit.none,
//                     ),
//                   ),
//                   SizedBox(width: 10),
//                   Expanded(
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           widget.tankerId != null ? 'Edit Tanker' : 'Create Tanker',
//                           style: TextStyle(
//                             fontWeight: FontWeight.w500,
//                             fontSize: 24,
//                             color: AppColors.secondary,
//                           ),
//                         ),
//                         Text(
//                           widget.tankerId != null ? 'Update tanker details' : 'Add tanker for your product delivery',
//                           style: TextStyle(
//                             fontWeight: FontWeight.w400,
//                             fontSize: 14,
//                             color: AppColors.icon,
//                           ),
//                         )
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             Expanded(
//               child: SingleChildScrollView(
//                 padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
//                 child: Column(
//                   children: [
//                     SizedBox(height: 20),
//
//                     // Registration Number (Required)
//                     TextFormField(
//                       controller: _tankerController.registrationNumberController,
//                       inputFormatters: [
//                         AlphanumericInputFormatter(),
//                         LengthLimitingTextInputFormatter(15),
//                       ],
//                       decoration: InputDecoration(
//                         labelText: "Tanker Registration Number *",
//                         hintText: "e.g. MH12AB1234",
//                         helperText: "Only letters and numbers allowed (no spaces)",
//                         enabledBorder: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(12),
//                           borderSide: BorderSide(color: AppColors.primary, width: 1),
//                         ),
//                         focusedBorder: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(12),
//                           borderSide: BorderSide(color: AppColors.primary, width: 2),
//                         ),
//                         errorBorder: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(12),
//                           borderSide: BorderSide(color: Colors.red, width: 1),
//                         ),
//                         focusedErrorBorder: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(12),
//                           borderSide: BorderSide(color: Colors.red, width: 2),
//                         ),
//                       ),
//                       validator: _validateRegistrationNumberEnhanced,
//                     ),
//                     SizedBox(height: 20),
//
//                     // Capacity (Required)
//                     TextFormField(
//                       controller: _tankerController.capacityController,
//                       keyboardType: TextInputType.number,
//                       inputFormatters: [
//                         FilteringTextInputFormatter.digitsOnly,
//                         LengthLimitingTextInputFormatter(10),
//                       ],
//                       decoration: InputDecoration(
//                         labelText: "Capacity (Litres) *",
//                         hintText: "e.g. 50000",
//                         helperText: "Only numbers allowed",
//                         enabledBorder: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(12),
//                           borderSide: BorderSide(color: AppColors.primary, width: 1),
//                         ),
//                         focusedBorder: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(12),
//                           borderSide: BorderSide(color: AppColors.primary, width: 2),
//                         ),
//                         errorBorder: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(12),
//                           borderSide: BorderSide(color: Colors.red, width: 1),
//                         ),
//                         focusedErrorBorder: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(12),
//                           borderSide: BorderSide(color: Colors.red, width: 2),
//                         ),
//                       ),
//                       validator: _validateCapacity,
//                     ),
//                     SizedBox(height: 20),
//
//                     // Tanker Type Dropdown (Required)
//                     // In CreateTanker.dart - Update the tanker type dropdown
//
// // Tanker Type Dropdown (Required)
// //                     Obx(() => Container(
// //                       decoration: BoxDecoration(
// //                         borderRadius: BorderRadius.circular(12),
// //                         border: Border.all(color: AppColors.primary, width: 1),
// //                       ),
// //                       child: DropdownButtonFormField<String>(
// //                         value: _tankerController.selectedTankerType.value,
// //                         isExpanded: true,
// //                         decoration: InputDecoration(
// //                           contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 16),
// //                           border: InputBorder.none,
// //                           hintText: 'Select Tanker Type *',
// //                           hintStyle: TextStyle(
// //                             fontSize: 16,
// //                             fontWeight: FontWeight.w400,
// //                             color: AppColors.text.withOpacity(0.6),
// //                           ),
// //                         ),
// //                         icon: Padding(
// //                           padding: const EdgeInsets.only(right: 8),
// //                           child: SvgPicture.asset(
// //                             'assets/images/Arrow.svg',
// //                             width: 11,
// //                             height: 15,
// //                           ),
// //                         ),
// //                         style: TextStyle(fontSize: 16, color: Colors.black),
// //                         items: _tankerController.tankerTypesList
// //                             .map<DropdownMenuItem<String>>((type) {
// //                           return DropdownMenuItem<String>(
// //                             value: type['name']?.toString() ?? 'Unknown',
// //                             child: Text(type['name']?.toString() ?? 'Unknown'),
// //                           );
// //                         }).toList(),
// //                         onChanged: (String? newValue) {
// //                           _tankerController.updateTankerType(newValue);
// //                         },
// //                         validator: (value) => _validateDropdown(value, 'Tanker Type'),
// //                       ),
// //                     )),
// //                     SizedBox(height: 20),
//
//                     // Fitness Certificate Number (Optional)
//                     TextFormField(
//                       controller: _tankerController.fitnessCertNoController,
//                       inputFormatters: [
//                         AlphanumericInputFormatter(),
//                         LengthLimitingTextInputFormatter(20),
//                       ],
//                       decoration: InputDecoration(
//                         labelText: "Fitness Certificate Number",
//                         hintText: "e.g. FC123456",
//                         helperText: "Only letters and numbers allowed (no spaces)",
//                         enabledBorder: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(12),
//                           borderSide: BorderSide(color: AppColors.primary, width: 1),
//                         ),
//                         focusedBorder: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(12),
//                           borderSide: BorderSide(color: AppColors.primary, width: 2),
//                         ),
//                         errorBorder: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(12),
//                           borderSide: BorderSide(color: Colors.red, width: 1),
//                         ),
//                         focusedErrorBorder: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(12),
//                           borderSide: BorderSide(color: Colors.red, width: 2),
//                         ),
//                       ),
//                     ),
//                     SizedBox(height: 20),
//
//                     // Fitness Certificate Expiry Date (Optional)
//                     TextFormField(
//                       controller: _tankerController.fitnessCertExpDateController,
//                       readOnly: true,
//                       decoration: InputDecoration(
//                         labelText: "Fitness Certificate Expiry Date",
//                         hintText: 'Select date',
//                         suffixIcon: Icon(Icons.calendar_today, color: AppColors.primary),
//                         enabledBorder: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(12),
//                           borderSide: BorderSide(color: AppColors.primary, width: 1),
//                         ),
//                         focusedBorder: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(12),
//                           borderSide: BorderSide(color: AppColors.primary, width: 2),
//                         ),
//                         errorBorder: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(12),
//                           borderSide: BorderSide(color: Colors.red, width: 1),
//                         ),
//                         focusedErrorBorder: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(12),
//                           borderSide: BorderSide(color: Colors.red, width: 2),
//                         ),
//                       ),
//                       onTap: () => _selectDate(context, 'fitness_cert_exp_date'),
//                     ),
//                     SizedBox(height: 20),
//
//                     // Pollution Control Certificate Number (Optional)
//                     TextFormField(
//                       controller: _tankerController.pollutionControlCertNoController,
//                       inputFormatters: [
//                         AlphanumericInputFormatter(),
//                         LengthLimitingTextInputFormatter(20),
//                       ],
//                       decoration: InputDecoration(
//                         labelText: "Pollution Control Certificate Number",
//                         hintText: "e.g. PC987654",
//                         helperText: "Only letters and numbers allowed (no spaces)",
//                         enabledBorder: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(12),
//                           borderSide: BorderSide(color: AppColors.primary, width: 1),
//                         ),
//                         focusedBorder: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(12),
//                           borderSide: BorderSide(color: AppColors.primary, width: 2),
//                         ),
//                         errorBorder: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(12),
//                           borderSide: BorderSide(color: Colors.red, width: 1),
//                         ),
//                         focusedErrorBorder: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(12),
//                           borderSide: BorderSide(color: Colors.red, width: 2),
//                         ),
//                       ),
//                     ),
//                     SizedBox(height: 20),
//
//                     // Pollution Control Certificate Expiry Date (Optional)
//                     TextFormField(
//                       controller: _tankerController.pollutionControlCertExpDateController,
//                       readOnly: true,
//                       decoration: InputDecoration(
//                         labelText: "Pollution Control Certificate Expiry Date",
//                         hintText: 'Select date',
//                         suffixIcon: Icon(Icons.calendar_today, color: AppColors.primary),
//                         enabledBorder: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(12),
//                           borderSide: BorderSide(color: AppColors.primary, width: 1),
//                         ),
//                         focusedBorder: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(12),
//                           borderSide: BorderSide(color: AppColors.primary, width: 2),
//                         ),
//                         errorBorder: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(12),
//                           borderSide: BorderSide(color: Colors.red, width: 1),
//                         ),
//                         focusedErrorBorder: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(12),
//                           borderSide: BorderSide(color: Colors.red, width: 2),
//                         ),
//                       ),
//                       onTap: () => _selectDate(context, 'pollution_control_cert_exp_date'),
//                     ),
//                     SizedBox(height: 20),
//
//                     // Insurance Policy Number (Optional)
//                     TextFormField(
//                       controller: _tankerController.insurancePolicyNumberController,
//                       inputFormatters: [
//                         AlphanumericInputFormatter(),
//                         LengthLimitingTextInputFormatter(25),
//                       ],
//                       decoration: InputDecoration(
//                         labelText: "Insurance Policy Number",
//                         hintText: "e.g. INS123456789",
//                         helperText: "Only letters and numbers allowed (no spaces)",
//                         enabledBorder: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(12),
//                           borderSide: BorderSide(color: AppColors.primary, width: 1),
//                         ),
//                         focusedBorder: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(12),
//                           borderSide: BorderSide(color: AppColors.primary, width: 2),
//                         ),
//                         errorBorder: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(12),
//                           borderSide: BorderSide(color: Colors.red, width: 1),
//                         ),
//                         focusedErrorBorder: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(12),
//                           borderSide: BorderSide(color: Colors.red, width: 2),
//                         ),
//                       ),
//                     ),
//                     SizedBox(height: 20),
//
//                     // Insurance Expiry Date (Optional)
//                     TextFormField(
//                       controller: _tankerController.insuranceExpDateController,
//                       readOnly: true,
//                       decoration: InputDecoration(
//                         labelText: "Insurance Expiry Date",
//                         hintText: 'Select date',
//                         suffixIcon: Icon(Icons.calendar_today, color: AppColors.primary),
//                         enabledBorder: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(12),
//                           borderSide: BorderSide(color: AppColors.primary, width: 1),
//                         ),
//                         focusedBorder: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(12),
//                           borderSide: BorderSide(color: AppColors.primary, width: 2),
//                         ),
//                         errorBorder: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(12),
//                           borderSide: BorderSide(color: Colors.red, width: 1),
//                         ),
//                         focusedErrorBorder: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(12),
//                           borderSide: BorderSide(color: Colors.red, width: 2),
//                         ),
//                       ),
//                       onTap: () => _selectDate(context, 'insurance_exp_date'),
//                     ),
//                     SizedBox(height: 20),
//
//                     // Calibration Number (Optional)
//                     _buildCalibrationNumberField(),
//                     SizedBox(height: 20),
//
//                     _buildCalibrationExpiryDateField(),
//                     SizedBox(height: 20),
//
//                     // Permit Number (Optional)
//                     TextFormField(
//                       controller: _tankerController.permitNumberController,
//                       inputFormatters: [
//                         AlphanumericInputFormatter(),
//                         LengthLimitingTextInputFormatter(20),
//                       ],
//                       decoration: InputDecoration(
//                         labelText: "Permit Number",
//                         hintText: "e.g. 996314",
//                         helperText: "Only letters and numbers allowed",
//                         enabledBorder: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(12),
//                           borderSide: BorderSide(color: AppColors.primary, width: 1),
//                         ),
//                         focusedBorder: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(12),
//                           borderSide: BorderSide(color: AppColors.primary, width: 2),
//                         ),
//                         errorBorder: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(12),
//                           borderSide: BorderSide(color: Colors.red, width: 1),
//                         ),
//                         focusedErrorBorder: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(12),
//                           borderSide: BorderSide(color: Colors.red, width: 2),
//                         ),
//                       ),
//                     ),
//                     SizedBox(height: 20),
//
//                     // Explosive Expiry Date (Optional)
//                     TextFormField(
//                       controller: _tankerController.explosiveExpDateController,
//                       readOnly: true,
//                       decoration: InputDecoration(
//                         labelText: "Explosive Expiry Date",
//                         hintText: 'Select date',
//                         suffixIcon: Icon(Icons.calendar_today, color: AppColors.primary),
//                         enabledBorder: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(12),
//                           borderSide: BorderSide(color: AppColors.primary, width: 1),
//                         ),
//                         focusedBorder: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(12),
//                           borderSide: BorderSide(color: AppColors.primary, width: 2),
//                         ),
//                         errorBorder: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(12),
//                           borderSide: BorderSide(color: Colors.red, width: 1),
//                         ),
//                         focusedErrorBorder: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(12),
//                           borderSide: BorderSide(color: Colors.red, width: 2),
//                         ),
//                       ),
//                       onTap: () => _selectDate(context, 'explosive_exp_date'),
//                     ),
//                     SizedBox(height: 20),
//
//                     // RC Document Upload (Mandatory)
//                     Obx(() => Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           "RC Document *",
//                           style: TextStyle(
//                             fontSize: 16,
//                             fontWeight: FontWeight.w500,
//                             color: AppColors.text,
//                           ),
//                         ),
//                         SizedBox(height: 8),
//                         Container(
//                           width: double.infinity,
//                           height: 60,
//                           decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(12),
//                             border: Border.all(
//                                 color: _tankerController.rcDocImage.value != null
//                                     ? Colors.green
//                                     : AppColors.primary,
//                                 width: 2
//                             ),
//                           ),
//                           child: InkWell(
//                             onTap: () => _pickFile(true),
//                             borderRadius: BorderRadius.circular(12),
//                             child: Row(
//                               children: [
//                                 SizedBox(width: 15),
//                                 Icon(
//                                   Icons.upload_file,
//                                   color: _tankerController.rcDocImage.value != null
//                                       ? Colors.green
//                                       : AppColors.primary,
//                                   size: 24,
//                                 ),
//                                 SizedBox(width: 15),
//                                 Expanded(
//                                   child: Text(
//                                     _tankerController.rcDocImage.value != null
//                                         ? 'RC Document Selected: ${_tankerController.rcDocImage.value!.path.split('/').last}'
//                                         : 'Upload RC Document *',
//                                     style: TextStyle(
//                                       fontSize: 16,
//                                       color: _tankerController.rcDocImage.value != null
//                                           ? Colors.green
//                                           : AppColors.text,
//                                     ),
//                                     overflow: TextOverflow.ellipsis,
//                                   ),
//                                 ),
//                                 if (_tankerController.rcDocImage.value != null)
//                                   Padding(
//                                     padding: const EdgeInsets.only(right: 15),
//                                     child: Icon(Icons.check_circle, color: Colors.green, size: 24),
//                                   ),
//                                 SizedBox(width: 10),
//                               ],
//                             ),
//                           ),
//                         ),
//                         SizedBox(height: 5),
//                         Text(
//                           "Mandatory document for tanker registration",
//                           style: TextStyle(
//                             fontSize: 12,
//                             color: AppColors.text.withOpacity(0.6),
//                           ),
//                         ),
//                       ],
//                     )),
//                     SizedBox(height: 20),
//
//                     // Other Certificate Upload (Optional)
//                     Obx(() => Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           "Other Certificate (Optional)",
//                           style: TextStyle(
//                             fontSize: 16,
//                             fontWeight: FontWeight.w500,
//                             color: AppColors.text,
//                           ),
//                         ),
//                         SizedBox(height: 8),
//                         Container(
//                           width: double.infinity,
//                           height: 60,
//                           decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(12),
//                             border: Border.all(
//                                 color: _tankerController.otherCertImage.value != null
//                                     ? Colors.green
//                                     : AppColors.primary,
//                                 width: 1
//                             ),
//                           ),
//                           child: InkWell(
//                             onTap: () => _pickFile(false),
//                             borderRadius: BorderRadius.circular(12),
//                             child: Row(
//                               children: [
//                                 SizedBox(width: 15),
//                                 Icon(
//                                   Icons.upload_file,
//                                   color: _tankerController.otherCertImage.value != null
//                                       ? Colors.green
//                                       : AppColors.primary,
//                                   size: 24,
//                                 ),
//                                 SizedBox(width: 15),
//                                 Expanded(
//                                   child: Text(
//                                     _tankerController.otherCertImage.value != null
//                                         ? 'Other Certificate Selected: ${_tankerController.otherCertImage.value!.path.split('/').last}'
//                                         : 'Upload Other Certificate (Optional)',
//                                     style: TextStyle(
//                                       fontSize: 16,
//                                       color: _tankerController.otherCertImage.value != null
//                                           ? Colors.green
//                                           : AppColors.text,
//                                     ),
//                                     overflow: TextOverflow.ellipsis,
//                                   ),
//                                 ),
//                                 if (_tankerController.otherCertImage.value != null)
//                                   Padding(
//                                     padding: const EdgeInsets.only(right: 15),
//                                     child: Icon(Icons.check_circle, color: Colors.green, size: 24),
//                                   ),
//                                 SizedBox(width: 10),
//                               ],
//                             ),
//                           ),
//                         ),
//                         SizedBox(height: 5),
//                         Text(
//                           "Additional certificates (if any)",
//                           style: TextStyle(
//                             fontSize: 12,
//                             color: AppColors.text.withOpacity(0.6),
//                           ),
//                         ),
//                       ],
//                     )),
//                     SizedBox(height: 30),
//
//                     // Create/Update Tanker Button
//                     Obx(() {
//                       bool isLoading = widget.tankerId != null
//                           ? _tankerController.isUpdateLoading.value
//                           : _tankerController.isAddLoading.value;
//
//                       return SizedBox(
//                         width: double.infinity,
//                         height: 50,
//                         child: ElevatedButton(
//                           onPressed: isLoading ? null : _submitForm,
//                           style: ElevatedButton.styleFrom(
//                             backgroundColor: AppColors.button,
//                             shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(10),
//                             ),
//                             disabledBackgroundColor: AppColors.button.withOpacity(0.6),
//                           ),
//                           child: isLoading
//                               ? SizedBox(
//                             width: 20,
//                             height: 20,
//                             child: CircularProgressIndicator(
//                               color: AppColors.background,
//                               strokeWidth: 2,
//                             ),
//                           )
//                               : Text(
//                             widget.tankerId != null ? "Update Tanker" : "Create Tanker",
//                             style: TextStyle(
//                               fontSize: 20,
//                               fontWeight: FontWeight.w500,
//                               color: AppColors.background,
//                             ),
//                           ),
//                         ),
//                       );
//                     }),
//                     SizedBox(height: 20),
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import '../../../controllers/AdminController/TankerController.dart';
import '../../../utils/colors.dart';

// Input formatters to remove special characters and spaces
class AlphanumericInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue,
      TextEditingValue newValue,
      ) {
    // Remove spaces and special characters, keep only alphanumeric
    String filteredText = newValue.text.replaceAll(RegExp(r'[^a-zA-Z0-9]'), '');

    return TextEditingValue(
      text: filteredText.toUpperCase(),
      selection: TextSelection.collapsed(offset: filteredText.length),
    );
  }
}

class NumericInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue,
      TextEditingValue newValue,
      ) {
    // Remove everything except numbers
    String filteredText = newValue.text.replaceAll(RegExp(r'[^0-9]'), '');

    return TextEditingValue(
      text: filteredText,
      selection: TextSelection.collapsed(offset: filteredText.length),
    );
  }
}

class CreateTanker extends StatefulWidget {
  final String? tankerId;

  const CreateTanker({super.key, this.tankerId});

  @override
  State<CreateTanker> createState() => _CreateTankerState();
}

class _CreateTankerState extends State<CreateTanker> {
  final _formKey = GlobalKey<FormState>();
  final TankerController _tankerController = Get.find<TankerController>();
  final ImagePicker _picker = ImagePicker();

  // Add calibration number controller (separate from calibration date)
  var calibrationNumberController = TextEditingController();

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (widget.tankerId != null) {
        // Load tanker details for editing
        _tankerController.getTankerDetail(widget.tankerId!);
      } else {
        // Clear form when creating new tanker
        _tankerController.clearTankerForm();
      }
    });
  }

  @override
  void dispose() {
    calibrationNumberController.dispose();
    super.dispose();
  }

  // Validation methods
  String? _validateRequired(String? value, String fieldName) {
    if (value == null || value.trim().isEmpty) {
      return '$fieldName is required';
    }
    return null;
  }

  String? _validateRegistrationNumber(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Registration number is required';
    }
    if (value.length < 6) {
      return 'Registration number must be at least 6 characters';
    }
    return null;
  }

  String? _validateCapacity(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Capacity is required';
    }
    final capacity = int.tryParse(value);
    if (capacity == null || capacity <= 0) {
      return 'Enter a valid capacity';
    }
    return null;
  }

  String? _validateDate(String? value, String fieldName) {
    if (value == null || value.trim().isEmpty) {
      return '$fieldName is required';
    }
    try {
      final date = DateFormat('yyyy-MM-dd').parse(value);
      // Allow current date and future dates
      if (date.isBefore(DateTime.now().subtract(Duration(days: 1)))) {
        return '$fieldName cannot be in the past';
      }
    } catch (e) {
      return 'Enter a valid date (YYYY-MM-DD)';
    }
    return null;
  }

  String? _validateDropdown(String? value, String fieldName) {
    if (value == null || value.isEmpty) {
      return '$fieldName is required';
    }
    return null;
  }

  String? _validateFileUpload(File? file, String fieldName) {
    if (file == null) {
      return '$fieldName is required';
    }
    return null;
  }

  // Enhanced validation for registration number with no special characters
  String? _validateRegistrationNumberEnhanced(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Registration number is required';
    }

    // Check for special characters or spaces
    if (RegExp(r'[^a-zA-Z0-9]').hasMatch(value)) {
      return 'Registration number cannot contain spaces or special characters';
    }

    if (value.length < 6) {
      return 'Registration number must be at least 6 characters';
    }

    if (value.length > 15) {
      return 'Registration number cannot exceed 15 characters';
    }

    return null;
  }

  // Enhanced validation for certificate numbers
  String? _validateCertificateNumber(String? value, String fieldName) {
    if (value == null || value.trim().isEmpty) {
      return '$fieldName is required';
    }

    // Check for special characters or spaces
    if (RegExp(r'[^a-zA-Z0-9]').hasMatch(value)) {
      return '$fieldName cannot contain spaces or special characters';
    }

    if (value.length < 3) {
      return '$fieldName must be at least 3 characters';
    }

    if (value.length > 20) {
      return '$fieldName cannot exceed 20 characters';
    }

    return null;
  }

  // Date picker - Updated to use controller's observable values
  Future<void> _selectDate(BuildContext context, String dateType) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2040),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: AppColors.primary,
              onPrimary: Colors.white,
              surface: Colors.white,
              onSurface: Colors.black,
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      final formattedDate = DateFormat('yyyy-MM-dd').format(picked);
      setState(() {
        switch (dateType) {
          case 'fitness_cert_exp_date':
            _tankerController.fitnessCertExpDateController.text = formattedDate;
            _tankerController.selectedFitnessCertExpDate.value = formattedDate;
            break;
          case 'pollution_control_cert_exp_date':
            _tankerController.pollutionControlCertExpDateController.text = formattedDate;
            _tankerController.selectedPollutionControlCertExpDate.value = formattedDate;
            break;
          case 'insurance_exp_date':
            _tankerController.insuranceExpDateController.text = formattedDate;
            _tankerController.selectedInsuranceExpDate.value = formattedDate;
            break;
          case 'calibration_date':
            _tankerController.calibrationDateController.text = formattedDate;
            _tankerController.selectedCalibrationDate.value = formattedDate;
            break;
          case 'calibration_exp_date':
            _tankerController.calibrationExpDateController.text = formattedDate;
            _tankerController.selectedCalibrationExpDate.value = formattedDate;
            break;
          case 'explosive_exp_date':
            _tankerController.explosiveExpDateController.text = formattedDate;
            _tankerController.selectedExplosiveExpDate.value = formattedDate;
            break;
        }
      });
    }
  }

  // File picker - Updated to use controller's methods
  Future<void> _pickFile(bool isRcDoc) async {
    try {
      final XFile? pickedFile = await _picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 80,
      );

      if (pickedFile != null) {
        final file = File(pickedFile.path);
        if (isRcDoc) {
          _tankerController.setRcDocImage(file);
        } else {
          _tankerController.setOtherCertImage(file);
        }
        setState(() {});
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error picking file: ${e.toString()}')),
      );
    }
  }

  // Show image dialog
  void _showImageDialog(String imageUrl, String title) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        backgroundColor: Colors.transparent,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.close, color: Colors.white),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ],
              ),
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Colors.white,
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  imageUrl,
                  fit: BoxFit.contain,
                  width: MediaQuery.of(context).size.width * 0.9,
                  height: MediaQuery.of(context).size.height * 0.7,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Submit form - Updated to use controller's addTanker or updateTanker method
  Future<void> _submitForm() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    // Validate required fields
    if (_tankerController.calibrationNumberController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please enter calibration number')),
      );
      return;
    }

    // Validate RC document upload only for new tankers
    if (!_tankerController.isEditMode.value && _tankerController.rcDocImage.value == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please upload RC Document')),
      );
      return;
    }

    // Use appropriate method based on edit mode
    if (_tankerController.isEditMode.value) {
      await _tankerController.updateTanker(_tankerController.editingTankerId.value);
    } else {
      await _tankerController.addTanker();
    }
  }

  // Build calibration number field
  Widget _buildCalibrationNumberField() {
    return TextFormField(
      controller: _tankerController.calibrationNumberController,
      inputFormatters: [
        AlphanumericInputFormatter(),
        LengthLimitingTextInputFormatter(20),
      ],
      decoration: InputDecoration(
        labelText: "Calibration Number *",
        hintText: "e.g. CAL123456",
        helperText: "Only letters and numbers allowed - REQUIRED FIELD",
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: AppColors.primary, width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: AppColors.primary, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.red, width: 1),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.red, width: 2),
        ),
      ),
      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return 'Calibration number is required';
        }
        return null;
      },
    );
  }

  Widget _buildCalibrationExpiryDateField() {
    return TextFormField(
      controller: _tankerController.calibrationExpDateController,
      readOnly: true,
      decoration: InputDecoration(
        labelText: "Calibration Expiry Date",
        hintText: 'Select date',
        suffixIcon: Icon(Icons.calendar_today, color: AppColors.primary),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: AppColors.primary, width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: AppColors.primary, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.red, width: 1),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.red, width: 2),
        ),
      ),
      onTap: () => _selectDate(context, 'calibration_exp_date'),
    );
  }

  // Build calibration date field
  Widget _buildCalibrationDateField() {
    return TextFormField(
      controller: _tankerController.calibrationDateController,
      readOnly: true,
      decoration: InputDecoration(
        labelText: "Calibration Date",
        hintText: 'Select date',
        suffixIcon: Icon(Icons.calendar_today, color: AppColors.primary),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: AppColors.primary, width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: AppColors.primary, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.red, width: 1),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.red, width: 2),
        ),
      ),
      onTap: () => _selectDate(context, 'calibration_date'),
    );
  }

  // Build RC Document Upload Section
  Widget _buildRcDocumentUpload() {
    return Obx(() => Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "RC Document *",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: AppColors.text,
          ),
        ),
        SizedBox(height: 8),

        // Show existing RC document if available (for edit mode)
        if (_tankerController.existingRcDocUrl.value.isNotEmpty)
          Column(
            children: [
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.green, width: 2),
                  color: Colors.green.withOpacity(0.1),
                ),
                child: Row(
                  children: [
                    Icon(Icons.picture_as_pdf, color: Colors.green, size: 24),
                    SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Existing RC Document',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.green,
                            ),
                          ),
                          Text(
                            'Click to view current document',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.green.withOpacity(0.8),
                            ),
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.remove_red_eye, color: Colors.green),
                      onPressed: () => _showImageDialog(
                        _tankerController.existingRcDocUrl.value,
                        'RC Document',
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10),
              Text(
                "Upload new RC document to replace existing one",
                style: TextStyle(
                  fontSize: 12,
                  color: AppColors.text.withOpacity(0.6),
                ),
              ),
              SizedBox(height: 10),
            ],
          ),

        // Upload new RC document
        Container(
          width: double.infinity,
          height: 60,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: _tankerController.rcDocImage.value != null
                  ? Colors.blue
                  : AppColors.primary,
              width: 2,
            ),
          ),
          child: InkWell(
            onTap: () => _pickFile(true),
            borderRadius: BorderRadius.circular(12),
            child: Row(
              children: [
                SizedBox(width: 15),
                Icon(
                  Icons.upload_file,
                  color: _tankerController.rcDocImage.value != null
                      ? Colors.blue
                      : AppColors.primary,
                  size: 24,
                ),
                SizedBox(width: 15),
                Expanded(
                  child: Text(
                    _tankerController.rcDocImage.value != null
                        ? 'New RC Document Selected: ${_tankerController.rcDocImage.value!.path.split('/').last}'
                        : _tankerController.existingRcDocUrl.value.isNotEmpty
                        ? 'Upload New RC Document (Optional)'
                        : 'Upload RC Document *',
                    style: TextStyle(
                      fontSize: 16,
                      color: _tankerController.rcDocImage.value != null
                          ? Colors.blue
                          : AppColors.text,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                if (_tankerController.rcDocImage.value != null)
                  Padding(
                    padding: const EdgeInsets.only(right: 15),
                    child: Icon(Icons.check_circle, color: Colors.blue, size: 24),
                  ),
                SizedBox(width: 10),
              ],
            ),
          ),
        ),
        SizedBox(height: 5),
        Text(
          _tankerController.existingRcDocUrl.value.isNotEmpty
              ? "Existing document is shown above. Upload new one only if you want to replace it."
              : "Mandatory document for tanker registration",
          style: TextStyle(
            fontSize: 12,
            color: AppColors.text.withOpacity(0.6),
          ),
        ),
      ],
    ));
  }

  // Build Other Certificate Upload Section
  Widget _buildOtherCertificateUpload() {
    return Obx(() => Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Other Certificate (Optional)",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: AppColors.text,
          ),
        ),
        SizedBox(height: 8),

        // Show existing other certificate if available (for edit mode)
        if (_tankerController.existingOtherCertUrl.value.isNotEmpty)
          Column(
            children: [
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.green, width: 2),
                  color: Colors.green.withOpacity(0.1),
                ),
                child: Row(
                  children: [
                    Icon(Icons.picture_as_pdf, color: Colors.green, size: 24),
                    SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Existing Other Certificate',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.green,
                            ),
                          ),
                          Text(
                            'Click to view current document',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.green.withOpacity(0.8),
                            ),
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.remove_red_eye, color: Colors.green),
                      onPressed: () => _showImageDialog(
                        _tankerController.existingOtherCertUrl.value,
                        'Other Certificate',
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10),
              Text(
                "Upload new certificate to replace existing one",
                style: TextStyle(
                  fontSize: 12,
                  color: AppColors.text.withOpacity(0.6),
                ),
              ),
              SizedBox(height: 10),
            ],
          ),

        // Upload new other certificate
        Container(
          width: double.infinity,
          height: 60,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: _tankerController.otherCertImage.value != null
                  ? Colors.blue
                  : AppColors.primary,
              width: 1,
            ),
          ),
          child: InkWell(
            onTap: () => _pickFile(false),
            borderRadius: BorderRadius.circular(12),
            child: Row(
              children: [
                SizedBox(width: 15),
                Icon(
                  Icons.upload_file,
                  color: _tankerController.otherCertImage.value != null
                      ? Colors.blue
                      : AppColors.primary,
                  size: 24,
                ),
                SizedBox(width: 15),
                Expanded(
                  child: Text(
                    _tankerController.otherCertImage.value != null
                        ? 'New Certificate Selected: ${_tankerController.otherCertImage.value!.path.split('/').last}'
                        : _tankerController.existingOtherCertUrl.value.isNotEmpty
                        ? 'Upload New Certificate (Optional)'
                        : 'Upload Other Certificate (Optional)',
                    style: TextStyle(
                      fontSize: 16,
                      color: _tankerController.otherCertImage.value != null
                          ? Colors.blue
                          : AppColors.text,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                if (_tankerController.otherCertImage.value != null)
                  Padding(
                    padding: const EdgeInsets.only(right: 15),
                    child: Icon(Icons.check_circle, color: Colors.blue, size: 24),
                  ),
                SizedBox(width: 10),
              ],
            ),
          ),
        ),
        SizedBox(height: 5),
        Text(
          _tankerController.existingOtherCertUrl.value.isNotEmpty
              ? "Existing certificate is shown above. Upload new one only if you want to replace it."
              : "Additional certificates (if any)",
          style: TextStyle(
            fontSize: 12,
            color: AppColors.text.withOpacity(0.6),
          ),
        ),
      ],
    ));
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      height: size.height * 0.95,
      width: size.width * 0.99,
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            SizedBox(height: 2),
            Container(
              height: 5,
              width: 53,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: AppColors.alert,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15, right: 8, bottom: 8, top: 20),
              child: Row(
                children: [
                  Container(
                    height: 62,
                    width: 62,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: AppColors.primary,
                    ),
                    child: SvgPicture.asset(
                      'assets/images/Tanker3.svg',
                      color: AppColors.background,
                      fit: BoxFit.none,
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.tankerId != null ? 'Edit Tanker' : 'Create Tanker',
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 24,
                            color: AppColors.secondary,
                          ),
                        ),
                        Text(
                          widget.tankerId != null ? 'Update tanker details' : 'Add tanker for your product delivery',
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 14,
                            color: AppColors.icon,
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
                child: Column(
                  children: [
                    SizedBox(height: 20),

                    // Registration Number (Required)
                    TextFormField(
                      controller: _tankerController.registrationNumberController,
                      inputFormatters: [
                        AlphanumericInputFormatter(),
                        LengthLimitingTextInputFormatter(15),
                      ],
                      decoration: InputDecoration(
                        labelText: "Tanker Registration Number *",
                        hintText: "e.g. MH12AB1234",
                        helperText: "Only letters and numbers allowed (no spaces)",
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: AppColors.primary, width: 1),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: AppColors.primary, width: 2),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: Colors.red, width: 1),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: Colors.red, width: 2),
                        ),
                      ),
                      validator: _validateRegistrationNumberEnhanced,
                    ),
                    SizedBox(height: 20),

                    // Capacity (Required)
                    TextFormField(
                      controller: _tankerController.capacityController,
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        LengthLimitingTextInputFormatter(10),
                      ],
                      decoration: InputDecoration(
                        labelText: "Capacity (Litres) *",
                        hintText: "e.g. 50000",
                        helperText: "Only numbers allowed",
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: AppColors.primary, width: 1),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: AppColors.primary, width: 2),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: Colors.red, width: 1),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: Colors.red, width: 2),
                        ),
                      ),
                      validator: _validateCapacity,
                    ),
                    SizedBox(height: 20),

                    // Fitness Certificate Number (Optional)
                    TextFormField(
                      controller: _tankerController.fitnessCertNoController,
                      inputFormatters: [
                        AlphanumericInputFormatter(),
                        LengthLimitingTextInputFormatter(20),
                      ],
                      decoration: InputDecoration(
                        labelText: "Fitness Certificate Number",
                        hintText: "e.g. FC123456",
                        helperText: "Only letters and numbers allowed (no spaces)",
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: AppColors.primary, width: 1),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: AppColors.primary, width: 2),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: Colors.red, width: 1),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: Colors.red, width: 2),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),

                    // Fitness Certificate Expiry Date (Optional)
                    TextFormField(
                      controller: _tankerController.fitnessCertExpDateController,
                      readOnly: true,
                      decoration: InputDecoration(
                        labelText: "Fitness Certificate Expiry Date",
                        hintText: 'Select date',
                        suffixIcon: Icon(Icons.calendar_today, color: AppColors.primary),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: AppColors.primary, width: 1),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: AppColors.primary, width: 2),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: Colors.red, width: 1),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: Colors.red, width: 2),
                        ),
                      ),
                      onTap: () => _selectDate(context, 'fitness_cert_exp_date'),
                    ),
                    SizedBox(height: 20),

                    // Pollution Control Certificate Number (Optional)
                    TextFormField(
                      controller: _tankerController.pollutionControlCertNoController,
                      inputFormatters: [
                        AlphanumericInputFormatter(),
                        LengthLimitingTextInputFormatter(20),
                      ],
                      decoration: InputDecoration(
                        labelText: "Pollution Control Certificate Number",
                        hintText: "e.g. PC987654",
                        helperText: "Only letters and numbers allowed (no spaces)",
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: AppColors.primary, width: 1),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: AppColors.primary, width: 2),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: Colors.red, width: 1),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: Colors.red, width: 2),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),

                    // Pollution Control Certificate Expiry Date (Optional)
                    TextFormField(
                      controller: _tankerController.pollutionControlCertExpDateController,
                      readOnly: true,
                      decoration: InputDecoration(
                        labelText: "Pollution Control Certificate Expiry Date",
                        hintText: 'Select date',
                        suffixIcon: Icon(Icons.calendar_today, color: AppColors.primary),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: AppColors.primary, width: 1),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: AppColors.primary, width: 2),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: Colors.red, width: 1),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: Colors.red, width: 2),
                        ),
                      ),
                      onTap: () => _selectDate(context, 'pollution_control_cert_exp_date'),
                    ),
                    SizedBox(height: 20),

                    // Insurance Policy Number (Optional)
                    TextFormField(
                      controller: _tankerController.insurancePolicyNumberController,
                      inputFormatters: [
                        AlphanumericInputFormatter(),
                        LengthLimitingTextInputFormatter(25),
                      ],
                      decoration: InputDecoration(
                        labelText: "Insurance Policy Number",
                        hintText: "e.g. INS123456789",
                        helperText: "Only letters and numbers allowed (no spaces)",
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: AppColors.primary, width: 1),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: AppColors.primary, width: 2),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: Colors.red, width: 1),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: Colors.red, width: 2),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),

                    // Insurance Expiry Date (Optional)
                    TextFormField(
                      controller: _tankerController.insuranceExpDateController,
                      readOnly: true,
                      decoration: InputDecoration(
                        labelText: "Insurance Expiry Date",
                        hintText: 'Select date',
                        suffixIcon: Icon(Icons.calendar_today, color: AppColors.primary),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: AppColors.primary, width: 1),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: AppColors.primary, width: 2),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: Colors.red, width: 1),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: Colors.red, width: 2),
                        ),
                      ),
                      onTap: () => _selectDate(context, 'insurance_exp_date'),
                    ),
                    SizedBox(height: 20),

                    // Calibration Number (Optional)
                    _buildCalibrationNumberField(),
                    SizedBox(height: 20),

                    _buildCalibrationExpiryDateField(),
                    SizedBox(height: 20),

                    // Permit Number (Optional)
                    TextFormField(
                      controller: _tankerController.permitNumberController,
                      inputFormatters: [
                        AlphanumericInputFormatter(),
                        LengthLimitingTextInputFormatter(20),
                      ],
                      decoration: InputDecoration(
                        labelText: "Permit Number",
                        hintText: "e.g. 996314",
                        helperText: "Only letters and numbers allowed",
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: AppColors.primary, width: 1),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: AppColors.primary, width: 2),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: Colors.red, width: 1),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: Colors.red, width: 2),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),

                    // Explosive Expiry Date (Optional)
                    TextFormField(
                      controller: _tankerController.explosiveExpDateController,
                      readOnly: true,
                      decoration: InputDecoration(
                        labelText: "Explosive Expiry Date",
                        hintText: 'Select date',
                        suffixIcon: Icon(Icons.calendar_today, color: AppColors.primary),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: AppColors.primary, width: 1),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: AppColors.primary, width: 2),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: Colors.red, width: 1),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: Colors.red, width: 2),
                        ),
                      ),
                      onTap: () => _selectDate(context, 'explosive_exp_date'),
                    ),
                    SizedBox(height: 20),

                    // RC Document Upload (Mandatory)
                    _buildRcDocumentUpload(),
                    SizedBox(height: 20),

                    // Other Certificate Upload (Optional)
                    _buildOtherCertificateUpload(),
                    SizedBox(height: 30),

                    // Create/Update Tanker Button
                    Obx(() {
                      bool isLoading = widget.tankerId != null
                          ? _tankerController.isUpdateLoading.value
                          : _tankerController.isAddLoading.value;

                      return SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: ElevatedButton(
                          onPressed: isLoading ? null : _submitForm,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.button,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            disabledBackgroundColor: AppColors.button.withOpacity(0.6),
                          ),
                          child: isLoading
                              ? SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(
                              color: AppColors.background,
                              strokeWidth: 2,
                            ),
                          )
                              : Text(
                            widget.tankerId != null ? "Update Tanker" : "Create Tanker",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                              color: AppColors.background,
                            ),
                          ),
                        ),
                      );
                    }),
                    SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}