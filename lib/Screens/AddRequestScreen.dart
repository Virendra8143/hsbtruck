// screens/employee/AddRequestScreen.dart - SIMPLE VERSION
import 'package:flutter/material.dart';
import 'package:get/get.dart';


import '../Utils/colors.dart';
import '../controllers/AddRequestScreen.dart';


class AddRequestScreen extends StatelessWidget {
  AddRequestScreen({Key? key}) : super(key: key);

  final EmployeeRequestController controller = Get.put(EmployeeRequestController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Request'),
        backgroundColor: AppColors.primary,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Get.back(),
        ),
      ),
      body: SafeArea(
        child: GestureDetector(
          onTap: () {
            // Close keyboard when tapping outside text fields
            FocusScope.of(context).unfocus();
          },
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Purpose Field
                Text(
                  'Purpose *',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[700],
                  ),
                ),
                const SizedBox(height: 8),
                Obx(() => TextField(
                  controller: controller.purposeController,
                  focusNode: controller.purposeFocus,
                  decoration: InputDecoration(
                    hintText: 'Enter purpose',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    errorText: controller.purposeError.value.isNotEmpty
                        ? controller.purposeError.value
                        : null,
                  ),
                  onChanged: (value) => controller.purpose.value = value,
                )),

                const SizedBox(height: 20),

                // Description Field
                Text(
                  'Description *',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[700],
                  ),
                ),
                const SizedBox(height: 8),
                Obx(() => TextField(
                  controller: controller.descriptionController,
                  focusNode: controller.descriptionFocus,
                  maxLines: 4,
                  decoration: InputDecoration(
                    hintText: 'Enter description',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    errorText: controller.descriptionError.value.isNotEmpty
                        ? controller.descriptionError.value
                        : null,
                  ),
                  onChanged: (value) => controller.description.value = value,
                )),

                const SizedBox(height: 20),

                // Amount Field
                Text(
                  'Amount (₹) *',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[700],
                  ),
                ),
                const SizedBox(height: 8),
                Obx(() => TextField(
                  controller: controller.amountController,
                  focusNode: controller.amountFocus,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText: 'Enter amount',
                    prefixText: '₹ ',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    errorText: controller.amountError.value.isNotEmpty
                        ? controller.amountError.value
                        : null,
                  ),
                  onChanged: (value) => controller.amount.value = value,
                )),

                const SizedBox(height: 30),

                // Submit Button
                Obx(() => SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: controller.isSubmitting.value
                        ? null
                        : () async {
                      debugPrint('Submit Request button clicked');
                      // Validate and submit
                      if (controller.validateForm()) {
                        debugPrint('Form validation passed');
                        final success = await controller.submitRequest();
                        if (success) {
                          Get.back();
                        }
                      } else {
                        debugPrint('Form validation failed');
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: controller.isSubmitting.value
                        ? const SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: Colors.white,
                      ),
                    )
                        : const Text(
                      'Submit Request',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}