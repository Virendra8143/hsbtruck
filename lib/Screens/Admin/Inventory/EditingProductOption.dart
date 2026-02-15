import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../Widgets/CustomAlertDialog.dart';
import '../../../Widgets/Delete toast.dart';
import '../../../controllers/AdminController/EditMachineController.dart';
import '../../../controllers/AdminController/EditProductController.dart';
import '../../../controllers/AdminController/GetProductListController.dart';
import '../../../models/AdminModels/CustomerListModel.dart' as GetProductModel;
import '../../../utils/colors.dart';
import 'EditProduct.dart';
 // Make sure this import is correct

class EditingProductOption extends StatefulWidget {
  final String? machineId;
  final String? productId;
  final Map<String, dynamic>? productData;

  EditingProductOption({
    super.key,
    this.machineId,
    this.productId,
    this.productData,
  });

  @override
  State<EditingProductOption> createState() => _EditingProductOptionState();
}

class _EditingProductOptionState extends State<EditingProductOption> {
  final EditMachineController editMachineController = Get.find<EditMachineController>();
  final EditProductController editProductController = Get.find<EditProductController>();

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final screenWidth = mediaQuery.size.width;
    final screenHeight = mediaQuery.size.height;

    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          height: screenHeight * 0.5,
          width: screenWidth * 0.99,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(24),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                blurRadius: 10,
                offset: Offset(0, 5),
              ),
            ],
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(height: screenHeight * 0.025),

                // Header section
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      height: 62,
                      width: 62,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: AppColors.primary,
                      ),
                      child: Center(
                        child: Image.asset(
                          'assets/images/Vector.png',
                          color: AppColors.background,
                          height: 24,
                          width: 24,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                    SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            "Editing options",
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.w500,
                              color: AppColors.secondary,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                          SizedBox(height: 4),
                          Text(
                            "You can use this action to manage Products",
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 14,
                            ),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                SizedBox(height: screenHeight * 0.025),

                // Edit Option - FIXED
                _buildOption(
                  context,
                  iconPath: 'assets/images/editicon.png',
                  title: "Edit",
                  onTap: () {
                    print('🔄 Edit tapped for product: ${widget.productId}');
                    print('📋 Product data available: ${widget.productData}');

                    if (widget.productId == null || widget.productData == null) {
                      Get.snackbar(
                        'Error',
                        'Product data is incomplete',
                        snackPosition: SnackPosition.BOTTOM,
                        backgroundColor: Colors.red,
                        colorText: Colors.white,
                      );
                      return;
                    }

                    // Close current sheet
                    Navigator.of(context).pop();

                    // Open edit screen after current sheet is closed
                    Future.microtask(() {
                      showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                        ),
                        builder: (context) => EditProductScreen(
                          productId: widget.productId!,
                          productData: widget.productData!,
                        ),
                      );
                    });
                  },
                ),


                // _buildOption(
                //   context,
                //   iconPath: 'assets/images/activeicon.png',
                //   title: "Active/De-active",
                //   onTap: () {
                //     if (widget.productId != null) {
                //       editProductController.updateProductStatus(
                //         productId: widget.productId!,
                //         updateStatus: "1",
                //       );
                //     }
                //   },
                // ),
                //
                // SizedBox(height: screenHeight * 0.025),
                //
                // _buildOption(
                //   context,
                //   iconPath: 'assets/images/deleteicon.png',
                //   title: "Delete Permanently",
                //   onTap: () {
                //     showDialog(
                //       context: context,
                //       builder: (BuildContext context) {
                //         return CustomAlertDialog(
                //           title: 'Deletion Warning',
                //           message:
                //           "Deleting this admin will deactivate all associated data from the database, including their details, "
                //               "as well as any tasks or activities linked to their account or branch. This action is irreversible.",
                //           iconAsset: 'assets/images/Delete.svg',
                //           iconBackgroundColor: AppColors.primary,
                //           onConfirm: () {
                //             Navigator.pop(context);
                //
                //             if (widget.productId != null) {
                //               editProductController.updateProductStatus(
                //                   productId: widget.productId!,
                //                   updateStatus: "9");
                //             } else if (widget.machineId != null) {
                //               editMachineController.updateMachineStatus(
                //                   machineId: widget.machineId!,
                //                   updateStatus: "9");
                //             }
                //
                //             Future.delayed(Duration(milliseconds: 100), () {
                //               showDialog(
                //                 context: context,
                //                 builder: (BuildContext context) {
                //                   return Tash();
                //                 },
                //               );
                //             });
                //           },
                //         );
                //       },
                //     );
                //   },
            // In EditingProductOption widget, update the Active/De-active and Delete buttons:
                // In EditingProductOption.dart, update the _buildOption for Active/De-active:
                _buildOption(
                  context,
                  iconPath: 'assets/images/activeicon.png',
                  title: (widget.productData?['status']?.toString() ?? '1') == "1"
                      ? "Deactivate Product"
                      : "Activate Product",
                  onTap: () {
                    if (widget.productId != null) {
                      // Debug the product data
                      print('🔍 PRODUCT DATA: ${widget.productData}');
                      print('🔍 STATUS VALUE: ${widget.productData?['status']}');

                      final currentStatus = widget.productData?['status']?.toString() ?? '1';
                      final isCurrentlyActive = currentStatus == "1";
                      final newStatus = isCurrentlyActive ? "0" : "1";

                      print('🔄 Current status: $currentStatus, Toggling to: $newStatus');

                      editProductController.updateProductStatus(
                        productId: widget.productId!,
                        updateStatus: newStatus,
                      );

                      Navigator.of(context).pop();
                    } else {
                      print('❌ Missing product ID');
                      Get.snackbar(
                        'Error',
                        'Product ID is missing',
                        snackPosition: SnackPosition.BOTTOM,
                        backgroundColor: Colors.red,
                        colorText: Colors.white,
                      );
                    }
                  },
                ),

