import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../controllers/AdminController/GetProductDetailController.dart';
import '../../../utils/colors.dart';

class Inventoryeye extends StatefulWidget {
  final String productId;

  const Inventoryeye({super.key, required this.productId});

  @override
  State<Inventoryeye> createState() => _InventoryeyeState();
}

class _InventoryeyeState extends State<Inventoryeye> {
  final GetProductDetailController getProductDetailController =
  Get.put(GetProductDetailController());

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await getProductDetailController.getProductDetail(
          productId: widget.productId);
    });
    super.initState();
  }

  Widget _buildInfoRow({
    required String iconPath,
    required String title,
    required String value,
    Color valueColor = AppColors.primary,
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
              child: SvgPicture.asset(
                iconPath,
                width: 20,
                height: 20,
                color: AppColors.primary,
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
        ],
      ),
    );
  }

  Widget _buildTwoColumnInfo({
    required String iconPath1,
    required String title1,
    required String value1,
    required String iconPath2,
    required String title2,
    required String value2,
    Color valueColor1 = AppColors.primary,
    Color valueColor2 = AppColors.primary,
  }) {
    return Row(
      children: [
        Expanded(
          child: _buildInfoRow(
            iconPath: iconPath1,
            title: title1,
            value: value1,
            valueColor: valueColor1,
          ),
        ),
        SizedBox(width: 12),
        Expanded(
          child: _buildInfoRow(
            iconPath: iconPath2,
            title: title2,
            value: value2,
            valueColor: valueColor2,
          ),
        ),
      ],
    );
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
          height: screenHeight * 0.85,
          // width: screenWidth * 0.95,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Obx(
                () => getProductDetailController.isLoading.value ||
                getProductDetailController
                    .getProductDetailModel.value.data ==
                    null
                ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(
                    color: AppColors.primary,
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Loading Product Details...',
                    style: TextStyle(
                      color: AppColors.secondary,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            )
                : Column(
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
                        color: Colors.grey.shade300, // Border color
                        width: 1.0, // Border width
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
                          child: SvgPicture.asset(
                            'assets/images/MSE20.svg',
                            width: 30,
                            height: 30,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${getProductDetailController.getProductDetailModel.value.data![0].name}',
                              style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 20,
                                color: AppColors.secondary,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            SizedBox(height: 4),
                            Text(
                              'Product Details Overview',
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
                        // Product Code & Brand
                        _buildInfoRow(
                          iconPath: 'assets/svg_icons/product-code-icon.svg', // Changed icon
                          title: 'Product Code',
                          value: '#${getProductDetailController.getProductDetailModel.value.data![0].code}',
                        ),

                        _buildInfoRow(
                          iconPath: 'assets/svg_icons/brand-icon.svg', // Changed icon
                          title: 'Brand',
                          value: getProductDetailController.getProductDetailModel.value.data![0].brand ?? 'Not Specified',
                        ),

                        // Storage Capacity
                        _buildInfoRow(
                          iconPath: 'assets/images/Storage.svg',
                          title: 'Storage Capacity',
                          value: getProductDetailController.getProductDetailModel.value.data![0].storageCapacity ?? 'Not Specified',
                        ),

                        // Price
                        _buildInfoRow(
                          iconPath: 'assets/images/₹.svg',
                          title: 'Price',
                          value: '₹${getProductDetailController.getProductDetailModel.value.data![0].perPrice}',
                          valueColor: Colors.green,
                        ),

                        // Quantity Information in 2 columns
                        _buildTwoColumnInfo(
                          iconPath1: 'assets/svg_icons/stock-qty-icon.svg', // Changed icon
                          title1: 'Stock Quantity',
                          value1: '${getProductDetailController.getProductDetailModel.value.data![0].qtyInStock ?? '0'}',
                          valueColor1: AppColors.primary,
                          iconPath2: 'assets/svg_icons/stock-qty-icon.svg', // Changed icon
                          title2: 'Min Quantity',
                          value2: '${getProductDetailController.getProductDetailModel.value.data![0].minQtyAlert ?? '0'}',
                          valueColor2: Colors.orange,
                        ),

                        // Supplier
                        _buildInfoRow(
                          iconPath: 'assets/svg_icons/supplier-icon.svg', // Changed icon
                          title: 'Supplier',
                          value: getProductDetailController.getProductDetailModel.value.data![0].supplierName ?? 'Not Assigned',
                        ),

                        // Description
                        Container(
                          margin: EdgeInsets.symmetric(vertical: 8),
                          padding: EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: Colors.grey.shade200),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    width: 40,
                                    height: 40,
                                    decoration: BoxDecoration(
                                      color: AppColors.primary.withOpacity(0.1),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Center(
                                      child: SvgPicture.asset(
                                        'assets/svg_icons/description-icon.svg', // Changed icon
                                        width: 20,
                                        height: 20,
                                        color: AppColors.primary,
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 16),
                                  Text(
                                    'Description',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16,
                                      color: AppColors.secondary,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 12),
                              Text(
                                getProductDetailController.getProductDetailModel.value.data![0].description ??
                                    'No description available for this product.',
                                style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14,
                                  color: AppColors.secondary.withOpacity(0.8),
                                  height: 1.5,
                                ),
                              ),
                            ],
                          ),
                        ),

                        SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),

        // Close Button - Positioned like in the second code
        Positioned(
          top: -70, // Positioned above the sheet
          left: mediaQuery.size.width * 0.5 - 30, // Centered horizontally
          child: GestureDetector(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: CircleAvatar(
              radius: 30,
              backgroundColor: Colors.black54, // Transparent black background
              child: Icon(Icons.close, size: 30, color: Colors.white),
            ),
          ),
        ),
      ],
    );
  }
}