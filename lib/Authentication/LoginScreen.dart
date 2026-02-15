// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
//
// import '../Screens/Admin/AdminDashboard.dart';
// import '../utils/colors.dart';
// import '../Widgets/ManualScreen.dart';
// import 'login_controller.dart';
//
// class LoginScreen extends StatelessWidget {
//   final LoginController loginController = Get.put(LoginController());
//
//   @override
//   Widget build(BuildContext context) {
//     final mediaQuery = MediaQuery.of(context).size;
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: Padding(
//         padding: EdgeInsets.all(mediaQuery.width * 0.025),
//         child: SingleChildScrollView(
//           child: Form(
//             key: loginController.formKey,
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 SizedBox(height: mediaQuery.height * 0.06),
//                 Center(
//                   child: Column(
//                     children: [
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Image.asset(
//                             'assets/images/HSB.png',
//                             width: mediaQuery.width * 0.25,
//                             height: mediaQuery.height * 0.05,
//                           ),
//                           GestureDetector(
//                             onTap: () {
//                               Get.to(() => ManualScreen());
//                             },
//                             child: Image.asset(
//                               'assets/images/helplogo.png',
//                               width: mediaQuery.width * 0.08,
//                               height: mediaQuery.height * 0.06,
//                             ),
//                           ),
//                         ],
//                       ),
//                       SizedBox(height: mediaQuery.height * 0.03),
//                       Text(
//                         'Welcome To HSB Fuels',
//                         style: TextStyle(
//                           fontSize: mediaQuery.width * 0.08,
//                           fontWeight: FontWeight.w600,
//                           color: Colors.black,
//                         ),
//                       ),
//                       SizedBox(height: mediaQuery.height * 0.015),
//                       Text(
//                         'Please login to access your account.',
//                         style: TextStyle(
//                           fontSize: mediaQuery.width * 0.04,
//                           fontWeight: FontWeight.w400,
//                           color: Colors.black,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 SizedBox(height: mediaQuery.height * 0.05),
//                 TextFormField(
//                   controller: loginController.workIdController.value,
//                   decoration: InputDecoration(
//                     labelText: 'Enter your work id',
//                     border: OutlineInputBorder(),
//                   ),
//                   validator: (value) {
//                     if (value == null || value.isEmpty) {
//                       return 'Please enter your work ID';
//                     }
//                     return null;
//                   },
//                 ),
//                 SizedBox(height: mediaQuery.height * 0.02),
//                 TextFormField(
//                   controller: loginController.passwordController.value,
//                   obscureText: true,
//                   decoration: InputDecoration(
//                     labelText: 'Password',
//                     border: OutlineInputBorder(),
//                   ),
//                   validator: (value) {
//                     if (value == null || value.isEmpty) {
//                       return 'Please enter your password';
//                     }
//                     if (value.length < 6) {
//                       return 'Password must be at least 6 characters';
//                     }
//                     return null;
//                   },
//                 ),
//                 SizedBox(height: mediaQuery.height * 0.03),
//                 SizedBox(height: mediaQuery.height * 0.02),
//
//                 // Enhanced Login Button with Progress Indicator
//                 Obx(() => ElevatedButton(
//                       onPressed: loginController.proccessing.value
//                           ? null
//                           : () {
//                               loginController.loginUser();
//                             },
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: loginController.proccessing.value
//                             ? AppColors.primary.withOpacity(0.6)
//                             : AppColors.primary,
//                         minimumSize:
//                             Size(double.infinity, mediaQuery.height * 0.07),
//                       ),
//                       child: loginController.proccessing.value
//                           ? Row(
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               children: [
//                                 SizedBox(
//                                   width: 20,
//                                   height: 20,
//                                   child: CircularProgressIndicator(
//                                     strokeWidth: 2,
//                                     valueColor: AlwaysStoppedAnimation<Color>(
//                                         Colors.white),
//                                   ),
//                                 ),
//                                 SizedBox(width: 10),
//                                 Text(
//                                   'Logging in...',
//                                   style: TextStyle(
//                                     fontSize: mediaQuery.width * 0.05,
//                                     fontWeight: FontWeight.w500,
//                                     color: Colors.white,
//                                   ),
//                                 ),
//                               ],
//                             )
//                           : Text(
//                               'Login',
//                               style: TextStyle(
//                                 fontSize: mediaQuery.width * 0.05,
//                                 fontWeight: FontWeight.w500,
//                                 color: Colors.white,
//                               ),
//                             ),
//                     )),
//                 SizedBox(height: mediaQuery.height * 0.02),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../Screens/Admin/AdminDashboard.dart';
import '../Widgets/appbar/main_app_bar.dart';
import '../utils/colors.dart';
import '../Widgets/ManualScreen.dart';
import 'login_controller.dart';

class LoginScreen extends StatelessWidget {
  final LoginController loginController = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.whitebg,
        appBar: MainAppBar(
          logoPath: 'assets/images/HSB.png',
          backgroundColor: AppColors.whitebg,
          iconColor: AppColors.text,
          actions: [
            AppBarActionItem(
              imagePath: 'assets/svg_icons/help.svg',
              label: 'Help',
              color: AppColors.primary, // optional override
              onTap: () {},
            ),
          ],
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: mediaQuery.width * 0.045,vertical: mediaQuery.width * 0.025),
          child: SingleChildScrollView(
            child: Form(
              key: loginController.formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: mediaQuery.height * 0.06),
                  Center(
                    child: Column(
                      children: [
                        Text(
                          'Welcome To Truck',
                          style: TextStyle(
                            fontSize: mediaQuery.width * 0.08,
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(height: mediaQuery.height * 0.015),
                        Text(
                          'Please login to access your account.',
                          style: TextStyle(
                            fontSize: mediaQuery.width * 0.04,
                            fontWeight: FontWeight.w400,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: mediaQuery.height * 0.05),
                  TextFormField(
                    controller: loginController.workIdController.value,
                    decoration: InputDecoration(
                      labelText: 'Enter Truck work id',
                      border: OutlineInputBorder(),
                      labelStyle: TextStyle(color: Colors.grey),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey), // Normal border color
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: AppColors.primary, width: 2), // Focused border color
                      ),
                      errorBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: AppColors.primary, width: 2), // When validation fails
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: AppColors.primary, width: 2),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your Truck work ID';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: mediaQuery.height * 0.02),
                  TextFormField(
                    controller: loginController.passwordController.value,
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      labelStyle: TextStyle(color: Colors.grey),
                      border: OutlineInputBorder(),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey), // Normal border color
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: AppColors.primary, width: 2), // Focused border color
                      ),
                      errorBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: AppColors.primary, width: 2), // When validation fails
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: AppColors.primary, width: 2),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your password';
                      }
                      return null;
                    },
                  ),

                  SizedBox(height: mediaQuery.height * 0.03),
                  SizedBox(height: mediaQuery.height * 0.02),

                  // Enhanced Login Button with Progress Indicator
                  Obx(() => ElevatedButton(
                    onPressed: loginController.proccessing.value
                        ? null
                        : () {
                      loginController.loginUser();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: loginController.proccessing.value
                          ? AppColors.primary.withOpacity(0.6)
                          : AppColors.primary,
                      minimumSize:
                      Size(double.infinity, mediaQuery.height * 0.07),
                    ),
                    child: loginController.proccessing.value
                        ? Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            valueColor: AlwaysStoppedAnimation<Color>(
                                Colors.white),
                          ),
                        ),
                        SizedBox(width: 10),
                        Text(
                          'Logging in...',
                          style: TextStyle(
                            fontSize: mediaQuery.width * 0.05,
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    )
                        : Text(
                      'Login',
                      style: TextStyle(
                        fontSize: mediaQuery.width * 0.05,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                    ),
                  )),
                  SizedBox(height: mediaQuery.height * 0.02),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}