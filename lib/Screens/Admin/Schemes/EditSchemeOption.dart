import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../../../Widgets/CustomAlertDialog.dart';
import '../../../Widgets/Delete toast.dart';
import '../../../controllers/AdminController/EditSchemeStatusController.dart';
import '../../../utils/colors.dart';
import 'AddSchemes.dart';

class EditSchemeOption extends StatefulWidget {
  final String schemeId;

  const EditSchemeOption({
    Key? key,
    required this.schemeId,
  }) : super(key: key);

  @override
  State<EditSchemeOption> createState() => _EditSchemeOptionState();
}

class _EditSchemeOptionState extends State<EditSchemeOption> {
  final EditSchemeController editSchemeController = Get.put(EditSchemeController());


  @override
  void initState() {
    super.initState();
    if (widget.schemeId != null) {
      editSchemeController.getCurrentSchemeStatus(schemeId: widget.schemeId!);
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
                          child:  SvgPicture.asset('assets/images/AddSchemes.svg',
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
                              "Scheme Editing Options",
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.w500,
                                color: AppColors.secondary,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                            SizedBox(height: 4),
                            Text(
                              "You can use this action to manage Schemes",
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
                          return AddSchemes(schemeId: widget.schemeId);
                        },
                      );
                    },
                  ),

                  // SizedBox(height: screenHeight * 0.025),

                  // _buildOption(
                  //   context,
                  //   iconPath: 'assets/images/activeicon.png',
                  //   title: editSchemeController.currentSchemeStatus.value == "0"
                  //       ? "Activate Scheme"
                  //       : "De-activate Scheme",
                  //   onTap: () {
                  //     editSchemeController.toggleSchemeStatus(schemeId: widget.schemeId!);
                  //     Navigator.of(context).pop(); // Close the bottom sheet
                  //   },
                  // ),
                  Obx(() => _buildOption(
                    context,
                    iconPath: 'assets/images/activeicon.png',
                    title: editSchemeController.currentSchemeStatus.value == "0"
                        ? "Activate Scheme"
                        : "De-activate Scheme",
                    onTap: () {
                      // Just toggle the status without closing the bottom sheet
                      editSchemeController.toggleSchemeStatus(schemeId: widget.schemeId!);

                      // The user will see the title change immediately and can close manually
                      // Don't call Navigator.pop() - let the user close it
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
                  //               "This will move the scheme to trash. It can be restored later.",
                  //           iconAsset: 'assets/images/deleteicon.png',
                  //           iconBackgroundColor: AppColors.primary,
                  //           onConfirm: () {
                  //             Navigator.pop(context);
                  //             editSchemeController.updateSchemeStatus(
                  //                 schemeId: widget.schemeId, updateStatus: "2");
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
                                "Deleting this scheme will permanently remove all associated data from the database, including its details, "
                                "as well as any configurations or activities linked to this scheme. This action is irreversible.",
                            iconAsset: 'assets/images/Delete.svg',
                            iconBackgroundColor: Colors.red,
                            onConfirm: () {
                              Navigator.pop(context);
                              editSchemeController.updateSchemeStatus(
                                  schemeId: widget.schemeId, updateStatus: "9");
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