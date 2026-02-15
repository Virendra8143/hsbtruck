// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:get/get.dart';
//
// import '../../Authentication/LoginScreen.dart';
// import '../../Data/AppDialoge.dart';
// import '../../Utils/Const.dart';
// import '../../Widgets/AlertDialog.dart';
// import '../../Widgets/ManualScreen.dart';
// import '../../utils/colors.dart';
// import '../../utils/preference.dart';
// import 'CreditCustomer/CreateCustomer.dart';
// import 'Inventory/InventoryScreen.dart';
// import 'Machine/CreateMachine.dart';
// import 'Schemes/Scheme.dart';
// import 'Staff/Staff.dart';
// import 'Tanker/Tanker.dart';
//
// class AdminDashBoard extends StatelessWidget {
//   void showCreateBranchDialog(BuildContext context) {
//     showDialog(
//       context: context,
//       builder: (context) => CreateBranchDialog(),
//     );
//   }
//
//   void showLogoutDialog(BuildContext context) {
//     showDialog(
//       context: context,
//       barrierDismissible: false,
//       builder: (context) => AlertDialog(
//         backgroundColor: AppColors.background,
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(16),
//         ),
//         title: Row(
//           children: [
//             Container(
//               padding: EdgeInsets.all(8),
//               decoration: BoxDecoration(
//                 color: Colors.red.withOpacity(0.1),
//                 borderRadius: BorderRadius.circular(8),
//               ),
//               child: Icon(
//                 Icons.logout_rounded,
//                 color: Colors.red.shade600,
//                 size: 20,
//               ),
//             ),
//             SizedBox(width: 12),
//             Text(
//               'Logout',
//               style: TextStyle(
//                 color: AppColors.secondary,
//                 fontSize: 18,
//                 fontWeight: FontWeight.w600,
//               ),
//             ),
//           ],
//         ),
//         content: Text(
//           'Are you sure you want to logout?',
//           style: TextStyle(
//             color: AppColors.secondary.withOpacity(0.7),
//             fontSize: 14,
//           ),
//         ),
//         actions: [
//           Container(
//             width: double.infinity,
//             child: Row(
//               children: [
//                 Expanded(
//                   child: TextButton(
//                     onPressed: () => Navigator.of(context).pop(),
//                     style: TextButton.styleFrom(
//                       backgroundColor: AppColors.whitebg,
//                       foregroundColor: AppColors.secondary,
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(8),
//                       ),
//                       padding: EdgeInsets.symmetric(vertical: 12),
//                     ),
//                     child: Text(
//                       'Cancel',
//                       style: TextStyle(
//                         fontWeight: FontWeight.w500,
//                         fontSize: 14,
//                       ),
//                     ),
//                   ),
//                 ),
//                 SizedBox(width: 12),
//                 Expanded(
//                   child: TextButton(
//                     onPressed: () async {
//                       await performLogout(context);
//                     },
//                     style: TextButton.styleFrom(
//                       backgroundColor: Colors.red.shade600,
//                       foregroundColor: AppColors.background,
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(8),
//                       ),
//                       padding: EdgeInsets.symmetric(vertical: 12),
//                     ),
//                     child: Text(
//                       'Logout',
//                       style: TextStyle(
//                         fontWeight: FontWeight.w500,
//                         fontSize: 14,
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Future<void> performLogout(BuildContext context) async {
//     try {
//       // Clear saved preferences
//       await Preference.removePrefKey(KEY_TOKEN);
//       await Preference.saveSharedPrefBool(KEY_LOGIN, false);
//
//       // Close the dialog
//       Navigator.of(context).pop();
//
//       // Show logout success message
//       Appdialogs.showToast('Logged out successfully');
//
//       // Navigate to login screen and clear navigation stack
//       Get.offAll(() => LoginScreen());
//
//     } catch (e) {
//       // Close the dialog
//       Navigator.of(context).pop();
//
//       // Show error message
//       Appdialogs.showToast('Logout failed. Please try again.');
//
//       print('Logout error: $e');
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     // Get MediaQuery data
//     final mediaQuery = MediaQuery.of(context);
//     final width = mediaQuery.size.width;
//     final height = mediaQuery.size.height;
//
//     return SafeArea(
//       child: Scaffold(
//         body: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             SizedBox(height: height * 0.02),
//             Row(
//               children: [
//                 Padding(
//                   padding: const EdgeInsets.only(left: 10),
//                   child: Image.asset(
//                     'assets/images/HSB.png',
//                     width: width * 0.25,
//                     height: height * 0.06,
//                   ),
//                 ),
//                 Spacer(),
//                 Image.asset(
//                   'assets/images/Notification.png',
//                   width: width * 0.25,
//                   height: height * 0.06,
//                 ),
//                 GestureDetector(
//                   onTap: () {
//                     // Navigate to the next screen
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(builder: (context) => ManualScreen()),
//                     );
//                   },
//                   child: Padding(
//                     padding: const EdgeInsets.only(right: 8),
//                     child: Image.asset(
//                       'assets/images/drawer.png',
//                       width: width * 0.08,
//                       height: height * 0.06,
//                     ),
//                   ),
//                 ),
//                 // Updated Logout button to match design
//                 GestureDetector(
//                   onTap: () {
//                     showLogoutDialog(context);
//                   },
//                   child: Padding(
//                     padding: const EdgeInsets.only(right: 15),
//                     child: Container(
//                       width: width * 0.12,
//                       height: height * 0.06,
//                       decoration: BoxDecoration(
//                         color: AppColors.background,
//                         borderRadius: BorderRadius.circular(12),
//                         border: Border.all(
//                           color: Colors.red.withOpacity(0.2),
//                           width: 1,
//                         ),
//                         boxShadow: [
//                           BoxShadow(
//                             color: Colors.black.withOpacity(0.05),
//                             blurRadius: 4,
//                             offset: Offset(0, 2),
//                           ),
//                         ],
//                       ),
//                       child: Icon(
//                         Icons.logout_rounded,
//                         color: Colors.red.shade600,
//                         size: 20,
//                       ),
//                     ),
//                   ),
//                 )
//               ],
//             ),
//             SizedBox(height: height * 0.02),
//             Padding(
//               padding: const EdgeInsets.only(left: 8),
//               child: Text(
//                 'Admin',
//                 style: TextStyle(
//                   fontSize: 16,
//                   fontWeight: FontWeight.w600,
//                   color: AppColors.primary,
//                 ),
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.only(left: 8),
//               child: Text(
//                 'Welcome,\nKundan Singh pan..',
//                 style: TextStyle(
//                   fontSize: 32,
//                   fontWeight: FontWeight.w600,
//                   color: AppColors.secondary,
//                 ),
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.only(left: 8),
//               child: Text(
//                 "Good Morning, Have a nice day!",
//                 style: TextStyle(color: AppColors.secondary),
//               ),
//             ),
//             SizedBox(height: height * 0.02),
//             Container(
//               height: height * 0.15,
//               width: width,
//               decoration: BoxDecoration(
//                 color: AppColors.button,
//               ),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                 children: [
//                   SizedBox(width: width * 0.02),
//                   Column(
//                     children: [
//                       SizedBox(height: height * 0.01),
//                       GestureDetector(
//                         onTap: () {
//                           showModalBottomSheet(
//                             context: context,
//                             isScrollControlled: true,
//                             shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
//                             ),
//                             builder: (context) {
//                               return CreateInventory();
//                             },
//                           );
//                         },
//                         child: Container(
//                           height: 62,
//                           width: 62,
//                           decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(12),
//                             color: AppColors.background,
//                           ),
//                           child: Image.asset('assets/images/Inventory.png'),
//                         ),
//                       ),
//                       SizedBox(height: 5),
//                       Text(
//                         'Inventory',
//                         style: TextStyle(
//                           color: AppColors.background,
//                           fontSize: 16,
//                           fontWeight: FontWeight.w500,
//                         ),
//                       ),
//                     ],
//                   ),
//                   SizedBox(width: width * 0.05),
//                   Column(
//                     children: [
//                       SizedBox(height: height * 0.01),
//                       GestureDetector(
//                         onTap: () {
//                           showModalBottomSheet(
//                             context: context,
//                             isScrollControlled: true,
//                             shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
//                             ),
//                             builder: (context) {
//                               return CreateMachine();
//                             },
//                           );
//                         },
//                         child: Container(
//                           height: 62,
//                           width: 62,
//                           decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(12),
//                             color: AppColors.background,
//                           ),
//                           child: Image.asset('assets/images/Union.png'),
//                         ),
//                       ),
//                       SizedBox(height: 5),
//                       Text(
//                         'Create Machine',
//                         style: TextStyle(
//                           color: AppColors.background,
//                           fontSize: 16,
//                           fontWeight: FontWeight.w500,
//                         ),
//                       ),
//                     ],
//                   ),
//                   SizedBox(width: width * 0.02),
//                   Column(
//                     children: [
//                       SizedBox(height: height * 0.01),
//                       GestureDetector(
//                         onTap: () {
//                           showModalBottomSheet(
//                             context: context,
//                             isScrollControlled: true,
//                             shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
//                             ),
//                             builder: (context) {
//                               return Staff();
//                             },
//                           );
//                         },
//                         child: Container(
//                           height: 62,
//                           width: 62,
//                           decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(12),
//                             color: AppColors.background,
//                           ),
//                           child: Image.asset('assets/images/Staff.png'),
//                         ),
//                       ),
//                       SizedBox(height: 5),
//                       Text(
//                         'Staff',
//                         style: TextStyle(
//                           color: AppColors.background,
//                           fontSize: 16,
//                           fontWeight: FontWeight.w500,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//             SizedBox(height: height * 0.02),
//             Row(
//               children: [
//                 Column(
//                   children: [
//                     Text(
//                       'Yesterday Collection',
//                       style: TextStyle(
//                         color: AppColors.primary,
//                         fontSize: 14,
//                         fontWeight: FontWeight.w500,
//                       ),
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.only(left: 25, top: 10),
//                       child: Container(
//                         height: 65,
//                         width: width * 0.45,
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(12),
//                           color: AppColors.whitebg,
//                         ),
//                         child: Center(
//                           child: Text(
//                             '₹55,526',
//                             style: TextStyle(
//                               color: AppColors.secondary,
//                               fontSize: 32,
//                               fontWeight: FontWeight.w500,
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//                 Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       "Today's Collection",
//                       style: TextStyle(
//                         color: AppColors.primary,
//                         fontSize: 14,
//                         fontWeight: FontWeight.w500,
//                       ),
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.only(left: 10, top: 10),
//                       child: Container(
//                         height: 65,
//                         width: width * 0.40,
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(12),
//                           color: AppColors.whitebg,
//                         ),
//                         child: Center(
//                           child: Text(
//                             '₹75,982',
//                             style: TextStyle(
//                               color: AppColors.green,
//                               fontSize: 32,
//                               fontWeight: FontWeight.w500,
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//             Container(
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                 children: [
//                   SizedBox(width: width * 0.02),
//                   Column(
//                     children: [
//                       SizedBox(height: height * 0.01),
//                       IconButton(
//                         onPressed: () {
//                           showModalBottomSheet(
//                             context: context,
//                             isScrollControlled: true,
//                             shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
//                             ),
//                             builder: (context) {
//                               return Scheme();
//                             },
//                           );
//                         },
//                         icon: Container(
//                           height: 62,
//                           width: 62,
//                           decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(12),
//                             color: AppColors.background,
//                           ),
//                           child: SvgPicture.asset('assets/images/Scheme.svg', fit: BoxFit.none),
//                         ),
//                       ),
//                       SizedBox(height: 5),
//                       Text(
//                         'Add Scheme',
//                         style: TextStyle(
//                           color: AppColors.secondary,
//                           fontSize: 16,
//                           fontWeight: FontWeight.w500,
//                         ),
//                       ),
//                     ],
//                   ),
//                   SizedBox(width: width * 0.05),
//                   Column(
//                     children: [
//                       SizedBox(height: height * 0.01),
//                       IconButton(
//                         onPressed: () {
//                           showModalBottomSheet(
//                             context: context,
//                             isScrollControlled: true,
//                             shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
//                             ),
//                             builder: (context) {
//                               return CreditCustomer();
//                             },
//                           );
//                         },
//                         icon: Container(
//                           height: 62,
//                           width: 62,
//                           decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(12),
//                             color: AppColors.background,
//                           ),
//                           child: SvgPicture.asset('assets/images/Credit.svg', fit: BoxFit.none),
//                         ),
//                       ),
//                       SizedBox(height: 5),
//                       Text(
//                         'Create Customer',
//                         style: TextStyle(
//                           color: AppColors.secondary,
//                           fontSize: 16,
//                           fontWeight: FontWeight.w500,
//                         ),
//                       ),
//                     ],
//                   ),
//                   SizedBox(width: width * 0.02),
//                   Column(
//                     children: [
//                       SizedBox(height: height * 0.01),
//                       IconButton(
//                         onPressed: () {
//                           showModalBottomSheet(
//                             context: context,
//                             isScrollControlled: true,
//                             shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
//                             ),
//                             builder: (context) {
//                               return Tanker();
//                             },
//                           );
//                         },
//                         icon: Container(
//                           height: 62,
//                           width: 62,
//                           decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(12),
//                             color: AppColors.background,
//                           ),
//                           child: SvgPicture.asset('assets/images/Tanker.svg', fit: BoxFit.none),
//                         ),
//                       ),
//                       SizedBox(height: 5),
//                       Text(
//                         'Create Tanker',
//                         style: TextStyle(
//                           color: AppColors.secondary,
//                           fontSize: 16,
//                           fontWeight: FontWeight.w500,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/cupertino.dart' hide Widget;
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart' hide Widget;
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../../Authentication/LoginScreen.dart';
import '../../Authentication/login_controller.dart';
import '../../Data/AppDialoge.dart';
import '../../Myrecord/NamedetailScreen.dart';
import '../../Utils/Const.dart';
import '../../Widgets/AlertDialog.dart';
import '../../Widgets/ManualScreen.dart';
import '../../Widgets/NotificationsScreen.dart';
import '../../Widgets/appbar/main_app_bar.dart';
import '../../controllers/collectioncontroller.dart';
import '../../utils/colors.dart';
import '../../utils/preference.dart';
import '../AddRequestScreen.dart';
import '../ProfileScreen.dart';
import '../Truck/ExpensesScreen.dart';
import '../Truck/TaskListScreen.dart';
import 'CreditCustomer/CreateCustomer.dart' hide Widget;
import 'Customer/SchemeUsers.dart';
import 'Staff/Staff.dart';



class AdminDashBoard extends StatefulWidget {
  const AdminDashBoard({Key? key}) : super(key: key);

  @override
  State<AdminDashBoard> createState() => _AdminDashBoardState();
}

class _AdminDashBoardState extends State<AdminDashBoard> {
  final LoginController loginController = Get.put(LoginController());
  final TodayCollectionController collectionController = Get.put(TodayCollectionController());
  String userName = 'Admin';
  String greetingMessage = 'Good Morning, Have a nice day!';

  @override
  void initState() {
    super.initState();
    _initializeUserData();
    _updateGreeting();
    collectionController.getTodayCollection();
  }

  void _initializeUserData() {
    // Get user name from the LoginController
    if (loginController.loginUserModel.value.data?.name != null) {
      userName = loginController.loginUserModel.value.data!.name!;
      // Save user name to SharedPreferences for future use
      _saveUserNameToPreferences(userName);
    } else {
      // If not available in controller, try to get from SharedPreferences
      _getUserNameFromPreferences();
    }
  }

  void _saveUserNameToPreferences(String name) async {
    await Preference.saveSharedPrefString('user_name', name);
  }

  void _getUserNameFromPreferences() async {
    String? savedUserName = await Preference.getSharedPref('user_name');
    if (savedUserName != null && savedUserName.isNotEmpty) {
      setState(() {
        userName = savedUserName;
      });
    }
  }

  void _updateGreeting() {
    final now = DateTime.now();
    final hour = now.hour;

    setState(() {
      if (hour >= 5 && hour < 12) {
        greetingMessage = 'Good Morning, Have a nice day!';
      } else if (hour >= 12 && hour < 17) {
        greetingMessage = 'Good Afternoon, Have a productive day!';
      } else if (hour >= 17 && hour < 21) {
        greetingMessage = 'Good Evening, Hope you had a great day!';
      } else {
        greetingMessage = 'Good Night, Take care and rest well!';
      }
    });
  }

  String _getDisplayName() {
    if (userName.length > 15) {
      return userName.substring(0, 15) + '..';
    }
    return userName;
  }

  void showCreateBranchDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => CreateBranchDialog(),
    );
  }

  void showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        backgroundColor: AppColors.background,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        title: Row(
          children: [
            Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.red.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                Icons.logout_rounded,
                color: Colors.red.shade600,
                size: 20,
              ),
            ),
            SizedBox(width: 12),
            Text(
              'Logout',
              style: TextStyle(
                color: AppColors.secondary,
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        content: Text(
          'Are you sure you want to logout?',
          style: TextStyle(
            color: AppColors.secondary.withOpacity(0.7),
            fontSize: 14,
          ),
        ),
        actions: [
          Container(
            width: double.infinity,
            child: Row(
              children: [
                Expanded(
                  child: TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    style: TextButton.styleFrom(
                      backgroundColor: AppColors.whitebg,
                      foregroundColor: AppColors.secondary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: EdgeInsets.symmetric(vertical: 12),
                    ),
                    child: Text(
                      'Cancel',
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: TextButton(
                    onPressed: () async {
                      await performLogout(context);
                    },
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.red.shade600,
                      foregroundColor: AppColors.background,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: EdgeInsets.symmetric(vertical: 12),
                    ),
                    child: Text(
                      'Logout',
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> performLogout(BuildContext context) async {
    try {
      // Clear saved preferences using your Preference class
      await Preference.removePrefKey(KEY_TOKEN);
      await Preference.removePrefKey('user_name'); // Clear user name as well
      await Preference.saveSharedPrefBool(KEY_LOGIN, false);

      // Close the dialog
      Navigator.of(context).pop();

      // Show logout success message
      Appdialogs.showToast('Logged out successfully');

      // Navigate to login screen and clear navigation stack
      Get.offAll(() => LoginScreen());

    } catch (e) {
      // Close the dialog
      Navigator.of(context).pop();

      // Show error message
      Appdialogs.showToast('Logout failed. Please try again.');

      print('Logout error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    // Get MediaQuery data
    final mediaQuery = MediaQuery.of(context);
    final width = mediaQuery.size.width;
    final height = mediaQuery.size.height;

    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.background,
        appBar: MainAppBar(
          logoPath: 'assets/images/HSB.png',
          backgroundColor: AppColors.background,
          iconColor: AppColors.text,
          actions: [
            AppBarActionItem(
              imagePath: 'assets/svg_icons/notification.svg',
              color: AppColors.secondary, // optional override
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => NotificationsScreen()));
              },
            ),
            AppBarActionItem(
              imagePath: 'assets/svg_icons/appbar-settings.svg',
              color: AppColors.secondary, // optional override
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => ManualScreen()));
              },
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: height * 0.02),
              Container(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 2),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Truck',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: AppColors.primary,
                        ),
                      ),
                      Text(
                        'Welcome,${_getDisplayName()}',
                        maxLines: 1,

                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.w600,
                          color: AppColors.secondary,
                        ),
                      ),

                      Text("Today's Analytics Updates", style: TextStyle(fontWeight: FontWeight.bold)),

                       SizedBox(height: 10,)
,
                      // SingleChildScrollView(
                      //   keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
                      //   child: Row(
                      //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      //     children: [
                      //
                      //       Column(
                      //
                      //         children: [
                      //           Text("Opening Reading(Automatic)", style: TextStyle(fontWeight: FontWeight.bold,color: AppColors.primary)),
                      //           SizedBox(height: 10,),
                      //
                      //           Container(
                      //             height: 70,
                      //             width: 180,
                      //             child: TextField(
                      //               autofocus: false, // Important: prevents keyboard from opening automatically
                      //               keyboardType: TextInputType.number,
                      //               decoration: InputDecoration(
                      //                 contentPadding: const EdgeInsets.symmetric(vertical: 12),
                      //                 enabledBorder: OutlineInputBorder(
                      //                   borderRadius: BorderRadius.circular(12),
                      //                   borderSide: BorderSide(
                      //                     color: AppColors.primary,
                      //                     width: 1,
                      //                   ),
                      //                 ),
                      //                 focusedBorder: OutlineInputBorder(
                      //                   borderRadius: BorderRadius.circular(12),
                      //                   borderSide: BorderSide(
                      //                     color: AppColors.primary,
                      //                     width: 2,
                      //                   ),
                      //                 ),
                      //                 border: OutlineInputBorder(
                      //                   borderRadius: BorderRadius.circular(12),
                      //                   borderSide: BorderSide(
                      //                     color: AppColors.primary,
                      //                     width: 1,
                      //                   ),
                      //                 ),
                      //               ),
                      //             ),
                      //           ),
                      //           // SizedBox(
                      //           //   width: 180, // Button width
                      //           //   height: 40, // Button height
                      //           //   child: ElevatedButton(
                      //           //     style: ElevatedButton.styleFrom(
                      //           //       backgroundColor: AppColors.primary,
                      //           //       shape: RoundedRectangleBorder(
                      //           //         borderRadius: BorderRadius.circular(12),
                      //           //       ),
                      //           //     ),
                      //           //     onPressed: () {
                      //           //       // Add your save logic here
                      //           //       print("Save button clicked");
                      //           //     },
                      //           //     child: Text(
                      //           //       "Save",
                      //           //       style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                      //           //     ),
                      //           //   ),
                      //           // ),
                      //           // SizedBox(height: 10,),
                      //         ],
                      //       ),
                      //       Column(
                      //         children: [
                      //           Text("Closing Reading(Automatic)", style: TextStyle(fontWeight: FontWeight.bold,color: AppColors.primary)),
                      //           SizedBox(height: 10,),
                      //           Container(
                      //             height: 70,
                      //             width: 180,
                      //             child: TextField(
                      //               autofocus: false, // Important: prevents keyboard from opening automatically
                      //               keyboardType: TextInputType.number,
                      //               decoration: InputDecoration(
                      //                 contentPadding: const EdgeInsets.symmetric(vertical: 12),
                      //                 enabledBorder: OutlineInputBorder(
                      //                   borderRadius: BorderRadius.circular(12),
                      //                   borderSide: BorderSide(
                      //                     color: AppColors.primary,
                      //                     width: 1,
                      //                   ),
                      //                 ),
                      //                 focusedBorder: OutlineInputBorder(
                      //                   borderRadius: BorderRadius.circular(12),
                      //                   borderSide: BorderSide(
                      //                     color: AppColors.primary,
                      //                     width: 2,
                      //                   ),
                      //                 ),
                      //                 border: OutlineInputBorder(
                      //                   borderRadius: BorderRadius.circular(12),
                      //                   borderSide: BorderSide(
                      //                     color: AppColors.primary,
                      //                     width: 1,
                      //                   ),
                      //                 ),
                      //               ),
                      //             ),
                      //           ),
                      //           // SizedBox(
                      //           //   width: 180, // Button width
                      //           //   height: 40, // Button height
                      //           //   child: ElevatedButton(
                      //           //     style: ElevatedButton.styleFrom(
                      //           //       backgroundColor: AppColors.primary,
                      //           //       shape: RoundedRectangleBorder(
                      //           //         borderRadius: BorderRadius.circular(12),
                      //           //       ),
                      //           //     ),
                      //           //     onPressed: () {
                      //           //       // Add your save logic here
                      //           //       print("Save button clicked");
                      //           //     },
                      //           //     child: Text(
                      //           //       "Save",
                      //           //       style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                      //           //     ),
                      //           //   ),
                      //           // ),
                      //           // SizedBox(height: 10,),
                      //         ],
                      //       ),
                      //     ],
                      //   ),
                      // ),
                      //
                      // SingleChildScrollView(
                      //   keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
                      //   child: Row(
                      //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      //     children: [
                      //
                      //       Column(
                      //         children: [
                      //           Text("Opening Reading(Manual)", style: TextStyle(fontWeight: FontWeight.bold,color: AppColors.primary)),
                      //           SizedBox(height: 10,),
                      //           Container(
                      //             height: 70,
                      //             width: 180,
                      //             child: TextField(
                      //               autofocus: false, // Important: prevents keyboard from opening automatically
                      //               keyboardType: TextInputType.number,
                      //               decoration: InputDecoration(
                      //                 contentPadding: const EdgeInsets.symmetric(vertical: 12),
                      //                 enabledBorder: OutlineInputBorder(
                      //                   borderRadius: BorderRadius.circular(12),
                      //                   borderSide: BorderSide(
                      //                     color: AppColors.primary,
                      //                     width: 1,
                      //                   ),
                      //                 ),
                      //                 focusedBorder: OutlineInputBorder(
                      //                   borderRadius: BorderRadius.circular(12),
                      //                   borderSide: BorderSide(
                      //                     color: AppColors.primary,
                      //                     width: 2,
                      //                   ),
                      //                 ),
                      //                 border: OutlineInputBorder(
                      //                   borderRadius: BorderRadius.circular(12),
                      //                   borderSide: BorderSide(
                      //                     color: AppColors.primary,
                      //                     width: 1,
                      //                   ),
                      //                 ),
                      //               ),
                      //             ),
                      //           ),
                      //           // SizedBox(
                      //           //   width: 180, // Button width
                      //           //   height: 40, // Button height
                      //           //   child: ElevatedButton(
                      //           //     style: ElevatedButton.styleFrom(
                      //           //       backgroundColor: AppColors.primary,
                      //           //       shape: RoundedRectangleBorder(
                      //           //         borderRadius: BorderRadius.circular(12),
                      //           //       ),
                      //           //     ),
                      //           //     onPressed: () {
                      //           //       // Add your save logic here
                      //           //       print("Save button clicked");
                      //           //     },
                      //           //     child: Text(
                      //           //       "Save",
                      //           //       style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                      //           //     ),
                      //           //   ),
                      //           // ),
                      //           // SizedBox(height: 10,),
                      //         ],
                      //       ),
                      //       Column(
                      //         children: [
                      //           Text("Closing Reading(Manual)", style: TextStyle(fontWeight: FontWeight.bold,color: AppColors.primary)),
                      //           SizedBox(height: 10,),
                      //           Container(
                      //             height: 70,
                      //             width: 180,
                      //             child: TextField(
                      //               autofocus: false, // Important: prevents keyboard from opening automatically
                      //               keyboardType: TextInputType.number,
                      //               decoration: InputDecoration(
                      //                 contentPadding: const EdgeInsets.symmetric(vertical: 12),
                      //                 enabledBorder: OutlineInputBorder(
                      //                   borderRadius: BorderRadius.circular(12),
                      //                   borderSide: BorderSide(
                      //                     color: AppColors.primary,
                      //                     width: 1,
                      //                   ),
                      //                 ),
                      //                 focusedBorder: OutlineInputBorder(
                      //                   borderRadius: BorderRadius.circular(12),
                      //                   borderSide: BorderSide(
                      //                     color: AppColors.primary,
                      //                     width: 2,
                      //                   ),
                      //                 ),
                      //                 border: OutlineInputBorder(
                      //                   borderRadius: BorderRadius.circular(12),
                      //                   borderSide: BorderSide(
                      //                     color: AppColors.primary,
                      //                     width: 1,
                      //                   ),
                      //                 ),
                      //               ),
                      //             ),
                      //           ),
                      //           // SizedBox(
                      //           //   width: 180, // Button width
                      //           //   height: 40, // Button height
                      //           //   child: ElevatedButton(
                      //           //     style: ElevatedButton.styleFrom(
                      //           //       backgroundColor: AppColors.primary,
                      //           //       shape: RoundedRectangleBorder(
                      //           //         borderRadius: BorderRadius.circular(12),
                      //           //       ),
                      //           //     ),
                      //           //     onPressed: () {
                      //           //       // Add your save logic here
                      //           //       print("Save button clicked");
                      //           //     },
                      //           //     child: Text(
                      //           //       "Save",
                      //           //       style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                      //           //     ),
                      //           //   ),
                      //           // ),
                      //           // SizedBox(height: 10,),
                      //         ],
                      //       ),
                      //     ],
                      //   ),
                      // ),
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      //   children: [
                      //     Column(
                      //       children: [
                      //         ImagePickerWidget(
                      //           title: "Opening Reading (image)",
                      //           onImagePicked: (file) {
                      //             // Use the selected opening image here
                      //             print("Opening image selected: ${file?.path}");
                      //           },
                      //         ),
                      //         SizedBox(height: 10,),
                      //         // SizedBox(
                      //         //   width: 180, // Button width
                      //         //   height: 40, // Button height
                      //         //   child: ElevatedButton(
                      //         //     style: ElevatedButton.styleFrom(
                      //         //       backgroundColor: AppColors.primary,
                      //         //       shape: RoundedRectangleBorder(
                      //         //         borderRadius: BorderRadius.circular(12),
                      //         //       ),
                      //         //     ),
                      //         //     onPressed: () {
                      //         //       // Add your save logic here
                      //         //       print("Save button clicked");
                      //         //     },
                      //         //     child: Text(
                      //         //       "Save",
                      //         //       style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                      //         //     ),
                      //         //   ),
                      //         // ),
                      //         // SizedBox(height: 10,),
                      //       ],
                      //     ),
                      //
                      //     Column(
                      //       children: [
                      //         ImagePickerWidget(
                      //           title: "Closing Reading (image)",
                      //           onImagePicked: (file) {
                      //             // Use the selected closing image here
                      //             print("Closing image selected: ${file?.path}");
                      //           },
                      //         ),
                      //         SizedBox(height: 10,),
                      //
                      //       ],
                      //     ),
                      //   ],
                      // ),
                      // SizedBox(height: 10,),
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      //   children: [
                      //     SizedBox(
                      //       width: 180, // Button width
                      //       height: 50, // Button height
                      //       child: ElevatedButton(
                      //         style: ElevatedButton.styleFrom(
                      //           backgroundColor: AppColors.primary,
                      //           shape: RoundedRectangleBorder(
                      //             borderRadius: BorderRadius.circular(12),
                      //           ),
                      //         ),
                      //         onPressed: () {
                      //           // Add your save logic here
                      //           print("Save button clicked");
                      //         },
                      //         child: Text(
                      //           "Save",
                      //           style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                      //         ),
                      //       ),
                      //     ),
                      //     SizedBox(
                      //       width: 180, // Button width
                      //       height: 50, // Button height
                      //       child: ElevatedButton(
                      //         style: ElevatedButton.styleFrom(
                      //           backgroundColor: AppColors.primary,
                      //           shape: RoundedRectangleBorder(
                      //             borderRadius: BorderRadius.circular(12),
                      //           ),
                      //         ),
                      //         onPressed: () {
                      //           // Add your save logic here
                      //           print("Save button clicked");
                      //         },
                      //         child: Text(
                      //           "Save",
                      //           style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                      //         ),
                      //       ),
                      //     ),
                      //   ],
                      // ),
                      //
                      //
                      //
                      // SizedBox(height: 10,),

                      // Wrap(
                      //   spacing: 24,
                      //   runSpacing: 24,
                      //   children: [
                      //     // Row(children: [
                      //     //   TextField(
                      //     //     decoration: InputDecoration(
                      //     //       contentPadding: const EdgeInsets.symmetric(vertical: 12),
                      //     //       enabledBorder: OutlineInputBorder(
                      //     //         borderRadius: BorderRadius.circular(12),
                      //     //         borderSide: BorderSide(
                      //     //           color: AppColors.primary,
                      //     //           width: 1,
                      //     //         ),
                      //     //       ),
                      //     //       focusedBorder: OutlineInputBorder(
                      //     //         borderRadius: BorderRadius.circular(12),
                      //     //         borderSide: BorderSide(
                      //     //           color: AppColors.primary,
                      //     //           width: 2,
                      //     //         ),
                      //     //       ),
                      //     //       border: OutlineInputBorder(
                      //     //         borderRadius: BorderRadius.circular(12),
                      //     //         borderSide: BorderSide(
                      //     //           color: AppColors.primary,
                      //     //           width: 1,
                      //     //         ),
                      //     //       ),
                      //     //     ),
                      //     //   ),
                      //     //   SizedBox(width: 10,),
                      //     //   TextField(
                      //     //     decoration: InputDecoration(
                      //     //       contentPadding: const EdgeInsets.symmetric(vertical: 12),
                      //     //       enabledBorder: OutlineInputBorder(
                      //     //         borderRadius: BorderRadius.circular(12),
                      //     //         borderSide: BorderSide(
                      //     //           color: AppColors.primary,
                      //     //           width: 1,
                      //     //         ),
                      //     //       ),
                      //     //       focusedBorder: OutlineInputBorder(
                      //     //         borderRadius: BorderRadius.circular(12),
                      //     //         borderSide: BorderSide(
                      //     //           color: AppColors.primary,
                      //     //           width: 2,
                      //     //         ),
                      //     //       ),
                      //     //       border: OutlineInputBorder(
                      //     //         borderRadius: BorderRadius.circular(12),
                      //     //         borderSide: BorderSide(
                      //     //           color: AppColors.primary,
                      //     //           width: 1,
                      //     //         ),
                      //     //       ),
                      //     //     ),
                      //     //   ),
                      //     // ],),
                      //     // analyticsTile('Employees on Leave', '3'),
                      //     // analyticsTile('Something Else', '2'),
                      //   ],
                      // ),
                    ],
                  ),
                ),
              ),



              //ok
              // SizedBox(height: height * 0.03),
              // SizedBox(height: height * 0.02),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: width,
                  height: 300,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.vertical(top: Radius.circular(16),bottom: Radius.circular(16)),
                    color: AppColors.button,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [

                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(height: height * 0.01),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(context, MaterialPageRoute(builder: (context) => ExpenseDetailsScreen()));
                                  },
                                  child: Container(
                                    height: 62,
                                    width: 62,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12),
                                      color: AppColors.background,
                                    ),
                                    child: SvgPicture.asset('assets/Truck/TruckExpenses.svg', fit: BoxFit.none),
                                  ),
                                ),
                                SizedBox(height: 5),
                                Text(
                                  'Add Expenses',
                                  style: TextStyle(
                                    color: AppColors.background,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),

                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(height: height * 0.01),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(context, MaterialPageRoute(builder: (context) => NameDetailsScreen(

                                    )));
                                  },
                                  child: Container(
                                    height: 62,
                                    width: 62,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12),
                                      color: AppColors.background,
                                    ),
                                    child: SvgPicture.asset('assets/Truck/TruckRecord.svg',fit: BoxFit.none,),
                                  ),
                                ),
                                SizedBox(height: 5),
                                Text(
                                  'My Record',
                                  style: TextStyle(
                                    color: AppColors.background,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(width: width * 0.02),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(height: height * 0.01),
                                GestureDetector(
                                  onTap: () {
                                    showModalBottomSheet(
                                      context: context,
                                      isScrollControlled: true,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
                                      ),
                                      builder: (context) {
                                        return TaskListScreen();// Call the CustomerScreen directly
                                      },
                                    );
                                  },
                                  child: Container(
                                    height: 62,
                                    width: 62,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12),
                                      color: AppColors.background,
                                    ),
                                    child: SvgPicture.asset('assets/Truck/Task.svg', fit: BoxFit.none),
                                  ),
                                ),
                                SizedBox(height: 5),
                                Text(
                                  'New Task',
                                  style: TextStyle(
                                    color: AppColors.background,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(height: 10,),
                        Padding(
                          padding: const EdgeInsets.only(left: 50),
                          child: Row(
                            children: [
                              Column(
                                children: [
                                  SizedBox(height: height * 0.01),

                                  GestureDetector(
                                    onTap: () {
                                      _showAddRequestBottomSheet(context);
                                    },
                                    child: Container(
                                      height: 62,
                                      width: 62,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(12),
                                        color: AppColors.background,
                                      ),
                                      child: SvgPicture.asset('assets/images/Requests.svg', fit: BoxFit.none),
                                    ),
                                  ),
                                  SizedBox(height: 5),
                                  Text(
                                    'Request',
                                    style: TextStyle(
                                      color: AppColors.background,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(width: width * 0.13),
                              Column(
                                children: [
                                  SizedBox(height: height * 0.01),
                                  GestureDetector(
                                    onTap: () {
                                      showModalBottomSheet(
                                        context: context,
                                        isScrollControlled: true,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
                                        ),
                                        builder: (context) {
                                          return EmployeeProfileScreen();},
                                      );
                                    },
                                    child: Container(
                                      height: 62,
                                      width: 62,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(12),
                                        color: AppColors.background,
                                      ),
                                      child: SvgPicture.asset('assets/images/settings.svg', fit: BoxFit.none),
                                    ),
                                  ),
                                  SizedBox(height: 5),
                                  Text(
                                    'Setting',
                                    style: TextStyle(
                                      color: AppColors.background,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                              // SizedBox(width: width * 0.02),
                              // Column(
                              //   children: [
                              //     SizedBox(height: height * 0.01),
                              //     GestureDetector(
                              //       onTap: () {
                              //         Navigator.push(context, MaterialPageRoute(builder: (context) => Tanker()));
                              //       },
                              //       child: Container(
                              //         height: 62,
                              //         width: 62,
                              //         decoration: BoxDecoration(
                              //           borderRadius: BorderRadius.circular(12),
                              //           color: AppColors.background,
                              //         ),
                              //         child: SvgPicture.asset('assets/images/Tanker.svg', fit: BoxFit.none),
                              //       ),
                              //     ),
                              //     SizedBox(height: 5),
                              //     Text(
                              //       'Create Tanker',
                              //       style: TextStyle(
                              //         color: AppColors.background,
                              //         fontSize: 16,
                              //         fontWeight: FontWeight.w500,
                              //       ),
                              //     ),
                              //   ],
                              // ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),


                ),
              ),



            ],
          ),
        ),
      ),
    );
  }
}
void _showAddRequestBottomSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
    ),
    builder: (context) {
      return Container(
        height: MediaQuery.of(context).size.height * 0.85,
        child: AddRequestScreen(),
      );
    },
  );
}
Widget analyticsTile(String title, String count) {
  return Container(
    width: 180,
    height: 70,
    decoration: BoxDecoration(
      color: Colors.indigo[900],
      borderRadius: BorderRadius.circular(12),
    ),
    child: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(title, style: TextStyle(color: Colors.white, fontSize: 12)),
          SizedBox(height: 4),
          Text(count, style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
        ],
      ),
    ),
  );
}