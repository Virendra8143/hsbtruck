// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:get/get.dart';
//
// import '../../../controllers/AdminController/GetProductListController.dart';
// import '../../../models/AdminModels/GetProductModel.dart';
// import '../../../utils/colors.dart';
// // import '../Machine/EditingOption2.dart';
// import 'AddProducts.dart';
// import 'EditingProductOption.dart';
// import 'ExportReports.dart';
// import 'Inventorydeletewarning.dart';
// import 'Inventoryeye.dart';
// import 'Sales.dart';
// import '../../../Widgets/ManualScreen.dart';
// import '../../../Widgets/NotificationsScreen.dart';
//
// class CreateInventory extends StatefulWidget {
//   const CreateInventory({super.key});
//
//   @override
//   State<CreateInventory> createState() => _CreateInventoryState();
// }
//
// class _CreateInventoryState extends State<CreateInventory> {
//   int selectedTabIndex = 0;
//
//   final GetProductController getProductController =
//       Get.put(GetProductController());
//   final Rx<Data?> selectedProduct = Rx<Data?>(null);
//
//   @override
//   void initState() {
//     getProductController.getProduct();
//     getProductController.getProductCount();
//     getProductController.getLowStockProducts();
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final mediaQuery = MediaQuery.of(context);
//     final screenWidth = mediaQuery.size.width;
//     final screenHeight = mediaQuery.size.height;
//
//     return SafeArea(
//       child: Scaffold(
//         body: Padding(
//           padding: EdgeInsets.only(top: screenHeight * 0.02),
//           child: Container(
//             height: screenHeight,
//             width: screenWidth,
//             child: Column(
//               children: [
//                 SizedBox(height: screenHeight * 0.05),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     GestureDetector(
//                       onTap: () {
//                         Get.back();
//                       },
//                       child: Image.asset(
//                         'assets/images/back.png',
//                         fit: BoxFit.fitHeight,
//                       ),
//                     ),
//                     SizedBox(width: screenWidth * 0.25),
//                     IconButton(
//                       onPressed: () {
//                         Get.to(() => const NotificationsScreen());
//                       },
//                       icon: Image.asset(
//                         'assets/images/Notification.png',
//                         fit: BoxFit.fitHeight,
//                       ),
//                     ),
//                     IconButton(
//                       onPressed: () {},
//                       icon: Image.asset(
//                         'assets/images/drawer.png',
//                         fit: BoxFit.fitHeight,
//                       ),
//                     ),
//                   ],
//                 ),
//                 SizedBox(height: screenHeight * 0.02),
//                 Padding(
//                   padding: EdgeInsets.only(left: screenWidth * 0.05),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(
//                             'Inventory ',
//                             style: TextStyle(
//                               fontWeight: FontWeight.w700,
//                               fontSize: 24,
//                               color: AppColors.primary,
//                             ),
//                           ),
//                           Text(
//                             'Dashboard ',
//                             style: TextStyle(
//                               fontWeight: FontWeight.w700,
//                               fontSize: 24,
//                               color: AppColors.primary,
//                             ),
//                           ),
//                         ],
//                       ),
//                       Container(
//                         height: screenHeight * 0.12,
//                         width: screenWidth * 0.38,
//                         child: SvgPicture.asset('assets/images/Car2.svg'),
//                       ),
//                     ],
//                   ),
//                 ),
//                 SizedBox(height: screenHeight * 0.02),
//                 // Updated stats section with real-time data
//                 Obx(() => SingleChildScrollView(
//                       scrollDirection: Axis.horizontal,
//                       child: Row(
//                         children: [
//                           _buildStatColumn(
//                               'Products',
//                               getProductController.getProductCountModel.value
//                                               .data !=
//                                           null &&
//                                       getProductController.getProductCountModel
//                                           .value.data!.isNotEmpty
//                                   ? getProductController
//                                       .getProductCountModel.value.data![0].all
//                                       .toString()
//                                   : '0'),
//                           SizedBox(width: 5),
//                           _divider(),
//                           SizedBox(width: 5),
//                           _buildStatColumn(
//                               'Low Stock',
//                               getProductController.getProductCountModel.value
//                                               .data !=
//                                           null &&
//                                       getProductController.getProductCountModel
//                                           .value.data!.isNotEmpty
//                                   ? getProductController.getProductCountModel
//                                       .value.data![0].lowStok
//                                       .toString()
//                                   : '0'),
//                           SizedBox(width: 5),
//                           _divider(),
//                           SizedBox(width: 5),
//                           _buildExportReports(),
//                         ],
//                       ),
//                     )),
//                 Padding(
//                   padding: EdgeInsets.only(left: screenWidth * 0.025, top: 8),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.start,
//                     children: [
//                       Container(
//                         height: 1,
//                         width: screenWidth * 0.65,
//                         color: AppColors.text,
//                       ),
//                     ],
//                   ),
//                 ),
//                 SizedBox(height: 10),
//                 Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: Column(
//                     children: [
//                       ScrollConfiguration(
//                         behavior: ScrollBehavior().copyWith(overscroll: false),
//                         child: SingleChildScrollView(
//                           scrollDirection: Axis.horizontal,
//                           child: Padding(
//                             padding: const EdgeInsets.all(8.0),
//                             child: Row(
//                               children: [
//                                 _buildTab("All Products", 0),
//                                 SizedBox(width: 10),
//                                 _buildTab("Low Stock", 1),
//                                 SizedBox(width: 10),
//                                 _buildTab("Sales", 2),
//                                 SizedBox(width: 10),
//                                 _buildTab("Products", 3),
//                                 SizedBox(width: 10),
//                               ],
//                             ),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 Expanded(
//                   child: Obx(() => _buildTabContent()),
//                 ),
//                 Padding(
//                   padding: EdgeInsets.only(left: screenWidth * 0.8),
//                   child: Container(
//                     height: screenHeight * 0.08,
//                     width: screenWidth * 0.15,
//                     child: ElevatedButton(
//                       onPressed: () {
//                         showModalBottomSheet(
//                           context: context,
//                           isScrollControlled: true,
//                           shape: RoundedRectangleBorder(
//                             borderRadius:
//                                 BorderRadius.vertical(top: Radius.circular(16)),
//                           ),
//                           builder: (context) {
//                             return AddProducts();
//                           },
//                         );
//                       },
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: AppColors.button,
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(12),
//                         ),
//                         elevation: 4,
//                       ),
//                       child: Column(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           Icon(
//                             Icons.add,
//                             color: Colors.white,
//                             size: 24,
//                           ),
//                           SizedBox(height: 4),
//                           Text(
//                             'Add\nProduct',
//                             style: TextStyle(
//                               color: Colors.white,
//                               fontSize: 12,
//                               fontWeight: FontWeight.w600,
//                             ),
//                             textAlign: TextAlign.center,
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget _buildStatColumn(String title, String value) {
//     return Padding(
//       padding: const EdgeInsets.only(left: 10),
//       child: Column(
//         children: [
//           Text(
//             title,
//             style: TextStyle(
//               fontSize: 16,
//               fontWeight: FontWeight.w600,
//               color: AppColors.primary,
//             ),
//           ),
//           Text(
//             value,
//             style: TextStyle(
//               fontSize: 24,
//               fontWeight: FontWeight.w600,
//               color: AppColors.text,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _divider() {
//     return Container(
//       width: 2,
//       height: 61,
//       color: AppColors.text,
//     );
//   }
//
//   Widget _buildExportReports() {
//     return Padding(
//       padding: const EdgeInsets.only(left: 10),
//       child: Column(
//         children: [
//           Text(
//             'Export Reports',
//             style: TextStyle(
//               fontSize: 14,
//               fontWeight: FontWeight.w600,
//               color: AppColors.primary,
//             ),
//           ),
//           GestureDetector(
//             onTap: () {
//               showModalBottomSheet(
//                 context: context,
//                 isScrollControlled: true,
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
//                 ),
//                 builder: (context) {
//                   return ExportReports();
//                 },
//               );
//             },
//             child: SvgPicture.asset('assets/images/Export.svg'),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildTab(String title, int index) {
//     return GestureDetector(
//       onTap: () => setState(() => selectedTabIndex = index),
//       child: Container(
//         padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//         decoration: BoxDecoration(
//           color: selectedTabIndex == index
//               ? AppColors.primary
//               : AppColors.secondary,
//           borderRadius: BorderRadius.circular(100),
//         ),
//         child: Text(
//           title,
//           style: TextStyle(
//             fontWeight: FontWeight.w600,
//             fontSize: 16,
//             color: Colors.white,
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget _buildTabContent() {
//     switch (selectedTabIndex) {
//       case 0:
//         return _buildAllProductsTab();
//       case 1:
//         return _buildLowStockTab();
//       case 2:
//         return _buildSalesTab();
//       case 3:
//         return _buildProductsTab();
//       default:
//         return Container();
//     }
//   }
//
//   Widget _buildAllProductsTab() {
//     if (getProductController.isLoading.value) {
//       return Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             CircularProgressIndicator(color: AppColors.primary),
//             SizedBox(height: 16),
//             Text(
//               'Loading products...',
//               style: TextStyle(
//                 fontSize: 16,
//                 color: AppColors.text,
//               ),
//             ),
//           ],
//         ),
//       );
//     }
//
//     if (getProductController.getProductModel.value.data == null ||
//         getProductController.getProductModel.value.data!.isEmpty) {
//       return Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Icon(
//               Icons.inventory_2_outlined,
//               size: 64,
//               color: AppColors.icon,
//             ),
//             SizedBox(height: 16),
//             Text(
//               "No Products Found",
//               style: TextStyle(
//                 fontSize: 18,
//                 fontWeight: FontWeight.w600,
//                 color: AppColors.text,
//               ),
//             ),
//             SizedBox(height: 8),
//             Text(
//               "Add your first product to get started",
//               style: TextStyle(
//                 fontSize: 14,
//                 color: AppColors.icon,
//               ),
//             ),
//           ],
//         ),
//       );
//     }
//
//     final products = getProductController.getProductModel.value.data!;
//
//     return ListView.builder(
//       itemCount: products.length,
//       itemBuilder: (context, index) {
//         final product = products[index];
//         final productId = product.id;
//
//         return Card(
//           shape:
//               RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
//           margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
//           child: ListTile(
//             title: Text(
//               product.code ?? "Product Code Not Available",
//               style: const TextStyle(
//                 color: AppColors.primary,
//                 fontSize: 16,
//                 fontWeight: FontWeight.w400,
//               ),
//             ),
//             subtitle: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 const SizedBox(height: 4),
//                 Text(
//                   product.name != null && product.name!.isNotEmpty
//                       ? (product.brand != null && product.brand!.isNotEmpty
//                           ? '${product.name} (${product.brand})'
//                           : product.name!)
//                       : 'Product Name Not Available',
//                   style: const TextStyle(
//                     color: AppColors.secondary,
//                     fontSize: 20,
//                     fontWeight: FontWeight.w700,
//                   ),
//                 ),
//                 const SizedBox(height: 4),
//                 Row(
//                   children: [
//                     Text(
//                       "Stock: ${product.qtyInStock ?? 'N/A'}",
//                       style: const TextStyle(
//                         color: AppColors.icon,
//                         fontSize: 12,
//                         fontWeight: FontWeight.w400,
//                       ),
//                     ),
//                     if (product.storageCapacity != null && product.storageCapacity!.isNotEmpty)
//                       Padding(
//                         padding: const EdgeInsets.only(left: 16),
//                         child: Text(
//                           "Capacity: ${product.storageCapacity}",
//                           style: const TextStyle(
//                             color: AppColors.icon,
//                             fontSize: 12,
//                             fontWeight: FontWeight.w400,
//                           ),
//                         ),
//                       ),
//                   ],
//                 ),
//               ],
//             ),
//             trailing: Row(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 IconButton(
//                   onPressed: () {
//                     showModalBottomSheet(
//                       context: context,
//                       isScrollControlled: true,
//                       shape: RoundedRectangleBorder(
//                         borderRadius:
//                             BorderRadius.vertical(top: Radius.circular(16)),
//                       ),
//                       builder: (context) {
//                         return Inventoryeye(
//                           productId: productId!,
//                         );
//                       },
//                     );
//                   },
//                   icon: SvgPicture.asset('assets/images/View.svg'),
//                 ),
//                 IconButton(
//                   onPressed: () {
//                     showModalBottomSheet(
//                       context: context,
//                       isScrollControlled: true,
//                       shape: RoundedRectangleBorder(
//                         borderRadius:
//                             BorderRadius.vertical(top: Radius.circular(16)),
//                       ),
//                       builder: (context) {
//                         return EditingProductOption();
//                       },
//                     );
//                   },
//                   icon: SvgPicture.asset('assets/images/3dots.svg'),
//                 ),
//               ],
//             ),
//           ),
//         );
//       },
//     );
//   }
//
//   Widget _buildLowStockTab() {
//     if (getProductController.isLowStockLoading.value) {
//       return Center(child: CircularProgressIndicator());
//     }
//
//     if (getProductController.getLowStockProductModel.value.data == null ||
//         getProductController.getLowStockProductModel.value.data!.isEmpty) {
//       return Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Icon(
//               Icons.inventory_2_outlined,
//               size: 64,
//               color: AppColors.icon,
//             ),
//             SizedBox(height: 16),
//             Text(
//               "No Low Stock Products",
//               style: TextStyle(
//                 fontSize: 18,
//                 fontWeight: FontWeight.w600,
//                 color: AppColors.text,
//               ),
//             ),
//             SizedBox(height: 8),
//             Text(
//               "All products have sufficient stock",
//               style: TextStyle(
//                 fontSize: 14,
//                 color: AppColors.icon,
//               ),
//             ),
//           ],
//         ),
//       );
//     }
//
//     final lowStockProducts =
//         getProductController.getLowStockProductModel.value.data!;
//
//     return ListView.builder(
//       itemCount: lowStockProducts.length,
//       itemBuilder: (context, index) {
//         final product = lowStockProducts[index];
//
//         return Card(
//           shape:
//               RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
//           margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
//           child: ListTile(
//             title: Text(
//               product.code ?? "#Product Code is Not Available",
//               style: TextStyle(
//                 color: AppColors.primary,
//                 fontSize: 16,
//                 fontWeight: FontWeight.w400,
//               ),
//             ),
//             subtitle: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 SizedBox(height: 4),
//                 Text(
//                   product.name ?? "Product Name Not Available",
//                   style: TextStyle(
//                     color: AppColors.secondary,
//                     fontSize: 20,
//                     fontWeight: FontWeight.w700,
//                   ),
//                 ),
//                 SizedBox(height: 4),
//                 Text(
//                   "Stock: ${product.qtyInStock ?? 'N/A'}",
//                   style: TextStyle(
//                     color: AppColors.icon,
//                     fontSize: 12,
//                     fontWeight: FontWeight.w400,
//                   ),
//                 ),
//                 // Add unit of measure if available
//                 if (product.unitOfMeasure != null && product.unitOfMeasure!.isNotEmpty)
//                   Padding(
//                     padding: const EdgeInsets.only(top: 2),
//                     child: Text(
//                       "Unit: ${product.unitOfMeasure}",
//                       style: TextStyle(
//                         color: AppColors.icon,
//                         fontSize: 11,
//                         fontWeight: FontWeight.w400,
//                       ),
//                     ),
//                   ),
//                 // Add min quantity alert if available
//                 if (product.minQtyAlert != null &&
//                     product.minQtyAlert!.isNotEmpty)
//                   Padding(
//                     padding: const EdgeInsets.only(top: 2),
//                     child: Text(
//                       "Minimum Stock: ${product.minQtyAlert}",
//                       style: TextStyle(
//                         color: Colors.orange,
//                         fontSize: 11,
//                         fontWeight: FontWeight.w400,
//                       ),
//                     ),
//                   ),
//               ],
//             ),
//             trailing: Row(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 IconButton(
//                   onPressed: () {},
//                   icon: SvgPicture.asset('assets/images/lowstock.svg'),
//                 ),
//                 Column(
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//                     Text(
//                       'ST: ${product.qtyInStock ?? "N/A"}',
//                       style: TextStyle(
//                         fontWeight: FontWeight.w600,
//                         fontSize: 16,
//                         color: AppColors.primary,
//                       ),
//                     ),
//                     // Show stock status indicator
//                     Container(
//                       padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
//                       decoration: BoxDecoration(
//                         color: Colors.red.shade100,
//                         borderRadius: BorderRadius.circular(12),
//                       ),
//                       child: Text(
//                         'Low Stock',
//                         style: TextStyle(
//                           fontSize: 10,
//                           fontWeight: FontWeight.w500,
//                           color: Colors.red.shade700,
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         );
//       },
//     );
//   }
//
//   Widget _buildSalesTab() {
//     if (getProductController.getProductModel.value.data == null) {
//       return Center(child: CircularProgressIndicator());
//     }
//
//     final products = getProductController.getProductModel.value.data!;
//
//     return ListView.builder(
//       itemCount: products.length,
//       itemBuilder: (context, index) {
//         final product = products[index];
//         final salesAmount = '₹${(index + 1) * 15000}';
//
//         return Card(
//           shape:
//               RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
//           margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
//           child: ListTile(
//             title: Text(
//               product.code ?? "#Product Code is Not Available",
//               style: TextStyle(
//                 color: AppColors.primary,
//                 fontSize: 16,
//                 fontWeight: FontWeight.w400,
//               ),
//             ),
//             subtitle: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 SizedBox(height: 4),
//                 Text(
//                   product.name ?? "Product Name Not Available",
//                   style: TextStyle(
//                     color: AppColors.secondary,
//                     fontSize: 20,
//                     fontWeight: FontWeight.w700,
//                   ),
//                 ),
//                 SizedBox(height: 4),
//                 Text(
//                   "Stock: ${product.qtyInStock ?? 'N/A'}",
//                   style: TextStyle(
//                     color: AppColors.icon,
//                     fontSize: 12,
//                     fontWeight: FontWeight.w400,
//                   ),
//                 ),
//                 // Add unit of measure if available
//                 if (product.unitOfMeasure != null && product.unitOfMeasure!.isNotEmpty)
//                   Padding(
//                     padding: const EdgeInsets.only(top: 2),
//                     child: Text(
//                       "Unit: ${product.unitOfMeasure}",
//                       style: TextStyle(
//                         color: AppColors.icon,
//                         fontSize: 11,
//                         fontWeight: FontWeight.w400,
//                       ),
//                     ),
//                   ),
//               ],
//             ),
//             trailing: Row(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 IconButton(
//                   onPressed: () {},
//                   icon: SvgPicture.asset('assets/images/Sales.svg'),
//                 ),
//                 IconButton(
//                   onPressed: () {
//                     showModalBottomSheet(
//                       context: context,
//                       isScrollControlled: true,
//                       shape: RoundedRectangleBorder(
//                         borderRadius:
//                             BorderRadius.vertical(top: Radius.circular(12)),
//                       ),
//                       builder: (context) {
//                         return Sales();
//                       },
//                     );
//                   },
//                   icon: SvgPicture.asset('assets/images/View.svg'),
//                 ),
//                 SizedBox(width: 10),
//                 Text(
//                   salesAmount,
//                   style: TextStyle(
//                     fontWeight: FontWeight.w600,
//                     fontSize: 24,
//                     color: AppColors.primary,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         );
//       },
//     );
//   }
//
//   Widget _buildProductsTab() {
//     if (getProductController.getProductModel.value.data == null) {
//       return Center(child: CircularProgressIndicator());
//     }
//
//     final products = getProductController.getProductModel.value.data!;
//
//     return ListView.builder(
//       itemCount: products.length,
//       itemBuilder: (context, index) {
//         final product = products[index];
//
//         return Card(
//           shape:
//               RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
//           margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
//           child: ListTile(
//             title: Text(
//               product.code ?? "#Product Code is Not Available",
//               style: TextStyle(
//                 color: AppColors.primary,
//                 fontSize: 16,
//                 fontWeight: FontWeight.w400,
//               ),
//             ),
//             subtitle: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 SizedBox(height: 4),
//                 Text(
//                   product.name ?? "Product Name Not Available",
//                   style: TextStyle(
//                     color: AppColors.secondary,
//                     fontSize: 20,
//                     fontWeight: FontWeight.w700,
//                   ),
//                 ),
//                 SizedBox(height: 4),
//                 Text(
//                   "Stock: ${product.qtyInStock ?? 'N/A'}",
//                   style: TextStyle(
//                     color: AppColors.icon,
//                     fontSize: 12,
//                     fontWeight: FontWeight.w400,
//                   ),
//                 ),
//                 // Add unit of measure if available
//                 if (product.unitOfMeasure != null && product.unitOfMeasure!.isNotEmpty)
//                   Padding(
//                     padding: const EdgeInsets.only(top: 2),
//                     child: Text(
//                       "Unit: ${product.unitOfMeasure}",
//                       style: TextStyle(
//                         color: AppColors.icon,
//                         fontSize: 11,
//                         fontWeight: FontWeight.w400,
//                       ),
//                     ),
//                   ),
//               ],
//             ),
//             trailing: IconButton(
//               onPressed: () {
//                 showDialog(
//                   context: context,
//                   builder: (BuildContext context) {
//                     return Inventorydeletewarning();
//                   },
//                 );
//               },
//               icon: SvgPicture.asset('assets/images/Delete.svg'),
//             ),
//           ),
//         );
//       },
//     );
//   }
//
//   void refreshData() {
//     getProductController.refreshAllData();
//   }
// }
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../Widgets/CommonHeader.dart';
import '../../../Widgets/ManualScreen.dart';
import '../../../Widgets/appbar/main_app_bar.dart';
import '../../../controllers/AdminController/GetProductListController.dart';
import '../../../helpers/verticle_divider.dart';
import '../../../models/AdminModels/GetProductModel.dart';
import '../../../utils/colors.dart';
// import '../Machine/EditingOption2.dart';
import 'AddProducts.dart';
import 'EditingProductOption.dart';
import 'ExportReports.dart';
import 'Inventorydeletewarning.dart';
import 'Inventoryeye.dart';
import 'Sales.dart';
import 'SalesGraph.dart';
import '../../../Widgets/NotificationsScreen.dart';

import '../../../Widgets/EmptyStateWidget.dart';
import 'package:intl/intl.dart';

class CreateInventory extends StatefulWidget {
  const CreateInventory({super.key});

  @override
  State<CreateInventory> createState() => _CreateInventoryState();
}

class _CreateInventoryState extends State<CreateInventory> {
  int selectedTabIndex = 0;

  final GetProductController getProductController =
      Get.put(GetProductController());
  final Rx<Data?> selectedProduct = Rx<Data?>(null);

  // Map to store sales amounts for each product
  final Map<String, String> productSalesMap = {};

  @override
  void initState() {
    getProductController.getProduct();
    getProductController.getProductCount();
    getProductController.getLowStockProducts();
    super.initState();
    // Initialize sales data for current month
    _loadCurrentMonthSalesData();
  }

  // Load sales data for current month for all products
  void _loadCurrentMonthSalesData() {
    final now = DateTime.now();
    final startDate = '${now.year}-${now.month.toString().padLeft(2, '0')}-01';
    final lastDay = DateTime(now.year, now.month + 1, 0).day;
    final endDate =
        '${now.year}-${now.month.toString().padLeft(2, '0')}-$lastDay';

    // This will be called after products are loaded
    if (getProductController.getProductModel.value.data != null) {
      for (var product in getProductController.getProductModel.value.data!) {
        _loadSalesForProduct(product.id?.toString() ?? '', startDate, endDate);
      }
    }
  }

  // Load sales data for a specific product
  void _loadSalesForProduct(
      String productId, String startDate, String endDate) {
    if (productId.isNotEmpty) {
      getProductController.getProductGraph(
        productId: productId,
        startDate: startDate,
        endDate: endDate,
      );

      // Listen for data changes and calculate total
      ever(getProductController.productGraphModel, (model) {
        if (model.data != null && model.data!.isNotEmpty) {
          final total =
              model.data!.fold(0, (sum, data) => sum + (data.amount ?? 0));
          setState(() {
            productSalesMap[productId] = NumberFormat('#,##,###').format(total);
          });
        }
      });
    }
  }

  // Get current month sales for a product
  String _getCurrentMonthSales(String productId) {
    return productSalesMap[productId] ?? '0';
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final screenWidth = mediaQuery.size.width;
    final screenHeight = mediaQuery.size.height;

    return SafeArea(
      child: Scaffold(

        backgroundColor: AppColors.background,
        appBar: MainAppBar(
          logoPath: 'assets/images/HSB.png',
          showBack: true,
          backgroundColor: AppColors.background,
          iconColor: AppColors.text,
          actions: [
            AppBarActionItem(
              imagePath: 'assets/svg_icons/notification.svg',
              color: AppColors.secondary, // optional override
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => NotificationsScreen()));
              },
            ),
            AppBarActionItem(
              imagePath: 'assets/svg_icons/appbar-settings.svg',
              color: AppColors.secondary, // optional override
              onTap: () {},
            ),
          ],
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
          child: Container(
            height: screenHeight,
            width: screenWidth,
            child: Column(
              children: [
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // 🟣 Text Section
                      Flexible(
                        flex: 1,
                        child: Text.rich(
                          TextSpan(
                            children: const [
                              TextSpan(
                                text:
                                    'Inventory\n', // 👈 line break added here
                                style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 24,
                                  color: AppColors.primary,
                                ),
                              ),
                              TextSpan(
                                text: 'Dashboard',
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 24,
                                  color: AppColors.secondary,
                                ),
                              ),
                            ],
                          ),
                          softWrap: true,
                        ),
                      ),

                      const SizedBox(width: 12),

                      // 🟣 Image Section
                      Flexible(
                        flex: 1,
                        child: SvgPicture.asset(
                          'assets/images/Car2.svg',
                          fit: BoxFit.contain,
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 30),
                // Updated stats section with real-time data
                Obx(
                      () => SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: AppColors.secondary, // 👈 main border color
                          width: 0.8,
                        ),
                      ),
                      child: Row(
                        children: [
                          // 🟣 Column 1
                          _buildStatColumn(
                            'Products',
                            getProductController.getProductCountModel.value.data != null &&
                                getProductController.getProductCountModel.value.data!.isNotEmpty
                                ? getProductController.getProductCountModel.value.data![0].all.toString()
                                : '0',
                          ),

                          verticalDivider(),

                          // 🟣 Column 2
                          _buildStatColumn(
                            'Low Stock',
                            getProductController.getProductCountModel.value.data != null &&
                                getProductController.getProductCountModel.value.data!.isNotEmpty
                                ? getProductController.getProductCountModel.value.data![0].lowStok.toString()
                                : '0',
                          ),

                          verticalDivider(),

                          // 🟣 Column 3
                          _buildExportReports(),
                        ],
                      ),
                    ),
                  ),
                ),

                SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      ScrollConfiguration(
                        behavior:
                            ScrollBehavior().copyWith(overscroll: false),
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                _buildTab("All Products", 0),
                                SizedBox(width: 10),
                                _buildTab("Low Stock", 1),
                                SizedBox(width: 10),
                                _buildTab("Sales", 2),
                                SizedBox(width: 10),
                                _buildTab("Products", 3),
                                SizedBox(width: 10),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                // Add bottom padding to prevent overflow with floating button
                Expanded(
                  child: Obx(() => _buildTabContent()),
                ),
              ],
            ),
          ),
        ),
        floatingActionButton: GestureDetector(
          onTap: () {
            showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              backgroundColor: Colors.transparent, // 👈 Important: make background transparent
              builder: (context) {
                return ClipRRect(
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(24)), // 👈 Round corners here
                  child: Container(
                    color: Colors.white, // 👈 Your bottom sheet background color
                    child: AddProducts(), // 👈 Your content widget
                  ),
                );
              },
            );
          },
          child: SvgPicture.asset(
            'assets/images/addicon 2.svg',
            width: 56,
            height: 56,
          ),
        ),

        // // 🔵 Optional: Controls where FAB appears (default is bottom-right)
        // floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      ),
    );
  }

  Widget _buildStatColumn(String title, String value) {
    return Padding(
      padding: const EdgeInsets.only(left: 10),
      child: Column(
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: AppColors.primary,
            ),
          ),
          SizedBox(height: 12,),
          Text(
            value,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w600,
              color: AppColors.text,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildExportReports() {
    return Padding(
      padding: const EdgeInsets.only(left: 10),
      child: Column(
        children: [
          Text(
            'Export Reports',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: AppColors.primary,
            ),
          ),
          SizedBox(height: 12,),
          GestureDetector(
            onTap: () {
              showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                ),
                builder: (context) {
                  return ExportReports();
                },
              );
            },
            child: SvgPicture.asset('assets/images/Export.svg',width: 30,),
          ),
        ],
      ),
    );
  }

  Widget _buildTab(String title, int index) {
    final bool isSelected = selectedTabIndex == index;

    return GestureDetector(
      onTap: () => setState(() => selectedTabIndex = index),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primary : Colors.transparent,
          borderRadius: BorderRadius.circular(100),
          border: isSelected
              ? null // 👈 Remove border when selected
              : Border.all(
            color: AppColors.secondary,
            width: 0.8,
          ),
        ),
        child: Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 14,
            color: isSelected ? Colors.white : AppColors.secondary,
          ),
        ),
      ),
    );
  }



  Widget _buildTabContent() {
    switch (selectedTabIndex) {
      case 0:
        return _buildAllProductsTab();
      case 1:
        return _buildLowStockTab();
      case 2:
        return _buildSalesTab();
      case 3:
        return _buildProductsTab();
      default:
        return Container();
    }
  }

  Widget _buildAllProductsTab() {
    if (getProductController.isLoading.value) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(color: AppColors.primary),
            SizedBox(height: 16),
            Text(
              'Loading products...',
              style: TextStyle(
                fontSize: 16,
                color: AppColors.text,
              ),
            ),
          ],
        ),
      );
    }

    if (getProductController.getProductModel.value.data == null ||
        getProductController.getProductModel.value.data!.isEmpty) {
      return EmptyStateWidget(
        title: "No Products Found",
        subtitle: "Add your first product to get started",
        icon: Icons.inventory_2_outlined,
        actionText: "Add Product",
        onActionPressed: () {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
            ),
            builder: (context) {
              return AddProducts();
            },
          );
        },
      );
    }

    final products = getProductController.getProductModel.value.data!;

    return ListView.builder(
      itemCount: products.length,
      itemBuilder: (context, index) {
        final product = products[index];
        final productId = product.id;
        final isActive = product.status == "1"; // Check if product is active
        final isInactive =
            product.status == "0"; // Check if product is inactive

        return Card(
          elevation: 0,
          margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: BorderSide(
              color: AppColors.secondary.withOpacity(0.3), // border color
              width: 1,
            ),
          ),
          color: isInactive ? Colors.grey[100] : Colors.white,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 🔹 Row 1 — Product Code + Icons
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      product.code ?? "Product Code Not Available",
                      style: TextStyle(
                        color: isInactive ? Colors.grey : AppColors.primary,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Row(
                      children: [
                        IconButton(
                          padding: EdgeInsets.zero,
                          constraints: const BoxConstraints(),
                          icon: SvgPicture.asset(
                            'assets/images/View.svg',
                            width: 34,
                            color: isInactive ? Colors.grey : AppColors.secondary,
                          ),
                          onPressed: () {
                            showModalBottomSheet(
                              context: context,
                              isScrollControlled: true,
                              shape: const RoundedRectangleBorder(
                                borderRadius:
                                BorderRadius.vertical(top: Radius.circular(16)),
                              ),
                              builder: (context) => Inventoryeye(productId: productId!),
                            );
                          },
                        ),
                        const SizedBox(width:20),
                        IconButton(
                          padding: EdgeInsets.zero,
                          constraints: const BoxConstraints(),
                          icon: SvgPicture.asset(
                            'assets/images/3dots.svg',
                            width: 34,
                            color: isInactive ? Colors.grey : AppColors.secondary,
                          ),
                          onPressed: () {
                            showModalBottomSheet(
                              context: context,
                              isScrollControlled: true,
                              shape: const RoundedRectangleBorder(
                                borderRadius:
                                BorderRadius.vertical(top: Radius.circular(24)),
                              ),
                              builder: (context) => EditingProductOption(
                                productId: productId?.toString(),
                                productData: _prepareProductDataForEditing(product),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ],
                ),

                const SizedBox(height: 6),

                // 🔹 Row 2 — Product name + Capacity
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        product.name != null && product.name!.isNotEmpty
                            ? (product.brand != null && product.brand!.isNotEmpty
                            ? '${product.name} (${product.brand})'
                            : product.name!)
                            : 'Product Name Not Available',
                        style: TextStyle(
                          color: isInactive ? Colors.grey : AppColors.secondary,
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    if (product.storageCapacity != null && product.storageCapacity!.isNotEmpty)
                      Text(
                        "Capacity: "
                            "${product.storageCapacity ?? 'N/A'} "
                            "${(product.unitOfMeasure?.trim().toLowerCase() == 'litres' ||
                            product.unitOfMeasure?.trim().toLowerCase() == 'liter' ||
                            product.unitOfMeasure?.trim().toLowerCase() == 'liters')
                            ? 'KL'
                            : (product.unitOfMeasure?.trim().toLowerCase() == 'pieces')
                            ? 'pc'
                            : ''}",
                        style: TextStyle(
                          color: isInactive ? Colors.grey : AppColors.icon,
                          fontSize: 12,
                        ),
                      ),
                  ],
                ),

                const SizedBox(height: 6),

                // 🔹 Row 3 — Minimum Stock
                // Text(
                //   "Minimum Stock: "
                //       "${product.unitOfMeasure == 'Litres'
                //       ? (product.minQtyAlert?.isEmpty ?? true
                //       ? 'N/A'
                //       : product.minQtyAlert)
                //       : (product.qtyInStock?.isEmpty ?? true
                //       ? 'N/A'
                //       : int.tryParse(product.qtyInStock!) ??
                //       double.tryParse(product.qtyInStock!)?.toInt() ??
                //       'N/A')} "
                //       "${product.unitOfMeasure == 'Litres'
                //       ? 'KL'
                //       : product.unitOfMeasure == 'Pieces'
                //       ? 'pc'
                //       : ''}",
                //   style: TextStyle(
                //     color: isInactive ? Colors.grey : AppColors.icon,
                //     fontSize: 12,
                //   ),
                //   overflow: TextOverflow.ellipsis,
                // ),
                Text(
                  "Minimum Stock: "
                      "${(product.unitOfMeasure?.trim().toLowerCase() == 'litres')
                      ? ((product.minQtyAlert?.isEmpty ?? true) ? 'N/A' : product.minQtyAlert)
                      : ((product.qtyInStock?.isEmpty ?? true)
                      ? 'N/A'
                      : int.tryParse(product.qtyInStock!) ??
                      double.tryParse(product.qtyInStock!)?.toInt() ??
                      'N/A')} "
                      "${(product.unitOfMeasure?.trim().toLowerCase() == 'litres')
                      ? 'KL'
                      : (product.unitOfMeasure?.trim().toLowerCase() == 'pieces')
                      ? 'pc'
                      : ''}",
                  style: TextStyle(
                    color: isInactive ? Colors.grey : AppColors.icon,
                    fontSize: 12,
                  ),
                  overflow: TextOverflow.ellipsis,
                )
,
                if (isInactive) ...[
                  const SizedBox(height: 6),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      'INACTIVE',
                      style: TextStyle(
                        color: Colors.grey[700],
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
        );



      },
    );
  }

  Widget _buildLowStockTab() {
    if (getProductController.isLowStockLoading.value) {
      return Center(child: CircularProgressIndicator());
    }

    if (getProductController.getLowStockProductModel.value.data == null ||
        getProductController.getLowStockProductModel.value.data!.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.inventory_2_outlined,
              size: 64,
              color: AppColors.icon,
            ),
            SizedBox(height: 16),
            Text(
              "No Low Stock Products",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: AppColors.text,
              ),
            ),
            SizedBox(height: 8),
            Text(
              "All products have sufficient stock",
              style: TextStyle(
                fontSize: 14,
                color: AppColors.icon,
              ),
            ),
          ],
        ),
      );
    }

    final lowStockProducts =
        getProductController.getLowStockProductModel.value.data!;

    return Expanded(
      child: ListView.builder(
        itemCount: lowStockProducts.length,
        itemBuilder: (context, index) {
          final product = lowStockProducts[index];
          final isInactive = product.status == "0"; // Check if product is inactive

          return Card(
            elevation: 0,
            margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
              side: BorderSide(
                color: AppColors.secondary.withOpacity(0.3),
                width: 1,
              ),
            ),
            color: isInactive ? Colors.grey[100] : Colors.white,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 🔹 Row 1 — Product Code + Icons
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        product.code ?? "Product Code Not Available",
                        style: TextStyle(
                          color: isInactive ? Colors.grey : AppColors.primary,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Row(
                        children: [
                          IconButton(
                            padding: EdgeInsets.zero,
                            constraints: const BoxConstraints(),
                            icon: SvgPicture.asset(
                              'assets/images/lowstock.svg',
                              width: 34,
                              color: isInactive ? Colors.grey : Colors.red,
                            ),
                            onPressed: () {},
                          ),
                          const SizedBox(width: 20),
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                'ST: ${product.qtyInStock ?? "N/A"}',
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16,
                                  color: isInactive ? Colors.grey : AppColors.primary,
                                ),
                              ),
                              // Show stock status indicator
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                                decoration: BoxDecoration(
                                  color: isInactive
                                      ? Colors.grey[300]
                                      : Colors.red.shade100,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Text(
                                  'Low Stock',
                                  style: TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.w500,
                                    color: isInactive
                                        ? Colors.grey[700]
                                        : Colors.red.shade700,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),

                  const SizedBox(height: 6),

                  // 🔹 Row 2 — Product name + Capacity
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          product.name ?? "Product Name Not Available",
                          style: TextStyle(
                            color: isInactive ? Colors.grey : AppColors.secondary,
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      if (product.storageCapacity != null &&
                          product.storageCapacity!.isNotEmpty)
                        // Text(
                        //   "Capacity: "
                        //       "${product.unitOfMeasure == 'Pieces'
                        //       ? (double.tryParse(product.storageCapacity!)?.toInt() ?? 'N/A')
                        //       : (product.storageCapacity ?? 'N/A')} "
                        //       "${product.unitOfMeasure == 'Litres'
                        //       ? 'KL'
                        //       : product.unitOfMeasure == 'Pieces'
                        //       ? 'pc'
                        //       : ''}",
                        //   style: TextStyle(
                        //     color: isInactive ? Colors.grey : AppColors.icon,
                        //     fontSize: 12,
                        //   ),
                        // ),

                        Text(
                          "Capacity: "
                              "${(product.unitOfMeasure?.trim().toLowerCase() == 'pieces')
                              ? (double.tryParse(product.storageCapacity ?? '')?.toInt() ?? 'N/A')
                              : (product.storageCapacity?.isNotEmpty ?? false
                              ? product.storageCapacity
                              : 'N/A')} "
                              "${(product.unitOfMeasure?.trim().toLowerCase() == 'litres' ||
                              product.unitOfMeasure?.trim().toLowerCase() == 'liter' ||
                              product.unitOfMeasure?.trim().toLowerCase() == 'liters')
                              ? 'KL'
                              : (product.unitOfMeasure?.trim().toLowerCase() == 'pieces')
                              ? 'pc'
                              : ''}",
                          style: TextStyle(
                            color: isInactive ? Colors.grey : AppColors.icon,
                            fontSize: 12,
                          ),
                        ),


                    ],
                  ),

                  const SizedBox(height: 16),

                  // 🔹 Row 3 — Stock Information
                  // 🟢 Stock Info (Two Rows Layout)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // 🔹 Row 1 — Labels
                      Row(
                        children: const [
                          Expanded(
                            child: Text(
                              "Stock",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: Colors.grey,
                              ),
                              textAlign: TextAlign.left, // 👈 Left aligned
                            ),
                          ),
                          Expanded(
                            child: Text(
                              "Min Stock",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: Colors.grey,
                              ),
                              textAlign: TextAlign.left, // 👈 Left aligned
                            ),
                          ),
                          Expanded(
                            child: Text(
                              "Unit",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: Colors.grey,
                              ),
                              textAlign: TextAlign.left, // 👈 Left aligned
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 2),

                      // 🔹 Row 2 — Values
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              "${product.qtyInStock ?? 'N/A'} "
                                  "${product.unitOfMeasure == 'Litres'
                                  ? 'KL'
                                  : product.unitOfMeasure == 'Pieces'
                                  ? 'pc'
                                  : ''}",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                color: isInactive ? Colors.grey : AppColors.icon,
                              ),
                              textAlign: TextAlign.left, // 👈 Left aligned
                            ),
                          ),
                          Expanded(
                            child: Text(
                              "${product.minQtyAlert ?? 'N/A'} "
                                  "${product.unitOfMeasure == 'Litres'
                                  ? 'KL'
                                  : product.unitOfMeasure == 'Pieces'
                                  ? 'pc'
                                  : ''}",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                color: isInactive ? Colors.grey : Colors.orange,
                              ),
                              textAlign: TextAlign.left, // 👈 Left aligned
                            ),
                          ),
                          Expanded(
                            child: Text(
                              product.unitOfMeasure ?? 'N/A',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                color: isInactive ? Colors.grey : AppColors.icon,
                              ),
                              textAlign: TextAlign.left, // 👈 Left aligned
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),



                  // 🔹 Inactive Badge
                  if (isInactive) ...[
                    const SizedBox(height: 6),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        'INACTIVE',
                        style: TextStyle(
                          color: Colors.grey[700],
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildSalesTab() {
    if (getProductController.getProductModel.value.data == null) {
      return Center(child: CircularProgressIndicator());
    }

    final products = getProductController.getProductModel.value.data!;

    return Expanded(
      child: ListView.builder(
        itemCount: products.length,
        itemBuilder: (context, index) {
          final product = products[index];
          final isInactive = product.status == "0";
          final salesAmount =
              '₹${_getCurrentMonthSales(product.id?.toString() ?? '')}';

          return Card(
            elevation: 0,
            margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
              side: BorderSide(
                color: AppColors.secondary.withOpacity(0.3),
                width: 1,
              ),
            ),
            color: isInactive ? Colors.grey[100] : Colors.white,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 🔹 Row 1 — Product Code + Icons + Sales Amount
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        product.code ?? "Product Code Not Available",
                        style: TextStyle(
                          color: isInactive ? Colors.grey : AppColors.primary,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Row(
                        children: [
                          // IconButton(
                          //   padding: EdgeInsets.zero,
                          //   constraints: const BoxConstraints(),
                          //   icon: SvgPicture.asset(
                          //     'assets/images/Sales.svg',
                          //     width: 28,
                          //     color: isInactive ? Colors.grey : AppColors.primary,
                          //   ),
                          //   onPressed: isInactive
                          //       ? null
                          //       : () {
                          //     showModalBottomSheet(
                          //       context: context,
                          //       isScrollControlled: true,
                          //       shape: const RoundedRectangleBorder(
                          //         borderRadius: BorderRadius.vertical(
                          //             top: Radius.circular(16)),
                          //       ),
                          //       builder: (context) {
                          //         return Sales(
                          //             productId: product.id?.toString());
                          //       },
                          //     );
                          //   },
                          // ),

                          IconButton(
                            padding: EdgeInsets.zero,
                            constraints: const BoxConstraints(),
                            icon: SvgPicture.asset(
                              'assets/images/Sales.svg',
                              width: 28,
                              color: isInactive ? Colors.grey : AppColors.primary,
                            ),
                            onPressed: isInactive
                                ? null
                                : () {
                              showModalBottomSheet(
                                context: context,
                                isScrollControlled: true,
                                shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.vertical(
                                      top: Radius.circular(12)),
                                ),
                                builder: (context) {
                                  return SalesGraph(
                                      productId:
                                      product.id?.toString() ?? '');
                                },
                              );
                            },
                          ),
                          const SizedBox(width: 10),
                          Text(
                            salesAmount,
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 22,
                              color: isInactive
                                  ? Colors.grey
                                  : AppColors.primary,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),

                  const SizedBox(height: 6),

                  // 🔹 Row 2 — Product Name + Capacity
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          product.name ?? "Product Name Not Available",
                          style: TextStyle(
                            color:
                            isInactive ? Colors.grey : AppColors.secondary,
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      if (product.storageCapacity != null &&
                          product.storageCapacity!.isNotEmpty)
                        Text(
                          "Capacity: "
                              "${product.unitOfMeasure == 'Pieces'
                              ? (double.tryParse(product.storageCapacity!)?.toInt() ?? 'N/A')
                              : (product.storageCapacity ?? 'N/A')} "
                              "${product.unitOfMeasure == 'Litres'
                              ? 'KL'
                              : product.unitOfMeasure == 'Pieces'
                              ? 'pc'
                              : ''}",
                          style: TextStyle(
                            color: isInactive ? Colors.grey : AppColors.icon,
                            fontSize: 12,
                          ),
                        ),
                    ],
                  ),

                  const SizedBox(height: 14),

                  // 🔹 Row 3 — Stock + Unit info (like Low Stock layout)
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          "Stock: ${product.qtyInStock ?? 'N/A'} "
                              "${product.unitOfMeasure == 'Litres'
                              ? 'KL'
                              : product.unitOfMeasure == 'Pieces'
                              ? 'pc'
                              : ''}",
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                            color: isInactive ? Colors.grey : AppColors.icon,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          "Unit: ${product.unitOfMeasure ?? 'N/A'}",
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                            color: isInactive ? Colors.grey : AppColors.icon,
                          ),
                        ),
                      ),
                    ],
                  ),

                  // 🔹 Inactive Badge
                  if (isInactive) ...[
                    const SizedBox(height: 6),
                    Container(
                      padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        'INACTIVE',
                        style: TextStyle(
                          color: Colors.grey[700],
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          );
        },
      ),
    );
  }


  Widget _buildProductsTab() {
    if (getProductController.getProductModel.value.data == null) {
      return const Center(child: CircularProgressIndicator());
    }

    final products = getProductController.getProductModel.value.data!;

    return Expanded(
      child: ListView.builder(
        itemCount: products.length,
        itemBuilder: (context, index) {
          final product = products[index];
          final isInactive = product.status == "0";

          return Card(
            elevation: 0,
            margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
              side: BorderSide(
                color: AppColors.secondary.withOpacity(0.3),
                width: 1,
              ),
            ),
            color: isInactive ? Colors.grey[100] : Colors.white,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 🔹 Row 1 — Product Code + Delete Button
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        product.code ?? "Product Code Not Available",
                        style: TextStyle(
                          color: isInactive ? Colors.grey : AppColors.primary,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      IconButton(
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(),
                        icon: SvgPicture.asset(
                          'assets/images/Delete.svg',
                          width: 26,
                          color: isInactive ? Colors.grey : Colors.redAccent,
                        ),
                        onPressed: isInactive
                            ? null
                            : () {
                          showDialog(
                            context: context,
                            barrierDismissible: true,
                            builder: (BuildContext context) {
                              return Inventorydeletewarning(
                                productId: product.id?.toString() ?? '',
                                productName: product.name ?? 'Product',
                              );
                            },
                          );
                        },
                      ),
                    ],
                  ),

                  const SizedBox(height: 6),

                  // 🔹 Row 2 — Product Name + Capacity
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          product.name ?? "Product Name Not Available",
                          style: TextStyle(
                            color: isInactive ? Colors.grey : AppColors.secondary,
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      if (product.storageCapacity != null &&
                          product.storageCapacity!.isNotEmpty)
                        Text(
                          "Capacity: "
                              "${product.unitOfMeasure == 'Pieces'
                              ? (double.tryParse(product.storageCapacity!)?.toInt() ?? 'N/A')
                              : (product.storageCapacity ?? 'N/A')} "
                              "${product.unitOfMeasure == 'Litres'
                              ? 'KL'
                              : product.unitOfMeasure == 'Pieces'
                              ? 'pc'
                              : ''}",
                          style: TextStyle(
                            color: isInactive ? Colors.grey : AppColors.icon,
                            fontSize: 12,
                          ),
                        ),
                    ],
                  ),

                  const SizedBox(height: 14),

                  // 🔹 Row 3 — Stock + Unit Info
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          "Stock: ${product.qtyInStock ?? 'N/A'} "
                              "${product.unitOfMeasure == 'Litres'
                              ? 'KL'
                              : product.unitOfMeasure == 'Pieces'
                              ? 'pc'
                              : ''}",
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                            color: isInactive ? Colors.grey : AppColors.icon,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          "Unit: ${product.unitOfMeasure ?? 'N/A'}",
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                            color: isInactive ? Colors.grey : AppColors.icon,
                          ),
                        ),
                      ),
                    ],
                  ),

                  // 🔹 Inactive Badge
                  if (isInactive) ...[
                    const SizedBox(height: 6),
                    Container(
                      padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        'INACTIVE',
                        style: TextStyle(
                          color: Colors.grey[700],
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          );
        },
      ),
    );
  }


  void refreshData() {
    getProductController.refreshAllData();
  }


  // Map<String, dynamic> _prepareProductDataForEditing(dynamic product) {
  //   final data = {
  //     'name': product.name ?? '',
  //     'product_id': product.id?.toString() ?? '',
  //     'product_category_id': product.id?.toString() ?? '',
  //     'brand': product.brand ?? '',
  //     'unit_of_measure': product.unitOfMeasure ?? '',
  //     'per_price': product.perPrice?.toString() ?? '',
  //     'storage_capacity': product.storageCapacity?.toString() ?? '',
  //     'qty_in_stock': product.qtyInStock?.toString() ?? '',
  //     'min_qty_alert': product.minQtyAlert?.toString() ?? '',
  //     'description': product.description ?? '',
  //     'supplier_name': product.supplierName ?? '',
  //     'status': product.status?.toString() ?? '1', // ADD THIS LINE - CRITICAL!
  //   };
  //
  //   print('🎯 PREPARED EDIT DATA:');
  //   data.forEach((key, value) {
  //     print('   $key: $value');
  //   });
  //
  //   return data;
  // }
  Map<String, dynamic> _prepareProductDataForEditing(dynamic product) {
    // First, let's debug what's actually in the product object
    print('🔍 DEBUG PRODUCT OBJECT:');
    print('Product type: ${product.runtimeType}');

    // Try different ways to access the name
    if (product is Data) {
      print('✅ Product is Data type');
      print('Name from product.name: ${product.name}');
      print('Name from product.name.toString(): ${product.name?.toString()}');
    } else {
      print('❌ Product is NOT Data type');
    }

    // Try to access properties dynamically
    try {
      print('Trying dynamic access - product.name: ${product.name}');
    } catch (e) {
      print('Error accessing product.name: $e');
    }

    try {
      print('Trying toJson if available: ${product.toJson()}');
    } catch (e) {
      print('No toJson method: $e');
    }

    // Create the data map with proper null checks
    final data = {
      'product_id': product.id?.toString() ?? '',
      'name': _extractProductName(product), // Use helper method
      'product_category_id': product.id?.toString() ?? '',
      'brand': product.brand ?? '',
      'unit_of_measure': product.unitOfMeasure ?? '',
      'per_price': product.perPrice?.toString() ?? '',
      'storage_capacity': product.storageCapacity?.toString() ?? '',
      'qty_in_stock': product.qtyInStock?.toString() ?? '',
      'min_qty_alert': product.minQtyAlert?.toString() ?? '',
      'description': product.description ?? '',
      'supplier_name': product.supplierName ?? '',
      'status': product.status?.toString() ?? '1',
    };

    print('🎯 PREPARED EDIT DATA:');
    data.forEach((key, value) {
      print('   $key: $value');
    });

    return data;
  }

