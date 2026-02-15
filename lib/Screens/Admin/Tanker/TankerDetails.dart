//
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:get/get.dart';
// import 'package:intl/intl.dart';
//
// import '../../../controllers/AdminController/TankerController.dart';
// import '../../../utils/colors.dart';
//
// class TankerDetails extends StatefulWidget {
//   final String tankerId;
//
//   const TankerDetails({super.key, required this.tankerId});
//
//   @override
//   State<TankerDetails> createState() => _TankerDetailsState();
// }
//
// class _TankerDetailsState extends State<TankerDetails> {
//   final TankerController tankerController = Get.put(TankerController());
//
//   @override
//   void initState() {
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       tankerController.getTankerDetail(widget.tankerId);
//     });
//     super.initState();
//   }
//
//   // Function to format date (show only date, not time)
//   String _formatDate(String? dateString) {
//     if (dateString == null || dateString.isEmpty) return 'N/A';
//
//     try {
//       DateTime date = DateTime.parse(dateString);
//       return DateFormat('dd/MM/yyyy').format(date);
//     } catch (e) {
//       // If parsing fails, try to extract date part if it contains time
//       if (dateString.contains(' ')) {
//         return dateString.split(' ')[0];
//       }
//       return dateString;
//     }
//   }
//
//   // Function to copy text to clipboard and show success message
//   void _copyToClipboard(String text, String type) async {
//     try {
//       await Clipboard.setData(ClipboardData(text: text));
//       Get.snackbar(
//         'Success',
//         '$type copied successfully!',
//         snackPosition: SnackPosition.BOTTOM,
//         backgroundColor: Colors.green,
//         colorText: Colors.white,
//         duration: Duration(seconds: 2),
//         margin: EdgeInsets.all(16),
//         borderRadius: 8,
//         icon: Icon(Icons.check_circle, color: Colors.white),
//       );
//     } catch (e) {
//       Get.snackbar(
//         'Error',
//         'Failed to copy $type',
//         snackPosition: SnackPosition.BOTTOM,
//         backgroundColor: Colors.red,
//         colorText: Colors.white,
//         duration: Duration(seconds: 2),
//         margin: EdgeInsets.all(16),
//         borderRadius: 8,
//         icon: Icon(Icons.error, color: Colors.white),
//       );
//     }
//   }
//
//   Widget _buildInfoRow({
//     required String iconPath,
//     required String title,
//     required String value,
//     Color valueColor = AppColors.primary,
//     bool showCopyButton = false,
//     String? copyText,
//   }) {
//     return Container(
//       margin: EdgeInsets.symmetric(vertical: 8),
//       padding: EdgeInsets.all(16),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(12),
//         border: Border.all(color: Colors.grey.shade200),
//       ),
//       child: Row(
//         children: [
//           Container(
//             width: 40,
//             height: 40,
//             decoration: BoxDecoration(
//               color: AppColors.primary.withOpacity(0.1),
//               borderRadius: BorderRadius.circular(8),
//             ),
//             child: Center(
//               child: _buildIconWithFallback(
//                 assetName: iconPath,
//                 width: 20,
//                 height: 20,
//                 fallbackIcon: _getDefaultIconForTitle(title),
//               ),
//             ),
//           ),
//           SizedBox(width: 16),
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   title,
//                   style: TextStyle(
//                     fontWeight: FontWeight.w500,
//                     fontSize: 14,
//                     color: AppColors.secondary.withOpacity(0.7),
//                   ),
//                 ),
//                 SizedBox(height: 4),
//                 Text(
//                   value,
//                   style: TextStyle(
//                     fontWeight: FontWeight.w600,
//                     fontSize: 16,
//                     color: valueColor,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           if (showCopyButton)
//             InkWell(
//               onTap: () {
//                 _copyToClipboard(copyText ?? value, title);
//               },
//               borderRadius: BorderRadius.circular(20),
//               child: Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: Image.asset(
//                   'assets/images/Copy.png',
//                   color: AppColors.primary,
//                   width: 24,
//                   height: 24,
//                   errorBuilder: (context, error, stackTrace) {
//                     return Icon(
//                       Icons.copy,
//                       size: 24,
//                       color: AppColors.primary,
//                     );
//                   },
//                 ),
//               ),
//             ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildIconWithFallback({
//     required String assetName,
//     double? width,
//     double? height,
//     required IconData fallbackIcon,
//     Color? color,
//   }) {
//     // Check if asset is PNG or SVG
//     if (assetName.toLowerCase().endsWith('.png')) {
//       return Image.asset(
//         assetName,
//         width: width,
//         height: height,
//         color: color,
//         fit: BoxFit.contain,
//         errorBuilder: (context, error, stackTrace) {
//           return Icon(
//             fallbackIcon,
//             size: width,
//             color: color ?? AppColors.primary,
//           );
//         },
//       );
//     } else {
//       // Handle SVG assets
//       return SvgPicture.asset(
//         assetName,
//         width: width,
//         height: height,
//         color: color,
//         fit: BoxFit.contain,
//         errorBuilder: (context, error, stackTrace) {
//           return Icon(
//             fallbackIcon,
//             size: width,
//             color: color ?? AppColors.primary,
//           );
//         },
//       );
//     }
//   }
//
//   IconData _getDefaultIconForTitle(String title) {
//     switch (title.toLowerCase()) {
//       case 'registration number':
//         return Icons.local_shipping;
//       case 'tanker type':
//         return Icons.category;
//       case 'capacity':
//         return Icons.water;
//       case 'fitness certificate no.':
//       case 'pollution control cert. no.':
//       case 'insurance policy no.':
//       case 'permit number':
//       case 'driver license no.':
//         return Icons.description;
//       case 'fitness cert. expiry':
//       case 'pollution control expiry':
//       case 'insurance expiry':
//       case 'calibration date':
//       case 'created date':
//         return Icons.calendar_today;
//       case 'driver name':
//       case 'helper name':
//         return Icons.person;
//       case 'mobile number':
//         return Icons.phone;
//       case 'status':
//         return Icons.info;
//       case 'tanker id':
//         return Icons.numbers;
//       default:
//         return Icons.info;
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final mediaQuery = MediaQuery.of(context);
//     final screenHeight = mediaQuery.size.height;
//
//     return Stack(
//       clipBehavior: Clip.none,
//       children: [
//         Container(
//           height: screenHeight * 0.85,
//           decoration: BoxDecoration(
//             color: Colors.white,
//             borderRadius: BorderRadius.circular(16),
//           ),
//           child: Obx(
//                 () {
//               if (tankerController.isDetailLoading.value ||
//                   tankerController.tankerDetailModel.value.data == null ||
//                   tankerController.tankerDetailModel.value.data!.isEmpty) {
//                 return Center(
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       CircularProgressIndicator(
//                         color: AppColors.primary,
//                       ),
//                       SizedBox(height: 16),
//                       Text(
//                         'Loading Tanker Details...',
//                         style: TextStyle(
//                           color: AppColors.secondary,
//                           fontSize: 16,
//                         ),
//                       ),
//                     ],
//                   ),
//                 );
//               }
//
//               final data = tankerController.tankerDetailModel.value.data![0];
//
//               return Column(
//                 children: [
//                   // Sticky Header
//                   Container(
//                     padding: EdgeInsets.all(20),
//                     decoration: BoxDecoration(
//                       color: Colors.white,
//                       borderRadius: BorderRadius.only(
//                         topLeft: Radius.circular(16),
//                         topRight: Radius.circular(16),
//                       ),
//                       border: Border(
//                         bottom: BorderSide(
//                           color: Colors.grey.shade300,
//                           width: 1.0,
//                         ),
//                       ),
//                     ),
//                     child: Row(
//                       children: [
//                         Container(
//                           height: 60,
//                           width: 60,
//                           decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(12),
//                             color: AppColors.primary,
//                           ),
//                           child: Center(
//                             child: _buildIconWithFallback(
//                               assetName: 'assets/images/Tanker3.svg',
//                               width: 30,
//                               height: 30,
//                               color: Colors.white,
//                               fallbackIcon: Icons.local_shipping,
//                             ),
//                           ),
//                         ),
//                         SizedBox(width: 16),
//                         Expanded(
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Text(
//                                 'Tanker Details',
//                                 style: TextStyle(
//                                   fontWeight: FontWeight.w700,
//                                   fontSize: 20,
//                                   color: AppColors.secondary,
//                                 ),
//                               ),
//                               SizedBox(height: 4),
//                               Text(
//                                 'Complete tanker information overview',
//                                 style: TextStyle(
//                                   fontWeight: FontWeight.w400,
//                                   fontSize: 14,
//                                   color: AppColors.icon,
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//
//                   // Content Area
//                   Expanded(
//                     child: SingleChildScrollView(
//                       padding: EdgeInsets.all(16),
//                       child: Column(
//                         children: [
//                           // Registration Number
//                           _buildInfoRow(
//                             iconPath: 'assets/images/Tanker2.svg',
//                             title: 'Registration Number',
//                             value: data.registrationNumber ?? 'N/A',
//                           ),
//
//                           // Tanker Type
//                           _buildInfoRow(
//                             iconPath: 'assets/images/Tanker2.svg',
//                             title: 'Tanker Type',
//                             value: data.tankerType ?? 'N/A',
//                           ),
//
//                           // Capacity
//                           _buildInfoRow(
//                             iconPath: 'assets/images/Tanker2.svg',
//                             title: 'Capacity',
//                             value: data.capacity != null ? '${data.capacity} Litres' : 'N/A',
//                           ),
//
//                           // Fitness Certificate No.
//                           _buildInfoRow(
//                             iconPath: 'assets/images/aadhar number.svg',
//                             title: 'Fitness Certificate No.',
//                             value: data.fitnessCertNo ?? 'N/A',
//                           ),
//
//                           // Fitness Cert. Expiry
//                           _buildInfoRow(
//                             iconPath: 'assets/images/Calender.svg',
//                             title: 'Fitness Cert. Expiry',
//                             value: _formatDate(data.fitnessCertExpDate),
//                           ),
//
//                           // Pollution Control Cert. No.
//                           _buildInfoRow(
//                             iconPath: 'assets/images/aadhar number.svg',
//                             title: 'Pollution Control Cert. No.',
//                             value: data.pollutionControlCertNo ?? 'N/A',
//                           ),
//
//                           // Pollution Control Expiry
//                           _buildInfoRow(
//                             iconPath: 'assets/images/Calender.svg',
//                             title: 'Pollution Control Expiry',
//                             value: _formatDate(data.pollutionControlCertExpDate),
//                           ),
//
//                           // Insurance Policy No.
//                           _buildInfoRow(
//                             iconPath: 'assets/images/aadhar number.svg',
//                             title: 'Insurance Policy No.',
//                             value: data.insurancePolicyNumber ?? 'N/A',
//                           ),
//
//                           // Insurance Expiry
//                           _buildInfoRow(
//                             iconPath: 'assets/images/Calender.svg',
//                             title: 'Insurance Expiry',
//                             value: _formatDate(data.insuranceExpDate),
//                           ),
//
//                           // Calibration Date
//                           _buildInfoRow(
//                             iconPath: 'assets/images/Calender.svg',
//                             title: 'Calibration Date',
//                             value: _formatDate(data.calibrationDate),
//                           ),
//
//                           // Permit Number (if available)
//                           if (data.permitNumber != null && data.permitNumber!.isNotEmpty)
//                             _buildInfoRow(
//                               iconPath: 'assets/images/aadhar number.svg',
//                               title: 'Permit Number',
//                               value: data.permitNumber!,
//                             ),
//
//                           // Tanker ID with copy button
//                           _buildInfoRow(
//                             iconPath: 'assets/images/Tanker2.svg',
//                             title: 'Tanker ID',
//                             value: data.id?.toString() ?? 'N/A',
//                             showCopyButton: data.id?.toString().isNotEmpty == true,
//                             copyText: data.id?.toString(),
//                           ),
//
//                           // Created Date
//                           _buildInfoRow(
//                             iconPath: 'assets/images/Calender.svg',
//                             title: 'Created Date',
//                             value: _formatDate(data.createdDate),
//                           ),
//
//                           // Status
//                           // _buildInfoRow(
//                           //   iconPath: 'assets/images/activeicon.png',
//                           //   title: 'Status',
//                           //   value: data.status ?? 'N/A',
//                           //   valueColor: data.status?.toLowerCase() == 'active' ? Colors.green : AppColors.primary,
//                           // ),
//
//                           // Crew Information Section
//                           if (data.crewDriverName != null && data.crewDriverName!.isNotEmpty) ...[
//                             SizedBox(height: 16),
//                             // Crew Information Header
//                             Container(
//                               margin: EdgeInsets.symmetric(vertical: 8),
//                               padding: EdgeInsets.all(16),
//                               decoration: BoxDecoration(
//                                 color: AppColors.primary.withOpacity(0.05),
//                                 borderRadius: BorderRadius.circular(12),
//                                 border: Border.all(color: AppColors.primary.withOpacity(0.2)),
//                               ),
//                               child: Row(
//                                 children: [
//                                   Container(
//                                     width: 40,
//                                     height: 40,
//                                     decoration: BoxDecoration(
//                                       color: AppColors.primary.withOpacity(0.1),
//                                       borderRadius: BorderRadius.circular(8),
//                                     ),
//                                     child: Center(
//                                       child: Icon(
//                                         Icons.people,
//                                         size: 20,
//                                         color: AppColors.primary,
//                                       ),
//                                     ),
//                                   ),
//                                   SizedBox(width: 16),
//                                   Text(
//                                     'Crew Information',
//                                     style: TextStyle(
//                                       fontWeight: FontWeight.w600,
//                                       fontSize: 16,
//                                       color: AppColors.primary,
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//
//                             // Driver Name
//                             _buildInfoRow(
//                               iconPath: 'assets/images/Admin.svg',
//                               title: 'Driver Name',
//                               value: data.crewDriverName!,
//                             ),
//
//                             // Driver License No.
//                             _buildInfoRow(
//                               iconPath: 'assets/images/aadhar number.svg',
//                               title: 'Driver License No.',
//                               value: data.crewDriverLicenseNo ?? 'N/A',
//                             ),
//
//                             // Mobile Number
//                             _buildInfoRow(
//                               iconPath: 'assets/images/callicon.png',
//                               title: 'Mobile Number',
//                               value: data.crewMobile ?? 'N/A',
//                             ),
//
//                             // Helper Name (if available)
//                             if (data.crewHelperName != null && data.crewHelperName!.isNotEmpty)
//                               _buildInfoRow(
//                                 iconPath: 'assets/images/Admin.svg',
//                                 title: 'Helper Name',
//                                 value: data.crewHelperName!,
//                               ),
//                           ],
//
//                           SizedBox(height: 20),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ],
//               );
//             },
//           ),
//         ),
//
//         // Close Button
//         Positioned(
//           top: -70,
//           left: mediaQuery.size.width * 0.5 - 30,
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
// }
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../controllers/AdminController/TankerController.dart';
import '../../../utils/colors.dart';

class TankerDetails extends StatefulWidget {
  final String tankerId;

  const TankerDetails({super.key, required this.tankerId});

  @override
  State<TankerDetails> createState() => _TankerDetailsState();
}

class _TankerDetailsState extends State<TankerDetails> {
  final TankerController tankerController = Get.put(TankerController());

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      tankerController.getTankerDetail(widget.tankerId);
    });
    super.initState();
  }

  // Function to format date (show only date, not time)
  String _formatDate(String? dateString) {
    if (dateString == null || dateString.isEmpty) return 'N/A';

    try {
      DateTime date = DateTime.parse(dateString);
      return DateFormat('dd/MM/yyyy').format(date);
    } catch (e) {
      // If parsing fails, try to extract date part if it contains time
      if (dateString.contains(' ')) {
        return dateString.split(' ')[0];
      }
      return dateString;
    }
  }

  // Function to copy text to clipboard and show success message
  void _copyToClipboard(String text, String type) async {
    try {
      await Clipboard.setData(ClipboardData(text: text));
      Get.snackbar(
        'Success',
        '$type copied successfully!',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
        duration: Duration(seconds: 2),
        margin: EdgeInsets.all(16),
        borderRadius: 8,
        icon: Icon(Icons.check_circle, color: Colors.white),
      );
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to copy $type',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
        duration: Duration(seconds: 2),
        margin: EdgeInsets.all(16),
        borderRadius: 8,
        icon: Icon(Icons.error, color: Colors.white),
      );
    }
  }

  Widget _buildInfoRow({
    required String iconPath,
    required String title,
    required String value,
    Color valueColor = AppColors.primary,
    bool showCopyButton = false,
    String? copyText,
  }) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: AppColors.primary.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Center(
              child: _buildIconWithFallback(
                assetName: iconPath,
                width: 20,
                height: 20,
                fallbackIcon: _getDefaultIconForTitle(title),
              ),
            ),
          ),
          SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                    color: AppColors.secondary.withOpacity(0.7),
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  value,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                    color: valueColor,
                  ),
                ),
              ],
            ),
          ),
          if (showCopyButton)
            InkWell(
              onTap: () {
                _copyToClipboard(copyText ?? value, title);
              },
              borderRadius: BorderRadius.circular(20),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.asset(
                  'assets/images/Copy.png',
                  color: AppColors.primary,
                  width: 24,
                  height: 24,
                  errorBuilder: (context, error, stackTrace) {
                    return Icon(
                      Icons.copy,
                      size: 24,
                      color: AppColors.primary,
                    );
                  },
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildIconWithFallback({
    required String assetName,
    double? width,
    double? height,
    required IconData fallbackIcon,
    Color? color,
  }) {
    // Check if asset is PNG or SVG
    if (assetName.toLowerCase().endsWith('.png')) {
      return Image.asset(
        assetName,
        width: width,
        height: height,
        color: color,
        fit: BoxFit.contain,
        errorBuilder: (context, error, stackTrace) {
          return Icon(
            fallbackIcon,
            size: width,
            color: color ?? AppColors.primary,
          );
        },
      );
    } else {
      // Handle SVG assets
      return SvgPicture.asset(
        assetName,
        width: width,
        height: height,
        color: color,
        fit: BoxFit.contain,
        errorBuilder: (context, error, stackTrace) {
          return Icon(
            fallbackIcon,
            size: width,
            color: color ?? AppColors.primary,
          );
        },
      );
    }
  }

  IconData _getDefaultIconForTitle(String title) {
    switch (title.toLowerCase()) {
      case 'registration number':
        return Icons.local_shipping;
      case 'capacity':
        return Icons.water;
      case 'fitness certificate no.':
      case 'pollution control cert. no.':
      case 'insurance policy no.':
      case 'permit number':
      case 'driver license no.':
      case 'calibration number':
        return Icons.description;
      case 'fitness cert. expiry':
      case 'pollution control expiry':
      case 'insurance expiry':
      case 'calibration date':
      case 'calibration expiry date':
      case 'created date':
        return Icons.calendar_today;
      case 'driver name':
      case 'helper name':
        return Icons.person;
      case 'mobile number':
        return Icons.phone;
      case 'status':
        return Icons.info;
      case 'tanker id':
        return Icons.numbers;
      default:
        return Icons.info;
    }
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final screenHeight = mediaQuery.size.height;

    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          height: screenHeight * 0.85,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Obx(
                () {
              if (tankerController.isDetailLoading.value ||
                  tankerController.tankerDetailModel.value.data == null ||
                  tankerController.tankerDetailModel.value.data!.isEmpty) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircularProgressIndicator(
                        color: AppColors.primary,
                      ),
                      SizedBox(height: 16),
                      Text(
                        'Loading Tanker Details...',
                        style: TextStyle(
                          color: AppColors.secondary,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                );
              }

              final data = tankerController.tankerDetailModel.value.data![0];

              return Column(
                children: [
                  // Sticky Header
                  Container(
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(16),
                        topRight: Radius.circular(16),
                      ),
                      border: Border(
                        bottom: BorderSide(
                          color: Colors.grey.shade300,
                          width: 1.0,
                        ),
                      ),
                    ),
                    child: Row(
                      children: [
                        Container(
                          height: 60,
                          width: 60,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: AppColors.primary,
                          ),
                          child: Center(
                            child: _buildIconWithFallback(
                              assetName: 'assets/images/Tanker3.svg',
                              width: 30,
                              height: 30,
                              color: Colors.white,
                              fallbackIcon: Icons.local_shipping,
                            ),
                          ),
                        ),
                        SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Tanker Details',
                                style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 20,
                                  color: AppColors.secondary,
                                ),
                              ),
                              SizedBox(height: 4),
                              Text(
                                'Complete tanker information overview',
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
                  ),

                  // Content Area
                  Expanded(
                    child: SingleChildScrollView(
                      padding: EdgeInsets.all(16),
                      child: Column(
                        children: [
                          // Registration Number
                          _buildInfoRow(
                            iconPath: 'assets/images/Tanker2.svg',
                            title: 'Registration Number',
                            value: data.registrationNumber ?? 'N/A',
                          ),

                          // Capacity
                          _buildInfoRow(
                            iconPath: 'assets/images/Tanker2.svg',
                            title: 'Capacity',
                            value: data.capacity != null ? '${data.capacity} Litres' : 'N/A',
                          ),

                          // Calibration Number
                          _buildInfoRow(
                            iconPath: 'assets/images/aadhar number.svg',
                            title: 'Calibration Number',
                            value: data.calibrationNumber ?? 'N/A',
                          ),

                          // Calibration Expiry Date - ADDED
                          _buildInfoRow(
                            iconPath: 'assets/images/Calender.svg',
                            title: 'Calibration Expiry Date',
                            value: _formatDate(data.calibrationExpDate),
                          ),

                          // Fitness Certificate No.
                          _buildInfoRow(
                            iconPath: 'assets/images/aadhar number.svg',
                            title: 'Fitness Certificate No.',
                            value: data.fitnessCertNo ?? 'N/A',
                          ),

                          // Fitness Cert. Expiry
                          _buildInfoRow(
                            iconPath: 'assets/images/Calender.svg',
                            title: 'Fitness Cert. Expiry',
                            value: _formatDate(data.fitnessCertExpDate),
                          ),

                          // Pollution Control Cert. No.
                          _buildInfoRow(
                            iconPath: 'assets/images/aadhar number.svg',
                            title: 'Pollution Control Cert. No.',
                            value: data.pollutionControlCertNo ?? 'N/A',
                          ),

                          // Pollution Control Expiry
                          _buildInfoRow(
                            iconPath: 'assets/images/Calender.svg',
                            title: 'Pollution Control Expiry',
                            value: _formatDate(data.pollutionControlCertExpDate),
                          ),

                          // Insurance Policy No.
                          _buildInfoRow(
                            iconPath: 'assets/images/aadhar number.svg',
                            title: 'Insurance Policy No.',
                            value: data.insurancePolicyNumber ?? 'N/A',
                          ),

                          // Insurance Expiry
                          _buildInfoRow(
                            iconPath: 'assets/images/Calender.svg',
                            title: 'Insurance Expiry',
                            value: _formatDate(data.insuranceExpDate),
                          ),

                          // Permit Number (if available)
                          if (data.permitNumber != null && data.permitNumber!.isNotEmpty)
                            _buildInfoRow(
                              iconPath: 'assets/images/aadhar number.svg',
                              title: 'Permit Number',
                              value: data.permitNumber!,
                            ),

                          // Explosive Expiry Date (if available)
                          if (data.explosiveExpDate != null && data.explosiveExpDate!.isNotEmpty)
                            _buildInfoRow(
                              iconPath: 'assets/images/Calender.svg',
                              title: 'Explosive Expiry Date',
                              value: _formatDate(data.explosiveExpDate),
                            ),

                          // Tanker ID with copy button
                          _buildInfoRow(
                            iconPath: 'assets/images/Tanker2.svg',
                            title: 'Tanker ID',
                            value: data.id?.toString() ?? 'N/A',
                            showCopyButton: data.id?.toString().isNotEmpty == true,
                            copyText: data.id?.toString(),
                          ),

                          // Created Date
                          _buildInfoRow(
                            iconPath: 'assets/images/Calender.svg',
                            title: 'Created Date',
                            value: _formatDate(data.createdDate),
                          ),

                          // Status
                          // _buildInfoRow(
                          //   iconPath: 'assets/images/activeicon.png',
                          //   title: 'Status',
                          //   value: data.status ?? 'N/A',
                          //   valueColor: data.status?.toLowerCase() == 'active' ? Colors.green : AppColors.primary,
                          // ),

                          // Crew Information Section
                          if (data.crewDriverName != null && data.crewDriverName!.isNotEmpty) ...[
                            SizedBox(height: 16),
                            // Crew Information Header
                            Container(
                              margin: EdgeInsets.symmetric(vertical: 8),
                              padding: EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: AppColors.primary.withOpacity(0.05),
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(color: AppColors.primary.withOpacity(0.2)),
                              ),
                              child: Row(
                                children: [
                                  Container(
                                    width: 40,
                                    height: 40,
                                    decoration: BoxDecoration(
                                      color: AppColors.primary.withOpacity(0.1),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Center(
                                      child: Icon(
                                        Icons.people,
                                        size: 20,
                                        color: AppColors.primary,
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 16),
                                  Text(
                                    'Crew Information',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16,
                                      color: AppColors.primary,
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            // Driver Name
                            _buildInfoRow(
                              iconPath: 'assets/images/Admin.svg',
                              title: 'Driver Name',
                              value: data.crewDriverName!,
                            ),

                            // Driver License No.
                            _buildInfoRow(
                              iconPath: 'assets/images/aadhar number.svg',
                              title: 'Driver License No.',
                              value: data.crewDriverLicenseNo ?? 'N/A',
                            ),

                            // Mobile Number
                            _buildInfoRow(
                              iconPath: 'assets/images/callicon.png',
                              title: 'Mobile Number',
                              value: data.crewMobile ?? 'N/A',
                            ),

                            // Helper Name (if available)
                            if (data.crewHelperName != null && data.crewHelperName!.isNotEmpty)
                              _buildInfoRow(
                                iconPath: 'assets/images/Admin.svg',
                                title: 'Helper Name',
                                value: data.crewHelperName!,
                              ),
                          ],

                          SizedBox(height: 20),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),

        // Close Button
        Positioned(
          top: -70,
          left: mediaQuery.size.width * 0.5 - 30,
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
}