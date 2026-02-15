import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../controllers/AdminController/UpdateAdminStatusController.dart';
import '../models/SuperAdminModel/adminlistmodel.dart';
import '../utils/colors.dart';
import 'CustomAlertDialog.dart';
import 'Delete toast.dart';

class EditingOption extends StatefulWidget {

  final AdminData admin; // Receive an admin object

  const EditingOption({super.key, required this.admin});

  @override
  State<EditingOption> createState() => _EditingOptionState();
}

class _EditingOptionState extends State<EditingOption> {


  @override
  void initState() {
    super.initState();

  }




  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context).size;
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          height: mediaQuery.height * 0.5,
          width: mediaQuery.width * 0.99,
          decoration: BoxDecoration(

            borderRadius: BorderRadius.circular(mediaQuery.width * 0.03),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                blurRadius: 10,
                offset: Offset(0, mediaQuery.height * 0.005),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: mediaQuery.height * 0.02),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: mediaQuery.width * 0.02),
                    child: Stack(
                      children: [
                        Container(
                          height: mediaQuery.width * 0.15,
                          width: mediaQuery.width * 0.15,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(mediaQuery.width * 0.03),
                            color: AppColors.primary,
                          ),
                        ),
                        Positioned(
                          top: mediaQuery.height * 0.03,
                          left: mediaQuery.width * 0.04,
                          child: SvgPicture.asset(
                            'assets/images/3dots.svg',
                            color: AppColors.background,
                            fit: BoxFit.fitHeight,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: mediaQuery.width * 0.05),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Editing options",
                        style: TextStyle(fontSize: mediaQuery.width * 0.06, fontWeight: FontWeight.w500, color: AppColors.secondary),
                      ),
                      SizedBox(height: mediaQuery.width * 0.02),
                      Text(
                        "You can use this action to manage admin",
                        style: TextStyle(color: Colors.grey, fontSize: mediaQuery.width * 0.04),
                      ),
                      Text(
                        "Manage Admin: ${widget.admin.name}", // Show admin name
                        style: TextStyle(color: Colors.grey, fontSize: mediaQuery.width * 0.04),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: mediaQuery.height * 0.02),
              Row(
                children: [
                  IconButton(
                    onPressed: () {
                      // showModalBottomSheet(
                      //   context: context,
                      //   isScrollControlled: true,
                      //   shape: RoundedRectangleBorder(
                      //     borderRadius: BorderRadius.vertical(top: Radius.circular(mediaQuery.width * 0.04)),
                      //   ),
                      //   builder: (context) {
                      //     return CreateAdmin();
                      //   },
                      // );

                    },
                    icon: SvgPicture.asset('assets/images/edit.svg',color: AppColors.secondary,),
                  ),

                  Text(
                    "Edit",
                    style: TextStyle(color:AppColors.secondary , fontSize: mediaQuery.width * 0.05, fontWeight: FontWeight.w400,),
                  ),
                ],
              ),SizedBox(height: mediaQuery.height * 0.02),
              Row(
                children: [
                  IconButton(
                    onPressed: () {



                    },
                    icon: SvgPicture.asset('assets/images/call.svg'),
                  ),

                  Text(
                    "Call Admin",
                    style: TextStyle(color:AppColors.secondary , fontSize: mediaQuery.width * 0.05, fontWeight: FontWeight.w400,),
                  ),
                ],
              ),SizedBox(height: mediaQuery.height * 0.02),

              Row(
                children: [
                  IconButton(
                    onPressed: () async {
                      final UpdateAdminStatusController controller = Get.find<UpdateAdminStatusController>();

                      // Convert admin ID to int safely
                      int adminId = int.tryParse(widget.admin.id ?? '') ?? 0; // Assuming widget.admin.id provides the admin ID.

                      if (adminId != 0) {
                        // Set admin data in the controller
                        controller.setAdminData(adminId, widget.admin.status.toString());

                        // Toggle admin status
                        String newStatus = controller.adminStatus.value == "1" ? "0" : "1";

                        // Update local state immediately for UI feedback
                        setState(() {
                          widget.admin.status = newStatus;  // Update the local widget state
                        });

                        // Call the method to update status in the backend
                        try {
                          await controller.updateAdminStatus(controller.adminId.value!, newStatus);
                        } catch (error) {
                          // Handle exceptions if necessary; reverting UI status
                          print("Error updating admin status: $error");
                          setState(() {
                            widget.admin.status = controller.adminStatus.value == "1" ? "0" : "1"; // Revert back
                          });
                        }
                      } else {
                        print("Error: Admin ID is invalid");
                        Get.snackbar('Error', 'Admin ID is invalid.');
                      }
                    },
                    icon: SvgPicture.asset('assets/images/updown.svg'),
                  ),
                  Text(
                    "Active/De-active",
                    style: TextStyle(color: AppColors.secondary, fontSize: mediaQuery.width * 0.05, fontWeight: FontWeight.w400),
                  ),
                ],
              ),


              SizedBox(height: mediaQuery.height * 0.02),
              Row(
                children: [
                  IconButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return CustomAlertDialog(title: 'Deletion Warning',
                            message: "Deleting this admin will deactivate all associated data from the database, including their details, "
                                "as well as any tasks or activities linked to their account or branch. This action is irreversible.",
                            iconAsset: 'assets/images/Delete.svg',
                            iconBackgroundColor: AppColors.primary,
                            onConfirm: () {
                              Navigator.pop(context);
                              // Show toast notification
                              Future.delayed(Duration(milliseconds: 100), () {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return Tash(); // Your toast notification
                                  },
                                );
                              });
                            },);
                        },
                      );


                    },
                    icon: SvgPicture.asset('assets/images/Delete.svg',color: AppColors.secondary,),
                  ),

                  Text(
                    "Delete Permanently",
                    style: TextStyle(color:AppColors.secondary , fontSize: mediaQuery.width * 0.05, fontWeight: FontWeight.w400,),
                  ),
                ],
              ),

            ],
          ),
        ),
        Positioned(
          top: -mediaQuery.height * 0.1,
          left: mediaQuery.width * 0.4,
          child: GestureDetector(
            onTap: () => Navigator.pop(context),
            child: CircleAvatar(
              radius: mediaQuery.width * 0.08,
              backgroundColor: Colors.black54,
              child: Icon(Icons.close, size: mediaQuery.width * 0.1, color: Colors.white,),
            ),
          ),
        ),
      ],
    );
  }


}
