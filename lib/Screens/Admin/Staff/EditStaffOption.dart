import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../Widgets/CustomAlertDialog.dart';
import '../../../Widgets/Delete toast.dart';
import '../../../controllers/AdminController/EditStaffController.dart';
import '../../../controllers/AdminController/StaffController.dart';
import '../../../utils/colors.dart';
import 'Addstaff.dart';

class EditStaffOption extends StatefulWidget {
  final String? staffId;

  EditStaffOption({
    super.key,
    this.staffId,
  });

  @override
  State<EditStaffOption> createState() => _EditStaffOptionState();
}

class _EditStaffOptionState extends State<EditStaffOption> {
  final EditStaffController editStaffController =
      Get.put(EditStaffController());
  final StaffController staffController = Get.find<StaffController>();

  @override
  void initState() {
    super.initState();
    if (widget.staffId != null) {
      staffController.getCurrentStaffStatus(staffId: widget.staffId!);
    }
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
                            'assets/images/worker staff.svg',
                            color: AppColors.background,
                            fit: BoxFit.none,
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
                              "Staff Editing Options",
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.w500,
                                color: AppColors.secondary,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                            SizedBox(height: 4),
                            Text(
                              "You can use this action to manage Staff",
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
                          return Addstaff(staffId: widget.staffId);
                        },
                      );
                    },
                  ),

                  // SizedBox(height: screenHeight * 0.025),

                  Obx(() => _buildOption(
                    context,
                    iconPath: 'assets/images/activeicon.png',
                    title: staffController.currentStaffStatus.value == "0"
                        ? "Activate Staff"
                        : "De-activate Staff",
                    onTap: () {
                      staffController.toggleStaffStatus(staffId: widget.staffId!);
                      // Don't close immediately, wait for the status to update
                      Future.delayed(Duration(milliseconds: 500), () {
                        Navigator.of(context).pop();
                      });
                    },
                  )),

                  // SizedBox(height: screenHeight * 0.025),
                  //
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
                  //               "This will move the staff member to trash. They can be restored later.",
                  //           iconAsset: 'assets/images/deleteicon.png',
                  //           iconBackgroundColor: AppColors.primary,
                  //           onConfirm: () {
                  //             Navigator.pop(context);
                  //             editStaffController.updateStaffStatus(
                  //                 staffId: widget.staffId!, updateStatus: "2");
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
                                "Deleting this staff member will permanently remove all associated data from the database, including their details, "
                                "as well as any tasks or activities linked to their account. This action is irreversible.",
                            iconAsset: 'assets/images/Delete.svg',
                            iconBackgroundColor: Colors.red,
                            onConfirm: () {
                              Navigator.pop(context);
                              editStaffController.updateStaffStatus(
                                  staffId: widget.staffId!, updateStatus: "9");
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
        required VoidCallback onTap,
        bool isDisabled = false}) {  // Add isDisabled parameter
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4.0),
      child: ListTile(
        contentPadding: EdgeInsets.zero,
        leading: Container(
          width: 40,
          height: 40,
          child: IconButton(
            onPressed: isDisabled ? null : onTap, // Disable if isDisabled is true
            icon: Image.asset(
              iconPath,
              height: 24,
              width: 24,
              fit: BoxFit.contain,
              color: isDisabled ? Colors.grey : null, // Grey out icon if disabled
            ),
            padding: EdgeInsets.zero,
          ),
        ),
        title: Text(
          title,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w400,
            color: isDisabled ? Colors.grey : AppColors.secondary, // Grey out text if disabled
          ),
          overflow: TextOverflow.ellipsis,
        ),
        onTap: isDisabled ? null : onTap, // Disable if isDisabled is true
      ),
    );
  }
  // Widget _buildOption(BuildContext context,
  //     {required String iconPath,
  //     required String title,
  //     required VoidCallback onTap
  //     }) {
  //   return Padding(
  //     padding: EdgeInsets.symmetric(vertical: 4.0),
  //     child: ListTile(
  //       contentPadding: EdgeInsets.zero,
  //       leading: Container(
  //         width: 40,
  //         height: 40,
  //         child: IconButton(
  //           onPressed: onTap,
  //           icon: Image.asset(
  //             iconPath,
  //             height: 24,
  //             width: 24,
  //             fit: BoxFit.contain,
  //           ),
  //           padding: EdgeInsets.zero,
  //         ),
  //       ),
  //       title: Text(
  //         title,
  //         style: TextStyle(
  //           fontSize: 18,
  //           fontWeight: FontWeight.w400,
  //           color: AppColors.secondary,
  //         ),
  //         overflow: TextOverflow.ellipsis,
  //       ),
  //       onTap: onTap,
  //     ),
  //   );
  // }
} 