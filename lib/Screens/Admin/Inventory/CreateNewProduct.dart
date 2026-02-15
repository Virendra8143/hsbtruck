import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../controllers/AdminController/CreateProductController.dart';
import '../../../utils/colors.dart';

class CreateNewProduct extends StatefulWidget {
  const CreateNewProduct({super.key});

  @override
  State<CreateNewProduct> createState() => _CreateNewProductState();
}

class _CreateNewProductState extends State<CreateNewProduct> {
  final CreateProductController productController = Get.put(CreateProductController());
  final _formKey = GlobalKey<FormState>(); // Form key for validation

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final screenWidth = mediaQuery.size.width;
    final keyboardHeight = mediaQuery.viewInsets.bottom;

    return Stack(
      clipBehavior: Clip.none,
      children: [
        SingleChildScrollView(
          padding: EdgeInsets.only(bottom: keyboardHeight),
          child: Container(
            width: screenWidth * 0.99,
            padding: const EdgeInsets.all(16),
            child: Form(
              key: _formKey, // Attach form key
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      SvgPicture.asset('assets/images/CreateProducticon.svg'),
                      const SizedBox(width: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Create New Product',
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 24,
                                color: AppColors.secondary),
                          ),
                          Text(
                            'Create and add a new product type',
                            style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 14,
                                color: AppColors.icon),
                          )
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 40),

                  // Product Name Input with Validation and Borders
                  SizedBox(
                    width: screenWidth * 0.95,
                    child: TextFormField(
                      controller: productController.nameController,
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Product name is required';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        labelText: "Enter New Product Name Only",
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
                          borderSide: const BorderSide(color: Colors.red, width: 1.5),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(color: Colors.red, width: 2),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  const SizedBox(height: 20),

                  // Create Now Button
                  Obx(() {
                    return SizedBox(
                      height: 60,
                      width: screenWidth * 0.95,
                      child: ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            productController.createProductName(
                              name: productController.nameController.text.trim(),
                            );
                            // Reset unit of measure selection
                            productController.selectedUnitOfMeasure.value = 'Litre';
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.button,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: productController.isLoading.value
                            ? const CircularProgressIndicator(color: Colors.white)
                            : Text(
                          "Create Now",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                            color: AppColors.background,
                          ),
                        ),
                      ),
                    );
                  }),
                ],
              ),
            ),
          ),
        ),

        // Close Icon Positioned
        Positioned(
          top: -80,
          left: screenWidth * 0.5 - 30,
          child: GestureDetector(
            onTap: () {
              Navigator.pop(context);
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
}
