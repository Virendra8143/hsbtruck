import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../utils/colors.dart';
import '../../../controllers/AdminController/EditProductController.dart';

class Inventorydeletewarning extends StatefulWidget {
  final String productId;
  final String productName;
  
  const Inventorydeletewarning({
    super.key, 
    required this.productId,
    required this.productName,
  });

  @override
  State<Inventorydeletewarning> createState() => _InventorydeletewarningState();
}

class _InventorydeletewarningState extends State<Inventorydeletewarning> {
  String? selectedButton;
  final EditProductController editProductController = Get.put(EditProductController());

  @override
  Widget build(BuildContext context) {

    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      contentPadding: EdgeInsets.all(20),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Header
          Row(
            children: [
              Container(
                height: 45,
                width: 45,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: AppColors.primary,
                ),
                child: Image.asset(
                  'assets/images/deleteicon.png',
                  width: 45,
                  height: 45,
                  color: AppColors.background,
                ),
              ),
              SizedBox(width: 12),
              Expanded(
                child: Text(
                  'Delete Product',
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 20,
                    color: AppColors.secondary,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 20),
          
          // Message
          Container(
            width: double.maxFinite,
            child: Text(
              "Are you sure you want to permanently delete '${widget.productName}'? This will remove all associated data from the database. This action cannot be undone.",
              textAlign: TextAlign.left,
              style: TextStyle(
                fontSize: 16,
                color: AppColors.text,
              ),
            ),
          ),
          SizedBox(height: 30),
          
          // Buttons
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              // No Button
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text(
                  'Cancel',
                  style: TextStyle(
                    color: AppColors.text,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              SizedBox(width: 12),
              
              // Yes Button - Delete Product Permanently
              // ElevatedButton(
              //   onPressed: () {
              //     Navigator.of(context).pop(); // Close dialog first
              //
              //     // Delete product permanently using status "9"
              //     if (widget.productId.isNotEmpty) {
              //       editProductController.updateProductStatus(
              //         productId: widget.productId,
              //         updateStatus: "9", // Permanent delete
              //       );
              //
              //       // Show success message
              //       Get.snackbar(
              //         'Success',
              //         '${widget.productName} has been deleted permanently',
              //         snackPosition: SnackPosition.BOTTOM,
              //         backgroundColor: AppColors.primary,
              //         colorText: Colors.white,
              //         duration: Duration(seconds: 3),
              //       );
              //     }
              //   },
              //   style: ElevatedButton.styleFrom(
              //     backgroundColor: Colors.red,
              //     padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              //     shape: RoundedRectangleBorder(
              //       borderRadius: BorderRadius.circular(8),
              //     ),
              //   ),
              //   child: Text(
              //     'Delete',
              //     style: TextStyle(
              //       color: Colors.white,
              //       fontSize: 16,
              //       fontWeight: FontWeight.w600,
              //     ),
              //   ),
              // ),
              // In Inventorydeletewarning widget, update the delete button:

              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop(); // Close dialog first

                  // Delete product permanently using status "9" with required fields
                  if (widget.productId.isNotEmpty) {
                    // You'll need to pass the product data here or get it from controller
                    final editProductController = Get.find<EditProductController>();
                    editProductController.updateProductStatus(
                      productId: widget.productId,
                      updateStatus: "9", // Permanent delete
                      // You might need to pass additionalData here if available
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text(
                  'Delete',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}