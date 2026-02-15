// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:get/get.dart';
//
// import '../../../Widgets/CustomAlertDialog.dart';
// import '../../../Widgets/Delete toast.dart';
// import '../../../controllers/AdminController/TankerController.dart';
// import '../../../utils/colors.dart';
// import 'CreateTanker.dart';
// import 'Tanker.dart';
//
// class EditTankerOption extends StatefulWidget {
//   final String tankerId;
//
//   const EditTankerOption({
//     Key? key,
//     required this.tankerId,
//   }) : super(key: key);
//
//   @override
//   State<EditTankerOption> createState() => _EditTankerOptionState();
// }
//
// class _EditTankerOptionState extends State<EditTankerOption> {
//   final TankerController tankerController = Get.put(TankerController());
//
//   @override
//   Widget build(BuildContext context) {
//     // Get media query data
//     final mediaQuery = MediaQuery.of(context);
//     final screenWidth = mediaQuery.size.width;
//     final screenHeight = mediaQuery.size.height;
//
//     return Stack(
//       clipBehavior: Clip.none,
//       children: [
//         Container(
//           constraints: BoxConstraints(
//             maxHeight: screenHeight * 0.7,
//             minHeight: screenHeight * 0.4,
//           ),
//           width: screenWidth * 0.99,
//           decoration: BoxDecoration(
//             color: Colors.white,
//             borderRadius: BorderRadius.circular(12),
//             boxShadow: [
//               BoxShadow(
//                 color: Colors.grey.withOpacity(0.2),
//                 blurRadius: 10,
//                 offset: Offset(0, 5),
//               ),
//             ],
//           ),
//           child: Padding(
//             padding: EdgeInsets.symmetric(horizontal: 16.0),
//             child: SingleChildScrollView(
//               child: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   SizedBox(height: screenHeight * 0.025),
//
//                   // Fixed header section with proper spacing
//                   Row(
//                     crossAxisAlignment: CrossAxisAlignment.center,
//                     children: [
//                       // Icon container - fixed size
//                       Container(
//                         height: 62,
//                         width: 62,
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(12),
//                           color: AppColors.primary,
//                         ),
//                         child: Center(
//                           child: SvgPicture.asset(
//                             'assets/images/Tanker2.svg',
//                             height: 24,
//                             width: 24,
//                             fit: BoxFit.contain,
//                             color: AppColors.background,
//                             errorBuilder: (context, error, stackTrace) {
//                               return Icon(
//                                 Icons.local_shipping,
//                                 size: 24,
//                                 color: AppColors.background,
//                               );
//                             },
//                           ),
//                         ),
//                       ),
//
//                       SizedBox(width: 16),
//
//                       // Text section - takes remaining space
//                       Expanded(
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           mainAxisSize: MainAxisSize.min,
//                           children: [
//                             Text(
//                               "Tanker Editing Options",
//                               style: TextStyle(
//                                 fontSize: 22,
//                                 fontWeight: FontWeight.w500,
//                                 color: AppColors.secondary,
//                               ),
//                               overflow: TextOverflow.ellipsis,
//                             ),
//                             SizedBox(height: 4),
//                             Text(
//                               "You can use this action to manage Tankers",
//                               style: TextStyle(
//                                 color: Colors.grey,
//                                 fontSize: 14,
//                               ),
//                               overflow: TextOverflow.ellipsis,
//                               maxLines: 2,
//                             ),
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//
//                   SizedBox(height: screenHeight * 0.025),
//
//                   _buildOption(
//                     context,
//                     iconPath: 'assets/images/editicon.png',
//                     title: "Edit",
//                     onTap: () {
//                       Navigator.of(context).pop(); // Close the options menu first
//                       showModalBottomSheet(
//                         context: context,
//                         isScrollControlled: true,
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
//                         ),
//                         builder: (context) {
//                           return CreateTanker(tankerId: widget.tankerId);
//                         },
//                       );
//                     },
//                   ),
//                   // SizedBox(height: screenHeight * 0.025),
//
//                   _buildOption(
//                     context,
//                     iconPath: 'assets/images/activeicon.png',
//                     title: "Active/De-active",
//                     onTap: () {
//                       showDialog(
//                         context: context,
//                         builder: (BuildContext context) {
//                           return Tanker();
//                         },
//                       );
//                     },
//                   ),
//
//                   // SizedBox(height: screenHeight * 0.025),
//
//                   // _buildOption(
//                   //   context,
//                   //   iconPath: 'assets/images/deleteicon.png',
//                   //   title: "Move to Trash",
//                   //   onTap: () {
//                   //     showDialog(
//                   //       context: context,
//                   //       builder: (BuildContext context) {
//                   //         return CustomAlertDialog(
//                   //           title: 'Move to Trash',
//                   //           message:
//                   //           "This will move the tanker to trash. It can be restored later.",
//                   //           iconAsset: 'assets/images/deleteicon.png',
//                   //           iconBackgroundColor: AppColors.primary,
//                   //           onConfirm: () {
//                   //             Navigator.pop(context);
//                   //             // Add tanker trash logic here
//                   //             // tankerController.updateTankerStatus(tankerId: widget.tankerId, updateStatus: "2");
//                   //           },
//                   //         );
//                   //       },
//                   //     );
//                   //   },
//                   // ),
//
//                   // SizedBox(height: screenHeight * 0.025),
//
//                   _buildOption(
//                     context,
//                     iconPath: 'assets/images/deleteicon.png',
//                     title: "Delete Permanently",
//                     onTap: () {
//                       showDialog(
//                         context: context,
//                         builder: (BuildContext context) {
//                           return CustomAlertDialog(
//                             title: 'Permanent Deletion Warning',
//                             message:
//                             "Deleting this tanker will permanently remove all associated data from the database, including its details, "
//                                 "crew information, and any certificates linked to this tanker. This action is irreversible.",
//                             iconAsset: 'assets/images/Delete.svg',
//                             iconBackgroundColor: Colors.red,
//                             onConfirm: () {
//                               Navigator.pop(context);
//                               // Add tanker permanent delete logic here
//                               // tankerController.updateTankerStatus(tankerId: widget.tankerId, updateStatus: "9");
//                               Future.delayed(Duration(milliseconds: 100), () {
//                                 showDialog(
//                                   context: context,
//                                   builder: (BuildContext context) {
//                                     return Tash();
//                                   },
//                                 );
//                               });
//                             },
//                           );
//                         },
//                       );
//                     },
//                   ),
//
//                   SizedBox(height: screenHeight * 0.025),
//                 ],
//               ),
//             ),
//           ),
//         ),
//
//         Positioned(
//           top: -80,
//           left: screenWidth * 0.4,
//           child: GestureDetector(
//             onTap: () {
//               Navigator.of(context).pop();
//             },
//             child: CircleAvatar(
//               radius: 30,
//               backgroundColor: Colors.black54,
//               child: Icon(Icons.close, size: 30, color: Colors.white),
//             ),
//           ),
//         ),
//       ],
//     );
//   }
//
//   Widget _buildOption(BuildContext context,
//       {required String iconPath,
//         required String title,
//         required VoidCallback onTap}) {
//     return Padding(
//       padding: EdgeInsets.symmetric(vertical: 4.0),
//       child: ListTile(
//         contentPadding: EdgeInsets.zero,
//         leading: Container(
//           width: 40,
//           height: 40,
//           child: IconButton(
//             onPressed: onTap,
//             icon: iconPath.endsWith('.svg')
//                 ? SvgPicture.asset(
//               iconPath,
//               height: 24,
//               width: 24,
//               fit: BoxFit.contain,
//             )
//                 : Image.asset(
//               iconPath,
//               height: 24,
//               width: 24,
//               fit: BoxFit.contain,
//             ),
//             padding: EdgeInsets.zero,
//           ),
//         ),
//         title: Text(
//           title,
//           style: TextStyle(
//             fontSize: 18,
//             fontWeight: FontWeight.w400,
//             color: AppColors.secondary,
//           ),
//           overflow: TextOverflow.ellipsis,
//         ),
//         onTap: onTap,
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../Data/AppDialoge.dart';
import '../../../Widgets/CustomAlertDialog.dart';
import '../../../Widgets/Delete toast.dart';
import '../../../controllers/AdminController/TankerController.dart';
import '../../../utils/colors.dart';
import 'CreateTanker.dart';

