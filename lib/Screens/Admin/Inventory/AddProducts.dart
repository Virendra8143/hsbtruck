//
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:get/get.dart';
// import 'package:get/get_core/src/get_main.dart';
//
// // import '../../../Utils/Preference.dart';
// import '../../../controllers/AdminController/CreateProductController.dart';
// import '../../../models/AdminModels/GetProductNameModel.dart';
// import '../../../utils/colors.dart';
// import 'CreateNewProduct.dart';
//
// class AddProducts extends StatefulWidget {
//   const AddProducts({super.key});
//
//   @override
//   State<AddProducts> createState() => _AddProductsState();
// }
//
// class _AddProductsState extends State<AddProducts> {
//   String? dropdownValue;
//   String? dropdownValue2;
//   String? dropdownValue3;
//
//   final CreateProductController createProductController =
//   Get.put(CreateProductController());
//
//   final Rx<Data?> selectedProduct = Rx<Data?>(null);
//
//   // Form key for validation
//   final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
//
//   // Add TextEditingControllers for form data
//   final TextEditingController _brandController = TextEditingController();
//   final TextEditingController _priceController = TextEditingController();
//   final TextEditingController _quantityController = TextEditingController();
//   final TextEditingController _minStockController = TextEditingController();
//   final TextEditingController _descriptionController = TextEditingController();
//   final TextEditingController _supplierController = TextEditingController();
//
//   // Add FocusNodes to maintain focus
//   final FocusNode _brandFocusNode = FocusNode();
//   final FocusNode _priceFocusNode = FocusNode();
//   final FocusNode _quantityFocusNode = FocusNode();
//   final FocusNode _minStockFocusNode = FocusNode();
//   final FocusNode _descriptionFocusNode = FocusNode();
//   final FocusNode _supplierFocusNode = FocusNode();
//
//   // Error messages for dropdowns
//   String? productError;
//   String? unitOfMeasureError;
//   String? storageCapacityError;
//
//   @override
//   void initState() {
//     super.initState();
//     // Load product names when screen initializes
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       _loadProductData();
//     });
//   }
//
//   // Method to load product data with error handling
//   void _loadProductData() {
//     try {
//       createProductController.getProductName();
//       print('Loading product names...');
//       // Use a delay to check if data loaded after API call
//       Future.delayed(Duration(seconds: 2), () {
//         final itemCount = createProductController.getProductNameModel.value.data?.length ?? 0;
//         print('Product names loaded: $itemCount items');
//         if (itemCount == 0) {
//           Get.snackbar(
//             'Info',
//             'No products found. Please create a product first.',
//             snackPosition: SnackPosition.BOTTOM,
//             backgroundColor: Colors.orange,
//             colorText: Colors.white,
//           );
//         }
//       });
//     } catch (e) {
//       print('Error loading products: $e');
//       // Show error message to user
//       Get.snackbar(
//         'Error',
//         'Failed to load products. Please try again.',
//         snackPosition: SnackPosition.BOTTOM,
//         backgroundColor: Colors.red,
//         colorText: Colors.white,
//       );
//     }
//   }
//
//   @override
//   void dispose() {
//     // Dispose controllers
//     _brandController.dispose();
//     _priceController.dispose();
//     _quantityController.dispose();
//     _minStockController.dispose();
//     _descriptionController.dispose();
//     _supplierController.dispose();
//
//     // Dispose focus nodes
//     _brandFocusNode.dispose();
//     _priceFocusNode.dispose();
//     _quantityFocusNode.dispose();
//     _minStockFocusNode.dispose();
//     _descriptionFocusNode.dispose();
//     _supplierFocusNode.dispose();
//     super.dispose();
//   }
//
//   // void _saveProduct() {
//   //   // Check if products are available first
//   //   final items = createProductController.getProductNameModel.value.data ?? [];
//   //
//   //   if (items.isEmpty) {
//   //     Get.snackbar(
//   //       'No Products Available',
//   //       'Please create a product first before adding it to inventory.',
//   //       snackPosition: SnackPosition.BOTTOM,
//   //       backgroundColor: Colors.orange,
//   //       colorText: Colors.white,
//   //       duration: Duration(seconds: 4),
//   //       icon: Icon(Icons.warning, color: Colors.white),
//   //       shouldIconPulse: false,
//   //       margin: EdgeInsets.all(16),
//   //       borderRadius: 8,
//   //     );
//   //     return;
//   //   }
//   //
//   //   setState(() {
//   //     // Clear previous errors
//   //     productError = null;
//   //     unitOfMeasureError = null;
//   //     storageCapacityError = null;
//   //
//   //     // Validate dropdowns
//   //     if (selectedProduct.value == null) {
//   //       productError = 'Please select a product';
//   //     }
//   //     if (dropdownValue2 == null) {
//   //       unitOfMeasureError = 'Please select unit of measure';
//   //     }
//   //     if (dropdownValue3 == null) {
//   //       storageCapacityError = 'Please select storage capacity';
//   //     }
//   //   });
//   //
//   //   // Validate form and dropdowns
//   //   if (_formKey.currentState!.validate() &&
//   //       productError == null &&
//   //       unitOfMeasureError == null &&
//   //       storageCapacityError == null) {
//   //
//   //     // Call the API function
//   //     createProductController.addUpdateProduct(
//   //       productId: selectedProduct.value!.id.toString(),
//   //       brand: _brandController.text.trim(),
//   //       unitOfMeasure: dropdownValue2!,
//   //       perPrice: _priceController.text.trim(),
//   //       storageCapacity: dropdownValue3!,
//   //       qtyInStock: _quantityController.text.trim(),
//   //       minQtyAlert: _minStockController.text.trim(),
//   //       description: _descriptionController.text.trim(),
//   //       supplierName: _supplierController.text.trim(),
//   //     );
//   //   }
//   // }
//   void _saveProduct() {
//     // Check if products are available first
//     final items = createProductController.getProductNameModel.value.data ?? [];
//
//     if (items.isEmpty) {
//       Get.snackbar(
//         'No Products Available',
//         'Please create a product first before adding it to inventory.',
//         snackPosition: SnackPosition.BOTTOM,
//         backgroundColor: Colors.orange,
//         colorText: Colors.white,
//         duration: Duration(seconds: 4),
//       );
//       return;
//     }
//
//     setState(() {
//       // Clear previous errors
//       productError = null;
//       unitOfMeasureError = null;
//       storageCapacityError = null;
//
//       // Validate dropdowns
//       if (selectedProduct.value == null) {
//         productError = 'Please select a product';
//       }
//       if (dropdownValue2 == null) {
//         unitOfMeasureError = 'Please select unit of measure';
//       }
//       // Only validate storage capacity if Litres is selected
//       if (dropdownValue2 == 'Litres' && dropdownValue3 == null) {
//         storageCapacityError = 'Please select storage capacity';
//       }
//     });
//
//     // Validate form
//     if (!_formKey.currentState!.validate()) {
//       Get.snackbar(
//         'Validation Error',
//         'Please fix the form errors',
//         snackPosition: SnackPosition.BOTTOM,
//         backgroundColor: Colors.red,
//         colorText: Colors.white,
//       );
//       return;
//     }
//
//     // Validate dropdowns after form validation
//     if (productError != null || unitOfMeasureError != null || storageCapacityError != null) {
//       Get.snackbar(
//         'Validation Error',
//         'Please select all required dropdowns',
//         snackPosition: SnackPosition.BOTTOM,
//         backgroundColor: Colors.red,
//         colorText: Colors.white,
//       );
//       return;
//     }
//
//     // Prepare data for API call
//     final productId = selectedProduct.value!.id.toString();
//     final brand = _brandController.text.trim();
//     final unitOfMeasure = dropdownValue2!;
//     final perPrice = _priceController.text.trim();
//     final storageCapacity = dropdownValue3 ?? ''; // Can be empty for Pices
//     final qtyInStock = _quantityController.text.trim();
//     final minQtyAlert = _minStockController.text.trim();
//     final description = _descriptionController.text.trim();
//     final supplierName = _supplierController.text.trim();
//
//     // Debug print to see what data is being sent
//     print('Sending product data:');
//     print('Product ID: $productId');
//     print('Brand: $brand');
//     print('Unit of Measure: $unitOfMeasure');
//     print('Price: $perPrice');
//     print('Storage Capacity: $storageCapacity');
//     print('Quantity in Stock: $qtyInStock');
//     print('Min Stock Alert: $minQtyAlert');
//     print('Description: $description');
//     print('Supplier: $supplierName');
//
//     // Call the API function
//     createProductController.addUpdateProduct(
//       productId: productId,
//       brand: brand,
//       unitOfMeasure: unitOfMeasure,
//       perPrice: perPrice,
//       storageCapacity: storageCapacity,
//       qtyInStock: qtyInStock,
//       minQtyAlert: minQtyAlert,
//       description: description,
//       supplierName: supplierName,
//     );
//   }
//   @override
//   Widget build(BuildContext context) {
//     final mediaQuery = MediaQuery.of(context);
//     final screenHeight = mediaQuery.size.height;
//     final screenWidth = mediaQuery.size.width;
//     final keyboardHeight = MediaQuery.of(context).viewInsets.bottom;
//
//     return Material(
//       child: Container(
//           height: screenHeight * 0.8,
//           width: screenWidth * 0.99,
//           child: Column(
//             children: [
//               Expanded(
//                 child: SingleChildScrollView(
//                   keyboardDismissBehavior:
//                   ScrollViewKeyboardDismissBehavior.manual,
//                   physics: AlwaysScrollableScrollPhysics(),
//                   child: Form(
//                     key: _formKey,
//                     child: Container(
//                       padding: EdgeInsets.only(
//                         bottom: keyboardHeight > 0 ? keyboardHeight + 20 : 20,
//                       ),
//                       child: Column(
//                         children: [
//                           Padding(
//                             padding: EdgeInsets.symmetric(
//                                 horizontal: screenWidth * 0.02, vertical: 20),
//                             child: Row(
//                               children: [
//                                 SvgPicture.asset('assets/images/AddProducts.svg'),
//                                 SizedBox(width: screenWidth * 0.01),
//                                 Expanded(
//                                   child: Column(
//                                     crossAxisAlignment: CrossAxisAlignment.start,
//                                     children: [
//                                       Text(
//                                         'Product Management',
//                                         style: TextStyle(
//                                           fontWeight: FontWeight.w500,
//                                           fontSize: 24,
//                                           color: AppColors.secondary,
//                                         ),
//                                       ),
//                                       Text(
//                                         'Add or update product information',
//                                         style: TextStyle(
//                                           fontWeight: FontWeight.w400,
//                                           fontSize: 14,
//                                           color: AppColors.icon,
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                                 SizedBox(width: screenWidth * 0.01),
//                                 Column(
//                                   children: [
//                                     GestureDetector(
//                                       onTap: () async {
//                                         showModalBottomSheet(
//                                           context: context,
//                                           isScrollControlled: true,
//                                           shape: RoundedRectangleBorder(
//                                             borderRadius: BorderRadius.vertical(
//                                                 top: Radius.circular(16)),
//                                           ),
//                                           builder: (context) {
//                                             return CreateNewProduct();
//                                           },
//                                         );
//                                       },
//                                                                           child: Container(
//                                       width: 48,
//                                       height: 48,
//                                       child: SvgPicture.asset(
//                                         'assets/images/Addicon.svg',
//                                         fit: BoxFit.contain,
//                                       ),
//                                     ),
//                                     ),
//                                     SizedBox(height: 10),
//                                     Text(
//                                       'Create New Product',
//                                       style: TextStyle(
//                                           fontSize: 14,
//                                           fontWeight: FontWeight.w400,
//                                           color: AppColors.icon),
//                                       textAlign: TextAlign.center,
//                                     ),
//                                   ],
//                                 ),
//                               ],
//                             ),
//                           ),
//                           SizedBox(height: 20),
//                           // Fixed Row with proper spacing and flex
//                           Padding(
//                             padding: EdgeInsets.symmetric(
//                                 horizontal: screenWidth * 0.05),
//                             child: Row(
//                               children: [
//                                 // Product dropdown - using Expanded to prevent overflow
//                                 Expanded(
//                                   flex: 1,
//                                   child: Column(
//                                     crossAxisAlignment: CrossAxisAlignment.start,
//                                     children: [
//                                       Container(
//                                         height: 60,
//                                         decoration: BoxDecoration(
//                                           borderRadius: BorderRadius.circular(12),
//                                           border: Border.all(
//                                               color: productError != null
//                                                   ? Colors.red
//                                                   : AppColors.primary,
//                                               width: 1
//                                           ),
//                                         ),
//                                         child: Obx(() {
//                                           if (createProductController.isLoading.value) {
//                                             return Center(
//                                               child: Row(
//                                                 children: [
//                                                   SizedBox(width: 10),
//                                                   SizedBox(
//                                                     width: 18,
//                                                     height: 18,
//                                                     child: CircularProgressIndicator(
//                                                       strokeWidth: 2,
//                                                       color: AppColors.primary,
//                                                     ),
//                                                   ),
//                                                   SizedBox(width: 8),
//                                                   Expanded(
//                                                     child: Text(
//                                                       'Loading...',
//                                                       style: TextStyle(
//                                                         fontSize: 14,
//                                                         color: AppColors.text,
//                                                       ),
//                                                     ),
//                                                   ),
//                                                   SizedBox(width: 10),
//                                                 ],
//                                               ),
//                                             );
//                                           }
//
//                                           final items = createProductController
//                                               .getProductNameModel.value.data ??
//                                               [];
//
//                                           if (items.isEmpty) {
//                                             return Padding(
//                                               padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
//                                               child: Row(
//                                                 children: [
//                                                   Icon(Icons.info_outline, color: AppColors.icon, size: 16),
//                                                   SizedBox(width: 8),
//                                                   Expanded(
//                                                     child: Text(
//                                                       'No products available. Please create a product first.',
//                                                       style: TextStyle(
//                                                         fontSize: 13,
//                                                         color: AppColors.text,
//                                                       ),
//                                                     ),
//                                                   ),
//                                                 ],
//                                               ),
//                                             );
//                                           }
//
//                                           return DropdownButtonFormField<Data>(
//                                             value: selectedProduct.value,
//                                             isExpanded: true,
//                                             decoration: InputDecoration(
//                                               contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
//                                               border: InputBorder.none,
//                                               hintText: 'Select Product',
//                                               hintStyle: TextStyle(
//                                                 fontSize: 16,
//                                                 fontWeight: FontWeight.w400,
//                                                 color: AppColors.text,
//                                               ),
//                                             ),
//                                             icon: Padding(
//                                               padding: const EdgeInsets.only(right: 10),
//                                               child: SvgPicture.asset(
//                                                 'assets/images/Arrow.svg',
//                                                 width: 11,
//                                                 height: 15,
//                                               ),
//                                             ),
//                                             style: TextStyle(
//                                                 fontSize: 16, color: Colors.black),
//                                             items: items.map<DropdownMenuItem<Data>>(
//                                                     (Data item) {
//                                                   return DropdownMenuItem<Data>(
//                                                     value: item,
//                                                     child: Text(
//                                                       item.name ?? 'Unknown Product',
//                                                       style: TextStyle(
//                                                         fontSize: 16,
//                                                         color: Colors.black,
//                                                       ),
//                                                     ),
//                                                   );
//                                                 }).toList(),
//                                             onChanged: (Data? newValue) {
//                                               selectedProduct.value = newValue;
//                                               setState(() {
//                                                 productError = null;
//                                               });
//                                             },
//                                             validator: (value) {
//                                               if (value == null) {
//                                                 return 'Please select a product';
//                                               }
//                                               return null;
//                                             },
//                                           );
//                                         }),
//                                       ),
//                                       if (productError != null)
//                                         Padding(
//                                           padding: const EdgeInsets.only(left: 12, top: 5),
//                                           child: Text(
//                                             productError!,
//                                             style: TextStyle(
//                                               color: Colors.red,
//                                               fontSize: 12,
//                                             ),
//                                           ),
//                                         ),
//                                     ],
//                                   ),
//                                 ),
//                                 SizedBox(width: screenWidth * 0.03),
//                                 // Space between elements
//                                 // Brand TextField - using Expanded to prevent overflow
//                                 Expanded(
//                                   flex: 1,
//                                   child: SizedBox(
//                                     height: 80,
//                                     child: TextFormField(
//                                       controller: _brandController,
//                                       focusNode: _brandFocusNode,
//                                       validator: (value) {
//                                         // if (value == null || value.trim().isEmpty) {
//                                         //   return 'Brand is required';
//                                         // }
//                                         return null;
//                                       },
//                                       decoration: InputDecoration(
//                                         labelText: "Brand",
//                                         labelStyle:
//                                         TextStyle(color: AppColors.text),
//                                         enabledBorder: OutlineInputBorder(
//                                           borderRadius: BorderRadius.circular(12),
//                                           borderSide: BorderSide(
//                                               color: AppColors.primary, width: 1),
//                                         ),
//                                         focusedBorder: OutlineInputBorder(
//                                           borderRadius: BorderRadius.circular(12),
//                                           borderSide: BorderSide(
//                                               color: AppColors.primary, width: 2),
//                                         ),
//                                         errorBorder: OutlineInputBorder(
//                                           borderRadius: BorderRadius.circular(12),
//                                           borderSide: BorderSide(
//                                               color: Colors.red, width: 1),
//                                         ),
//                                         focusedErrorBorder: OutlineInputBorder(
//                                           borderRadius: BorderRadius.circular(12),
//                                           borderSide: BorderSide(
//                                               color: Colors.red, width: 2),
//                                         ),
//                                         border: OutlineInputBorder(
//                                           borderRadius: BorderRadius.circular(12),
//                                           borderSide: BorderSide(
//                                               color: AppColors.primary, width: 1),
//                                         ),
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                           SizedBox(height: 20),
//
//                           // Unit of Measure Dropdown
//                           // Padding(
//                           //   padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
//                           //   child: Column(
//                           //     crossAxisAlignment: CrossAxisAlignment.start,
//                           //     children: [
//                           //       Container(
//                           //         height: 60,
//                           //         width: screenWidth * 0.9,
//                           //         decoration: BoxDecoration(
//                           //           borderRadius: BorderRadius.circular(12),
//                           //           border: Border.all(
//                           //               color: unitOfMeasureError != null
//                           //                   ? Colors.red
//                           //                   : Colors.red,
//                           //               width: 1
//                           //           ),
//                           //         ),
//                           //         child: DropdownButton<String>(
//                           //           value: dropdownValue2,
//                           //           isExpanded: true,
//                           //           hint: Padding(
//                           //             padding: const EdgeInsets.only(left: 10),
//                           //             child: Text(
//                           //               'Unit of Measure',
//                           //               style: TextStyle(
//                           //                   fontSize: 16,
//                           //                   fontWeight: FontWeight.w400,
//                           //                   color: AppColors.text),
//                           //             ),
//                           //           ),
//                           //           icon: Padding(
//                           //             padding: const EdgeInsets.only(right: 20),
//                           //             child: SvgPicture.asset(
//                           //               'assets/images/Arrow.svg',
//                           //               width: 11,
//                           //               height: 15,
//                           //             ),
//                           //           ),
//                           //           style: TextStyle(fontSize: 16, color: Colors.black),
//                           //           underline: SizedBox(),
//                           //           items: <String>['Litres', 'Pices']
//                           //               .map<DropdownMenuItem<String>>((String value) {
//                           //             return DropdownMenuItem<String>(
//                           //               value: value,
//                           //               child: Padding(
//                           //                 padding: const EdgeInsets.only(left: 10),
//                           //                 child: Text(value),
//                           //               ),
//                           //             );
//                           //           }).toList(),
//                           //           onChanged: (String? newValue) {
//                           //             setState(() {
//                           //               dropdownValue2 = newValue;
//                           //               unitOfMeasureError = null;
//                           //             });
//                           //           },
//                           //         ),
//                           //       ),
//                           //       if (unitOfMeasureError != null)
//                           //         Padding(
//                           //           padding: const EdgeInsets.only(left: 12, top: 5),
//                           //           child: Text(
//                           //             unitOfMeasureError!,
//                           //             style: TextStyle(
//                           //               color: Colors.red,
//                           //               fontSize: 12,
//                           //             ),
//                           //           ),
//                           //         ),
//                           //     ],
//                           //   ),
//                           // ),
//                           // Unit of Measure Dropdown - FIXED
//                           Padding(
//                             padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Container(
//                                   height: 60,
//                                   width: screenWidth * 0.9,
//                                   decoration: BoxDecoration(
//                                     borderRadius: BorderRadius.circular(12),
//                                     border: Border.all(
//                                       color: unitOfMeasureError != null
//                                           ? Colors.red
//                                           : AppColors.primary, // CHANGED: Removed hardcoded red
//                                       width: 1,
//                                     ),
//                                   ),
//                                   child: DropdownButton<String>(
//                                     value: dropdownValue2,
//                                     isExpanded: true,
//                                     hint: Padding(
//                                       padding: const EdgeInsets.only(left: 10),
//                                       child: Text(
//                                         'Unit of Measure',
//                                         style: TextStyle(
//                                           fontSize: 16,
//                                           fontWeight: FontWeight.w400,
//                                           color: AppColors.text,
//                                         ),
//                                       ),
//                                     ),
//                                     icon: Padding(
//                                       padding: const EdgeInsets.only(right: 20),
//                                       child: SvgPicture.asset(
//                                         'assets/images/Arrow.svg',
//                                         width: 11,
//                                         height: 15,
//                                       ),
//                                     ),
//                                     style: TextStyle(fontSize: 16, color: Colors.black),
//                                     underline: SizedBox(),
//                                     items: <String>['Litres', 'Pices']
//                                         .map<DropdownMenuItem<String>>((String value) {
//                                       return DropdownMenuItem<String>(
//                                         value: value,
//                                         child: Padding(
//                                           padding: const EdgeInsets.only(left: 10),
//                                           child: Text(value),
//                                         ),
//                                       );
//                                     }).toList(),
//                                     onChanged: (String? newValue) {
//                                       setState(() {
//                                         dropdownValue2 = newValue;
//                                         unitOfMeasureError = null;
//                                       });
//                                     },
//                                   ),
//                                 ),
//                                 if (unitOfMeasureError != null)
//                                   Padding(
//                                     padding: const EdgeInsets.only(left: 12, top: 5),
//                                     child: Text(
//                                       unitOfMeasureError!,
//                                       style: TextStyle(
//                                         color: Colors.red,
//                                         fontSize: 12,
//                                       ),
//                                     ),
//                                   ),
//                               ],
//                             ),
//                           ),
//                       Column(
//                         children: [
//                           SizedBox(height: 20),
//
//                           /// PRICE FIELD
//                           SizedBox(
//                             width: screenWidth * 0.9,
//                             child: TextFormField(
//                               controller: _priceController,
//                               focusNode: _priceFocusNode,
//                               keyboardType: const TextInputType.numberWithOptions(decimal: true),
//                               validator: (value) {
//                                 if (value == null || value.trim().isEmpty) {
//                                   return 'Price is required';
//                                 }
//                                 if (double.tryParse(value.trim()) == null) {
//                                   return 'Please enter a valid price';
//                                 }
//                                 if (double.parse(value.trim()) <= 0) {
//                                   return 'Price must be greater than 0';
//                                 }
//                                 return null;
//                               },
//                               decoration: InputDecoration(
//                                 labelText: "Price Per Litres (RSP)/Unit",
//                                 labelStyle: TextStyle(color: AppColors.text),
//                                 enabledBorder: OutlineInputBorder(
//                                   borderRadius: BorderRadius.circular(12),
//                                   borderSide: BorderSide(color: AppColors.primary, width: 1),
//                                 ),
//                                 focusedBorder: OutlineInputBorder(
//                                   borderRadius: BorderRadius.circular(12),
//                                   borderSide: BorderSide(color: AppColors.primary, width: 2),
//                                 ),
//                                 errorBorder: OutlineInputBorder(
//                                   borderRadius: BorderRadius.circular(12),
//                                   borderSide: const BorderSide(color: Colors.red, width: 1),
//                                 ),
//                                 focusedErrorBorder: OutlineInputBorder(
//                                   borderRadius: BorderRadius.circular(12),
//                                   borderSide: const BorderSide(color: Colors.red, width: 2),
//                                 ),
//                                 border: OutlineInputBorder(
//                                   borderRadius: BorderRadius.circular(12),
//                                   borderSide: BorderSide(color: AppColors.primary, width: 1),
//                                 ),
//                               ),
//                             ),
//                           ),
//
//                           SizedBox(height: 20),
//
//                           /// STORAGE CAPACITY (Visible only if Litres is selected)
//                           if (dropdownValue2 == 'Litres')
//                             Padding(
//                               padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
//                               child: Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   Container(
//                                     height: 60,
//                                     width: screenWidth * 0.9,
//                                     decoration: BoxDecoration(
//                                       borderRadius: BorderRadius.circular(12),
//                                       border: Border.all(
//                                         color: storageCapacityError != null
//                                             ? Colors.red
//                                             : AppColors.primary,
//                                         width: 1,
//                                       ),
//                                     ),
//                                     child: DropdownButton<String>(
//                                       value: dropdownValue3,
//                                       isExpanded: true,
//                                       hint: const Padding(
//                                         padding: EdgeInsets.only(left: 10),
//                                         child: Text(
//                                           'Storage Capacity',
//                                           style: TextStyle(
//                                             fontSize: 16,
//                                             fontWeight: FontWeight.w400,
//                                             color: AppColors.text,
//                                           ),
//                                         ),
//                                       ),
//                                       icon: Padding(
//                                         padding: const EdgeInsets.only(right: 20),
//                                         child: SvgPicture.asset(
//                                           'assets/images/Arrow.svg',
//                                           width: 11,
//                                           height: 15,
//                                         ),
//                                       ),
//                                       style: const TextStyle(fontSize: 16, color: Colors.black),
//                                       underline: const SizedBox(),
//                                       items: <String>['9 KL', '16 KL', '22 KL', '35 KL']
//                                           .map<DropdownMenuItem<String>>((String value) {
//                                         return DropdownMenuItem<String>(
//                                           value: value,
//                                           child: Padding(
//                                             padding: const EdgeInsets.only(left: 10),
//                                             child: Text(value),
//                                           ),
//                                         );
//                                       }).toList(),
//                                       onChanged: (String? newValue) {
//                                         setState(() {
//                                           dropdownValue3 = newValue;
//                                           storageCapacityError = null;
//                                         });
//                                       },
//                                     ),
//                                   ),
//                                   if (storageCapacityError != null)
//                                     Padding(
//                                       padding: const EdgeInsets.only(left: 12, top: 5),
//                                       child: Text(
//                                         storageCapacityError!,
//                                         style: const TextStyle(
//                                           color: Colors.red,
//                                           fontSize: 12,
//                                         ),
//                                       ),
//                                     ),
//                                 ],
//                               ),
//                             ),
//
//
//
//                           /// QUANTITY IN STOCK (Visible only if Pieces is selected)
//                           if (dropdownValue2 == 'Pices')
//                             SizedBox(
//                               width: screenWidth * 0.9,
//                               child: TextFormField(
//                                 controller: _quantityController,
//                                 focusNode: _quantityFocusNode,
//                                 keyboardType: TextInputType.number,
//                                 validator: (value) {
//                                   if (value == null || value.trim().isEmpty) {
//                                     return 'Quantity in stock is required';
//                                   }
//                                   if (int.tryParse(value.trim()) == null) {
//                                     return 'Please enter a valid quantity';
//                                   }
//                                   if (int.parse(value.trim()) < 0) {
//                                     return 'Quantity cannot be negative';
//                                   }
//                                   return null;
//                                 },
//                                 decoration: InputDecoration(
//                                   labelText: "Quantity in Stock",
//                                   labelStyle: TextStyle(color: AppColors.text),
//                                   enabledBorder: OutlineInputBorder(
//                                     borderRadius: BorderRadius.circular(12),
//                                     borderSide: BorderSide(color: AppColors.primary, width: 1),
//                                   ),
//                                   focusedBorder: OutlineInputBorder(
//                                     borderRadius: BorderRadius.circular(12),
//                                     borderSide: BorderSide(color: AppColors.primary, width: 2),
//                                   ),
//                                   errorBorder: OutlineInputBorder(
//                                     borderRadius: BorderRadius.circular(12),
//                                     borderSide: const BorderSide(color: Colors.red, width: 1),
//                                   ),
//                                   focusedErrorBorder: OutlineInputBorder(
//                                     borderRadius: BorderRadius.circular(12),
//                                     borderSide: const BorderSide(color: Colors.red, width: 2),
//                                   ),
//                                   border: OutlineInputBorder(
//                                     borderRadius: BorderRadius.circular(12),
//                                     borderSide: BorderSide(color: AppColors.primary, width: 1),
//                                   ),
//                                 ),
//                               ),
//                             ),
//
//                           SizedBox(height: 20),
//
//                           /// MINIMUM STOCK ALERT (Always Visible)
//                           SizedBox(
//                             width: screenWidth * 0.9,
//                             child: TextFormField(
//                               controller: _minStockController,
//                               focusNode: _minStockFocusNode,
//                               keyboardType: TextInputType.number,
//                               validator: (value) {
//                                 if (value != null && value.trim().isNotEmpty) {
//                                   if (int.tryParse(value.trim()) == null) {
//                                     return 'Please enter a valid minimum stock level';
//                                   }
//                                   if (int.parse(value.trim()) < 0) {
//                                     return 'Minimum stock level cannot be negative';
//                                   }
//                                 }
//                                 return null;
//                               },
//                               decoration: InputDecoration(
//                                 labelText: "Minimum Stock Alert Level",
//                                 labelStyle: TextStyle(color: AppColors.text),
//                                 enabledBorder: OutlineInputBorder(
//                                   borderRadius: BorderRadius.circular(12),
//                                   borderSide: BorderSide(color: AppColors.primary, width: 1),
//                                 ),
//                                 focusedBorder: OutlineInputBorder(
//                                   borderRadius: BorderRadius.circular(12),
//                                   borderSide: BorderSide(color: AppColors.primary, width: 2),
//                                 ),
//                                 errorBorder: OutlineInputBorder(
//                                   borderRadius: BorderRadius.circular(12),
//                                   borderSide: const BorderSide(color: Colors.red, width: 1),
//                                 ),
//                                 focusedErrorBorder: OutlineInputBorder(
//                                   borderRadius: BorderRadius.circular(12),
//                                   borderSide: const BorderSide(color: Colors.red, width: 2),
//                                 ),
//                                 border: OutlineInputBorder(
//                                   borderRadius: BorderRadius.circular(12),
//                                   borderSide: BorderSide(color: AppColors.primary, width: 1),
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//
//                           SizedBox(height: 20),
//                           SizedBox(
//                             height: 117,
//                             width: screenWidth * 0.9,
//                             child: TextFormField(
//                               controller: _descriptionController,
//                               focusNode: _descriptionFocusNode,
//                               maxLines: 4,
//                               decoration: InputDecoration(
//                                 labelText: "Description or Remark",
//                                 labelStyle: TextStyle(color: AppColors.text),
//                                 enabledBorder: OutlineInputBorder(
//                                   borderRadius: BorderRadius.circular(12),
//                                   borderSide: BorderSide(
//                                       color: AppColors.primary, width: 1),
//                                 ),
//                                 focusedBorder: OutlineInputBorder(
//                                   borderRadius: BorderRadius.circular(12),
//                                   borderSide: BorderSide(
//                                       color: AppColors.primary, width: 2),
//                                 ),
//                                 errorBorder: OutlineInputBorder(
//                                   borderRadius: BorderRadius.circular(12),
//                                   borderSide: BorderSide(
//                                       color: Colors.red, width: 1),
//                                 ),
//                                 focusedErrorBorder: OutlineInputBorder(
//                                   borderRadius: BorderRadius.circular(12),
//                                   borderSide: BorderSide(
//                                       color: Colors.red, width: 2),
//                                 ),
//                                 border: OutlineInputBorder(
//                                   borderRadius: BorderRadius.circular(12),
//                                   borderSide: BorderSide(
//                                       color: AppColors.primary, width: 1),
//                                 ),
//                               ),
//                             ),
//                           ),
//                           SizedBox(height: 20),
//                           SizedBox(
//                             height: 117,
//                             width: screenWidth * 0.9,
//                             child: TextFormField(
//                               controller: _supplierController,
//                               focusNode: _supplierFocusNode,
//                               maxLines: 4,
//                               decoration: InputDecoration(
//                                 labelText: "Supplier name",
//                                 labelStyle: TextStyle(color: AppColors.text),
//                                 enabledBorder: OutlineInputBorder(
//                                   borderRadius: BorderRadius.circular(12),
//                                   borderSide: BorderSide(
//                                       color: AppColors.primary, width: 1),
//                                 ),
//                                 focusedBorder: OutlineInputBorder(
//                                   borderRadius: BorderRadius.circular(12),
//                                   borderSide: BorderSide(
//                                       color: AppColors.primary, width: 2),
//                                 ),
//                                 errorBorder: OutlineInputBorder(
//                                   borderRadius: BorderRadius.circular(12),
//                                   borderSide: BorderSide(
//                                       color: Colors.red, width: 1),
//                                 ),
//                                 focusedErrorBorder: OutlineInputBorder(
//                                   borderRadius: BorderRadius.circular(12),
//                                   borderSide: BorderSide(
//                                       color: Colors.red, width: 2),
//                                 ),
//                                 border: OutlineInputBorder(
//                                   borderRadius: BorderRadius.circular(12),
//                                   borderSide: BorderSide(
//                                       color: AppColors.primary, width: 1),
//                                 ),
//                               ),
//                             ),
//                           ),
//                           SizedBox(height: 20),
//                           Container(
//                             width: screenWidth * 0.9,
//                             height: screenHeight * 0.07,
//                             child: Obx(() {
//                               final items = createProductController.getProductNameModel.value.data ?? [];
//                               final isDisabled = createProductController.isLoading.value || items.isEmpty;
//
//                               return ElevatedButton(
//                                 onPressed: isDisabled ? null : _saveProduct,
//                                 style: ElevatedButton.styleFrom(
//                                   backgroundColor: AppColors.button,
//                                   shape: RoundedRectangleBorder(
//                                     borderRadius: BorderRadius.circular(10),
//                                   ),
//                                 ),
//                                 child: createProductController.isLoading.value
//                                     ? CircularProgressIndicator(color: AppColors.background)
//                                     : Text(
//                                       "Save Product",
//                                       style: TextStyle(
//                                         fontSize: 20,
//                                         fontWeight: FontWeight.w500,
//                                         color: AppColors.background,
//                                       ),
//                                     ),
//                               );
//                             }),
//                           ),
//                           SizedBox(height: 20),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           )),
//     );
//   }
// }
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

