
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import '../../../controllers/AdminController/AddSchemeController.dart';
import '../../../controllers/AdminController/GiftController.dart';
import '../../../utils/colors.dart';
import 'CreateNewSchemesName.dart';

class AddSchemes extends StatefulWidget {
  final String? schemeId;
  const AddSchemes({Key? key, this.schemeId}) : super(key: key);

  @override
  State<AddSchemes> createState() => _AddSchemesState();
}

class _AddSchemesState extends State<AddSchemes> {
  late AddSchemeController controller;
  final GiftController giftController = Get.put(GiftController());
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    controller = Get.put(AddSchemeController());

    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.getSchemeName();
      controller.getVehicleTypes();
      controller.getProductTypes();
      giftController.getGiftsList(); // Fetch gifts from API

      // If schemeId is provided, load scheme details for editing
      if (widget.schemeId != null) {
        controller.getSchemeDetail(schemeId: widget.schemeId!);
      } else {
        // Clear form for new scheme
        controller.clearForm();
      }
    });
  }

  String? _validateDropdown(String? value, String fieldName) {
    if (value == null || value.isEmpty) {
      return 'Please select $fieldName';
    }
    return null;
  }

  String? _validateTextField(String? value, String fieldName) {
    if (value == null || value.trim().isEmpty) {
      return 'Please enter $fieldName';
    }
    if (value.trim().length < 2) {
      return '$fieldName must be at least 2 characters long';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final width = screenSize.width;
    final height = screenSize.height;

    return Container(
      height: height * 0.8,
      width: width,
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Row(
                  children: [
                    SvgPicture.asset('assets/images/AddSchemes.svg'),
                    SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.schemeId != null ? 'Edit Scheme' : 'Add Schemes',
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 24,
                                color: AppColors.secondary),
                          ),
                          Text(
                            'Enter all the schemes requirement details.',
                            style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 14,
                                color: AppColors.icon),
                          ),
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          shape: RoundedRectangleBorder(
                            borderRadius:
                            BorderRadius.vertical(top: Radius.circular(16)),
                          ),
                          builder: (context) {
                            return CreateNewSchemesName();
                          },
                        );
                      },
                      child: Column(
                        children: [
                          SvgPicture.asset('assets/images/Addicon.svg',
                              width: 40, height: 40),
                          SizedBox(height: 10),
                          Text(
                            'Create Scheme Name',
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: AppColors.icon),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Obx(() {
                final hasData =
                    controller.getSchemeNameListModel.value.data != null &&
                        controller.getSchemeNameListModel.value.data!.isNotEmpty;

                final schemeNamesList = hasData
                    ? controller.getSchemeNameListModel.value.data!
                    .map((e) => e.name ?? '')
                    .toList()
                    : <String>[];

                final schemeNameToIdMap = <String, String>{};
                if (hasData) {
                  controller.getSchemeNameListModel.value.data!.forEach((scheme) {
                    if (scheme.name != null && scheme.id != null) {
                      schemeNameToIdMap[scheme.name!] = scheme.id!;
                    }
                  });
                }

                return _buildDropdown(
                  'Scheme Names',
                  controller.selectedSchemeName.value.isEmpty
                      ? null
                      : controller.selectedSchemeName.value,
                  schemeNamesList,
                      (value) {
                    if (value != null) {
                      controller.selectedSchemeName.value = value;

                      final id = schemeNameToIdMap[value];
                      if (id != null) {
                        controller.selectedSchemeId.value = id;
                      }
                    }
                  },
                );
              }),
              SizedBox(height: 20),
              _buildDropdown(
                'Vehicle Type',
                controller.selectedVehicleType.value.isEmpty
                    ? null
                    : controller.selectedVehicleType.value,
                controller.vehicleTypes,
                    (value) {
                  if (value != null) {
                    controller.selectedVehicleType.value = value;
                  }
                },
              ),
              SizedBox(height: 20),
              _buildDropdown(
                'Product Type',
                controller.selectedProductType.value.isEmpty
                    ? null
                    : controller.selectedProductType.value,
                controller.productTypes,
                    (value) {
                  if (value != null) {
                    controller.selectedProductType.value = value;
                  }
                },
              ),
              SizedBox(height: 20),
              _buildTextField(
                'Enter New Product Name Only',
                controller: controller.productNameController,
              ),
              SizedBox(height: 20),
              // Gifts Dropdown from API
              Obx(() {
                if (giftController.isLoading.value) {
                  return _buildLoadingDropdown('Gifts');
                }

                final giftsList = giftController.gifts
                    .where((gift) => gift.status == "1") // Only active gifts
                    .map((gift) => gift.name ?? '')
                    .toList();

                // Create a map to get gift ID from name
                final giftNameToIdMap = <String, String>{};
                giftController.gifts.forEach((gift) {
                  if (gift.name != null && gift.id != null) {
                    giftNameToIdMap[gift.name!] = gift.id!;
                  }
                });

                return _buildDropdown(
                  'Gifts',
                  controller.selectedGift.value.isEmpty
                      ? null
                      : controller.selectedGift.value,
                  giftsList,
                      (value) {
                    if (value != null) {
                      controller.selectedGift.value = value;

                      // Also store the gift ID if needed
                      final giftId = giftNameToIdMap[value];
                      if (giftId != null) {
                        controller.selectedGiftId.value = giftId;
                      }
                    }
                  },
                );
              }),
              const SizedBox(height: 20),
              // _buildDropdown(
              //   'Qty',
              //   controller.selectedQty.value.isEmpty
              //       ? null
              //       : controller.selectedQty.value,
              //   ['1', '2', '3', '4'],
              //       (value) {
              //     if (value != null) {
              //       controller.selectedGiftQty.value = value;
              //     }
              //   },
              // ),
              // Fixed Quantity Dropdown
              _buildDropdown(
                'Quantity',
                controller.selectedQty.value.isEmpty
                    ? null
                    : controller.selectedQty.value,
                ['1', '2', '3', '4'],
                    (value) {
                  if (value != null) {
                    controller.selectedQty.value = value; // ✅ Fixed
                    print('Quantity selected: $value'); // Debug print
                  }
                },
              ),
              SizedBox(height: 20),
              Container(
                height: 60,
                width: width * 0.9,
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      // All fields are valid, proceed with adding scheme
                      controller.addScheme();
                      Get.back();
                    } else {
                      // Show error message if validation fails
                      Get.snackbar(
                        'Validation Error',
                        'Please fill all required fields correctly',
                        backgroundColor: Colors.red,
                        colorText: Colors.white,
                        snackPosition: SnackPosition.TOP,
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.button,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text(
                    widget.schemeId != null ? "Update Scheme" : "Add Scheme",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        color: AppColors.background),
                  ),
                ),
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDropdown(String hint, String? value, List<String> items,
      ValueChanged<String?> onChanged, {bool isRequired = true}) {
    // Safety check: ensure value exists in items list
    String? safeValue = value;
    if (value != null && !items.contains(value)) {
      print('Warning: Dropdown value "$value" not found in items for $hint. Setting to null.');
      safeValue = null;
    }

    return DropdownButtonFormField<String>(
      value: safeValue,
      isExpanded: true,
      decoration: InputDecoration(
        labelText: hint,
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
          borderSide: BorderSide(color: Colors.red, width: 1),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.red, width: 1.5),
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
      ),
      hint: Text(
        hint,
        style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w400,
            color: AppColors.text),
      ),
      icon: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SvgPicture.asset(
          'assets/images/Arrow.svg',
          width: 11,
          height: 15,
        ),
      ),
      style: TextStyle(fontSize: 16, color: Colors.black),
      items: items.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
      onChanged: onChanged,
      validator: isRequired ? (value) => _validateDropdown(value, hint) : null,
    );

  }


  Widget _buildLoadingDropdown(String hint) {
    return DropdownButtonFormField<String>(
      value: null,
      isExpanded: true,
      decoration: InputDecoration(
        labelText: hint,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: AppColors.primary, width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: AppColors.primary, width: 1.5),
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
        suffixIcon: Padding(
          padding: const EdgeInsets.all(10.0),
          child: SizedBox(
            width: 14,
            height: 14,
            child: CircularProgressIndicator(
              strokeWidth: 1.5,
              valueColor: AlwaysStoppedAnimation<Color>(AppColors.primary),
            ),
          ),
        ),
      ),
      hint: Text(
        'Loading gifts...',
        style: TextStyle(
          fontSize: 16,
          color: AppColors.text.withOpacity(0.6),
        ),
      ),
      icon: SvgPicture.asset(
        'assets/images/Arrow.svg',
        width: 11,
        height: 15,
      ),
      items: [],
      onChanged: null,
    );
  }

  Widget _buildTextField(String label, {TextEditingController? controller, bool isRequired = true}) {
    return SizedBox(
      width: double.infinity,
      child: TextFormField(
        controller: controller,
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
            borderSide: BorderSide(color: Colors.red, width: 1),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.red, width: 1.5),
          ),
          contentPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
        ),
        validator: isRequired ? (value) => _validateTextField(value, label) : null,
      ),
    );
  }
}
