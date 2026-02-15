import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../Widgets/CustomAlertDialog.dart';
import '../../../Widgets/Delete toast.dart';
import '../../../controllers/AdminController/EditCustomerController.dart';
import '../../../utils/colors.dart';
import 'AddCustomer.dart';

class EditCustomerOption extends StatefulWidget {
  final String customerId;

  const EditCustomerOption({
    Key? key,
    required this.customerId,
  }) : super(key: key);

  @override
  State<EditCustomerOption> createState() => _EditCustomerOptionState();
}

class _EditCustomerOptionState extends State<EditCustomerOption> {
  final EditCustomerController editCustomerController = Get.put(EditCustomerController());
  @override
  void initState() {
    super.initState();
    editCustomerController.getCurrentCustomerStatus(customerId: widget.customerId);
  }
  @override
  Widget build(BuildContext context) {
    // Get media query data
    final mediaQuery = MediaQuery.of(context);
    final screenWidth = mediaQuery.size.width;
    final screenHeight = mediaQuery.size.height;

    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          constraints: BoxConstraints(
            maxHeight: screenHeight * 0.7,
            minHeight: screenHeight * 0.4,
          ),
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
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(height: screenHeight * 0.025),

                  // Fixed header section with proper spacing
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // Icon container - fixed size
                      Container(
                        height: 62,
                        width: 62,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: AppColors.primary,
                        ),
                        child: Center(
                          child: SvgPicture.asset(
                            'assets/images/Admin.svg',
                            height: 24,
                            width: 24,
                            fit: BoxFit.contain,
                            color: AppColors.background,
                            errorBuilder: (context, error, stackTrace) {
                              return Icon(
                                Icons.person,
                                size: 24,
                                color: AppColors.background,
                              );
                            },
                          ),
                        ),
                      ),

                      SizedBox(width: 16),

                      // Text section - takes remaining space
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              "Customer Editing Options",
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.w500,
                                color: AppColors.secondary,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                            SizedBox(height: 4),
                            Text(
                              "You can use this action to manage Customers",
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

                  _buildOption(
                    context,
                    iconPath: 'assets/images/editicon.png',
                    title: "Edit",
                    onTap: () {
                      showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.vertical(top: Radius.circular(16)),
                        ),
                        builder: (context) {
                          return AddCustomer(customerId: widget.customerId);
                        },
                      );
                    },
                  ),

                  // SizedBox(height: screenHeight * 0.025),

                  Obx(() => _buildOption(
                    context,
                    iconPath: 'assets/images/activeicon.png',
                    title: editCustomerController.currentCustomerStatus.value.toLowerCase() == 'in-active'
                        ? "Activate Customer"
                        : "De-activate Customer",
                    onTap: () {
                      editCustomerController.toggleCustomerStatus(customerId: widget.customerId);
                    },
                  )),

                  // SizedBox(height: screenHeight * 0.025),

                  // _buildOption(
                  //   context,
                  //   iconPath: 'assets/images/deleteicon.png',
                  //   title: "Move to Trash",
                  //   onTap: () {
                  //     showDialog(
                  //       context: context,
                  //       builder: (BuildContext context) {
                  //         return CustomAlertDialog(
                  //           title: 'Move to Trash',
                  //           message:
                  //               "This will move the customer to trash. They can be restored later.",
                  //           iconAsset: 'assets/images/deleteicon.png',
                  //           iconBackgroundColor: AppColors.primary,
                  //           onConfirm: () {
                  //             Navigator.pop(context);
                  //             editCustomerController.updateCustomerStatus(
                  //                 customerId: widget.customerId, updateStatus: "2");
                  //           },
                  //         );
                  //       },
                  //     );
                  //   },
                  // ),

                  // SizedBox(height: screenHeight * 0.025),

                  _buildOption(
                    context,
                    iconPath: 'assets/images/deleteicon.png',
                    title: "Delete Permanently",
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return CustomAlertDialog(
                            title: 'Permanent Deletion Warning',
                            message:
                                "Deleting this customer will permanently remove all associated data from the database, including their details, "
                                "credit history, and any transactions linked to this account. This action is irreversible.",
                            iconAsset: 'assets/images/Delete.svg',
                            iconBackgroundColor: Colors.red,
                            onConfirm: () {
                              Navigator.pop(context);
                              editCustomerController.updateCustomerStatus(
                                  customerId: widget.customerId, updateStatus: "9");
                              Future.delayed(Duration(milliseconds: 100), () {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return Tash();
                                  },
                                );
                              });
                            },
                          );
                        },
                      );
                    },
                  ),

                  SizedBox(height: screenHeight * 0.025),
                ],
              ),
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
            icon: iconPath.endsWith('.svg')
                ? SvgPicture.asset(
                    iconPath,
                    height: 24,
                    width: 24,
                    fit: BoxFit.contain,
                  )
                : Image.asset(
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