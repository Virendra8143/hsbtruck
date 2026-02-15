// import 'dart:convert';
// import 'dart:io';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:get/get.dart';
// import 'package:image_picker/image_picker.dart';
// import '../../../Data/AppDialoge.dart';
// import '../../../utils/colors.dart';
//
// import '../../../controllers/AdminController/StaffController.dart';
//
// class Addstaff extends StatefulWidget {
//   final String? staffId;
//
//   const Addstaff({super.key, this.staffId});
//
//   @override
//   State<Addstaff> createState() => _AddstaffState();
// }
//
// class _AddstaffState extends State<Addstaff> {
//   String? roleValue;
//   String? shiftValue;
//
//   final RxList<String> selectedAccess = <String>[].obs;
//   final RxBool isFormLoading = false.obs;
//
//   final _formKey = GlobalKey<FormState>();
//
//   final Map<String, String> accessOptions = {
//     'Credit': 'credit',
//     'Add Schemes': 'add_scheme',
//     'Add Something': 'add_something',
//   };
//
//   final StaffController staffController = Get.put(StaffController());
//
//   @override
//   void initState() {
//     super.initState();
//     if (widget.staffId != null) {
//       // Load staff details for editing
//       staffController.getStaffDetail(staffId: widget.staffId!).then((_) {
//         _populateFormWithStaffData();
//       }).catchError((error) {
//         print('Error loading staff details: $error');
//         staffController.isLoading.value = false;
//       });
//
//       // Add timeout to prevent infinite loading
//       Future.delayed(Duration(seconds: 10), () {
//         if (staffController.isLoading.value) {
//           print('Timeout reached, stopping loading');
//           staffController.isLoading.value = false;
//         }
//       });
//     } else {
//       // New staff: clear any stale data from previous session
//       staffController.clear();
//       staffController.isLoading.value = false;
//     }
//   }
//
//   void _populateFormWithStaffData() {
//     print('Populating form with staff data...');
//     if (staffController.staffDetailModel.value.data != null &&
//         staffController.staffDetailModel.value.data!.isNotEmpty) {
//       final staffData = staffController.staffDetailModel.value.data![0];
//       print('Staff data loaded: ${staffData.name}');
//
//       // Populate text controllers
//       staffController.nameController.text = staffData.name ?? '';
//       staffController.phoneController.text = staffData.phone ?? '';
//       staffController.addressController.text = staffData.address ?? '';
//       staffController.salaryController.text = staffData.salary ?? '';
//       staffController.aadharController.text = staffData.aadharNumber ?? '';
//
//       // Set shift value
//       if (staffData.shift != null) {
//         switch (staffData.shift) {
//           case '0':
//             shiftValue = '24 Hour Shift';
//             staffController.updateShift('24 Hour Shift');
//             break;
//           case '1':
//             shiftValue = 'Day Shift';
//             staffController.updateShift('Day Shift');
//             break;
//           case '2':
//             shiftValue = 'Night Shift';
//             staffController.updateShift('Night Shift');
//             break;
//         }
//       }
//
//       // Set role value
//       if (staffData.role != null) {
//         switch (staffData.role) {
//           case '3':
//             roleValue = 'Manager';
//             staffController.updateRole('Manager');
//             break;
//           case '4':
//             roleValue = 'Pump Worker';
//             staffController.updateRole('Pump Worker');
//             break;
//         }
//       }
//
//       // Set access permissions
//       if (staffData.access != null && staffData.access!.isNotEmpty) {
//         List<String> accessList = staffData.access!.split(',');
//         selectedAccess.clear();
//         selectedAccess.addAll(accessList);
//         staffController.updateSelectedAccess(selectedAccess.toList());
//       }
//
//       print('Form populated successfully');
//     } else {
//       print('No staff data available');
//     }
//   }
//
//   Future<void> _pickImage(bool isFront) async {
//     try {
//       final ImagePicker picker = ImagePicker();
//       final XFile? image = await picker.pickImage(source: ImageSource.gallery);
//
//       if (image != null) {
//         File imageFile = File(image.path);
//         if (isFront) {
//           staffController.setAadharFrontImage(imageFile);
//         } else {
//           staffController.setAadharBackImage(imageFile);
//         }
//       }
//     } catch (e) {
//       Appdialogs.showToast("Error selecting image: ${e.toString()}");
//     }
//   }
//
//   void _toggleAccess(String value, String apiValue) {
//     if (selectedAccess.contains(apiValue)) {
//       selectedAccess.remove(apiValue);
//     } else {
//       selectedAccess.add(apiValue);
//     }
//     // Update controller with current selections
//     staffController.updateSelectedAccess(selectedAccess.toList());
//   }
//
//   void _submitForm() async {
//     if (_formKey.currentState!.validate()) {
//       isFormLoading.value = true;
//
//       // Update controller with final values before submission
//       staffController.updateSelectedAccess(selectedAccess.toList());
//       staffController.updateShift(shiftValue);
//       staffController.updateRole(roleValue);
//
//       try {
//         if (widget.staffId != null) {
//           // Update existing staff
//           await staffController.updateStaff(staffId: widget.staffId!, updateStatus: "1");
//         } else {
//           // Add new staff
//           await staffController.addStaff();
//         }
//       } catch (e) {
//         // Handle error if needed
//       } finally {
//         isFormLoading.value = false;
//       }
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final width = MediaQuery.of(context).size.width;
//     final height = MediaQuery.of(context).size.height;
//
//     return Obx(() => staffController.isLoading.value && widget.staffId != null
//         ? Container(
//             height: height * 0.82,
//             width: width * 0.99,
//             child: Center(
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   CircularProgressIndicator(color: AppColors.primary),
//                   SizedBox(height: 20),
//                   Text(
//                     'Loading staff details...',
//                     style: TextStyle(
//                       fontSize: 16,
//                       color: AppColors.secondary,
//                     ),
//                   ),
//                   SizedBox(height: 20),
//                   ElevatedButton(
//                     onPressed: () {
//                       staffController.isLoading.value = false;
//                     },
//                     child: Text('Cancel'),
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: Colors.red,
//                       foregroundColor: Colors.white,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           )
//         : Container(
//       height: height * 0.82,
//       width: width * 0.99,
//       child: Column(children: [
//         SizedBox(height: 2),
//         Container(
//           height: 5,
//           width: 53,
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(5),
//             color: AppColors.alert,
//           ),
//         ),
//         Padding(
//           padding:
//           const EdgeInsets.only(left: 15, right: 8, bottom: 8, top: 20),
//           child: Row(
//             children: [
//               Container(
//                 height: 62,
//                 width: 62,
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(12),
//                   color: AppColors.primary,
//                 ),
//                 child: SvgPicture.asset(
//                   'assets/images/worker staff.svg',
//                   fit: BoxFit.none,
//                 ),
//               ),
//               SizedBox(width: 10),
//               Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     widget.staffId != null ? 'Edit Staff' : 'Add Staff',
//                     style: TextStyle(
//                       fontWeight: FontWeight.w500,
//                       fontSize: 24,
//                       color: AppColors.secondary,
//                     ),
//                   ),
//                   Text(
//                     widget.staffId != null ? 'Edit staff and role' : 'Add staff and role',
//                     style: TextStyle(
//                       fontWeight: FontWeight.w400,
//                       fontSize: 14,
//                       color: AppColors.icon,
//                     ),
//                   )
//                 ],
//               ),
//               SizedBox(width: 20),
//             ],
//           ),
//         ),
//         Expanded(
//           child: Form(
//             key: _formKey,
//             child: SingleChildScrollView(
//               scrollDirection: Axis.vertical,
//               child: Column(
//                 children: [
//                   SizedBox(height: height * 0.02),
//                   // Name field
//                   SizedBox(
//                     width: width * 0.9,
//                     child: TextFormField(
//                       controller: staffController.nameController,
//                       decoration: InputDecoration(
//                         labelText: "Staff Name",
//                         enabledBorder: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(12),
//                           borderSide:
//                           BorderSide(color: AppColors.primary, width: 1),
//                         ),
//                         focusedBorder: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(12),
//                           borderSide:
//                           BorderSide(color: AppColors.primary, width: 2),
//                         ),
//                         errorBorder: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(12),
//                           borderSide: BorderSide(color: Colors.red, width: 1),
//                         ),
//                       ),
//                       validator: (value) {
//                         if (value == null || value.isEmpty) {
//                           return 'Please enter staff name';
//                         }
//                         return null;
//                       },
//                     ),
//                   ),
//                   SizedBox(height: 20),
//                   // Phone field
//                   SizedBox(
//                     width: width * 0.9,
//                     child: TextFormField(
//                       controller: staffController.phoneController,
//                       keyboardType: TextInputType.phone,
//                       decoration: InputDecoration(
//                         labelText: "Mobile Number",
//                         enabledBorder: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(12),
//                           borderSide:
//                           BorderSide(color: AppColors.primary, width: 1),
//                         ),
//                         focusedBorder: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(12),
//                           borderSide:
//                           BorderSide(color: AppColors.primary, width: 2),
//                         ),
//                         errorBorder: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(12),
//                           borderSide: BorderSide(color: Colors.red, width: 1),
//                         ),
//                       ),
//                       validator: (value) {
//                         if (value == null || value.isEmpty) {
//                           return 'Please enter mobile number';
//                         }
//                         if (value.length != 10) {
//                           return 'Mobile number should be 10 digits';
//                         }
//                         return null;
//                       },
//                     ),
//                   ),
//                   SizedBox(height: 20),
//                   // Rest of form fields...
//                   //                   SizedBox(height: 20),
//                   // Address field
//                   SizedBox(
//                     width: width * 0.9,
//                     child: TextFormField(
//                       controller: staffController.addressController,
//                       decoration: InputDecoration(
//                         labelText: "Address",
//                         enabledBorder: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(12),
//                           borderSide:
//                               BorderSide(color: AppColors.primary, width: 1),
//                         ),
//                         focusedBorder: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(12),
//                           borderSide:
//                               BorderSide(color: AppColors.primary, width: 2),
//                         ),
//                         errorBorder: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(12),
//                           borderSide: BorderSide(color: Colors.red, width: 1),
//                         ),
//                       ),
//                       validator: (value) {
//                         if (value == null || value.isEmpty) {
//                           return 'Please enter address';
//                         }
//                         return null;
//                       },
//                     ),
//                   ),
//                   SizedBox(height: 20),
//
//                   // Salary field
//                   SizedBox(
//                     width: width * 0.9,
//                     child: TextFormField(
//                       controller: staffController.salaryController,
//                       keyboardType: TextInputType.number,
//                       decoration: InputDecoration(
//                         labelText: "Salary",
//                         enabledBorder: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(12),
//                           borderSide:
//                               BorderSide(color: AppColors.primary, width: 1),
//                         ),
//                         focusedBorder: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(12),
//                           borderSide:
//                               BorderSide(color: AppColors.primary, width: 2),
//                         ),
//                         errorBorder: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(12),
//                           borderSide: BorderSide(color: Colors.red, width: 1),
//                         ),
//                       ),
//                       validator: (value) {
//                         if (value == null || value.isEmpty) {
//                           return 'Please enter salary';
//                         }
//                         return null;
//                       },
//                     ),
//                   ),
//                   SizedBox(height: 20),
//
//
//                   SizedBox(
//                     width: width * 0.9,
//                     child: TextFormField(
//                       controller: staffController.aadharController,
//                       keyboardType: TextInputType.number,
//                       decoration: InputDecoration(
//                         labelText: "Aadhar Number",
//                         enabledBorder: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(12),
//                           borderSide:
//                               BorderSide(color: AppColors.primary, width: 1),
//                         ),
//                         focusedBorder: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(12),
//                           borderSide:
//                               BorderSide(color: AppColors.primary, width: 2),
//                         ),
//                         errorBorder: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(12),
//                           borderSide: BorderSide(color: Colors.red, width: 1),
//                         ),
//                       ),
//                       validator: (value) {
//                         if (value == null || value.isEmpty) {
//                           return 'Please enter Aadhar number';
//                         }
//                         if (value.length != 12) {
//                           return 'Aadhar number should be 12 digits';
//                         }
//                         return null;
//                       },
//                     ),
//                   ),
//                   SizedBox(height: 20),
//
//
//                   Padding(
//                     padding: const EdgeInsets.only(left: 20),
//                     child: Row(
//                       children: [
//
//                         Obx(() => GestureDetector(
//                           onTap: () => _pickImage(true),
//                           child: Container(
//                             height: height * 0.13,
//                             width: width * 0.42,
//                             decoration: BoxDecoration(
//                               borderRadius: BorderRadius.circular(12),
//                               border: Border.all(
//                                   color: AppColors.primary, width: 1),
//                               image: staffController.aadharFrontImage.value != null
//                                   ? DecorationImage(
//                                 image: FileImage(staffController.aadharFrontImage.value!),
//                                 fit: BoxFit.cover,
//                               )
//                                   : null,
//                             ),
//                             child: staffController.aadharFrontImage.value == null
//                                 ? Column(
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               children: [
//                                 SvgPicture.asset(
//                                     'assets/images/Camera.svg'),
//                                 Text(
//                                   'Aadhar Card Front',
//                                   style: TextStyle(
//                                     fontWeight: FontWeight.w400,
//                                     fontSize: 12,
//                                     color: AppColors.text,
//                                   ),
//                                 )
//                               ],
//                             )
//                                 : null,
//                           ),
//                         )),
//                         SizedBox(width: 10),
//                         // Aadhar Back Image
//                         Obx(() => GestureDetector(
//                           onTap: () => _pickImage(false),
//                           child: Container(
//                             height: height * 0.13,
//                             width: width * 0.42,
//                             decoration: BoxDecoration(
//                               borderRadius: BorderRadius.circular(12),
//                               border: Border.all(
//                                   color: AppColors.primary, width: 1),
//                               image: staffController.aadharBackImage.value != null
//                                   ? DecorationImage(
//                                 image: FileImage(staffController.aadharBackImage.value!),
//                                 fit: BoxFit.cover,
//                               )
//                                   : null,
//                             ),
//                             child: staffController.aadharBackImage.value == null
//                                 ? Column(
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               children: [
//                                 SvgPicture.asset(
//                                     'assets/images/Camera.svg'),
//                                 Text(
//                                   'Aadhar Card Back',
//                                   style: TextStyle(
//                                     fontWeight: FontWeight.w400,
//                                     fontSize: 12,
//                                     color: AppColors.text,
//                                   ),
//                                 )
//                               ],
//                             )
//                                 : null,
//                           ),
//                         )),
//                       ],
//                     ),
//                   ),
//                   SizedBox(height: 20),
//
//                   // Shift dropdown
//                   Container(
//                     height: 60,
//                     width: width * 0.9,
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(12),
//                       border: Border.all(color: AppColors.primary, width: 1),
//                     ),
//                     child: DropdownButton<String>(
//                       value: shiftValue,
//                       isExpanded: true,
//                       hint: Padding(
//                         padding: const EdgeInsets.only(left: 10),
//                         child: Text(
//                           'Shifts',
//                           style: TextStyle(
//                               fontSize: 16,
//                               fontWeight: FontWeight.w400,
//                               color: AppColors.text),
//                         ),
//                       ),
//                       icon: Padding(
//                         padding: const EdgeInsets.only(right: 20),
//                         child: SvgPicture.asset(
//                           'assets/images/Arrow.svg',
//                           width: 11,
//                           height: 15,
//                         ),
//                       ),
//                       style: TextStyle(fontSize: 16, color: Colors.black),
//                       underline: SizedBox(),
//                       items: <String>[
//                         'Day Shift',
//                         'Night Shift',
//                         '24 Hour Shift'
//                       ].map<DropdownMenuItem<String>>((String value) {
//                         return DropdownMenuItem<String>(
//                           value: value,
//                           child: Padding(
//                             padding: const EdgeInsets.only(left: 10),
//                             child: Text(value),
//                           ),
//                         );
//                       }).toList(),
//                       onChanged: (String? newValue) {
//                         setState(() {
//                           shiftValue = newValue;
//                         });
//                         staffController.updateShift(newValue);
//                       },
//                     ),
//                   ),
//                   SizedBox(height: 20),
//
//                   // Access selection
//                   Container(
//                     width: width * 0.9,
//                     padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(12),
//                       border: Border.all(color: AppColors.primary, width: 1),
//                     ),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Padding(
//                           padding: const EdgeInsets.only(left: 5, bottom: 5),
//                           child: Text(
//                             'Access',
//                             style: TextStyle(
//                                 fontSize: 16,
//                                 fontWeight: FontWeight.w400,
//                                 color: AppColors.text),
//                           ),
//                         ),
//                         Obx(() => Wrap(
//                           spacing: 8,
//                           runSpacing: 8,
//                           children: accessOptions.entries.map((entry) {
//                             bool isSelected =
//                             selectedAccess.contains(entry.value);
//                             return GestureDetector(
//                               onTap: () =>
//                                   _toggleAccess(entry.key, entry.value),
//                               child: Chip(
//                                 backgroundColor: isSelected
//                                     ? AppColors.primary
//                                     : Colors.grey[200],
//                                 label: Text(
//                                   entry.key,
//                                   style: TextStyle(
//                                     color: isSelected
//                                         ? Colors.white
//                                         : Colors.black,
//                                   ),
//                                 ),
//                               ),
//                             );
//                           }).toList(),
//                         )),
//                       ],
//                     ),
//                   ),
//                   SizedBox(height: 20),
//
//                   // Role dropdown
//                   Container(
//                     height: 60,
//                     width: width * 0.9,
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(12),
//                       border: Border.all(color: AppColors.primary, width: 1),
//                     ),
//                     child: DropdownButton<String>(
//                       value: roleValue,
//                       isExpanded: true,
//                       hint: Padding(
//                         padding: const EdgeInsets.only(left: 10),
//                         child: Text(
//                           'Role',
//                           style: TextStyle(
//                               fontSize: 16,
//                               fontWeight: FontWeight.w400,
//                               color: AppColors.text),
//                         ),
//                       ),
//                       icon: Padding(
//                         padding: const EdgeInsets.only(right: 20),
//                         child: SvgPicture.asset(
//                           'assets/images/Arrow.svg',
//                           width: 11,
//                           height: 15,
//                         ),
//                       ),
//                       style: TextStyle(fontSize: 16, color: Colors.black),
//                       underline: SizedBox(),
//                       items: <String>['Manager', 'Pump Worker']
//                           .map<DropdownMenuItem<String>>((String value) {
//                         return DropdownMenuItem<String>(
//                           value: value,
//                           child: Padding(
//                             padding: const EdgeInsets.only(left: 10),
//                             child: Text(value),
//                           ),
//                         );
//                       }).toList(),
//                       onChanged: (String? newValue) {
//                         roleValue = newValue;
//                         staffController.updateRole(newValue);
//                       },
//                     ),
//                   ),
//                   SizedBox(height: 20),
//
//                   // Add Staff button
//                   Container(
//                     height: 60,
//                     width: width * 0.9,
//                     child: Obx(() => ElevatedButton(
//                       onPressed:
//                       isFormLoading.value ? null : _submitForm,
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: AppColors.button,
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(10),
//                         ),
//                       ),
//                       child: isFormLoading.value
//                           ? CircularProgressIndicator(color: Colors.white)
//                           : Text(
//                         widget.staffId != null ? "Update Staff" : "Add Staff",
//                         style: TextStyle(
//                             fontSize: 20,
//                             fontWeight: FontWeight.w500,
//                             color: AppColors.background),
//                       ),
//                     )),
//                   ),
//                   SizedBox(height: 20),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ]),
//     ));
//   }
// }
//
// // class _AddstaffState extends State<Addstaff> {
// //   String? roleValue;
// //   String? shiftValue;
// //   String? accessValue;
// //
// //   final List<String> selectedAccess = [];
// //
// //   final _formKey = GlobalKey<FormState>();
// //
// //   final Map<String, String> accessOptions = {
// //     'Credit': 'credit',
// //     'Add Schemes': 'add_scheme',
// //     'Add Something': 'add_something',
// //   };
// //
// //   final StaffController staffController = Get.put(StaffController());
// //
// //   Future<void> _pickImage(bool isFront) async {
// //     try {
// //       final ImagePicker picker = ImagePicker();
// //       final XFile? image = await picker.pickImage(source: ImageSource.gallery);
// //
// //       if (image != null) {
// //         if (isFront) {
// //           staffController.aadharFrontImage = File(image.path);
// //
// //           staffController.imageList!.add(File(staffController.aadharFrontImage!.path));
// //         } else {
// //           staffController.aadharBackImage = File(image.path);
// //
// //           staffController.imageList!.add(File(staffController.aadharBackImage!.path));
// //         }
// //
// //       }
// //     } catch (e) {
// //       Appdialogs.showToast("Error selecting image: ${e.toString()}");
// //     }
// //   }
// //
// //   void _toggleAccess(String value, String apiValue) {
// //     setState(() {
// //       if (selectedAccess.contains(apiValue)) {
// //         selectedAccess.remove(apiValue);
// //       } else {
// //         selectedAccess.add(apiValue);
// //       }
// //     });
// //   }
// //
// //   void _submitForm() {
// //     if (_formKey.currentState!.validate()) {
// //       if (staffController.aadharFrontImage == null || staffController.aadharBackImage == null) {
// //         Appdialogs.showToast("Please select both Aadhar card images");
// //         return;
// //       }
// //
// //       if (selectedAccess.isEmpty) {
// //         Appdialogs.showToast("Please select at least one access type");
// //         return;
// //       }
// //
// //       staffController.addStaff();
// //     }
// //   }
// //
// //
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     final width = MediaQuery.of(context).size.width;
// //     final height = MediaQuery.of(context).size.height;
// //
// //     return Container(
// //       height: height * 0.82,
// //       width: width * 0.99,
// //       child: Column(children: [
// //         SizedBox(height: 2),
// //         Container(
// //           height: 5,
// //           width: 53,
// //           decoration: BoxDecoration(
// //             borderRadius: BorderRadius.circular(5),
// //             color: AppColors.alert,
// //           ),
// //         ),
// //         Padding(
// //           padding:
// //               const EdgeInsets.only(left: 15, right: 8, bottom: 8, top: 20),
// //           child: Row(
// //             children: [
// //               Container(
// //                 height: 62,
// //                 width: 62,
// //                 decoration: BoxDecoration(
// //                   borderRadius: BorderRadius.circular(12),
// //                   color: AppColors.primary,
// //                 ),
// //                 child: SvgPicture.asset(
// //                   'assets/images/worker staff.svg',
// //                   fit: BoxFit.none,
// //                 ),
// //               ),
// //               SizedBox(width: 10),
// //               Column(
// //                 crossAxisAlignment: CrossAxisAlignment.start,
// //                 children: [
// //                   Text(
// //                     'Add Staff',
// //                     style: TextStyle(
// //                       fontWeight: FontWeight.w500,
// //                       fontSize: 24,
// //                       color: AppColors.secondary,
// //                     ),
// //                   ),
// //                   Text(
// //                     'Add staff and role',
// //                     style: TextStyle(
// //                       fontWeight: FontWeight.w400,
// //                       fontSize: 14,
// //                       color: AppColors.icon,
// //                     ),
// //                   )
// //                 ],
// //               ),
// //               SizedBox(width: 20),
// //             ],
// //           ),
// //         ),
// //         Expanded(
// //           child: Form(
// //             key: _formKey,
// //             child: SingleChildScrollView(
// //               scrollDirection: Axis.vertical,
// //               child: Column(
// //                 children: [
// //                   SizedBox(height: height * 0.02),
// //                   // Name field
// //                   SizedBox(
// //                     width: width * 0.9,
// //                     child: TextFormField(
// //                       controller: staffController.nameController,
// //                       decoration: InputDecoration(
// //                         labelText: "Staff Name",
// //                         enabledBorder: OutlineInputBorder(
// //                           borderRadius: BorderRadius.circular(12),
// //                           borderSide:
// //                               BorderSide(color: AppColors.primary, width: 1),
// //                         ),
// //                         focusedBorder: OutlineInputBorder(
// //                           borderRadius: BorderRadius.circular(12),
// //                           borderSide:
// //                               BorderSide(color: AppColors.primary, width: 2),
// //                         ),
// //                         errorBorder: OutlineInputBorder(
// //                           borderRadius: BorderRadius.circular(12),
// //                           borderSide: BorderSide(color: Colors.red, width: 1),
// //                         ),
// //                       ),
// //                       validator: (value) {
// //                         if (value == null || value.isEmpty) {
// //                           return 'Please enter staff name';
// //                         }
// //                         return null;
// //                       },
// //                     ),
// //                   ),
// //                   SizedBox(height: 20),
// //                   // Phone field
// //                   SizedBox(
// //                     width: width * 0.9,
// //                     child: TextFormField(
// //                       controller: staffController.phoneController,
// //                       keyboardType: TextInputType.phone,
// //                       decoration: InputDecoration(
// //                         labelText: "Mobile Number",
// //                         enabledBorder: OutlineInputBorder(
// //                           borderRadius: BorderRadius.circular(12),
// //                           borderSide:
// //                               BorderSide(color: AppColors.primary, width: 1),
// //                         ),
// //                         focusedBorder: OutlineInputBorder(
// //                           borderRadius: BorderRadius.circular(12),
// //                           borderSide:
// //                               BorderSide(color: AppColors.primary, width: 2),
// //                         ),
// //                         errorBorder: OutlineInputBorder(
// //                           borderRadius: BorderRadius.circular(12),
// //                           borderSide: BorderSide(color: Colors.red, width: 1),
// //                         ),
// //                       ),
// //                       validator: (value) {
// //                         if (value == null || value.isEmpty) {
// //                           return 'Please enter mobile number';
// //                         }
// //                         if (value.length != 10) {
// //                           return 'Mobile number should be 10 digits';
// //                         }
// //                         return null;
// //                       },
// //                     ),
// //                   ),
// //                   SizedBox(height: 20),
// //                   // Salary field
// //                   SizedBox(
// //                     width: width * 0.9,
// //                     child: TextFormField(
// //                       controller: staffController.salaryController,
// //                       keyboardType: TextInputType.number,
// //                       decoration: InputDecoration(
// //                         labelText: "Salary",
// //                         enabledBorder: OutlineInputBorder(
// //                           borderRadius: BorderRadius.circular(12),
// //                           borderSide:
// //                               BorderSide(color: AppColors.primary, width: 1),
// //                         ),
// //                         focusedBorder: OutlineInputBorder(
// //                           borderRadius: BorderRadius.circular(12),
// //                           borderSide:
// //                               BorderSide(color: AppColors.primary, width: 2),
// //                         ),
// //                         errorBorder: OutlineInputBorder(
// //                           borderRadius: BorderRadius.circular(12),
// //                           borderSide: BorderSide(color: Colors.red, width: 1),
// //                         ),
// //                       ),
// //                       validator: (value) {
// //                         if (value == null || value.isEmpty) {
// //                           return 'Please enter salary';
// //                         }
// //                         return null;
// //                       },
// //                     ),
// //                   ),
// //                   SizedBox(height: 20),
// //                   // Address field
// //                   SizedBox(
// //                     width: width * 0.9,
// //                     child: TextFormField(
// //                       controller: staffController.addressController,
// //                       decoration: InputDecoration(
// //                         labelText: "Address",
// //                         enabledBorder: OutlineInputBorder(
// //                           borderRadius: BorderRadius.circular(12),
// //                           borderSide:
// //                               BorderSide(color: AppColors.primary, width: 1),
// //                         ),
// //                         focusedBorder: OutlineInputBorder(
// //                           borderRadius: BorderRadius.circular(12),
// //                           borderSide:
// //                               BorderSide(color: AppColors.primary, width: 2),
// //                         ),
// //                         errorBorder: OutlineInputBorder(
// //                           borderRadius: BorderRadius.circular(12),
// //                           borderSide: BorderSide(color: Colors.red, width: 1),
// //                         ),
// //                       ),
// //                       validator: (value) {
// //                         if (value == null || value.isEmpty) {
// //                           return 'Please enter address';
// //                         }
// //                         return null;
// //                       },
// //                     ),
// //                   ),
// //                   SizedBox(height: 20),
// //
// //                   SizedBox(
// //                     width: width * 0.9,
// //                     child: TextFormField(
// //                       controller: staffController.aadharController,
// //                       keyboardType: TextInputType.number,
// //                       decoration: InputDecoration(
// //                         labelText: "Aadhar Number",
// //                         enabledBorder: OutlineInputBorder(
// //                           borderRadius: BorderRadius.circular(12),
// //                           borderSide:
// //                               BorderSide(color: AppColors.primary, width: 1),
// //                         ),
// //                         focusedBorder: OutlineInputBorder(
// //                           borderRadius: BorderRadius.circular(12),
// //                           borderSide:
// //                               BorderSide(color: AppColors.primary, width: 2),
// //                         ),
// //                         errorBorder: OutlineInputBorder(
// //                           borderRadius: BorderRadius.circular(12),
// //                           borderSide: BorderSide(color: Colors.red, width: 1),
// //                         ),
// //                       ),
// //                       validator: (value) {
// //                         if (value == null || value.isEmpty) {
// //                           return 'Please enter Aadhar number';
// //                         }
// //                         if (value.length != 12) {
// //                           return 'Aadhar number should be 12 digits';
// //                         }
// //                         return null;
// //                       },
// //                     ),
// //                   ),
// //                   SizedBox(height: 20),
// //
// //                   Padding(
// //                     padding: const EdgeInsets.only(left: 20),
// //                     child: Row(
// //                       children: [
// //
// //                         GestureDetector(
// //                           onTap: () => _pickImage(true),
// //                           child: Container(
// //                             height: height * 0.13,
// //                             width: width * 0.42,
// //                             decoration: BoxDecoration(
// //                               borderRadius: BorderRadius.circular(12),
// //                               border: Border.all(
// //                                   color: AppColors.primary, width: 1),
// //                               image: staffController.aadharFrontImage != null
// //                                   ? DecorationImage(
// //                                       image: FileImage(staffController.aadharFrontImage!),
// //                                       fit: BoxFit.cover,
// //                                     )
// //                                   : null,
// //                             ),
// //                             child: staffController.aadharFrontImage == null
// //                                 ? Column(
// //                                     mainAxisAlignment: MainAxisAlignment.center,
// //                                     children: [
// //                                       SvgPicture.asset(
// //                                           'assets/images/Camera.svg'),
// //                                       Text(
// //                                         'Aadhar Card Front',
// //                                         style: TextStyle(
// //                                           fontWeight: FontWeight.w400,
// //                                           fontSize: 12,
// //                                           color: AppColors.text,
// //                                         ),
// //                                       )
// //                                     ],
// //                                   )
// //                                 : null,
// //                           ),
// //                         ),
// //                         SizedBox(width: 10),
// //                         // Aadhar Back Image
// //                         GestureDetector(
// //                           onTap: () => _pickImage(false),
// //                           child: Container(
// //                             height: height * 0.13,
// //                             width: width * 0.42,
// //                             decoration: BoxDecoration(
// //                               borderRadius: BorderRadius.circular(12),
// //                               border: Border.all(
// //                                   color: AppColors.primary, width: 1),
// //                               image: staffController.aadharBackImage != null
// //                                   ? DecorationImage(
// //                                       image: FileImage(staffController.aadharBackImage!),
// //                                       fit: BoxFit.cover,
// //                                     )
// //                                   : null,
// //                             ),
// //                             child: staffController.aadharBackImage == null
// //                                 ? Column(
// //                                     mainAxisAlignment: MainAxisAlignment.center,
// //                                     children: [
// //                                       SvgPicture.asset(
// //                                           'assets/images/Camera.svg'),
// //                                       Text(
// //                                         'Aadhar Card Back',
// //                                         style: TextStyle(
// //                                           fontWeight: FontWeight.w400,
// //                                           fontSize: 12,
// //                                           color: AppColors.text,
// //                                         ),
// //                                       )
// //                                     ],
// //                                   )
// //                                 : null,
// //                           ),
// //                         ),
// //                       ],
// //                     ),
// //                   ),
// //                   SizedBox(height: 20),
// //
// //                   Container(
// //                     height: 60,
// //                     width: width * 0.9,
// //                     decoration: BoxDecoration(
// //                       borderRadius: BorderRadius.circular(12),
// //                       border: Border.all(color: AppColors.primary, width: 1),
// //                     ),
// //                     child: DropdownButton<String>(
// //                       value: shiftValue,
// //                       isExpanded: true,
// //                       hint: Padding(
// //                         padding: const EdgeInsets.only(left: 10),
// //                         child: Text(
// //                           'Shifts',
// //                           style: TextStyle(
// //                               fontSize: 16,
// //                               fontWeight: FontWeight.w400,
// //                               color: AppColors.text),
// //                         ),
// //                       ),
// //                       icon: Padding(
// //                         padding: const EdgeInsets.only(right: 20),
// //                         child: SvgPicture.asset(
// //                           'assets/images/Arrow.svg',
// //                           width: 11,
// //                           height: 15,
// //                         ),
// //                       ),
// //                       style: TextStyle(fontSize: 16, color: Colors.black),
// //                       underline: SizedBox(),
// //                       items: <String>[
// //                         'Day Shift',
// //                         'Night Shift',
// //                         '24 Hour Shift'
// //                       ].map<DropdownMenuItem<String>>((String value) {
// //                         return DropdownMenuItem<String>(
// //                           value: value,
// //                           child: Padding(
// //                             padding: const EdgeInsets.only(left: 10),
// //                             child: Text(value),
// //                           ),
// //                         );
// //                       }).toList(),
// //                       onChanged: (String? newValue) {
// //                         setState(() {
// //                           shiftValue = newValue;
// //                         });
// //                       },
// //                     ),
// //                   ),
// //                   SizedBox(height: 20),
// //                   // Access selection
// //                   Container(
// //                     width: width * 0.9,
// //                     padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
// //                     decoration: BoxDecoration(
// //                       borderRadius: BorderRadius.circular(12),
// //                       border: Border.all(color: AppColors.primary, width: 1),
// //                     ),
// //                     child: Column(
// //                       crossAxisAlignment: CrossAxisAlignment.start,
// //                       children: [
// //                         Padding(
// //                           padding: const EdgeInsets.only(left: 5, bottom: 5),
// //                           child: Text(
// //                             'Access',
// //                             style: TextStyle(
// //                                 fontSize: 16,
// //                                 fontWeight: FontWeight.w400,
// //                                 color: AppColors.text),
// //                           ),
// //                         ),
// //                         Wrap(
// //                           spacing: 8,
// //                           runSpacing: 8,
// //                           children: accessOptions.entries.map((entry) {
// //                             bool isSelected =
// //                                 selectedAccess.contains(entry.value);
// //                             return GestureDetector(
// //                               onTap: () =>
// //                                   _toggleAccess(entry.key, entry.value),
// //                               child: Chip(
// //                                 backgroundColor: isSelected
// //                                     ? AppColors.primary
// //                                     : Colors.grey[200],
// //                                 label: Text(
// //                                   entry.key,
// //                                   style: TextStyle(
// //                                     color: isSelected
// //                                         ? Colors.white
// //                                         : Colors.black,
// //                                   ),
// //                                 ),
// //                               ),
// //                             );
// //                           }).toList(),
// //                         ),
// //                       ],
// //                     ),
// //                   ),
// //                   SizedBox(height: 20),
// //                   // Role dropdown
// //                   Container(
// //                     height: 60,
// //                     width: width * 0.9,
// //                     decoration: BoxDecoration(
// //                       borderRadius: BorderRadius.circular(12),
// //                       border: Border.all(color: AppColors.primary, width: 1),
// //                     ),
// //                     child: DropdownButton<String>(
// //                       value: roleValue,
// //                       isExpanded: true,
// //                       hint: Padding(
// //                         padding: const EdgeInsets.only(left: 10),
// //                         child: Text(
// //                           'Role',
// //                           style: TextStyle(
// //                               fontSize: 16,
// //                               fontWeight: FontWeight.w400,
// //                               color: AppColors.text),
// //                         ),
// //                       ),
// //                       icon: Padding(
// //                         padding: const EdgeInsets.only(right: 20),
// //                         child: SvgPicture.asset(
// //                           'assets/images/Arrow.svg',
// //                           width: 11,
// //                           height: 15,
// //                         ),
// //                       ),
// //                       style: TextStyle(fontSize: 16, color: Colors.black),
// //                       underline: SizedBox(),
// //                       items: <String>['Manager', 'Pump Worker']
// //                           .map<DropdownMenuItem<String>>((String value) {
// //                         return DropdownMenuItem<String>(
// //                           value: value,
// //                           child: Padding(
// //                             padding: const EdgeInsets.only(left: 10),
// //                             child: Text(value),
// //                           ),
// //                         );
// //                       }).toList(),
// //                       onChanged: (String? newValue) {
// //                         setState(() {
// //                           roleValue = newValue;
// //                         });
// //                       },
// //                     ),
// //                   ),
// //                   SizedBox(height: 20),
// //                   // Add Staff button
// //                   Container(
// //                     height: 60,
// //                     width: width * 0.9,
// //                     child: ElevatedButton(
// //                       onPressed:
// //                           staffController.isLoading.value ? null : _submitForm,
// //                       style: ElevatedButton.styleFrom(
// //                         backgroundColor: AppColors.button,
// //                         shape: RoundedRectangleBorder(
// //                           borderRadius: BorderRadius.circular(10),
// //                         ),
// //                       ),
// //                       child: staffController.isLoading.value
// //                           ? CircularProgressIndicator(color: Colors.white)
// //                           : Text(
// //                               "Add Staff",
// //                               style: TextStyle(
// //                                   fontSize: 20,
// //                                   fontWeight: FontWeight.w500,
// //                                   color: AppColors.background),
// //                             ),
// //                     ),
// //                   ),
// //                   SizedBox(height: 20),
// //                 ],
// //               ),
// //             ),
// //           ),
// //         ),
// //       ]),
// //     );
// //   }
// // }
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../../../Data/AppDialoge.dart';
import '../../../utils/colors.dart';

import '../../../controllers/AdminController/StaffController.dart';

class Addstaff extends StatefulWidget {
  final String? staffId;

  const Addstaff({super.key, this.staffId});

  @override
  State<Addstaff> createState() => _AddstaffState();
}

class _AddstaffState extends State<Addstaff> {
  String? roleValue;
  String? shiftValue;

  final RxList<String> selectedAccess = <String>[].obs;
  final RxBool isFormLoading = false.obs;
  final RxBool isDataLoaded = false.obs; // Add this to track data loading

  final _formKey = GlobalKey<FormState>();

  final Map<String, String> accessOptions = {
    'Credit Customer': 'credit customer',
    'Scheme Registration' : 'scheme registration',
    'Mature Schemes': 'mature schemes',
    'Give Schemes' : 'give schemes',
    'Indent Book Issues' : 'indent book issues',
    'Inspection Mode' : 'inspection mode',
    'Cash Collection from Employee' : 'cash collection from employee',
    'View Customer Balance' : 'view customer balance',
    'Sales' : 'sales'
  };

  final StaffController staffController = Get.put(StaffController());

  @override
  void initState() {
    super.initState();

    // Defer any reactive variable updates until after build
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (widget.staffId != null) {
        // Load staff details for editing
        _loadStaffDetails();
      } else {
        // For new staff, clear any existing data and set as loaded
        staffController.clear();
        // Clear local UI state variables
        roleValue = null;
        shiftValue = null;
        selectedAccess.clear();
        isDataLoaded.value = true;
        staffController.isLoading.value = false;
      }
    });
  }

  Future<void> _loadStaffDetails() async {
    print('Loading staff details for ID: ${widget.staffId}');

    // Call the API to get staff details (controller will populate form automatically)
    await staffController.getStaffDetail(staffId: widget.staffId!);

    // The controller's _populateFormFields() is called automatically
    // Update local UI variables to match controller state
    _syncWithControllerState();

    // Mark as loaded
    isDataLoaded.value = true;
  }

  void _syncWithControllerState() {
    print('Syncing UI state with controller...');

    // Sync shift value
    if (staffController.selectedShift.value != null) {
      shiftValue = staffController.selectedShift.value;
      print('Synced shift: $shiftValue');
    }

    // Sync role value  
    if (staffController.selectedRole.value != null) {
      roleValue = staffController.selectedRole.value;
      print('Synced role: $roleValue');
    }

    // Sync access permissions
    selectedAccess.clear();
    selectedAccess.addAll(staffController.selectedAccessList);
    print('Synced access: ${selectedAccess.join(', ')}');

    // Force UI update
    setState(() {});
  }

  void _populateFormWithStaffData() {
    print('Populating form with staff data...');

    if (staffController.staffDetailModel.value.data != null &&
        staffController.staffDetailModel.value.data!.isNotEmpty) {
      final staffData = staffController.staffDetailModel.value.data![0];
      print('Staff data loaded: ${staffData.name}');

      // Populate text controllers
      staffController.nameController.text = staffData.name ?? '';
      staffController.phoneController.text = staffData.phone ?? '';
      staffController.addressController.text = staffData.address ?? '';
      staffController.salaryController.text = staffData.salary ?? '';
      staffController.aadharController.text = staffData.aadharNumber ?? '';

      // Set shift value and update UI
      if (staffData.shift != null) {
        switch (staffData.shift) {
          case '0':
            shiftValue = '24 Hour Shift';
            staffController.updateShift('24 Hour Shift');
            break;
          case '1':
            shiftValue = 'Day Shift';
            staffController.updateShift('Day Shift');
            break;
          case '2':
            shiftValue = 'Night Shift';
            staffController.updateShift('Night Shift');
            break;
        }
      }

      // Set role value and update UI
      if (staffData.role != null) {
        switch (staffData.role) {
          case '3':
            roleValue = 'Manager';
            staffController.updateRole('Manager');
            break;
          case '4':
            roleValue = 'Employee';
            staffController.updateRole('Employee');
            break;
          case '5':
            roleValue = 'Truck Driver';
            staffController.updateRole('Truck Driver');
            break;
        }
      }

      // Set access permissions
      if (staffData.access != null && staffData.access!.isNotEmpty) {
        List<String> accessList = staffData.access!.split(',');
        selectedAccess.clear();
        selectedAccess.addAll(accessList);
        staffController.updateSelectedAccess(selectedAccess.toList());
      }

      print('Form populated successfully');
      // Force UI update
      setState(() {});
    } else {
      print('No staff data available');
    }
  }

  Future<void> _pickImage(bool isFront) async {
    try {
      final ImagePicker picker = ImagePicker();
      final XFile? image = await picker.pickImage(source: ImageSource.gallery);

      if (image != null) {
        File imageFile = File(image.path);
        if (isFront) {
          staffController.setAadharFrontImage(imageFile);
        } else {
          staffController.setAadharBackImage(imageFile);
        }
      }
    } catch (e) {
      Appdialogs.showToast("Error selecting image: ${e.toString()}");
    }
  }

  void _toggleAccess(String value, String apiValue) {
    if (selectedAccess.contains(apiValue)) {
      selectedAccess.remove(apiValue);
    } else {
      selectedAccess.add(apiValue);
    }
    // Update controller with current selections
    staffController.updateSelectedAccess(selectedAccess.toList());
  }

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      isFormLoading.value = true;

      // Update controller with final values before submission
      staffController.updateSelectedAccess(selectedAccess.toList());
      staffController.updateShift(shiftValue);
      staffController.updateRole(roleValue);

      try {
        if (widget.staffId != null) {
          // Update existing staff
          await staffController.updateStaff(staffId: widget.staffId!, updateStatus: "1");
        } else {
          // Add new staff
          await staffController.addStaff();
        }
      } catch (e) {
        // Handle error if needed
        print('Error submitting form: $e');
      } finally {
        isFormLoading.value = false;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    // Show loading only when data is not loaded and we're in edit mode
    if (widget.staffId != null) {
      return Obx(() {
        if (!isDataLoaded.value) {
          return Container(
            height: height * 0.82,
            width: width * 0.99,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(color: AppColors.primary),
                  SizedBox(height: 20),
                  Text(
                    'Loading staff details...',
                    style: TextStyle(
                      fontSize: 16,
                      color: AppColors.secondary,
                    ),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      Get.back(); // Close the modal
                    },
                    child: Text('Cancel'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      foregroundColor: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          );
        }
        return _buildForm(context, width, height);
      });
    }

    // For new staff, show form directly
    return _buildForm(context, width, height);
  }

  Widget _buildForm(BuildContext context, double width, double height) {
    return Container(
      height: height * 0.82,
      width: width * 0.99,
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
                    'assets/images/worker staff.svg',
                    fit: BoxFit.none,
                    color: AppColors.background,
                  ),
                ),
                SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.staffId != null ? 'Edit Staff' : 'Add Staff',
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 24,
                        color: AppColors.secondary,
                      ),
                    ),
                    Text(
                      widget.staffId != null ? 'Edit staff and role' : 'Add staff and role',
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                        color: AppColors.icon,
                      ),
                    )
                  ],
                ),
                SizedBox(width: 20),
              ],
            ),
          ),
          Expanded(
            child: Form(
              key: _formKey,
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  children: [
                    SizedBox(height: height * 0.02),
                    // Name field
                    SizedBox(
                      width: width * 0.9,
                      child: TextFormField(
                        controller: staffController.nameController,
                        decoration: InputDecoration(
                          labelText: "Staff Name",
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
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter staff name';
                          }
                          return null;
                        },
                      ),
                    ),
                    SizedBox(height: 20),
                    // Phone field
                    SizedBox(
                      width: width * 0.9,
                      child: TextFormField(
                        controller: staffController.phoneController,
                        keyboardType: TextInputType.phone,
                        decoration: InputDecoration(
                          labelText: "Mobile Number",
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
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter mobile number';
                          }
                          if (value.length != 10) {
                            return 'Mobile number should be 10 digits';
                          }
                          return null;
                        },
                      ),
                    ),
                    SizedBox(height: 20),
                    // Address field
                    SizedBox(
                      width: width * 0.9,
                      child: TextFormField(
                        controller: staffController.addressController,
                        decoration: InputDecoration(
                          labelText: "Address",
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
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter address';
                          }
                          return null;
                        },
                      ),
                    ),
                    SizedBox(height: 20),
                    // Salary field
                    SizedBox(
                      width: width * 0.9,
                      child: TextFormField(
                        controller: staffController.salaryController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          labelText: "Salary",
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
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter salary';
                          }
                          return null;
                        },
                      ),
                    ),
                    SizedBox(height: 20),
                    // Aadhar Number field
                    SizedBox(
                      width: width * 0.9,
                      child: TextFormField(
                        controller: staffController.aadharController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          labelText: "Aadhar Number",
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
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter Aadhar number';
                          }
                          if (value.length != 12) {
                            return 'Aadhar number should be 12 digits';
                          }
                          return null;
                        },
                      ),
                    ),
                    SizedBox(height: 20),
                    // Aadhar Image Upload Section
                    Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Row(
                        children: [
                          Obx(() => GestureDetector(
                            onTap: () => _pickImage(true),
                            child: Container(
                              height: height * 0.13,
                              width: width * 0.42,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(color: AppColors.primary, width: 1),
                                image: staffController.aadharFrontImage.value != null
                                    ? DecorationImage(
                                  image: FileImage(staffController.aadharFrontImage.value!),
                                  fit: BoxFit.cover,
                                )
                                    : null,
                              ),
                              child: staffController.aadharFrontImage.value == null
                                  ? Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SvgPicture.asset('assets/images/Camera.svg'),
                                  Text(
                                    'Aadhar Card Front',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 12,
                                      color: AppColors.text,
                                    ),
                                  )
                                ],
                              )
                                  : null,
                            ),
                          )),
                          SizedBox(width: 10),
                          // Aadhar Back Image
                          Obx(() => GestureDetector(
                            onTap: () => _pickImage(false),
                            child: Container(
                              height: height * 0.13,
                              width: width * 0.42,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(color: AppColors.primary, width: 1),
                                image: staffController.aadharBackImage.value != null
                                    ? DecorationImage(
                                  image: FileImage(staffController.aadharBackImage.value!),
                                  fit: BoxFit.cover,
                                )
                                    : null,
                              ),
                              child: staffController.aadharBackImage.value == null
                                  ? Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SvgPicture.asset('assets/images/Camera.svg'),
                                  Text(
                                    'Aadhar Card Back',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 12,
                                      color: AppColors.text,
                                    ),
                                  )
                                ],
                              )
                                  : null,
                            ),
                          )),
                        ],
                      ),
                    ),
                    SizedBox(height: 20),
                    // Shift dropdown
                    Container(
                      height: 60,
                      width: width * 0.9,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: AppColors.primary, width: 1),
                      ),
                      child: DropdownButton<String>(
                        value: shiftValue,
                        isExpanded: true,
                        hint: Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Text(
                            'Shifts',
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                color: AppColors.text),
                          ),
                        ),
                        icon: Padding(
                          padding: const EdgeInsets.only(right: 20),
                          child: SvgPicture.asset(
                            'assets/images/Arrow.svg',
                            width: 11,
                            height: 15,
                          ),
                        ),
                        style: TextStyle(fontSize: 16, color: Colors.black),
                        underline: SizedBox(),
                        items: <String>[
                          'Day Shift',
                          'Night Shift',
                          '24 Hour Shift'
                        ].map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: Text(value),
                            ),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          setState(() {
                            shiftValue = newValue;
                          });
                          staffController.updateShift(newValue);
                        },
                      ),
                    ),
                    SizedBox(height: 20),
                    // Access selection
                    Container(
                      width: width * 0.9,
                      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: AppColors.primary, width: 1),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 5, bottom: 5),
                            child: Text(
                              'Access',
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                  color: AppColors.text),
                            ),
                          ),
                          Obx(() => Wrap(
                            spacing: 8,
                            runSpacing: 8,
                            children: accessOptions.entries.map((entry) {
                              bool isSelected = selectedAccess.contains(entry.value);
                              return GestureDetector(
                                onTap: () => _toggleAccess(entry.key, entry.value),
                                child: Chip(
                                  backgroundColor: isSelected
                                      ? AppColors.primary
                                      : Colors.grey[200],
                                  label: Text(
                                    entry.key,
                                    style: TextStyle(
                                      color: isSelected ? Colors.white : Colors.black,
                                    ),
                                  ),
                                ),
                              );
                            }).toList(),
                          )),
                        ],
                      ),
                    ),
                    SizedBox(height: 20),
                    // Role dropdown
                    Container(
                      height: 60,
                      width: width * 0.9,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: AppColors.primary, width: 1),
                      ),
                      child: DropdownButton<String>(
                        value: roleValue,
                        isExpanded: true,
                        hint: Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Text(
                            'Role',
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                color: AppColors.text),
                          ),
                        ),
                        icon: Padding(
                          padding: const EdgeInsets.only(right: 20),
                          child: SvgPicture.asset(
                            'assets/images/Arrow.svg',
                            width: 11,
                            height: 15,
                          ),
                        ),
                        style: TextStyle(fontSize: 16, color: Colors.black),
                        underline: SizedBox(),
                        items: <String>['Manager', 'Employee',]
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: Text(value),
                            ),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          setState(() {
                            roleValue = newValue;
                          });
                          staffController.updateRole(newValue);
                        },
                      ),
                    ),
                    SizedBox(height: 20),
                    // Add Staff button
                    Container(
                      height: 60,
                      width: width * 0.9,
                      child: Obx(() => ElevatedButton(
                        onPressed: isFormLoading.value ? null : _submitForm,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.button,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: isFormLoading.value
                            ? CircularProgressIndicator(color: Colors.white)
                            : Text(
                          widget.staffId != null ? "Update Staff" : "Add Staff",
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                              color: AppColors.background),
                        ),
                      )),
                    ),
                    SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}