// Add this helper method at the bottom of your class
        
                // In EditingProductOption widget, update the delete option:

                // In EditingProductOption widget
                _buildOption(
                  context,
                  iconPath: 'assets/images/deleteicon.png',
                  title: "Delete Permanently",
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return CustomAlertDialog(
                          title: 'Deletion Warning',
                          message: "Deleting this product will remove all associated data from the database. This action is irreversible.",
                          iconAsset: 'assets/images/Delete.svg',
                          iconBackgroundColor: AppColors.primary,
                          onConfirm: () {
                            Navigator.pop(context);

                            if (widget.productId != null) {
                              print('🗑️ Deleting product with ID: ${widget.productId}');

                              // Use status "9" for deletion (trash)
                              editProductController.updateProductStatus(
                                productId: widget.productId!,
                                updateStatus: "9", // 9 = trash/delete
                              );
                            } else {
                              print('❌ Missing product ID');
                              Get.snackbar(
                                'Error',
                                'Product ID is missing',
                                snackPosition: SnackPosition.BOTTOM,
                                backgroundColor: Colors.red,
                                colorText: Colors.white,
                              );
                            }
                          },
                        );
                      },
                    );
                  },
                ),
            ],
            ),
          ),
        ),
        Positioned(
          top: -80,
          left: screenWidth * 0.4,
          child: GestureDetector(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: CircleAvatar(
              radius: 30,
              backgroundColor: Colors.black54,
              child: Icon(Icons.close, size: 30, color: Colors.white),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildOption(BuildContext context,
      {required String iconPath,
        required String title,
        required VoidCallback onTap}) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4.0),
      child: ListTile(
        contentPadding: EdgeInsets.zero,
        leading: Container(
          width: 40,
          height: 40,
          child: IconButton(
            onPressed: onTap,
            icon: Image.asset(
              iconPath,
              height: 24,
              width: 24,
              fit: BoxFit.contain,
            ),
            padding: EdgeInsets.zero,
          ),
        ),
        title: Text(
          title,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w400,
            color: AppColors.secondary,
          ),
          overflow: TextOverflow.ellipsis,
        ),
        onTap: onTap,
      ),
    );
  }
}

GetProductModel.Data _GetProductModelData() {
  return GetProductModel.Data();
}
