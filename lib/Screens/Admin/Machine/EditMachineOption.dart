//
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
//
// import '../../../Widgets/CustomAlertDialog.dart';
// import '../../../Widgets/Delete toast.dart';
// import '../../../controllers/AdminController/EditMachineController.dart';
// import '../../../controllers/AdminController/AddMachineController.dart';
// import '../../../utils/colors.dart';
// import 'AddMachine.dart';
// import 'EditMachineScreen.dart';
//
// class EditMachineOption extends StatefulWidget {
//   final String? machineId;
//   final Map<String, dynamic>? machineData;
//   final String? currentStatus;
//
//   EditMachineOption({
//     super.key,
//     this.machineId,
//     this.machineData,
//     this.currentStatus,
//   });
//
//   @override
//   State<EditMachineOption> createState() => _EditMachineOptionState();
// }
//
// class _EditMachineOptionState extends State<EditMachineOption> {
//   final EditMachineController editMachineController = Get.put(EditMachineController());
//   final AddMachineController addMachineController = Get.find<AddMachineController>();
//
//   @override
//   Widget build(BuildContext context) {
//     final mediaQuery = MediaQuery.of(context);
//     final screenWidth = mediaQuery.size.width;
//     final screenHeight = mediaQuery.size.height;
//
//     return Stack(
//       clipBehavior: Clip.none,
//       children: [
//         Container(
//           height: screenHeight * 0.5,
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
//             child: Column(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 SizedBox(height: screenHeight * 0.025),
//
//                 // Header section
//                 Row(
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   children: [
//                     Container(
//                       height: 62,
//                       width: 62,
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(12),
//                         color: AppColors.primary,
//                       ),
//                       child: Center(
//                         child: Image.asset(
//                           'assets/images/Vector.png',
//                           color: AppColors.background,
//                           height: 24,
//                           width: 24,
//                           fit: BoxFit.contain,
//                         ),
//                       ),
//                     ),
//                     SizedBox(width: 16),
//                     Expanded(
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         mainAxisSize: MainAxisSize.min,
//                         children: [
//                           Text(
//                             "Editing options",
//                             style: TextStyle(
//                               fontSize: 22,
//                               fontWeight: FontWeight.w500,
//                               color: AppColors.secondary,
//                             ),
//                             overflow: TextOverflow.ellipsis,
//                           ),
//                           SizedBox(height: 4),
//                           Text(
//                             "You can use this action to manage Products",
//                             style: TextStyle(
//                               color: Colors.grey,
//                               fontSize: 14,
//                             ),
//                             overflow: TextOverflow.ellipsis,
//                             maxLines: 2,
//                           ),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//
//                 SizedBox(height: screenHeight * 0.025),
//
//                 _buildOption(
//                   iconPath: 'assets/images/editicon.png',
//                   title: "Edit",
//                   onTap: () => _handleEditTap(context),
//                 ),
//
//                 SizedBox(height: screenHeight * 0.025),
//
//                 _buildOption(
//                   iconPath: 'assets/images/activeicon.png',
//                   title: widget.currentStatus == "1" ? "Deactivate" : "Activate",
//                   onTap: () => _handleStatusToggle(context),
//                 ),
//
//                 SizedBox(height: screenHeight * 0.025),
//
//                 _buildOption(
//                   iconPath: 'assets/images/deleteicon.png',
//                   title: "Delete Permanently",
//                   onTap: () => _handleDelete(context),
//                 ),
//               ],
//             ),
//           ),
//         ),
//
//         Positioned(
//           top: -80,
//           left: screenWidth * 0.4,
//           child: GestureDetector(
//             onTap: () => Navigator.of(context).pop(),
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
//   void _handleEditTap(BuildContext context) {
//     print('Edit tapped for machine: ${widget.machineId}');
//     print('Machine data available: ${widget.machineData != null}');
//
//     if (widget.machineData == null) {
//       print('ERROR: No machine data provided for editing');
//       return;
//     }
//
//     // Close the options dialog first
//     Navigator.of(context).pop();
//
//     // Show the EditMachine screen instead of AddMachine
//     _showEditScreen(context);
//   }
//
//   void _showEditScreen(BuildContext context) {
//     // Show bottom sheet in the next frame
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       showModalBottomSheet(
//         context: context,
//         isScrollControlled: true,
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
//         ),
//         builder: (context) => EditMachine(
//           machineId: widget.machineId!,
//           machineData: widget.machineData!,
//         ),
//       );
//     });
//   }
//
//   void _handleStatusToggle(BuildContext context) {
//     showDialog(
//       context: context,
//       builder: (context) => CustomAlertDialog(
//         title: 'Change Status',
//         message: "Are you sure you want to ${widget.currentStatus == "1" ? "deactivate" : "activate"} this machine?",
//         iconAsset: 'assets/images/activeicon.png',
//         iconBackgroundColor: AppColors.primary,
//         onConfirm: () {
//           Navigator.pop(context);
//           if (widget.machineId != null && widget.currentStatus != null) {
//             editMachineController.toggleMachineStatus(
//               machineId: widget.machineId!,
//               currentStatus: widget.currentStatus!,
//             );
//             Navigator.of(context).pop(); // Close the options sheet
//           }
//         },
//       ),
//     );
//   }
//
//   void _handleDelete(BuildContext context) {
//     showDialog(
//       context: context,
//       builder: (context) => CustomAlertDialog(
//         title: 'Deletion Warning',
//         message: "Deleting this machine will deactivate all associated data. This action is irreversible.",
//         iconAsset: 'assets/images/Delete.svg',
//         iconBackgroundColor: AppColors.primary,
//         onConfirm: () {
//           Navigator.pop(context);
//           if (widget.machineId != null) {
//             editMachineController.updateMachineStatus(
//                 machineId: widget.machineId!,
//                 updateStatus: "9" // Assuming "9" is for delete
//             );
//             Navigator.of(context).pop(); // Close the options sheet
//             Future.delayed(Duration(milliseconds: 100), () {
//               showDialog(
//                 context: context,
//                 builder: (context) => Tash(),
//               );
//             });
//           }
//         },
//       ),
//     );
//   }
//
//   Widget _buildOption({
//     required String iconPath,
//     required String title,
//     required VoidCallback onTap,
//   }) {
//     return Padding(
//       padding: EdgeInsets.symmetric(vertical: 4.0),
//       child: ListTile(
//         contentPadding: EdgeInsets.zero,
//         leading: Container(
//           width: 40,
//           height: 40,
//           child: IconButton(
//             onPressed: onTap,
//             icon: Image.asset(
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
import 'package:get/get.dart';

import '../../../Data/AppDialoge.dart';
import '../../../Widgets/Delete toast.dart';
import '../../../controllers/AdminController/EditMachineController.dart';
import '../../../controllers/AdminController/AddMachineController.dart';
import '../../../utils/colors.dart';
import 'AddMachine.dart';
import 'EditMachineScreen.dart';

class EditMachineOption extends StatefulWidget {
  final String? machineId;
  final Map<String, dynamic>? machineData;
  final String? currentStatus;

  EditMachineOption({
    super.key,
    this.machineId,
    this.machineData,
    this.currentStatus,
  });

  @override
  State<EditMachineOption> createState() => _EditMachineOptionState();
}

class _EditMachineOptionState extends State<EditMachineOption> {
  final EditMachineController editMachineController = Get.put(EditMachineController());
  final AddMachineController addMachineController = Get.find<AddMachineController>();

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

                _buildOption(
                  iconPath: 'assets/images/editicon.png',
                  title: "Edit",
                  onTap: () => _handleEditTap(context),
                ),

                SizedBox(height: screenHeight * 0.025),

                Obx(() => _buildOption(
                  iconPath: 'assets/images/activeicon.png',
                  title: widget.currentStatus == "1" ? "Deactivate" : "Activate",
                  onTap: editMachineController.isLoading.value ? null : () => _handleStatusToggle(context),
                )),

                SizedBox(height: screenHeight * 0.025),

                Obx(() => _buildOption(
                  iconPath: 'assets/images/deleteicon.png',
                  title: "Delete Permanently",
                  onTap: editMachineController.isLoading.value ? null : () => _handleDelete(context),
                )),
              ],
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

        // Loading indicator
        Obx(() => editMachineController.isLoading.value
            ? Positioned.fill(
          child: Container(
            color: Colors.black54,
            child: Center(
              child: CircularProgressIndicator(
                color: AppColors.primary,
              ),
            ),
          ),
        )
            : SizedBox.shrink()),
      ],
    );
  }

  void _handleEditTap(BuildContext context) {
    print('Edit tapped for machine: ${widget.machineId}');
    print('Machine data available: ${widget.machineData != null}');

    if (widget.machineData == null) {
      print('ERROR: No machine data provided for editing');
      Appdialogs.showToast("No machine data available for editing");
      return;
    }

    // Close the options dialog first
    Navigator.of(context).pop();

    // Show the EditMachine screen
    _showEditScreen(context);
  }

  void _showEditScreen(BuildContext context) {
    // Show bottom sheet in the next frame
    WidgetsBinding.instance.addPostFrameCallback((_) {
      showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
        ),
        builder: (context) => EditMachine(
          machineId: widget.machineId!,
          machineData: widget.machineData!,
        ),
      );
    });
  }

  void _handleStatusToggle(BuildContext context) {
    // Directly toggle status without confirmation dialog
    if (widget.machineId != null && widget.currentStatus != null) {
      editMachineController.toggleMachineStatus(
        machineId: widget.machineId!,
        currentStatus: widget.currentStatus!,
      );

      // Close the options sheet immediately (don't wait for API response)
      Navigator.of(context).pop();
    }
  }

  void _handleDelete(BuildContext context) {
    // Directly delete without confirmation dialog
    if (widget.machineId != null) {
      editMachineController.updateMachineStatus(
        machineId: widget.machineId!,
        updateStatus: "9", // Assuming "9" is for delete
      );

      // Close the options sheet immediately (don't wait for API response)
      Navigator.of(context).pop();

      // Show delete success toast after a delay
      Future.delayed(Duration(milliseconds: 500), () {
        showDialog(
          context: context,
          builder: (context) => Tash(),
        );
      });
    }
  }

  Widget _buildOption({
    required String iconPath,
    required String title,
    required VoidCallback? onTap,
  }) {
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
              color: onTap == null ? Colors.grey : null,
            ),
            padding: EdgeInsets.zero,
          ),
        ),
        title: Text(
          title,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w400,
            color: onTap == null ? Colors.grey : AppColors.secondary,
          ),
          overflow: TextOverflow.ellipsis,
        ),
        onTap: onTap,
      ),
    );
  }
}