// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:get/get.dart';
// import 'package:intl/intl.dart';
//
// import '../../../controllers/AdminController/SchemeDetailController.dart';
// import '../../../utils/colors.dart';
//
// class SchemeDetails extends StatefulWidget {
//   final String schemeId;
//
//   const SchemeDetails({super.key, required this.schemeId});
//
//   @override
//   State<SchemeDetails> createState() => _SchemeDetailsState();
// }
//
// class _SchemeDetailsState extends State<SchemeDetails> {
//   final SchemeDetailController schemeController = Get.put(SchemeDetailController());
//
//   @override
//   void initState() {
//     WidgetsBinding.instance.addPostFrameCallback((_) async {
//       await schemeController.getSchemeDetail(schemeId: widget.schemeId);
//     });
//
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
//
//       // Show success toast
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
//       // Show error toast if copy fails
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
//   @override
//   Widget build(BuildContext context) {
//     return Obx(
//       () => schemeController.isLoading.value ||
//               schemeController.schemeDetailModel.value.data == null ||
//               schemeController.schemeDetailModel.value.data!.isEmpty
//           ? Container(
//               height: MediaQuery.of(context).size.height * 0.8,
//               width: double.infinity,
//               alignment: Alignment.center,
//               child: CircularProgressIndicator(
//                 color: AppColors.primary,
//               ),
//             )
//           : Container(
//               height: MediaQuery.of(context).size.height * 0.8,
//               width: double.infinity,
//               child: SingleChildScrollView(
//                 physics: const BouncingScrollPhysics(),
//                 child: Column(
//                   children: [
//                     const SizedBox(height: 16),
//                     // Drag handle
//                     GestureDetector(
//                       onTap: () {
//                         Navigator.pop(context);
//                       },
//                       child: Container(
//                         height: 5,
//                         width: 53,
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(5),
//                           color: AppColors.alert,
//                         ),
//                       ),
//                     ),
//                     _buildHeaderSection(),
//                     const SizedBox(height: 20),
//                     _buildInfoSection(),
//                   ],
//                 ),
//               ),
//             ),
//     );
//   }
//
//   Widget _buildHeaderSection() {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
//       child: Row(
//         children: [
//           Container(
//             height: 62,
//             width: 62,
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(12),
//               color: AppColors.primary,
//             ),
//             child: _buildIconWithFallback(
//               assetName: 'assets/images/AddSchemes.svg',
//
//               fallbackIcon: Icons.card_giftcard,
//             ),
//           ),
//           const SizedBox(width: 12),
//           Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 'Scheme Details',
//                 style: TextStyle(
//                   fontWeight: FontWeight.w500,
//                   fontSize: 24,
//                   color: AppColors.secondary,
//                 ),
//               ),
//               Text(
//                 'View complete scheme information',
//                 style: TextStyle(
//                   fontWeight: FontWeight.w400,
//                   fontSize: 14,
//                   color: AppColors.icon,
//                 ),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
//   Widget _buildInfoSection() {
//     final data = schemeController.schemeDetailModel.value.data![0];
//     print('=== SCHEME DATA FIELDS ===');
//     print('id: ${data.id}');
//     print('name: ${data.name}');
//     print('vehicle_type: ${data.vehicleType}');
//     print('product: ${data.product}');
//     print('liter_range: ${data.literRange}');
//     print('gifts: ${data.gifts}');
//     print('qty: ${data.qty}');
//     print('created_date: ${data.createdDate}');
//     print('product_code: ${data.productCode}');
//     print('product_name: ${data.productName}');
//     print('==========================');
//
//     // Helper function to map numeric product values to actual names
//     String getProductDisplayName(String? productValue) {
//       if (productValue == null || productValue.isEmpty) return 'N/A';
//
//       switch (productValue) {
//         case '0':
//           return 'Petrol';
//         case '1':
//           return 'Diesel';
//         case '2':
//           return 'Lube';
//         case '3':
//           return 'Power';
//         default:
//           return productValue;
//       }
//     }
//
//     // Helper function to display quantity values
//     String getQuantityDisplay(String? qtyValue) {
//       if (qtyValue == null || qtyValue.isEmpty) return 'Not specified';
//
//       // You can add mapping logic here if needed
//       // For example, if you have specific quantity names
//       switch (qtyValue) {
//         case '1':
//           return '1';
//         case '2':
//           return '2';
//         case '3':
//           return '3';
//         case '4':
//           return '4';
//         default:
//           return qtyValue; // Return as-is if no special mapping needed
//       }
//     }
//
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 20),
//       child: Column(
//         children: [
//           _buildInfoRow(
//             icon: 'assets/images/AddSchemes.svg',
//             title: 'Scheme Name',
//             value: data.name ?? 'N/A',
//           ),
//           const SizedBox(height: 16),
//
//           _buildInfoRow(
//             icon: 'assets/images/vehicles.png',
//             title: 'Vehicle Type',
//             value: data.vehicleType ?? 'N/A',
//           ),
//           const SizedBox(height: 16),
//
//           // Product Type - with proper mapping
//           _buildInfoRow(
//             icon: 'assets/images/AddProducts.svg',
//             title: 'Product Type',
//             value: getProductDisplayName(data.product),
//           ),
//           const SizedBox(height: 16),
// // If quantity is in liter_range field
//
//           // Gifts
//           _buildInfoRow(
//             icon: 'assets/images/AddGift.svg',
//             title: 'Gifts',
//             value: data.gifts ?? 'N/A',
//           ),
//           const SizedBox(height: 16),
//
//           // Liter Range
//           _buildInfoRow(
//             icon: 'assets/images/CreateProducticon.svg',
//             title: 'Quantity',
//             value: data.literRange?.isNotEmpty == true ? data.literRange! : 'Not specified',
//           ),
//           const SizedBox(height: 16),
//
//           // Quantity - with proper display
//
//
//           // Product Name
//
//
//           // Product Code
//
//
//           // Scheme ID Row
//           _buildSchemeIdRow(),
//           const SizedBox(height: 16),
//
//           // Created Date
//           _buildInfoRow(
//             icon: 'assets/images/Calender.svg',
//             title: 'Created Date',
//             value: _formatDate(data.createdDate),
//           ),
//           const SizedBox(height: 24),
//         ],
//       ),
//     );
//   }
//
//
//   Widget _buildInfoRow({
//     required String icon,
//     required String title,
//     required String value,
//   }) {
//     return Row(
//       children: [
//         _buildIconWithFallback(
//           assetName: icon,
//           width: 24,
//           height: 24,
//           fallbackIcon: _getDefaultIconForTitle(title),
//         ),
//         const SizedBox(width: 10),
//         Expanded(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 title,
//                 style: TextStyle(
//                   fontWeight: FontWeight.w500,
//                   fontSize: 18,
//                   color: AppColors.text,
//                 ),
//               ),
//               Text(
//                 value,
//                 style: TextStyle(
//                   fontWeight: FontWeight.w400,
//                   fontSize: 14,
//                   color: AppColors.primary,
//                 ),
//                 overflow: TextOverflow.ellipsis,
//                 maxLines: 2,
//               ),
//             ],
//           ),
//         ),
//       ],
//     );
//   }
//
//
//   Widget _buildSchemeIdRow() {
//     // Null safety check
//     if (schemeController.schemeDetailModel.value.data == null ||
//         schemeController.schemeDetailModel.value.data!.isEmpty) {
//       return SizedBox(); // Return empty if no data
//     }
//
//     final data = schemeController.schemeDetailModel.value.data![0];
//     final schemeId = data.id?.toString().trim() ?? 'N/A';
//
//     return Row(
//       children: [
//         _buildIconWithFallback(
//           assetName: 'assets/images/AddSchemes.svg',
//           height: 24,
//           width: 24,
//           fallbackIcon: Icons.numbers,
//         ),
//         const SizedBox(width: 10),
//         Expanded(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 'Scheme ID',
//                 style: TextStyle(
//                   fontWeight: FontWeight.w500,
//                   fontSize: 18,
//                   color: AppColors.text,
//                 ),
//               ),
//               Text(
//                 schemeId,
//                 style: TextStyle(
//                   fontWeight: FontWeight.w400,
//                   fontSize: 14,
//                   color: AppColors.primary,
//                 ),
//                 overflow: TextOverflow.ellipsis,
//                 maxLines: 1,
//               ),
//             ],
//           ),
//         ),
//         // Show copy button only for valid IDs
//         if (schemeId != 'N/A' && schemeId.isNotEmpty)
//           InkWell(
//             onTap: () {
//               _copyToClipboard(schemeId, 'Scheme ID');
//             },
//             borderRadius: BorderRadius.circular(20),
//             child: Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Image.asset(
//                 'assets/images/Copy.png',
//                 height: 24,
//                 width: 24,
//                 color: AppColors.primary,
//                 errorBuilder: (context, error, stackTrace) {
//                   return Icon(
//                     Icons.copy,
//                     size: 24,
//                     color: AppColors.primary,
//                   );
//                 },
//               ),
//             ),
//           ),
//       ],
//     );
//   }
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
//       case 'scheme name':
//         return Icons.card_giftcard;
//       case 'vehicle type':
//         return Icons.directions_car;
//       case 'product type':
//         return Icons.local_gas_station;
//       case 'liter range':
//         return Icons.water_drop;
//       case 'gifts':
//         return Icons.card_giftcard;
//       case 'quantity':
//         return Icons.numbers;
//       case 'product name':
//         return Icons.inventory;
//       case 'product code':
//         return Icons.qr_code;
//       case 'created date':
//         return Icons.calendar_today;
//       default:
//         return Icons.info;
//     }
//   }
// }
//
//
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../controllers/AdminController/SchemeDetailController.dart';
import '../../../utils/colors.dart';