class EditTankerOption extends StatefulWidget {
  final String tankerId;
  final String currentStatus;

  const EditTankerOption({
    Key? key,
    required this.tankerId,
    required this.currentStatus,
  }) : super(key: key);

  @override
  State<EditTankerOption> createState() => _EditTankerOptionState();
}

class _EditTankerOptionState extends State<EditTankerOption> {
  final TankerController tankerController = Get.find<TankerController>();
  late String currentStatus;

  @override
  void initState() {
    super.initState();
    currentStatus = widget.currentStatus;
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
                          child: SvgPicture.asset(
                            'assets/images/Tanker2.svg',
                            height: 24,
                            width: 24,
                            fit: BoxFit.contain,
                            color: AppColors.background,
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
                              "Tanker Editing Options",
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.w500,
                                color: AppColors.secondary,
                              ),
                            ),
                            SizedBox(height: 4),
                            Text(
                              "You can use this action to manage Tankers",
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 14,
                              ),
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
                      Navigator.of(context).pop();
                      showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        builder: (context) {
                          return CreateTanker(tankerId: widget.tankerId);
                        },
                      );
                    },
                  ),

                  // Simple toggle option - no confirmation dialog
                  _buildOption(
                    context,
                    iconPath: 'assets/images/activeicon.png',
                    title: currentStatus == "1" ? "Deactivate" : "Activate",
                    onTap: () {
                      _toggleTankerStatus();
                    },
                  ),

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
                            "Deleting this tanker will permanently remove all associated data from the database.",
                            iconAsset: 'assets/images/Delete.svg',
                            iconBackgroundColor: Colors.red,
                            onConfirm: () {
                              Navigator.pop(context);
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
            onTap: () => Navigator.of(context).pop(),
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

  // Simple toggle without confirmation
  void _toggleTankerStatus() async {
    final newStatus = currentStatus == "1" ? "0" : "1";

    // Update local state immediately for responsive UI
    setState(() {
      currentStatus = newStatus;
    });

    try {
      // Call API to update status using GET method
      bool success = await tankerController.updateTankerStatus(
        widget.tankerId,
        newStatus,
      );

      if (success) {
        // Close the options menu
        Navigator.of(context).pop();

        // Show quick toast
        Appdialogs.showToast(
            newStatus == "1" ? "Tanker activated" : "Tanker deactivated"
        );
      } else {
        // Revert local state if API call failed
        setState(() {
          currentStatus = widget.currentStatus;
        });
      }
    } catch (e) {
      // Handle any exceptions
      setState(() {
        currentStatus = widget.currentStatus;
      });
      Appdialogs.showToast("Error updating status");
    }
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
            )
                : Image.asset(
              iconPath,
              height: 24,
              width: 24,
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
        ),
        onTap: onTap,
      ),
    );
  }
}