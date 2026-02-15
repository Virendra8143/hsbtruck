//
// import 'package:flutter/material.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:get/get.dart';
// import 'package:get/get_core/src/get_main.dart';
// import 'package:petrolpump/controllers/AdminController/AddSchemeController.dart';
// import '../../../utils/colors.dart';
//
// class CreateNewSchemesName extends StatefulWidget {
//   const CreateNewSchemesName({super.key});
//
//   @override
//   State<CreateNewSchemesName> createState() => _CreateNewSchemesNameState();
// }
//
// class _CreateNewSchemesNameState extends State<CreateNewSchemesName> {
//   final AddSchemeController addSchemeController = Get.put(AddSchemeController());
//   final _formKey = GlobalKey<FormState>();
//
//   @override
//   Widget build(BuildContext context) {
//     final screenSize = MediaQuery.of(context).size;
//     final keyboardHeight = MediaQuery.of(context).viewInsets.bottom;
//
//     return Stack(
//       clipBehavior: Clip.none,
//       children: [
//         SingleChildScrollView(
//           padding: EdgeInsets.only(bottom: keyboardHeight),
//           child: Container(
//             width: screenSize.width * 0.99,
//             padding: const EdgeInsets.all(16),
//             child: Form(
//               key: _formKey,
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   const SizedBox(height: 20),
//                   Row(
//                     children: [
//                       SvgPicture.asset('assets/images/CreateProducticon.svg'),
//                       const SizedBox(width: 10),
//                       Expanded(
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Text(
//                               'Create New Scheme Name',
//                               style: TextStyle(
//                                 fontWeight: FontWeight.w500,
//                                 fontSize: 24,
//                                 color: AppColors.secondary,
//                               ),
//                             ),
//                             Text(
//                               'Add new schemes Name here',
//                               style: TextStyle(
//                                 fontWeight: FontWeight.w400,
//                                 fontSize: 14,
//                                 color: AppColors.icon,
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                   const SizedBox(height: 40),
//
//                   // Scheme Name Field with Validation and Borders
//                   SizedBox(
//                     width: screenSize.width * 0.9,
//                     child: TextFormField(
//                       controller: addSchemeController.nameController,
//                       validator: (value) {
//                         if (value == null || value.trim().isEmpty) {
//                           return 'Scheme name is required';
//                         }
//                         return null;
//                       },
//                       decoration: InputDecoration(
//                         labelText: "Enter new name for scheme",
//                         enabledBorder: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(12),
//                           borderSide: BorderSide(color: AppColors.primary, width: 1),
//                         ),
//                         focusedBorder: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(12),
//                           borderSide: BorderSide(color: AppColors.secondary, width: 2),
//                         ),
//                         errorBorder: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(12),
//                           borderSide: BorderSide(color: Colors.red, width: 1.5),
//                         ),
//                         focusedErrorBorder: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(12),
//                           borderSide: BorderSide(color: Colors.red, width: 2),
//                         ),
//                       ),
//                     ),
//                   ),
//                   const SizedBox(height: 20),
//
//                   // Submit Button
//                   SizedBox(
//                     height: 60,
//                     width: screenSize.width * 0.9,
//                     child: ElevatedButton(
//                       onPressed: () {
//                         if (_formKey.currentState!.validate()) {
//                           addSchemeController.createSchemeName(
//                             name: addSchemeController.nameController.text.trim(),
//                           );
//                           Navigator.pop(context);
//                         }
//                       },
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: AppColors.button,
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(10),
//                         ),
//                       ),
//                       child: Text(
//                         "Create Now",
//                         style: TextStyle(
//                           fontSize: 20,
//                           fontWeight: FontWeight.w500,
//                           color: AppColors.background,
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//
//         // X Icon to dismiss
//         Positioned(
//           top: -80,
//           left: screenSize.width * 0.5 - 30,
//           child: GestureDetector(
//             onTap: () {
//               Navigator.pop(context);
//             },
//             child: const CircleAvatar(
//               radius: 30,
//               backgroundColor: Colors.black54,
//               child: Icon(Icons.close, size: 40, color: Colors.white),
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }
//
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import '../../../controllers/AdminController/AddSchemeController.dart';
import '../../../utils/colors.dart';

class CreateNewSchemesName extends StatefulWidget {
  const CreateNewSchemesName({super.key});

  @override
  State<CreateNewSchemesName> createState() => _CreateNewSchemesNameState();
}

class _CreateNewSchemesNameState extends State<CreateNewSchemesName> {
  final AddSchemeController addSchemeController = Get.put(AddSchemeController());
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final keyboardHeight = MediaQuery.of(context).viewInsets.bottom;

    return Stack(
      clipBehavior: Clip.none,
      children: [
        SingleChildScrollView(
          padding: EdgeInsets.only(bottom: keyboardHeight),
          child: Container(
            width: screenSize.width * 0.99,
            padding: const EdgeInsets.all(16),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      SvgPicture.asset('assets/images/CreateProducticon.svg'),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Create New Scheme Name',
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 24,
                                color: AppColors.secondary,
                              ),
                            ),
                            Text(
                              'Add new schemes Name here',
                              style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 14,
                                color: AppColors.icon,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 40),

                  // Scheme Name Field with Validation and Borders
                  SizedBox(
                    width: screenSize.width * 0.9,
                    child: TextFormField(
                      controller: addSchemeController.nameController,
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Scheme name is required';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        labelText: "Enter new name for scheme",
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: AppColors.primary, width: 1),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: AppColors.secondary, width: 2),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: Colors.red, width: 1.5),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: Colors.red, width: 2),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Submit Button with Loading State
                  Obx(() => SizedBox(
                    height: 60,
                    width: screenSize.width * 0.9,
                    child: ElevatedButton(
                      onPressed: addSchemeController.isLoading.value
                          ? null
                          : () {
                        if (_formKey.currentState!.validate()) {
                          addSchemeController.createSchemeName(
                            name: addSchemeController.nameController.text.trim(),
                          );
                          Navigator.pop(context);
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.button,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: addSchemeController.isLoading.value
                          ? CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(AppColors.background),
                      )
                          : Text(
                        "Create Now",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                          color: AppColors.background,
                        ),
                      ),
                    ),
                  )),
                ],
              ),
            ),
          ),
        ),

        // X Icon to dismiss
        Positioned(
          top: -80,
          left: screenSize.width * 0.5 - 30,
          child: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: const CircleAvatar(
              radius: 30,
              backgroundColor: Colors.black54,
              child: Icon(Icons.close, size: 40, color: Colors.white),
            ),
          ),
        ),
      ],
    );
  }
}