// Helper method to extract product name safely
  String _extractProductName(dynamic product) {
    if (product == null) return '';

    // Try different ways to access the name
    try {
      if (product is Data) {
        return product.name ?? '';
      }

      // Try dynamic access
      if (product.name != null) {
        return product.name.toString();
      }

      // Try using toJson if available
      try {
        final json = product.toJson();
        return json['name']?.toString() ?? '';
      } catch (e) {
        // Ignore if toJson fails
      }
    } catch (e) {
      print('Error extracting product name: $e');
    }

    return '';
  }
  void _debugProductFields(dynamic product) {
    print('🎯 DEBUG CONTROLLER STATE:');
    print('🔍 Product Fields Debug:');
    print('ID: ${product.id}');
    print('Code: ${product.code}');
    print('Name: ${product.name}');
    print('Brand: ${product.brand}');
    print('Unit of Measure: ${product.unitOfMeasure}');
    print('Per Price: ${product.perPrice}');
    print('Storage Capacity: ${product.storageCapacity}');
    print('Qty in Stock: ${product.qtyInStock}');
    print('Min Qty Alert: ${product.minQtyAlert}');
    print('Description: ${product.description}');
    print('Supplier Name: ${product.supplierName}');

    // Try to print all properties using reflection
    print(
        'All properties: ${product.toJson()}'); // If your model has toJson method
  }
}
