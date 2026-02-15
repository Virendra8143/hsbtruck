import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../controllers/CustomerController.dart';
import '../../../utils/colors.dart';
import 'AddCustomerScreen.dart';

class SEditingOption extends StatefulWidget {
  final dynamic customer;

  const SEditingOption({
    super.key,
    required this.customer,
  });

  @override
  State<SEditingOption> createState() => _SEditingOptionState();
}

class _SEditingOptionState extends State<SEditingOption> {
  late final CustomerController customerController;

  @override
  void initState() {
    super.initState();
    customerController = Get.find<CustomerController>();
  }

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
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                blurRadius: 10,
                offset: Offset(0, 5),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: screenHeight * 0.025),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Stack(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 5),
                        child: Container(
                          height: 62,
                          width: 62,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: AppColors.primary),
                        ),
                      ),
                      Positioned(
                        top: 25,
                        left: 20,
                        child: Center(
                          child: Image.asset(
                            'assets/images/Vector.png',
                            color: AppColors.background,
                            fit: BoxFit.fitHeight,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(width: screenWidth * 0.05),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Editing options",
                        style: TextStyle(
                          fontSize: screenWidth * 0.06,
                          fontWeight: FontWeight.w500,
                          color: AppColors.secondary,
                        ),
                      ),
                      SizedBox(width: 10),
                      Text(
                        widget.customer?.name != null
                            ? "Manage ${widget.customer.name}"
                            : "Manage Customer",
                        style: TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: screenHeight * 0.025),

              // Edit Option
              _buildOption(
                context,
                iconPath: 'assets/images/editicon.png',
                title: "Edit Customer",
                onTap: _onEditPressed,
              ),
              SizedBox(height: screenHeight * 0.025),

              // Active/Deactive Option
              _buildOption(
                context,
                iconPath: 'assets/images/activeicon.png',
                title: widget.customer?.status?.toLowerCase() == 'active'
                    ? "Deactivate Customer"
                    : "Activate Customer",
                onTap: _onToggleStatusPressed,
              ),
              SizedBox(height: screenHeight * 0.025),

              // Delete Option
              _buildOption(
                context,
                iconPath: 'assets/images/deleteicon.png',
                title: "Delete Permanently",
                titleColor: Colors.red,
                onTap: _onDeletePressed,
              ),
            ],
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

  Widget _buildOption(BuildContext context, {
    required String iconPath,
    required String title,
    VoidCallback? onTap,
    Color titleColor = AppColors.secondary,
  }) {
    return ListTile(
      leading: IconButton(
        onPressed: onTap,
        icon: Image.asset(iconPath, fit: BoxFit.fitHeight),
      ),
      title: Text(
        title,
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w400,
          color: titleColor,
        ),
      ),
      onTap: onTap,
    );
  }

  // Edit Customer
  void _onEditPressed() {
    Navigator.of(context).pop(); // Close the editing options dialog

    // Show edit customer screen
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return AddCustomerScreen(
          customer: widget.customer,
          isEditMode: true,
        );
      },
    );
  }

  // Toggle Active/Deactive Status - NO LOADING
  void _onToggleStatusPressed() {
    Navigator.of(context).pop();

    final currentStatus = widget.customer?.status?.toLowerCase();
    final newStatus = currentStatus == 'active' ? 'inactive' : 'active';
    final action = currentStatus == 'active' ? 'deactivate' : 'activate';

    if (currentStatus == 'trash') {
      Get.snackbar(
        'Not Allowed',
        'Customer is in trash. Restore first to change status.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.orange,
        colorText: Colors.white,
      );
      return;
    }

    Get.defaultDialog(
      title: action == 'deactivate' ? 'Deactivate Customer' : 'Activate Customer',
      middleText: 'Are you sure you want to $action ${widget.customer?.name}?',
      textConfirm: action == 'deactivate' ? 'Deactivate' : 'Activate',
      textCancel: 'Cancel',
      confirmTextColor: Colors.white,
      onConfirm: () {
        Get.back();
        // NO LOADING - direct API call
        customerController.updateCustomerStatus(
          widget.customer?.id ?? '',
          newStatus,
        );
      },
    );
  }

  // Delete Customer (Move to Trash) - NO LOADING
  void _onDeletePressed() {
    Navigator.of(context).pop();

    Get.defaultDialog(
      title: 'Move to Trash',
      middleText: 'Are you sure you want to move ${widget.customer?.name} to trash?\n\nNote: This can be restored later.',
      textConfirm: 'Move to Trash',
      textCancel: 'Cancel',
      confirmTextColor: Colors.white,
      onConfirm: () {
        Get.back();
        // NO LOADING - direct API call
        customerController.deleteCustomer(widget.customer?.id ?? '');
      },
    );
  }
}