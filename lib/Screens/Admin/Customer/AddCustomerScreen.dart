// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:petrolpump/controllers/CustomerController.dart';
// import 'package:petrolpump/models/CustomerModel/CustomerDetailModel.dart';
// import '../../../Utils/colors.dart';
//
// class AddCustomerScreen extends StatefulWidget {
//   final CustomerDetailData? customer;
//   final bool isEditMode;
//
//   const AddCustomerScreen({
//     Key? key,
//     this.customer,
//     this.isEditMode = false,
//   }) : super(key: key);
//
//   @override
//   _AddCustomerScreenState createState() => _AddCustomerScreenState();
// }
//
// class _AddCustomerScreenState extends State<AddCustomerScreen> {
//   final CustomerController controller = Get.find<CustomerController>();
//   final _formKey = GlobalKey<FormState>();
//   final ImagePicker picker = ImagePicker();
//
//   // Temporary variables for image preview
//   File? _tempFrontImage;
//   File? _tempBackImage;
//
//   @override
//   void initState() {
//     super.initState();
//     if (widget.isEditMode && widget.customer != null) {
//       WidgetsBinding.instance.addPostFrameCallback((_) {
//         controller.loadCustomerForEdit(widget.customer!);
//       });
//     } else {
//       // Clear form when adding new customer
//       controller.clearFormData();
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: MediaQuery.of(context).size.height * 0.9,
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
//       ),
//       child: SafeArea(
//         top: false,
//         child: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Column(
//             children: [
//               // Header
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   IconButton(
//                     icon: Icon(Icons.close),
//                     onPressed: () => Get.back(),
//                   ),
//                   Text(
//                     widget.isEditMode ? 'Edit Customer' : 'Add New Customer',
//                     style: TextStyle(
//                       fontSize: 18,
//                       fontWeight: FontWeight.bold,
//                       color: AppColors.primary,
//                     ),
//                   ),
//                   SizedBox(width: 48), // For balance
//                 ],
//               ),
//
//               Expanded(
//                 child: SingleChildScrollView(
//                   child: Form(
//                     key: _formKey,
//                     child: Column(
//                       children: [
//                         SizedBox(height: 20),
//
//                         // Name Field
//                         _buildTextField(
//                           label: 'Full Name *',
//                           controller: controller.nameController,
//                           hintText: 'Enter customer name',
//                           validator: (value) {
//                             if (value == null || value.isEmpty) {
//                               return 'Please enter name';
//                             }
//                             if (value.length < 2) {
//                               return 'Name must be at least 2 characters';
//                             }
//                             return null;
//                           },
//                         ),
//
//                         SizedBox(height: 16),
//
//                         // Phone Field
//                         _buildTextField(
//                           label: 'Phone Number *',
//                           controller: controller.phoneController,
//                           hintText: 'Enter 10-digit phone number',
//                           keyboardType: TextInputType.phone,
//                           validator: (value) {
//                             if (value == null || value.isEmpty) {
//                               return 'Please enter phone number';
//                             }
//                             if (!RegExp(r'^[0-9]{10}$').hasMatch(value)) {
//                               return 'Enter valid 10-digit phone number';
//                             }
//                             return null;
//                           },
//                         ),
//
//                         SizedBox(height: 16),
//
//                         // Aadhar Field
//                         _buildTextField(
//                           label: 'Aadhar Number *',
//                           controller: controller.aadharController,
//                           hintText: 'Enter 12-digit aadhar number',
//                           keyboardType: TextInputType.number,
//                           validator: (value) {
//                             if (value == null || value.isEmpty) {
//                               return 'Please enter aadhar number';
//                             }
//                             if (!RegExp(r'^[0-9]{12}$').hasMatch(value)) {
//                               return 'Enter valid 12-digit aadhar number';
//                             }
//                             return null;
//                           },
//                         ),
//
//                         SizedBox(height: 16),
//
//                         // Products Selection
//                         _buildProductsSelection(),
//
//                         SizedBox(height: 24),
//
//                         // Aadhar Images Section
//                         _buildImageSection(),
//
//                         SizedBox(height: 32),
//
//                         // Save Button
//                         Obx(() => ElevatedButton(
//                           onPressed: controller.isSavingCustomer.value
//                               ? null
//                               : _saveCustomer,
//                           style: ElevatedButton.styleFrom(
//                             backgroundColor: AppColors.primary,
//                             minimumSize: Size(double.infinity, 50),
//                             shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(8),
//                             ),
//                           ),
//                           child: controller.isSavingCustomer.value
//                               ? SizedBox(
//                             height: 20,
//                             width: 20,
//                             child: CircularProgressIndicator(
//                               strokeWidth: 2,
//                               valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
//                             ),
//                           )
//                               : Text(
//                             widget.isEditMode ? 'Update Customer' : 'Save Customer',
//                             style: TextStyle(
//                               fontSize: 16,
//                               fontWeight: FontWeight.bold,
//                               color: Colors.white,
//                             ),
//                           ),
//                         )),
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget _buildTextField({
//     required String label,
//     required TextEditingController controller,
//     required String hintText,
//     TextInputType keyboardType = TextInputType.text,
//     String? Function(String?)? validator,
//   }) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           label,
//           style: TextStyle(
//             fontSize: 14,
//             fontWeight: FontWeight.w500,
//             color: Colors.grey[700],
//           ),
//         ),
//         SizedBox(height: 8),
//         TextFormField(
//           controller: controller,
//           keyboardType: keyboardType,
//           decoration: InputDecoration(
//             hintText: hintText,
//             border: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(8),
//               borderSide: BorderSide(color: Colors.grey[300]!),
//             ),
//             filled: true,
//             fillColor: Colors.grey[50],
//           ),
//           validator: validator,
//         ),
//       ],
//     );
//   }
//
//   Widget _buildProductsSelection() {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           'Select Products *',
//           style: TextStyle(
//             fontSize: 14,
//             fontWeight: FontWeight.w500,
//             color: Colors.grey[700],
//           ),
//         ),
//         SizedBox(height: 8),
//         Obx(() => Wrap(
//           spacing: 8,
//           runSpacing: 8,
//           children: controller.allProducts.map((productId) {
//             bool isSelected = controller.selectedProducts.contains(productId);
//             return ChoiceChip(
//               label: Text('Product $productId'),
//               selected: isSelected,
//               onSelected: (selected) {
//                 controller.toggleProduct(productId);
//               },
//               backgroundColor: isSelected ? AppColors.primary : Colors.grey[200],
//               labelStyle: TextStyle(
//                 color: isSelected ? Colors.white : Colors.black,
//               ),
//               selectedColor: AppColors.primary,
//             );
//           }).toList(),
//         )),
//         SizedBox(height: 4),
//         Obx(() => controller.selectedProducts.isEmpty
//             ? Text(
//           'Please select at least one product',
//           style: TextStyle(
//             fontSize: 12,
//             color: Colors.red,
//           ),
//         )
//             : SizedBox()),
//       ],
//     );
//   }
//
//   Widget _buildImageSection() {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           'Aadhar Card Images (Optional)',
//           style: TextStyle(
//             fontSize: 14,
//             fontWeight: FontWeight.w500,
//             color: Colors.grey[700],
//           ),
//         ),
//         SizedBox(height: 12),
//         Row(
//           children: [
//             Expanded(
//               child: _buildImageUploadButton(
//                 label: 'Front Side',
//                 image: controller.aadharFrontImage.value ?? _tempFrontImage,
//                 onPick: () async {
//                   final pickedFile = await picker.pickImage(source: ImageSource.gallery);
//                   if (pickedFile != null) {
//                     setState(() {
//                       _tempFrontImage = File(pickedFile.path);
//                     });
//                     controller.aadharFrontImage.value = File(pickedFile.path);
//                   }
//                 },
//                 onClear: () {
//                   setState(() {
//                     _tempFrontImage = null;
//                   });
//                   controller.clearAadharFrontImage();
//                 },
//               ),
//             ),
//             SizedBox(width: 16),
//             Expanded(
//               child: _buildImageUploadButton(
//                 label: 'Back Side',
//                 image: controller.aadharBackImage.value ?? _tempBackImage,
//                 onPick: () async {
//                   final pickedFile = await picker.pickImage(source: ImageSource.gallery);
//                   if (pickedFile != null) {
//                     setState(() {
//                       _tempBackImage = File(pickedFile.path);
//                     });
//                     controller.aadharBackImage.value = File(pickedFile.path);
//                   }
//                 },
//                 onClear: () {
//                   setState(() {
//                     _tempBackImage = null;
//                   });
//                   controller.clearAadharBackImage();
//                 },
//               ),
//             ),
//           ],
//         ),
//         SizedBox(height: 8),
//         Text(
//           'Note: Images should be clear and readable',
//           style: TextStyle(
//             fontSize: 12,
//             color: Colors.grey[600],
//             fontStyle: FontStyle.italic,
//           ),
//         ),
//       ],
//     );
//   }
//
//   Widget _buildImageUploadButton({
//     required String label,
//     required File? image,
//     required VoidCallback onPick,
//     required VoidCallback onClear,
//   }) {
//     return Column(
//       children: [
//         Container(
//           height: 120,
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(8),
//             border: Border.all(
//               color: Colors.grey[300]!,
//               width: 1,
//             ),
//             color: Colors.grey[50],
//           ),
//           child: image != null
//               ? Stack(
//             children: [
//               ClipRRect(
//                 borderRadius: BorderRadius.circular(8),
//                 child: Image.file(
//                   image,
//                   width: double.infinity,
//                   height: double.infinity,
//                   fit: BoxFit.cover,
//                 ),
//               ),
//               Positioned(
//                 top: 4,
//                 right: 4,
//                 child: Container(
//                   decoration: BoxDecoration(
//                     color: Colors.black54,
//                     shape: BoxShape.circle,
//                   ),
//                   child: IconButton(
//                     icon: Icon(Icons.close, color: Colors.white, size: 16),
//                     onPressed: onClear,
//                   ),
//                 ),
//               ),
//             ],
//           )
//               : Center(
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Icon(Icons.camera_alt, color: Colors.grey[400], size: 32),
//                 SizedBox(height: 8),
//                 Text(
//                   label,
//                   style: TextStyle(
//                     fontSize: 12,
//                     color: Colors.grey[600],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//         SizedBox(height: 8),
//         ElevatedButton(
//           onPressed: onPick,
//           style: ElevatedButton.styleFrom(
//             backgroundColor: Colors.grey[100],
//             foregroundColor: Colors.grey[700],
//             minimumSize: Size(double.infinity, 36),
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(6),
//             ),
//           ),
//           child: Text(
//             image != null ? 'Change $label' : 'Upload $label',
//             style: TextStyle(fontSize: 12),
//           ),
//         ),
//       ],
//     );
//   }
//
//   void _saveCustomer() {
//     if (_formKey.currentState!.validate()) {
//       if (controller.selectedProducts.isEmpty) {
//         Get.snackbar(
//           'Error',
//           'Please select at least one product',
//           snackPosition: SnackPosition.BOTTOM,
//           backgroundColor: Colors.red,
//           colorText: Colors.white,
//         );
//         return;
//       }
//
//       if (widget.isEditMode && widget.customer?.id != null) {
//         controller.saveOrUpdateCustomer(
//           customerId: widget.customer!.id!,
//           name: controller.nameController.text.trim(),
//           phone: controller.phoneController.text.trim(),
//           aadharNumber: controller.aadharController.text.trim(),
//           products: controller.selectedProducts,
//         );
//       } else {
//         controller.addCustomer(
//           name: controller.nameController.text.trim(),
//           phone: controller.phoneController.text.trim(),
//           aadharNumber: controller.aadharController.text.trim(),
//           products: controller.selectedProducts,
//         );
//       }
//     }
//   }
//
//   @override
//   void dispose() {
//     // Clear temporary images when screen is closed
//     _tempFrontImage = null;
//     _tempBackImage = null;
//     super.dispose();
//   }
// }

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../Utils/colors.dart';
import '../../../controllers/CustomerController.dart';
import '../../../models/CustomerModel/CustomerDetailModel.dart';

class AddCustomerScreen extends StatefulWidget {
  final CustomerDetailData? customer;
  final bool isEditMode;

  const AddCustomerScreen({
    Key? key,
    this.customer,
    this.isEditMode = false,
  }) : super(key: key);

  @override
  _AddCustomerScreenState createState() => _AddCustomerScreenState();
}

class _AddCustomerScreenState extends State<AddCustomerScreen> {
  final CustomerController controller = Get.find<CustomerController>();
  final _formKey = GlobalKey<FormState>();
  final ImagePicker picker = ImagePicker();

  // Temporary variables for image preview
  File? _tempFrontImage;
  File? _tempBackImage;

  @override
  void initState() {
    super.initState();
    if (widget.isEditMode && widget.customer != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        controller.loadCustomerForEdit(widget.customer!);
      });
    } else {
      // Clear form when adding new customer
      controller.clearFormData();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.9,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              // Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: Icon(Icons.close),
                    onPressed: () => Get.back(),
                  ),
                  Text(
                    widget.isEditMode ? 'Edit Customer' : 'Add New Customer',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primary,
                    ),
                  ),
                  SizedBox(width: 48),
                ],
              ),

              Expanded(
                child: SingleChildScrollView(
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        SizedBox(height: 20),

                        // Product Info (Static)
                        Container(
                          padding: EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: AppColors.primary.withOpacity(0.05),
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: AppColors.primary.withOpacity(0.2)),
                          ),
                          child: Row(
                            children: [
                              Icon(Icons.check_circle, color: Colors.green, size: 20),
                              SizedBox(width: 10),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Default Product',
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                        color: AppColors.primary,
                                      ),
                                    ),
                                    SizedBox(height: 2),
                                    Text(
                                      'Product ID: 1',
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.grey[600],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),

                        SizedBox(height: 16),

                        // Name Field
                        _buildTextField(
                          label: 'Full Name *',
                          controller: controller.nameController,
                          hintText: 'Enter customer name',
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter name';
                            }
                            if (value.length < 2) {
                              return 'Name must be at least 2 characters';
                            }
                            return null;
                          },
                        ),

                        SizedBox(height: 16),

                        // Phone Field
                        _buildTextField(
                          label: 'Phone Number *',
                          controller: controller.phoneController,
                          hintText: 'Enter 10-digit phone number',
                          keyboardType: TextInputType.phone,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter phone number';
                            }
                            if (!RegExp(r'^[0-9]{10}$').hasMatch(value)) {
                              return 'Enter valid 10-digit phone number';
                            }
                            return null;
                          },
                        ),

                        SizedBox(height: 16),

                        // Aadhar Field
                        _buildTextField(
                          label: 'Aadhar Number *',
                          controller: controller.aadharController,
                          hintText: 'Enter 12-digit aadhar number',
                          keyboardType: TextInputType.number,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter aadhar number';
                            }
                            if (!RegExp(r'^[0-9]{12}$').hasMatch(value)) {
                              return 'Enter valid 12-digit aadhar number';
                            }
                            return null;
                          },
                        ),

                        SizedBox(height: 24),

                        // Aadhar Images Section
                        _buildImageSection(),

                        SizedBox(height: 32),

                        // Save Button
                        Obx(() => ElevatedButton(
                          onPressed: controller.isSavingCustomer.value
                              ? null
                              : _saveCustomer,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primary,
                            minimumSize: Size(double.infinity, 50),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: controller.isSavingCustomer.value
                              ? SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                            ),
                          )
                              : Text(
                            widget.isEditMode ? 'Update Customer' : 'Save Customer',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        )),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required String label,
    required TextEditingController controller,
    required String hintText,
    TextInputType keyboardType = TextInputType.text,
    String? Function(String?)? validator,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Colors.grey[700],
          ),
        ),
        SizedBox(height: 8),
        TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          decoration: InputDecoration(
            hintText: hintText,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Colors.grey[300]!),
            ),
            filled: true,
            fillColor: Colors.grey[50],
          ),
          validator: validator,
        ),
      ],
    );
  }

  Widget _buildImageSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Aadhar Card Images (Optional)',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Colors.grey[700],
          ),
        ),
        SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: _buildImageUploadButton(
                label: 'Front Side',
                image: controller.aadharFrontImage.value ?? _tempFrontImage,
                onPick: () async {
                  final pickedFile = await picker.pickImage(source: ImageSource.gallery);
                  if (pickedFile != null) {
                    setState(() {
                      _tempFrontImage = File(pickedFile.path);
                    });
                    controller.aadharFrontImage.value = File(pickedFile.path);
                  }
                },
                onClear: () {
                  setState(() {
                    _tempFrontImage = null;
                  });
                  controller.clearAadharFrontImage();
                },
              ),
            ),
            SizedBox(width: 16),
            Expanded(
              child: _buildImageUploadButton(
                label: 'Back Side',
                image: controller.aadharBackImage.value ?? _tempBackImage,
                onPick: () async {
                  final pickedFile = await picker.pickImage(source: ImageSource.gallery);
                  if (pickedFile != null) {
                    setState(() {
                      _tempBackImage = File(pickedFile.path);
                    });
                    controller.aadharBackImage.value = File(pickedFile.path);
                  }
                },
                onClear: () {
                  setState(() {
                    _tempBackImage = null;
                  });
                  controller.clearAadharBackImage();
                },
              ),
            ),
          ],
        ),
        SizedBox(height: 8),
        Text(
          'Note: Images should be clear and readable',
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey[600],
            fontStyle: FontStyle.italic,
          ),
        ),
      ],
    );
  }

  Widget _buildImageUploadButton({
    required String label,
    required File? image,
    required VoidCallback onPick,
    required VoidCallback onClear,
  }) {
    return Column(
      children: [
        Container(
          height: 120,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: Colors.grey[300]!,
              width: 1,
            ),
            color: Colors.grey[50],
          ),
          child: image != null
              ? Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.file(
                  image,
                  width: double.infinity,
                  height: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                top: 4,
                right: 4,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.black54,
                    shape: BoxShape.circle,
                  ),
                  child: IconButton(
                    icon: Icon(Icons.close, color: Colors.white, size: 16),
                    onPressed: onClear,
                  ),
                ),
              ),
            ],
          )
              : Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.camera_alt, color: Colors.grey[400], size: 32),
                SizedBox(height: 8),
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: 8),
        ElevatedButton(
          onPressed: onPick,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.grey[100],
            foregroundColor: Colors.grey[700],
            minimumSize: Size(double.infinity, 36),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(6),
            ),
          ),
          child: Text(
            image != null ? 'Change $label' : 'Upload $label',
            style: TextStyle(fontSize: 12),
          ),
        ),
      ],
    );
  }

  void _saveCustomer() {
    if (_formKey.currentState!.validate()) {
      // Always use product "1" for all customers
      List<String> products = ['1'];

      if (widget.isEditMode && widget.customer?.id != null) {
        controller.saveOrUpdateCustomer(
          customerId: widget.customer!.id!,
          name: controller.nameController.text.trim(),
          phone: controller.phoneController.text.trim(),
          aadharNumber: controller.aadharController.text.trim(),
          products: products, // Always pass ['1']
        );
      } else {
        controller.addCustomer(
          name: controller.nameController.text.trim(),
          phone: controller.phoneController.text.trim(),
          aadharNumber: controller.aadharController.text.trim(),
          products: products, // Always pass ['1']
        );
      }
    }
  }

  @override
  void dispose() {
    // Clear temporary images when screen is closed
    _tempFrontImage = null;
    _tempBackImage = null;
    super.dispose();
  }
}