// import '../../../Utils/Preference.dart';
import '../../../controllers/AdminController/CreateProductController.dart';
import '../../../models/AdminModels/GetProductNameModel.dart';
import '../../../utils/colors.dart';
import 'CreateNewProduct.dart';

class AddProducts extends StatefulWidget {
  const AddProducts({super.key});

  @override
  State<AddProducts> createState() => _AddProductsState();
}

class _AddProductsState extends State<AddProducts> {
  String? dropdownValue;
  String? dropdownValue2;
  String? dropdownValue3;

  final CreateProductController createProductController =
  Get.put(CreateProductController());

  final Rx<Data?> selectedProduct = Rx<Data?>(null);

  // Form key for validation
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // Add TextEditingControllers for form data
  final TextEditingController _brandController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _quantityController = TextEditingController();
  final TextEditingController _minStockController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _supplierController = TextEditingController();

  // Add FocusNodes to maintain focus
  final FocusNode _brandFocusNode = FocusNode();
  final FocusNode _priceFocusNode = FocusNode();
  final FocusNode _quantityFocusNode = FocusNode();
  final FocusNode _minStockFocusNode = FocusNode();
  final FocusNode _descriptionFocusNode = FocusNode();
  final FocusNode _supplierFocusNode = FocusNode();

  // Error messages for dropdowns
  String? productError;
  String? unitOfMeasureError;
  String? storageCapacityError;

