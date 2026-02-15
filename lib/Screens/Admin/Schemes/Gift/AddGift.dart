import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import '../../../../Utils/colors.dart';
import '../../../../controllers/AdminController/GiftController.dart';


class AddGift extends StatefulWidget {
  const AddGift({super.key});

  @override
  State<AddGift> createState() => _AddGiftState();
}

class _AddGiftState extends State<AddGift> {
  final GiftController giftController = Get.put(GiftController());
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final keyboardHeight = MediaQuery.of(context).viewInsets.bottom;

    return Stack(
      clipBehavior: Clip.none,
      children: [
        SingleChildScrollView(
          padding: EdgeInsets.only(bottom: keyboardHeight),
          child: Container(
            width: screenSize.width * 0.99,
            padding: const EdgeInsets.all(16),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      SvgPicture.asset('assets/images/AddGift.svg'),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              giftController.getFormTitle(),
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 24,
                                color: AppColors.secondary,
                              ),
                            ),
                            Text(
                              giftController.isEditMode.value
                                  ? 'Update gift details'
                                  : 'Enter All Gift Items',
                              style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 14,
                                color: AppColors.icon,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 40),

                  // Gift Name Field
                  SizedBox(
                    width: screenSize.width * 0.9,
                    child: TextFormField(
                      controller: giftController.nameController,
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Gift name is required';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        labelText: "Enter Gift Name",
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: AppColors.primary, width: 1),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: AppColors.secondary, width: 2),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: Colors.red, width: 1.5),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: Colors.red, width: 2),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Gift Type Dropdown
                  SizedBox(
                    width: screenSize.width * 0.9,
                    child: DropdownButtonFormField<String>(
                      value: giftController.selectedGiftType.value,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please select gift type';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        labelText: "Select Gift Type",
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: AppColors.primary, width: 1),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: AppColors.secondary, width: 2),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: Colors.red, width: 1.5),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: Colors.red, width: 2),
                        ),
                      ),
                      items: giftController.giftTypes.map((type) {
                        return DropdownMenuItem<String>(
                          value: type['value'],
                          child: Text(type['label']!),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        giftController.updateGiftType(newValue);
                      },
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Gift Quantity Field (Optional)
                  SizedBox(
                    width: screenSize.width * 0.9,
                    child: TextFormField(
                      controller: giftController.quantityController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: "Gift Quantity (Optional)",
                        hintText: "Enter quantity if applicable",
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: AppColors.primary, width: 1),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: AppColors.secondary, width: 2),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: Colors.red, width: 1.5),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: Colors.red, width: 2),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Submit Button with Loading State
                  Obx(() => SizedBox(
                    height: 60,
                    width: screenSize.width * 0.9,
                    child: ElevatedButton(
                      onPressed: giftController.isAddLoading.value || giftController.isUpdateLoading.value
                          ? null
                          : () async {
                        if (_formKey.currentState!.validate()) {
                          bool success = await giftController.submitForm();
                          if (success && mounted) {
                            Navigator.pop(context);
                          }
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.button,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: (giftController.isAddLoading.value || giftController.isUpdateLoading.value)
                          ? CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(AppColors.background),
                      )
                          : Text(
                        giftController.getSubmitButtonText(),
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                          color: AppColors.background,
                        ),
                      ),
                    ),
                  )),
                ],
              ),
            ),
          ),
        ),

        // X Icon to dismiss
        Positioned(
          top: -80,
          left: screenSize.width * 0.5 - 30,
          child: GestureDetector(
            onTap: () {
              Navigator.pop(context);
              giftController.clearForm();
            },
            child: const CircleAvatar(
              radius: 30,
              backgroundColor: Colors.black54,
              child: Icon(Icons.close, size: 40, color: Colors.white),
            ),
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    giftController.clearForm();
    super.dispose();
  }
}