class SchemeDetails extends StatefulWidget {
  final String schemeId;

  const SchemeDetails({super.key, required this.schemeId});

  @override
  State<SchemeDetails> createState() => _SchemeDetailsState();
}

class _SchemeDetailsState extends State<SchemeDetails> {
  final SchemeDetailController schemeController = Get.put(SchemeDetailController());

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await schemeController.getSchemeDetail(schemeId: widget.schemeId);
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

  // Helper function to map numeric product values to actual names
  String getProductDisplayName(String? productValue) {
    if (productValue == null || productValue.isEmpty) return 'N/A';

    switch (productValue) {
      case '0':
        return 'Petrol';
      case '1':
        return 'Diesel';
      case '2':
        return 'Lube';
      case '3':
        return 'Power';
      default:
        return productValue;
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
      case 'scheme name':
        return Icons.card_giftcard;
      case 'vehicle type':
        return Icons.directions_car;
      case 'product type':
        return Icons.local_gas_station;
      case 'liter range':
      case 'quantity':
        return Icons.water_drop;
      case 'gifts':
        return Icons.card_giftcard;
      case 'product name':
        return Icons.inventory;
      case 'product code':
        return Icons.qr_code;
      case 'created date':
        return Icons.calendar_today;
      case 'scheme id':
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
              if (schemeController.isLoading.value ||
                  schemeController.schemeDetailModel.value.data == null ||
                  schemeController.schemeDetailModel.value.data!.isEmpty) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircularProgressIndicator(
                        color: AppColors.primary,
                      ),
                      SizedBox(height: 16),
                      Text(
                        'Loading Scheme Details...',
                        style: TextStyle(
                          color: AppColors.secondary,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                );
              }

              final data = schemeController.schemeDetailModel.value.data![0];

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
                              assetName: 'assets/images/AddSchemes.svg',


                              fallbackIcon: Icons.card_giftcard,
                            ),
                          ),
                        ),
                        SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Scheme Details',
                                style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 20,
                                  color: AppColors.secondary,
                                ),
                              ),
                              SizedBox(height: 4),
                              Text(
                                'Complete scheme information overview',
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
                          // Scheme Name
                          _buildInfoRow(
                            iconPath: 'assets/images/AddSchemes.svg',
                            title: 'Scheme Name',
                            value: data.name ?? 'N/A',
                          ),

                          // Vehicle Type
                          _buildInfoRow(
                            iconPath: 'assets/images/vehicles.png',
                            title: 'Vehicle Type',
                            value: data.vehicleType ?? 'N/A',
                          ),

                          // Product Type
                          _buildInfoRow(
                            iconPath: 'assets/images/AddProducts.svg',
                            title: 'Product Type',
                            value: getProductDisplayName(data.product),
                          ),

                          // Gifts
                          _buildInfoRow(
                            iconPath: 'assets/images/AddGift.svg',
                            title: 'Gifts',
                            value: data.gifts ?? 'N/A',
                          ),

                          // Quantity/Liter Range
                          if (data.literRange?.isNotEmpty == true)
                            _buildInfoRow(
                              iconPath: 'assets/images/CreateProducticon.svg',
                              title: 'Quantity',
                              value: data.literRange!,
                            ),

                          // Product Name (if available)
                          if (data.productName?.isNotEmpty == true)
                            _buildInfoRow(
                              iconPath: 'assets/images/AddProducts.svg',
                              title: 'Product Name',
                              value: data.productName!,
                            ),

                          // Product Code (if available)
                          if (data.productCode?.isNotEmpty == true)
                            _buildInfoRow(
                              iconPath: 'assets/images/CreateProducticon.svg',
                              title: 'Product Code',
                              value: data.productCode!,
                            ),

                          // Scheme ID with copy button
                          _buildInfoRow(
                            iconPath: 'assets/images/AddSchemes.svg',
                            title: 'Scheme ID',
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