  @override
  void initState() {
    super.initState();
    // Load product names when screen initializes
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadProductData();
    });
  }

  // Method to load product data with error handling
  void _loadProductData() {
    try {
      createProductController.getProductName();
      print('Loading product names...');
      // Use a delay to check if data loaded after API call
      Future.delayed(Duration(seconds: 2), () {
        final itemCount = createProductController.getProductNameModel.value.data?.length ?? 0;
        print('Product names loaded: $itemCount items');
        if (itemCount == 0) {
          Get.snackbar(
            'Info',
            'No products found. Please create a product first.',
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.orange,
            colorText: Colors.white,
          );
        }
      });
    } catch (e) {
      print('Error loading products: $e');
      // Show error message to user
      Get.snackbar(
        'Error',
        'Failed to load products. Please try again.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  @override
  void dispose() {
    // Dispose controllers
    _brandController.dispose();
    _priceController.dispose();
    _quantityController.dispose();
    _minStockController.dispose();
    _descriptionController.dispose();
    _supplierController.dispose();

    // Dispose focus nodes
    _brandFocusNode.dispose();
    _priceFocusNode.dispose();
    _quantityFocusNode.dispose();
    _minStockFocusNode.dispose();
    _descriptionFocusNode.dispose();
    _supplierFocusNode.dispose();
    super.dispose();
  }

  void _saveProduct() {
    // Check if products are available first
    final items = createProductController.getProductNameModel.value.data ?? [];

    if (items.isEmpty) {
      Get.snackbar(
        'No Products Available',
        'Please create a product first before adding it to inventory.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.orange,
        colorText: Colors.white,
        duration: Duration(seconds: 4),
      );
      return;
    }

    setState(() {
      // Clear previous errors
      productError = null;
      unitOfMeasureError = null;
      storageCapacityError = null;

      // Validate dropdowns
      if (selectedProduct.value == null) {
        productError = 'Please select a product';
      }
      if (dropdownValue2 == null) {
        unitOfMeasureError = 'Please select unit of measure';
      }
      // Only validate storage capacity if Litres is selected
      if (dropdownValue2 == 'Litres' && dropdownValue3 == null) {
        storageCapacityError = 'Please select storage capacity';
      }
    });

    // Validate form
    if (!_formKey.currentState!.validate()) {
      Get.snackbar(
        'Validation Error',
        'Please fix the form errors',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    // Validate dropdowns after form validation
    if (productError != null || unitOfMeasureError != null || storageCapacityError != null) {
      Get.snackbar(
        'Validation Error',
        'Please select all required dropdowns',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    // Prepare data for API call
    final productId = selectedProduct.value!.id.toString();
    final brand = _brandController.text.trim();
    final unitOfMeasure = dropdownValue2!;
    final perPrice = _priceController.text.trim();
    final storageCapacity = dropdownValue3 ?? ''; // Can be empty for Pices
    final qtyInStock = _quantityController.text.trim();
    final minQtyAlert = _minStockController.text.trim();
    final description = _descriptionController.text.trim();
    final supplierName = _supplierController.text.trim();

    // Debug print to see what data is being sent
    print('Sending product data:');
    print('Product ID: $productId');
    print('Brand: $brand');
    print('Unit of Measure: $unitOfMeasure');
    print('Price: $perPrice');
    print('Storage Capacity: $storageCapacity');
    print('Quantity in Stock: $qtyInStock');
    print('Min Stock Alert: $minQtyAlert');
    print('Description: $description');
    print('Supplier: $supplierName');

    // Call the API function
    createProductController.addUpdateProduct(
      productId: productId,
      brand: brand,
      unitOfMeasure: unitOfMeasure,
      perPrice: perPrice,
      storageCapacity: storageCapacity,
      qtyInStock: qtyInStock,
      minQtyAlert: minQtyAlert,
      description: description,
      supplierName: supplierName,
    );
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final screenHeight = mediaQuery.size.height;
    final screenWidth = mediaQuery.size.width;
    final keyboardHeight = MediaQuery.of(context).viewInsets.bottom;

    return Material(
      child: Container(
          height: screenHeight * 0.8,
          width: screenWidth * 0.99,
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  keyboardDismissBehavior:
                  ScrollViewKeyboardDismissBehavior.manual,
                  physics: AlwaysScrollableScrollPhysics(),
                  child: Form(
                    key: _formKey,
                    child: Container(
                      padding: EdgeInsets.only(
                        bottom: keyboardHeight > 0 ? keyboardHeight + 20 : 20,
                      ),
                      child: Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: screenWidth * 0.04,
                              vertical: 20,
                            ),
                            child: LayoutBuilder(
                              builder: (context, constraints) {
                                final isWide = constraints.maxWidth > 600; // Tablet/Desktop breakpoint

                                return Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    // 🖼️ Left Icon
                                    SvgPicture.asset(
                                      'assets/images/AddProducts.svg',
                                      width: isWide ? 64 : 48,
                                      height: isWide ? 64 : 48,
                                    ),

                                    SizedBox(width: screenWidth * 0.03),

                                    // 📄 Text Section
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            'Add Product',
                                            style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                              fontSize: isWide ? 26 : 22,
                                              color: AppColors.secondary,
                                              height: 1.2,
                                            ),
                                          ),
                                          const SizedBox(height: 4),
                                          Text(
                                            'Add or update product information',
                                            style: TextStyle(
                                              fontWeight: FontWeight.w400,
                                              fontSize: isWide ? 16 : 13,
                                              color: AppColors.icon,
                                              height: 1.3,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),

                                    SizedBox(width: screenWidth * 0.02),

                                    // ➕ Create Product Button
                                    Column(
                                      children: [
                                        GestureDetector(
                                          onTap: () async {
                                            showModalBottomSheet(
                                              context: context,
                                              isScrollControlled: true,
                                              shape: const RoundedRectangleBorder(
                                                borderRadius:
                                                BorderRadius.vertical(top: Radius.circular(20)),
                                              ),
                                              builder: (context) {
                                                return CreateNewProduct();
                                              },
                                            );
                                          },
                                          child: Container(
                                            width: isWide ? 56 : 48,
                                            height: isWide ? 56 : 48,
                                            decoration: BoxDecoration(
                                              color: AppColors.secondary.withOpacity(0.1),
                                              borderRadius: BorderRadius.circular(12),
                                              border: Border.all(
                                                color: AppColors.secondary.withOpacity(0.3),
                                              ),
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.black.withOpacity(0.05),
                                                  blurRadius: 6,
                                                  offset: const Offset(2, 2),
                                                ),
                                              ],
                                            ),
                                            child: Center(
                                              child: SvgPicture.asset(
                                                'assets/images/Addicon.svg',
                                                width: isWide ? 28 : 24,
                                                height: isWide ? 28 : 24,
                                              ),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(height: 8),
                                        Text(
                                          'Create New Product',
                                          style: TextStyle(
                                            fontSize: isWide ? 15 : 13,
                                            fontWeight: FontWeight.w500,
                                            color: AppColors.icon,
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                      ],
                                    ),
                                  ],
                                );
                              },
                            ),
                          ),

                          SizedBox(height: 20),
                          // Fixed Row with proper spacing and flex
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: screenWidth * 0.05),
                            child: Row(
                              children: [
                                // Product dropdown - using Expanded to prevent overflow
                                Expanded(
                                  flex: 1,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        height: 60,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(12),
                                          border: Border.all(
                                              color: productError != null
                                                  ? Colors.red
                                                  : AppColors.primary,
                                              width: 1
                                          ),
                                        ),
                                        child: Obx(() {
                                          if (createProductController.isLoading.value) {
                                            return Center(
                                              child: Row(
                                                children: [
                                                  SizedBox(width: 10),
                                                  SizedBox(
                                                    width: 18,
                                                    height: 18,
                                                    child: CircularProgressIndicator(
                                                      strokeWidth: 2,
                                                      color: AppColors.primary,
                                                    ),
                                                  ),
                                                  SizedBox(width: 8),
                                                  Expanded(
                                                    child: Text(
                                                      'Loading...',
                                                      style: TextStyle(
                                                        fontSize: 14,
                                                        color: AppColors.text,
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(width: 10),
                                                ],
                                              ),
                                            );
                                          }

                                          final items = createProductController
                                              .getProductNameModel.value.data ??
                                              [];

                                          if (items.isEmpty) {
                                            return Padding(
                                              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                                              child: Row(
                                                children: [
                                                  Icon(Icons.info_outline, color: AppColors.icon, size: 16),
                                                  SizedBox(width: 8),
                                                  Expanded(
                                                    child: Text(
                                                      'No products available. Please create a product first.',
                                                      style: TextStyle(
                                                        fontSize: 13,
                                                        color: AppColors.text,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            );
                                          }

                                          return DropdownButtonFormField<Data>(
                                            value: selectedProduct.value,
                                            isExpanded: true,
                                            decoration: InputDecoration(
                                              contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                                              border: InputBorder.none,
                                              hintText: 'Select Product',
                                              hintStyle: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w400,
                                                color: AppColors.text,
                                              ),
                                            ),
                                            icon: Padding(
                                              padding: const EdgeInsets.only(right: 10),
                                              child: SvgPicture.asset(
                                                'assets/images/Arrow.svg',
                                                width: 11,
                                                height: 15,
                                              ),
                                            ),
                                            style: TextStyle(
                                                fontSize: 16, color: Colors.black),
                                            items: items.map<DropdownMenuItem<Data>>(
                                                    (Data item) {
                                                  return DropdownMenuItem<Data>(
                                                    value: item,
                                                    child: Text(
                                                      item.name ?? 'Unknown Product',
                                                      style: TextStyle(
                                                        fontSize: 16,
                                                        color: Colors.black,
                                                      ),
                                                    ),
                                                  );
                                                }).toList(),
                                            onChanged: (Data? newValue) {
                                              selectedProduct.value = newValue;
                                              setState(() {
                                                productError = null;
                                              });
                                            },
                                            validator: (value) {
                                              if (value == null) {
                                                return 'Please select a product';
                                              }
                                              return null;
                                            },
                                          );
                                        }),
                                      ),
                                      if (productError != null)
                                        Padding(
                                          padding: const EdgeInsets.only(left: 12, top: 5),
                                          child: Text(
                                            productError!,
                                            style: TextStyle(
                                              color: Colors.red,
                                              fontSize: 12,
                                            ),
                                          ),
                                        ),
                                    ],
                                  ),
                                ),
                                SizedBox(width: screenWidth * 0.03),

                                // Space between elements
                                // Brand TextField - using Expanded to prevent overflow
                                Expanded(
                                  flex: 1,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: SizedBox(
                                      height: 80,
                                      child: Padding(
                                        padding: const EdgeInsets.only(top: 10.0),
                                        child: TextFormField(
                                          controller: _brandController,
                                          focusNode: _brandFocusNode,
                                          validator: (value) {
                                            // if (value == null || value.trim().isEmpty) {
                                            //   return 'Brand is required';
                                            // }
                                            return null;
                                          },
                                          decoration: InputDecoration(
                                            labelText: "Brand",
                                            labelStyle:
                                            TextStyle(color: AppColors.text),
                                            enabledBorder: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(12),
                                              borderSide: BorderSide(
                                                  color: AppColors.primary, width: 1),
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(12),
                                              borderSide: BorderSide(
                                                  color: AppColors.primary, width: 2),
                                            ),
                                            errorBorder: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(12),
                                              borderSide: BorderSide(
                                                  color: Colors.red, width: 1),
                                            ),
                                            focusedErrorBorder: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(12),
                                              borderSide: BorderSide(
                                                  color: Colors.red, width: 2),
                                            ),
                                            border: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(12),
                                              borderSide: BorderSide(
                                                  color: AppColors.primary, width: 1),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 20),

                          // Unit of Measure Dropdown - FIXED
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  height: 60,
                                  width: screenWidth * 0.9,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    border: Border.all(
                                      color: unitOfMeasureError != null
                                          ? Colors.red
                                          : AppColors.primary, // CHANGED: Removed hardcoded red
                                      width: 1,
                                    ),
                                  ),
                                  child: DropdownButton<String>(
                                    value: dropdownValue2,
                                    isExpanded: true,
                                    hint: Padding(
                                      padding: const EdgeInsets.only(left: 10),
                                      child: Text(
                                        'Unit of Measure',
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w400,
                                          color: AppColors.text,
                                        ),
                                      ),
                                    ),
                                    icon: Padding(
                                      padding: const EdgeInsets.only(right: 20),
                                      child: SvgPicture.asset(
                                        'assets/images/Arrow.svg',
                                        width: 11,
                                        height: 15,
                                      ),
                                    ),
                                    style: TextStyle(fontSize: 16, color: Colors.black),
                                    underline: SizedBox(),
                                    items: <String>['Litres', 'Pices']
                                        .map<DropdownMenuItem<String>>((String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Padding(
                                          padding: const EdgeInsets.only(left: 10),
                                          child: Text(value),
                                        ),
                                      );
                                    }).toList(),
                                    onChanged: (String? newValue) {
                                      setState(() {
                                        dropdownValue2 = newValue;
                                        unitOfMeasureError = null;
                                      });
                                    },
                                  ),
                                ),
                                if (unitOfMeasureError != null)
                                  Padding(
                                    padding: const EdgeInsets.only(left: 12, top: 5),
                                    child: Text(
                                      unitOfMeasureError!,
                                      style: TextStyle(
                                        color: Colors.red,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                          ),

                          Column(
                            children: [
                              SizedBox(height: 20),

                              /// PRICE FIELD
                              SizedBox(
                                width: screenWidth * 0.9,
                                child: TextFormField(
                                  controller: _priceController,
                                  focusNode: _priceFocusNode,
                                  keyboardType: const TextInputType.numberWithOptions(decimal: true),
                                  validator: (value) {
                                    if (value == null || value.trim().isEmpty) {
                                      return 'Price is required';
                                    }
                                    if (double.tryParse(value.trim()) == null) {
                                      return 'Please enter a valid price';
                                    }
                                    if (double.parse(value.trim()) <= 0) {
                                      return 'Price must be greater than 0';
                                    }
                                    return null;
                                  },
                                  decoration: InputDecoration(
                                    labelText: "Price Per Litres (RSP)/Unit",
                                    labelStyle: TextStyle(color: AppColors.text),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12),
                                      borderSide: BorderSide(color: AppColors.primary, width: 1),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12),
                                      borderSide: BorderSide(color: AppColors.primary, width: 2),
                                    ),
                                    errorBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12),
                                      borderSide: const BorderSide(color: Colors.red, width: 1),
                                    ),
                                    focusedErrorBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12),
                                      borderSide: const BorderSide(color: Colors.red, width: 2),
                                    ),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12),
                                      borderSide: BorderSide(color: AppColors.primary, width: 1),
                                    ),
                                  ),
                                ),
                              ),

                              SizedBox(height: 20),

                              /// STORAGE CAPACITY (Visible only if Litres is selected)
                              if (dropdownValue2 == 'Litres')
                                Padding(
                                  padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        height: 60,
                                        width: screenWidth * 0.9,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(12),
                                          border: Border.all(
                                            color: storageCapacityError != null
                                                ? Colors.red
                                                : AppColors.primary,
                                            width: 1,
                                          ),
                                        ),
                                        child: DropdownButton<String>(
                                          value: dropdownValue3,
                                          isExpanded: true,
                                          hint: const Padding(
                                            padding: EdgeInsets.only(left: 10),
                                            child: Text(
                                              'Storage Capacity',
                                              style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w400,
                                                color: AppColors.text,
                                              ),
                                            ),
                                          ),
                                          icon: Padding(
                                            padding: const EdgeInsets.only(right: 20),
                                            child: SvgPicture.asset(
                                              'assets/images/Arrow.svg',
                                              width: 11,
                                              height: 15,
                                            ),
                                          ),
                                          style: const TextStyle(fontSize: 16, color: Colors.black),
                                          underline: const SizedBox(),
                                          items: <String>['9 KL', '16 KL', '22 KL', '35 KL']
                                              .map<DropdownMenuItem<String>>((String value) {
                                            return DropdownMenuItem<String>(
                                              value: value,
                                              child: Padding(
                                                padding: const EdgeInsets.only(left: 10),
                                                child: Text(value),
                                              ),
                                            );
                                          }).toList(),
                                          onChanged: (String? newValue) {
                                            setState(() {
                                              dropdownValue3 = newValue;
                                              storageCapacityError = null;
                                            });
                                          },
                                        ),
                                      ),
                                      if (storageCapacityError != null)
                                        Padding(
                                          padding: const EdgeInsets.only(left: 12, top: 5),
                                          child: Text(
                                            storageCapacityError!,
                                            style: const TextStyle(
                                              color: Colors.red,
                                              fontSize: 12,
                                            ),
                                          ),
                                        ),
                                    ],
                                  ),
                                ),

                              SizedBox(height: 20),

                              /// QUANTITY IN STOCK (Now visible for BOTH Litres and Pices)
                              SizedBox(
                                width: screenWidth * 0.9,
                                child: TextFormField(
                                  controller: _quantityController,
                                  focusNode: _quantityFocusNode,
                                  keyboardType: TextInputType.number,
                                  validator: (value) {
                                    if (value == null || value.trim().isEmpty) {
                                      return 'Quantity in stock is required';
                                    }
                                    if (double.tryParse(value.trim()) == null) {
                                      return 'Please enter a valid quantity';
                                    }
                                    if (double.parse(value.trim()) < 0) {
                                      return 'Quantity cannot be negative';
                                    }
                                    return null;
                                  },
                                  decoration: InputDecoration(
                                    labelText: dropdownValue2 == 'Litres'
                                        ? "Quantity in Stock (Litres)"
                                        : "Quantity in Stock (Pieces)",
                                    labelStyle: TextStyle(color: AppColors.text),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12),
                                      borderSide: BorderSide(color: AppColors.primary, width: 1),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12),
                                      borderSide: BorderSide(color: AppColors.primary, width: 2),
                                    ),
                                    errorBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12),
                                      borderSide: const BorderSide(color: Colors.red, width: 1),
                                    ),
                                    focusedErrorBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12),
                                      borderSide: const BorderSide(color: Colors.red, width: 2),
                                    ),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12),
                                      borderSide: BorderSide(color: AppColors.primary, width: 1),
                                    ),
                                  ),
                                ),
                              ),

                              SizedBox(height: 20),

                              /// MINIMUM STOCK ALERT (Always Visible)
                              SizedBox(
                                width: screenWidth * 0.9,
                                child: TextFormField(
                                  controller: _minStockController,
                                  focusNode: _minStockFocusNode,
                                  keyboardType: TextInputType.number,
                                  validator: (value) {
                                    if (value != null && value.trim().isNotEmpty) {
                                      if (double.tryParse(value.trim()) == null) {
                                        return 'Please enter a valid minimum stock level';
                                      }
                                      if (double.parse(value.trim()) < 0) {
                                        return 'Minimum stock level cannot be negative';
                                      }
                                    }
                                    return null;
                                  },
                                  decoration: InputDecoration(
                                    labelText: "Minimum Stock Alert Level",
                                    labelStyle: TextStyle(color: AppColors.text),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12),
                                      borderSide: BorderSide(color: AppColors.primary, width: 1),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12),
                                      borderSide: BorderSide(color: AppColors.primary, width: 2),
                                    ),
                                    errorBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12),
                                      borderSide: const BorderSide(color: Colors.red, width: 1),
                                    ),
                                    focusedErrorBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12),
                                      borderSide: const BorderSide(color: Colors.red, width: 2),
                                    ),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12),
                                      borderSide: BorderSide(color: AppColors.primary, width: 1),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),

                          SizedBox(height: 20),
                          SizedBox(
                            height: 117,
                            width: screenWidth * 0.9,
                            child: TextFormField(
                              controller: _descriptionController,
                              focusNode: _descriptionFocusNode,
                              maxLines: 4,
                              decoration: InputDecoration(
                                labelText: "Description or Remark",
                                labelStyle: TextStyle(color: AppColors.text),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: BorderSide(
                                      color: AppColors.primary, width: 1),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: BorderSide(
                                      color: AppColors.primary, width: 2),
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: BorderSide(
                                      color: Colors.red, width: 1),
                                ),
                                focusedErrorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: BorderSide(
                                      color: Colors.red, width: 2),
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: BorderSide(
                                      color: AppColors.primary, width: 1),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 20),
                          SizedBox(
                            height: 117,
                            width: screenWidth * 0.9,
                            child: TextFormField(
                              controller: _supplierController,
                              focusNode: _supplierFocusNode,
                              maxLines: 4,
                              decoration: InputDecoration(
                                labelText: "Supplier name",
                                labelStyle: TextStyle(color: AppColors.text),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: BorderSide(
                                      color: AppColors.primary, width: 1),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: BorderSide(
                                      color: AppColors.primary, width: 2),
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: BorderSide(
                                      color: Colors.red, width: 1),
                                ),
                                focusedErrorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: BorderSide(
                                      color: Colors.red, width: 2),
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: BorderSide(
                                      color: AppColors.primary, width: 1),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 20),
                          Container(
                            width: screenWidth * 0.9,
                            height: screenHeight * 0.07,
                            child: Obx(() {
                              final items = createProductController.getProductNameModel.value.data ?? [];
                              final isDisabled = createProductController.isLoading.value || items.isEmpty;

                              return ElevatedButton(
                                onPressed: isDisabled ? null : _saveProduct,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColors.button,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                child: createProductController.isLoading.value
                                    ? CircularProgressIndicator(color: AppColors.background)
                                    : Text(
                                  "Save Product",
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w500,
                                    color: AppColors.background,
                                  ),
                                ),
                              );
                            }),
                          ),
                          SizedBox(height: 20),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          )),
    );
  }
}