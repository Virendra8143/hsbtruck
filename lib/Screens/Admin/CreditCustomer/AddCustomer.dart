//
// import 'dart:io';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:get/get.dart';
// import 'package:image_picker/image_picker.dart';
// import '../../../Data/AppDialoge.dart';
// import '../../../controllers/AdminController/AddCustomerController.dart';
// import '../../../utils/colors.dart';
// import 'package:signature/signature.dart';
//
// class AddCustomer extends StatefulWidget {
//   final String? customerId;
//
//   const AddCustomer({super.key, this.customerId});
//
//   @override
//   State<AddCustomer> createState() => _AddCustomerState();
// }
//
// class _AddCustomerState extends State<AddCustomer> {
//   final AddCustomerController controller = Get.put(AddCustomerController());
//   final _formKey = GlobalKey<FormState>();
//
//   @override
//   void initState() {
//     super.initState();
//
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       if (widget.customerId != null) {
//         // Load customer details for editing
//         controller.getCustomerDetail(customerId: widget.customerId!);
//       } else {
//         // Clear form for new customer
//         controller.clear();
//       }
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final width = MediaQuery.of(context).size.width;
//     final height = MediaQuery.of(context).size.height;
//
//     return Container(
//       padding: const EdgeInsets.all(16),
//       height: height * 0.9,
//       width: width * 0.9,
//       child: SingleChildScrollView(
//         child: Form(
//           key: _formKey,
//           autovalidateMode: AutovalidateMode.onUserInteraction,
//           child: Column(
//             children: [
//               const SizedBox(height: 2),
//               Container(
//                 height: 5,
//                 width: 53,
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(5),
//                   color: AppColors.alert,
//                 ),
//               ),
//               Padding(
//                 padding: const EdgeInsets.only(left: 15, right: 8, bottom: 8, top: 20),
//                 child: Row(
//                   children: [
//                     Container(
//                       height: 62,
//                       width: 62,
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(12),
//                         color: AppColors.primary,
//                       ),
//                       child: SvgPicture.asset('assets/images/worker staff.svg', color:AppColors.background,fit: BoxFit.none),
//                     ),
//                     const SizedBox(width: 10),
//                     Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                          Text(
//                           widget.customerId != null ? 'Edit Customer' : 'Add Customer',
//                           style: TextStyle(fontWeight: FontWeight.w500, fontSize: 24, color: AppColors.secondary),
//                         ),
//                          Text(
//                           widget.customerId != null ? 'Edit customer details' : 'Add customer details',
//                           style: TextStyle(fontWeight: FontWeight.w400, fontSize: 14, color: AppColors.icon),
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//               SizedBox(height: height * 0.02),
//
//               // Customer Name
//               _buildFormTextField(controller.nameController, "Customer Name", (value) {
//                 if (value == null || value.trim().isEmpty) return "Customer name is required";
//                 return null;
//               }),
//
//               SizedBox(height: height * 0.02),
//
//               // Mobile Number
//               _buildFormTextField(controller.phoneController, "Mobile Number", (value) {
//                 if (value == null || value.trim().isEmpty) return "Mobile number is required";
//                 if (value.trim().length != 10) return "Enter a valid 10-digit number";
//                 return null;
//               }, keyboardType: TextInputType.phone),
//
//               SizedBox(height: height * 0.02),
//
//               // Company Type Dropdown
//               Obx(() => _buildDropdown(
//                 width,
//                 'Company Type',
//                 controller.selectedCompanyType.value,
//                 controller.companyTypes,
//                     (String? newValue) {
//                   controller.selectedCompanyType.value = newValue;
//                 },
//               )),
//               SizedBox(height: height * 0.02),
//
//               // Aadhar Number
//               _buildFormTextField(controller.aadharController, "Aadhar Number", (value) {
//                 if (value == null || value.trim().isEmpty) return "Aadhar number is required";
//                 return null;
//               }, keyboardType: TextInputType.number),
//
//               SizedBox(height: height * 0.02),
//
//               // GST Number (Optional)
//               _buildFormTextField(controller.gstController, "GST Number (Optional)", null),
//
//               SizedBox(height: height * 0.02),
//
//               // Products Selection
//               Container(
//                 width: width * 0.9,
//                 padding: const EdgeInsets.all(12),
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(12),
//                   border: Border.all(color: AppColors.primary, width: 1),
//                 ),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text('Select Products',
//                         style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: AppColors.text)),
//                     const SizedBox(height: 8),
//                     Obx(() => Wrap(
//                       spacing: 8.0,
//                       runSpacing: 8.0,
//                       children: controller.products.map((product) {
//                         bool isSelected = controller.isProductSelected(product);
//                         return GestureDetector(
//                           onTap: () => controller.toggleProductSelection(product),
//                           child: Container(
//                             padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
//                             decoration: BoxDecoration(
//                               color: isSelected ? AppColors.primary : Colors.transparent,
//                               borderRadius: BorderRadius.circular(8),
//                               border: Border.all(
//                                 color: isSelected ? AppColors.primary : AppColors.icon,
//                                 width: 1,
//                               ),
//                             ),
//                             child: Text(
//                               product,
//                               style: TextStyle(
//                                 color: isSelected ? Colors.white : AppColors.text,
//                                 fontSize: 14,
//                               ),
//                             ),
//                           ),
//                         );
//                       }).toList(),
//                     )),
//                   ],
//                 ),
//               ),
//               SizedBox(height: height * 0.02),
//
//               // Time Period
//               _buildFormTextField(controller.timePeriodController, "Time Period (e.g., 30 days)", (value) {
//                 if (value == null || value.trim().isEmpty) return "Time period is required";
//                 return null;
//               }),
//
//               SizedBox(height: height * 0.02),
//
//               // Amount Limit
//               _buildFormTextField(controller.amountLimitController, "Amount Limit", (value) {
//                 if (value == null || value.trim().isEmpty) return "Amount limit is required";
//                 return null;
//               }, keyboardType: TextInputType.number),
//
//               SizedBox(height: height * 0.02),
//
//               // Interest Rate
//               _buildFormTextField(controller.interestRateController, "Interest Rate (%)", (value) {
//                 if (value == null || value.trim().isEmpty) return "Interest rate is required";
//                 return null;
//               }, keyboardType: TextInputType.numberWithOptions(decimal: true)),
//
//               SizedBox(height: height * 0.02),
//
//               // Aadhar Card Images
//               Padding(
//                 padding: const EdgeInsets.only(left: 20),
//                 child: Row(
//                   children: [
//                     Obx(() => GestureDetector(
//                       onTap: () => _pickImage(true),
//                       child: _imageUploadBox(width, controller.aadharFrontImage.value, "Aadhar Card Front"),
//                     )),
//                     const SizedBox(width: 10),
//                     Obx(() => GestureDetector(
//                       onTap: () => _pickImage(false),
//                       child: _imageUploadBox(width, controller.aadharBackImage.value, "Aadhar Card Back"),
//                     )),
//                   ],
//                 ),
//               ),
//               SizedBox(height: height * 0.04),
//
//
// // Signature Pad
//               Container(
//                 width: width * 0.9,
//                 padding: const EdgeInsets.all(12),
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(12),
//                   border: Border.all(color: AppColors.primary, width: 1),
//                 ),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       "Digital Signature",
//                       style: TextStyle(
//                         fontSize: 16,
//                         fontWeight: FontWeight.w500,
//                         color: AppColors.text,
//                       ),
//                     ),
//                     const SizedBox(height: 10),
//
//                     Container(
//                       height: 180,
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(12),
//                         border: Border.all(color: AppColors.icon, width: 1),
//                         color: Colors.white,
//                       ),
//                       child: ClipRRect(
//                         borderRadius: BorderRadius.circular(12),
//                         child: Signature(
//                           controller: controller.signatureController,
//                           backgroundColor: Colors.white,
//                         ),
//                       ),
//                     ),
//
//                     const SizedBox(height: 10),
//
//                     Row(
//                       children: [
//                         Expanded(
//                           child: ElevatedButton(
//                             onPressed: () {
//                               controller.signatureController.clear();
//                               controller.signatureBytes.value = null;
//                               controller.isSignatureAdded.value = false;
//                             },
//                             style: ElevatedButton.styleFrom(
//                               backgroundColor: Colors.grey.shade400,
//                               shape: RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.circular(10),
//                               ),
//                             ),
//                             child: const Text("Clear"),
//                           ),
//                         ),
//                         const SizedBox(width: 10),
//                         Expanded(
//                           child: ElevatedButton(
//                             onPressed: () async {
//                               await controller.saveSignature();
//                             },
//                             style: ElevatedButton.styleFrom(
//                               backgroundColor: AppColors.primary,
//                               shape: RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.circular(10),
//                               ),
//                             ),
//                             child: const Text("Save"),
//                           ),
//                         ),
//                       ],
//                     ),
//
//                     const SizedBox(height: 8),
//
//                     Obx(() => controller.isSignatureAdded.value
//                         ? Text(
//                       "✅ Signature Added",
//                       style: TextStyle(color: AppColors.primary, fontWeight: FontWeight.w500),
//                     )
//                         : Text(
//                       "Please sign above",
//                       style: TextStyle(color: Colors.grey.shade600),
//                     )),
//                   ],
//                 ),
//               ),
//
//               // Add Customer Button
//               Obx(() => SizedBox(
//                 height: 60,
//                 width: width * 0.9,
//                 child: ElevatedButton(
//                   onPressed: controller.isLoading.value
//                       ? null
//                       : () {
//                     if (_formKey.currentState!.validate()) {
//                       controller.addCustomer();
//                     }
//                   },
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: AppColors.button,
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(10),
//                     ),
//                   ),
//                   child: controller.isLoading.value
//                       ? CircularProgressIndicator(color: AppColors.background)
//                       : Text(
//                           widget.customerId != null ? "Update Customer" : "Add Customer",
//                           style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500, color: AppColors.background),
//                         ),
//                 ),
//               )),
//               SizedBox(height: height * 0.02),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget _buildDropdown(double width, String hint, String? currentValue, List<String> items, Function(String?) onChanged) {
//     return Container(
//       height: 60,
//       width: width * 0.9,
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(12),
//         border: Border.all(color: AppColors.primary, width: 1),
//       ),
//       child: DropdownButton<String>(
//         value: currentValue,
//         isExpanded: true,
//         hint: Padding(
//           padding: const EdgeInsets.only(left: 10),
//           child: Text(hint, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: AppColors.text)),
//         ),
//         icon: Padding(
//           padding: const EdgeInsets.only(right: 20),
//           child: SvgPicture.asset('assets/images/Arrow.svg', width: 11, height: 15),
//         ),
//         style: const TextStyle(fontSize: 16, color: Colors.black),
//         underline: const SizedBox(),
//         items: items.map<DropdownMenuItem<String>>((String value) {
//           return DropdownMenuItem<String>(
//             value: value,
//             child: Padding(padding: const EdgeInsets.only(left: 10), child: Text(value)),
//           );
//         }).toList(),
//         onChanged: onChanged,
//       ),
//     );
//   }
//
//   Widget _buildFormTextField(TextEditingController controller, String label, String? Function(String?)? validator,
//       {TextInputType? keyboardType}) {
//     return SizedBox(
//       width: MediaQuery.of(context).size.width * 0.9,
//       child: TextFormField(
//         controller: controller,
//         validator: validator,
//         keyboardType: keyboardType,
//         decoration: InputDecoration(
//           labelText: label,
//           enabledBorder: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(12),
//             borderSide: BorderSide(color: AppColors.primary, width: 1),
//           ),
//           focusedBorder: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(12),
//             borderSide: BorderSide(color: AppColors.primary, width: 1.5),
//           ),
//           errorBorder: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(12),
//             borderSide: const BorderSide(color: Colors.red, width: 1.5),
//           ),
//           focusedErrorBorder: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(12),
//             borderSide: const BorderSide(color: Colors.red, width: 1.5),
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget _imageUploadBox(double width, File? imageFile, String label) {
//     return Container(
//       height: 110,
//       width: width * 0.4,
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(12),
//         border: Border.all(color: AppColors.primary, width: 1),
//         color: imageFile != null ? AppColors.primary.withOpacity(0.1) : Colors.transparent,
//       ),
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           imageFile != null
//               ? Icon(Icons.check_circle, color: AppColors.primary, size: 32)
//               : SvgPicture.asset('assets/images/Camera.svg'),
//           Text(label,
//               style: TextStyle(fontWeight: FontWeight.w400, fontSize: 12, color: AppColors.text)),
//         ],
//       ),
//     );
//   }
//   Widget _digitalSignatureUploadBox(double width, File? imageFile) {
//     return Container(
//       height: 150,
//       width: width * 0.9,
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(12),
//         border: Border.all(
//           color: AppColors.primary,
//           width: 2,
//         ),
//         color: imageFile != null
//             ? AppColors.primary.withOpacity(0.05)
//             : Colors.grey[50],
//       ),
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           if (imageFile != null)
//             Image.file(
//               imageFile,
//               width: 100,
//               height: 80,
//               fit: BoxFit.contain,
//             )
//           else
//             Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Icon(
//                   Icons.upload_file,
//                   size: 40,
//                   color: AppColors.primary,
//                 ),
//                 SizedBox(height: 8),
//                 Text(
//                   'Tap to upload digital signature',
//                   style: TextStyle(
//                     color: AppColors.primary,
//                     fontWeight: FontWeight.w500,
//                   ),
//                 ),
//                 SizedBox(height: 4),
//                 Text(
//                   'PNG, JPG (Max 2MB)',
//                   style: TextStyle(
//                     color: Colors.grey[600],
//                     fontSize: 12,
//                   ),
//                 ),
//               ],
//             ),
//         ],
//       ),
//     );
//   }
//   Future<void> _pickImage(bool isFront) async {
//     try {
//       final ImagePicker picker = ImagePicker();
//       final XFile? image = await picker.pickImage(source: ImageSource.gallery);
//
//       if (image != null) {
//         File imageFile = File(image.path);
//         if (isFront) {
//           controller.setAadharFrontImage(imageFile);
//         } else {
//           controller.setAadharBackImage(imageFile);
//         }
//         setState(() {});
//       }
//     } catch (e) {
//       Appdialogs.showToast("Error selecting image: ${e.toString()}");
//     }
//   }
// }
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:signature/signature.dart';

import '../../../Data/AppDialoge.dart';
import '../../../controllers/AdminController/AddCustomerController.dart';
import '../../../utils/colors.dart';
import '../../../Utils/Api.dart';

class AddCustomer extends StatefulWidget {
  final String? customerId;

  const AddCustomer({super.key, this.customerId});

  @override
  State<AddCustomer> createState() => _AddCustomerState();
}

class _AddCustomerState extends State<AddCustomer> {
  final AddCustomerController controller = Get.put(AddCustomerController());
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (widget.customerId != null) {
        controller.getCustomerDetail(customerId: widget.customerId!);
      } else {
        controller.clear();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Container(
      padding: const EdgeInsets.all(16),
      height: height * 0.9,
      width: width * 0.9,
      child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Column(
            children: [
              const SizedBox(height: 2),
              Container(
                height: 5,
                width: 53,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: AppColors.alert,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 15, right: 8, bottom: 8, top: 20),
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
                        color: AppColors.background,
                        fit: BoxFit.none,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.customerId != null
                              ? 'Edit Customer'
                              : 'Add Customer',
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 24,
                              color: AppColors.secondary),
                        ),
                        Text(
                          widget.customerId != null
                              ? 'Edit customer details'
                              : 'Add customer details',
                          style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 14,
                              color: AppColors.icon),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: height * 0.02),

              // Customer Name
              _buildFormTextField(controller.nameController, "Customer Name",
                      (value) {
                    if (value == null || value.trim().isEmpty) {
                      return "Customer name is required";
                    }
                    return null;
                  }),

              SizedBox(height: height * 0.02),

              // Mobile Number
              _buildFormTextField(controller.phoneController, "Mobile Number",
                      (value) {
                    if (value == null || value.trim().isEmpty) {
                      return "Mobile number is required";
                    }
                    if (value.trim().length != 10) {
                      return "Enter a valid 10-digit number";
                    }
                    return null;
                  }, keyboardType: TextInputType.phone),

              SizedBox(height: height * 0.02),

              // Company Type Dropdown
              Obx(() => _buildDropdown(
                width,
                'Company Type',
                controller.selectedCompanyType.value,
                controller.companyTypes,
                    (String? newValue) {
                  controller.selectedCompanyType.value = newValue;
                },
              )),
              SizedBox(height: height * 0.02),

              // Aadhar Number
              _buildFormTextField(controller.aadharController, "Aadhar Number",
                      (value) {
                    if (value == null || value.trim().isEmpty) {
                      return "Aadhar number is required";
                    }
                    return null;
                  }, keyboardType: TextInputType.number),

              SizedBox(height: height * 0.02),

              // GST Number (Optional)
              _buildFormTextField(
                  controller.gstController, "GST Number (Optional)", null),

              SizedBox(height: height * 0.02),

              // Products Selection
              Container(
                width: width * 0.9,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: AppColors.primary, width: 1),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Select Products',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: AppColors.text)),
                    const SizedBox(height: 8),
                    Obx(() => Wrap(
                      spacing: 8.0,
                      runSpacing: 8.0,
                      children: controller.products.map((product) {
                        bool isSelected =
                        controller.isProductSelected(product);
                        return GestureDetector(
                          onTap: () =>
                              controller.toggleProductSelection(product),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 8),
                            decoration: BoxDecoration(
                              color: isSelected
                                  ? AppColors.primary
                                  : Colors.transparent,
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(
                                color: isSelected
                                    ? AppColors.primary
                                    : AppColors.icon,
                                width: 1,
                              ),
                            ),
                            child: Text(
                              product,
                              style: TextStyle(
                                color: isSelected
                                    ? Colors.white
                                    : AppColors.text,
                                fontSize: 14,
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    )),
                  ],
                ),
              ),
              SizedBox(height: height * 0.02),

              // Time Period
              _buildFormTextField(controller.timePeriodController,
                  "Time Period (e.g., 30 days)", (value) {
                    if (value == null || value.trim().isEmpty) {
                      return "Time period is required";
                    }
                    return null;
                  }),

              SizedBox(height: height * 0.02),

              // Amount Limit
              _buildFormTextField(
                  controller.amountLimitController, "Amount Limit", (value) {
                if (value == null || value.trim().isEmpty) {
                  return "Amount limit is required";
                }
                return null;
              }, keyboardType: TextInputType.number),

              SizedBox(height: height * 0.02),

              // Interest Rate
              _buildFormTextField(
                  controller.interestRateController, "Interest Rate (%)",
                      (value) {
                    if (value == null || value.trim().isEmpty) {
                      return "Interest rate is required";
                    }
                    return null;
                  }, keyboardType: const TextInputType.numberWithOptions(decimal: true)),

              SizedBox(height: height * 0.02),

              // ✅ Aadhar Card Images (UPDATED)
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Row(
                  children: [
                    Obx(() => GestureDetector(
                      onTap: () => _pickImage(true),
                      child: _imageUploadBox(
                        width,
                        controller.aadharFrontImage.value,
                        controller.aadharFrontImageUrl.value,
                        "Aadhar Card Front",
                      ),
                    )),
                    const SizedBox(width: 10),
                    Obx(() => GestureDetector(
                      onTap: () => _pickImage(false),
                      child: _imageUploadBox(
                        width,
                        controller.aadharBackImage.value,
                        controller.aadharBackImageUrl.value,
                        "Aadhar Card Back",
                      ),
                    )),
                  ],
                ),
              ),

              SizedBox(height: height * 0.04),

              // Signature Pad
              Container(
                width: width * 0.9,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: AppColors.primary, width: 1),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Digital Signature",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: AppColors.text,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Container(
                      height: 180,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: AppColors.icon, width: 1),
                        color: Colors.white,
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Signature(
                          controller: controller.signatureController,
                          backgroundColor: Colors.white,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              controller.signatureController.clear();
                              controller.signatureBytes.value = null;
                              controller.isSignatureAdded.value = false;
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.grey.shade400,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            child: const Text("Clear"),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () async {
                              await controller.saveSignature();
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.primary,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            child: const Text("Save"),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Obx(() => controller.isSignatureAdded.value
                        ? Text(
                      "✅ Signature Added",
                      style: TextStyle(
                          color: AppColors.primary,
                          fontWeight: FontWeight.w500),
                    )
                        : Text(
                      "Please sign above",
                      style:
                      TextStyle(color: Colors.grey.shade600),
                    )),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // Add Customer Button
              Obx(() => SizedBox(
                height: 60,
                width: width * 0.9,
                child: ElevatedButton(
                  onPressed: controller.isLoading.value
                      ? null
                      : () {
                    if (_formKey.currentState!.validate()) {
                      controller.addCustomer();
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.button,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: controller.isLoading.value
                      ? CircularProgressIndicator(
                      color: AppColors.background)
                      : Text(
                    widget.customerId != null
                        ? "Update Customer"
                        : "Add Customer",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        color: AppColors.background),
                  ),
                ),
              )),
              SizedBox(height: height * 0.02),
            ],
          ),
        ),
      ),
    );
  }

  // ===================== DROPDOWN =====================
  Widget _buildDropdown(double width, String hint, String? currentValue,
      List<String> items, Function(String?) onChanged) {
    return Container(
      height: 60,
      width: width * 0.9,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.primary, width: 1),
      ),
      child: DropdownButton<String>(
        value: currentValue,
        isExpanded: true,
        hint: Padding(
          padding: const EdgeInsets.only(left: 10),
          child: Text(hint,
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: AppColors.text)),
        ),
        icon: Padding(
          padding: const EdgeInsets.only(right: 20),
          child: SvgPicture.asset('assets/images/Arrow.svg',
              width: 11, height: 15),
        ),
        style: const TextStyle(fontSize: 16, color: Colors.black),
        underline: const SizedBox(),
        items: items.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Text(value)),
          );
        }).toList(),
        onChanged: onChanged,
      ),
    );
  }

  // ===================== TEXT FIELD =====================
  Widget _buildFormTextField(TextEditingController controller, String label,
      String? Function(String?)? validator,
      {TextInputType? keyboardType}) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.9,
      child: TextFormField(
        controller: controller,
        validator: validator,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          labelText: label,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: AppColors.primary, width: 1),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: AppColors.primary, width: 1.5),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Colors.red, width: 1.5),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Colors.red, width: 1.5),
          ),
        ),
      ),
    );
  }

  // ===================== IMAGE BOX (UPDATED) =====================
  Widget _imageUploadBox(
      double width,
      File? imageFile,
      String imageUrl,
      String label,
      ) {
    return Container(
      height: 110,
      width: width * 0.4,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.primary, width: 1),
        color: (imageFile != null || imageUrl.isNotEmpty)
            ? AppColors.primary.withOpacity(0.1)
            : Colors.transparent,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (imageFile != null)
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.file(
                imageFile,
                height: 60,
                width: 100,
                fit: BoxFit.cover,
              ),
            )
          else if (imageUrl.isNotEmpty)
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                APIEndPoints.imageBaseUrl + imageUrl,
                height: 60,
                width: 100,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Icon(Icons.image_not_supported,
                      color: Colors.red, size: 30);
                },
              ),
            )
          else
            SvgPicture.asset('assets/images/Camera.svg'),

          const SizedBox(height: 6),

          Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 12,
              color: AppColors.text,
            ),
          ),
        ],
      ),
    );
  }

  // ===================== PICK IMAGE =====================
  Future<void> _pickImage(bool isFront) async {
    try {
      final ImagePicker picker = ImagePicker();
      final XFile? image = await picker.pickImage(source: ImageSource.gallery);

      if (image != null) {
        File imageFile = File(image.path);

        if (isFront) {
          controller.setAadharFrontImage(imageFile);

          // ✅ agar user new image select kare to old url clear kar do
          controller.aadharFrontImageUrl.value = '';
        } else {
          controller.setAadharBackImage(imageFile);
          controller.aadharBackImageUrl.value = '';
        }

        setState(() {});
      }
    } catch (e) {
      Appdialogs.showToast("Error selecting image: ${e.toString()}");
    }
  }
}