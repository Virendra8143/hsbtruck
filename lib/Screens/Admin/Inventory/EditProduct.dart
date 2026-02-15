import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../controllers/AdminController/EditProductController.dart';
import '../../../utils/colors.dart';

class EditProductScreen extends StatefulWidget {
  final String productId;
  final Map<String, dynamic> productData;

  const EditProductScreen({
    super.key,
    required this.productId,
    required this.productData,
  });

  @override
  State<EditProductScreen> createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  late final EditProductController controller;
  final _formKey = GlobalKey<FormState>();
  bool _isInitialized = false;

  @override
  void initState() {
    super.initState();
    // Use Get.find to get the existing controller instance
    controller = Get.find<EditProductController>();
    // Initialize data immediately
    _initializeData();
  }

  void _initializeData() {
    if (!_isInitialized) {
      print('🔄 Initializing edit screen with data...');
      print('Product ID from widget: ${widget.productId}');
      print('Product Data from widget: ${widget.productData}');
      print('🔍 Controller instance: ${controller.hashCode}');

      controller.setEditData(widget.productId, widget.productData);
      _isInitialized = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final screenWidth = mediaQuery.size.width;
    final screenHeight = mediaQuery.size.height;

    return Container(
      height: screenHeight * 0.8,
      width: screenWidth * 0.99,
      child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              const SizedBox(height: 10),
              Container(
                height: 5,
                width: 53,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: AppColors.alert,
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.04, vertical: 20),
                child: Row(
                  children: [
                    Container(
                      height: 62,
                      width: 62,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: AppColors.primary,
                      ),
                      child: Icon(Icons.inventory_2, color: AppColors.background, size: 30),
                    ),
                    const SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Edit Product',
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: screenWidth * 0.06,
                            color: AppColors.secondary,
                          ),
                        ),
                        Text(
                          'Update product details',
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: screenWidth * 0.035,
                            color: AppColors.icon,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 40),
              // _buildTextField(
              //   controller: controller.productNameController,
              //   label: "Product Name",
              //   width: screenWidth,
              //   isRequired: true,
              // ),
              // Product Category ID
              // _buildTextField(
              //   controller: controller.productNameController,
              //   label: "Product Name",
              //   width: screenWidth,
              //   isRequired: true,
              // ),
              _buildTextField(
                controller: controller.productNameController, // NEW
                label: "Product Name",
                width: screenWidth,
                isRequired: true,
              ),
              const SizedBox(height: 20),
              _buildTextField(
                controller: controller.productCategoryIdController,
                label: "Product Category ID",
                width: screenWidth,
                isRequired: true,
              ),
              const SizedBox(height: 20),

              // Brand
              _buildTextField(
                controller: controller.brandController,
                label: "Brand",
                width: screenWidth,
                isRequired: true,
              ),
              const SizedBox(height: 20),

              // Unit of Measure
              _buildTextField(
                controller: controller.unitOfMeasureController,
                label: "Unit of Measure",
                width: screenWidth,
                isRequired: true,
              ),
              const SizedBox(height: 20),

              // Price Per Unit
              _buildTextField(
                controller: controller.perPriceController,
                label: "Price Per Unit",
                width: screenWidth,
                keyboardType: TextInputType.number,
                isRequired: true,
              ),
              const SizedBox(height: 20),

              // Storage Capacity
              _buildTextField(
                controller: controller.storageCapacityController,
                label: "Storage Capacity",
                width: screenWidth,
                isRequired: true,
              ),
              const SizedBox(height: 20),

              // Quantity in Stock
              _buildTextField(
                controller: controller.qtyInStockController,
                label: "Quantity in Stock",
                width: screenWidth,
                keyboardType: TextInputType.number,
                isRequired: true,
              ),
              const SizedBox(height: 20),

              // Minimum Quantity Alert
              _buildTextField(
                controller: controller.minQtyAlertController,
                label: "Minimum Quantity Alert",
                width: screenWidth,
                keyboardType: TextInputType.number,
                isRequired: true,
              ),
              const SizedBox(height: 20),

              // Description
              _buildTextField(
                controller: controller.descriptionController,
                label: "Description",
                width: screenWidth,
                maxLines: 3,
              ),
              const SizedBox(height: 20),

              // Supplier Name
              _buildTextField(
                controller: controller.supplierNameController,
                label: "Supplier Name",
                width: screenWidth,
              ),
              const SizedBox(height: 30),

              // Update Button
              SizedBox(
                width: screenWidth * 0.9,
                height: screenHeight * 0.05,
                child: GetBuilder<EditProductController>(
                  builder: (controller) {
                    return ElevatedButton(
                      onPressed: controller.isLoading.value
                          ? null
                          : () {
                        if (_formKey.currentState!.validate()) {
                          controller.updateProduct();
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.button,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: controller.isLoading.value
                          ? CircularProgressIndicator(color: AppColors.background)
                          : Text(
                        "Update Product",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        ),
                      ),
                    );
                  },
                ),
              ),

              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required double width,
    TextInputType keyboardType = TextInputType.text,
    int maxLines = 1,
    bool isRequired = false,
  }) {
    return SizedBox(
      width: width * 0.9,
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        maxLines: maxLines,
        decoration: _inputDecoration(label),
        validator: isRequired
            ? (value) {
          if (value == null || value.trim().isEmpty) {
            return 'Please enter $label';
          }
          return null;
        }
            : null,
      ),
    );
  }

  InputDecoration _inputDecoration(String label) {
    return InputDecoration(
      labelText: label,
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: AppColors.primary, width: 1),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: AppColors.secondary, width: 1.5),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Colors.red, width: 1.5),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Colors.red, width: 2),
      ),
    );
  }

  @override
  void dispose() {

    super.dispose();
  }
}