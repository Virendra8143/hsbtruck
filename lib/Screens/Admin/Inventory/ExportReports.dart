import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart';
import '../../../controllers/AdminController/Export Report.dart';
import '../../../controllers/Lubecontroller.dart';
import '../../../utils/colors.dart';
import '../../../controllers/AdminController/CreateProductController.dart';

class ExportReports extends StatefulWidget {
  const ExportReports({super.key});

  @override
  State<ExportReports> createState() => _ExportReportsState();
}

class _ExportReportsState extends State<ExportReports> {
  String? dropdownValue;
  String? dropdownValue2;
  DateTime? _fromDate;
  DateTime? _toDate;

  // Initialize controllers
  final CreateProductController productController = Get.put(CreateProductController());
  final GetLubeListController lubeController = Get.put(GetLubeListController());
  final ExportReportController exportController = Get.put(ExportReportController());

  @override
  void initState() {
    super.initState();
    // Load initial product list if needed
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (productController.getProductNameModel.value.data == null) {
        productController.getProductName();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final screenWidth = mediaQuery.size.width;
    final screenHeight = mediaQuery.size.height;

    return Stack(
      clipBehavior: Clip.none,
      children: [
        // Main Dialog Content - Increased height and made scrollable
        Container(
          height: screenHeight * 0.85, // Increased height
          width: screenWidth * 0.99,
          padding: EdgeInsets.all(screenWidth * 0.04),
          child: SingleChildScrollView( // Added scrollable
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: screenHeight * 0.02),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Stack(
                      children: [
                        Container(
                          height: 62,
                          width: 62,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: AppColors.button),
                        ),
                        Positioned(
                          top: 10,
                          left: 15,
                          child: SvgPicture.asset('assets/images/Export2.svg'),
                        ),
                      ],
                    ),
                    SizedBox(width: screenWidth * 0.05),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Export Reports",
                          style: TextStyle(
                            fontSize: screenWidth * 0.06,
                            fontWeight: FontWeight.w500,
                            color: AppColors.secondary,
                          ),
                        ),
                        SizedBox(width: 10),
                        Text(
                          "Get all product custom reports",
                          style: TextStyle(color: Colors.grey),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: screenHeight * 0.03), // Reduced spacing
                _buildProductDropdown(),
                if (dropdownValue == null)
                  Padding(
                    padding: const EdgeInsets.only(left: 12, top: 5),
                    // child: Text(
                    //   'Please select a product',
                    //   style: TextStyle(
                    //     color: Colors.red,
                    //     fontSize: 12,
                    //   ),
                    // ),
                  ),
                SizedBox(height: screenHeight * 0.015), // Reduced spacing
                _buildLubeDropdown(),
                SizedBox(height: screenHeight * 0.015), // Reduced spacing
                _buildDateInput(label: 'From Date'),
                SizedBox(height: screenHeight * 0.015), // Reduced spacing
                _buildDateInput(label: 'To Date'),
                SizedBox(height: screenHeight * 0.015), // Reduced spacing

                // Error message from export controller
                Obx(() => exportController.errorMessage.value.isNotEmpty
                    ? Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(12),
                  margin: EdgeInsets.only(bottom: 8), // Added margin
                  decoration: BoxDecoration(
                    color: Colors.red.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.red),
                  ),
                  child: Text(
                    exportController.errorMessage.value,
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: 14,
                    ),
                  ),
                )
                    : SizedBox()),

                if (_fromDate != null && _toDate != null)
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(12), // Reduced padding
                    margin: EdgeInsets.only(bottom: 8), // Added margin
                    decoration: BoxDecoration(
                      color: AppColors.button.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: AppColors.button.withOpacity(0.3)),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Date Range Selected:',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: AppColors.secondary,
                          ),
                        ),
                        SizedBox(height: 6), // Reduced spacing
                        Row(
                          children: [
                            Icon(
                              Icons.calendar_today,
                              size: 16,
                              color: AppColors.button,
                            ),
                            SizedBox(width: 6), // Reduced spacing
                            Flexible( // Added Flexible for text
                              child: Text(
                                '${DateFormat('dd MMM yyyy').format(_fromDate!)} - ${DateFormat('dd MMM yyyy').format(_toDate!)}',
                                style: TextStyle(
                                  fontSize: 14, // Reduced font size
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.button,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                SizedBox(height: screenHeight * 0.03), // Reduced spacing

                // Download Button with loading state
                Obx(() => Center(
                  child: Container(
                    height: screenHeight * 0.07, // Reduced height
                    width: screenWidth * 0.6,
                    margin: EdgeInsets.only(bottom: 20), // Added bottom margin
                    child: ElevatedButton(
                      onPressed: (dropdownValue != null &&
                          _fromDate != null &&
                          _toDate != null &&
                          !exportController.isLoading.value)
                          ? () async {
                        await _exportReport();
                      }
                          : null,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: (dropdownValue != null &&
                            _fromDate != null &&
                            _toDate != null &&
                            !exportController.isLoading.value)
                            ? AppColors.button
                            : AppColors.button.withOpacity(0.5),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: exportController.isLoading.value
                          ? SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          valueColor: AlwaysStoppedAnimation<Color>(AppColors.background),
                        ),
                      )
                          : Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.download,
                            color: AppColors.background,
                            size: 18, // Reduced icon size
                          ),
                          SizedBox(width: 6), // Reduced spacing
                          Text(
                            "Download Reports",
                            style: TextStyle(
                              fontSize: screenWidth * 0.04, // Reduced font size
                              fontWeight: FontWeight.w500,
                              color: AppColors.background,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                )),
                SizedBox(height: screenHeight * 0.01), // Small bottom padding
              ],
            ),
          ),
        ),
        Positioned(
          top: -80,
          left: (screenWidth / 2) - 30,
          child: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: CircleAvatar(
              radius: 30,
              backgroundColor: Colors.black54,
              child: Icon(Icons.close, size: 40, color: AppColors.background),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildProductDropdown() {
    return Obx(() {
      final products = productController.getProductNameModel.value.data ?? [];
      final isLoading = productController.isLoading.value;

      return Container(
        height: 60,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: dropdownValue != null ? AppColors.button : Colors.red,
            width: 1,
          ),
        ),
        child: DropdownButton<String>(
          value: dropdownValue,
          isExpanded: true,
          hint: Padding(
            padding: const EdgeInsets.only(left: 10),
            child: isLoading
                ? Text('Loading products...', style: TextStyle(color: Colors.grey))
                : Text(
              'Select Product',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: AppColors.text),
            ),
          ),
          icon: Padding(
            padding: const EdgeInsets.only(right: 20),
            child: isLoading
                ? SizedBox(
              width: 16,
              height: 16,
              child: CircularProgressIndicator(strokeWidth: 2),
            )
                : SvgPicture.asset(
              'assets/images/Arrow.svg',
              width: 11,
              height: 15,
            ),
          ),
          style: TextStyle(fontSize: 16, color: Colors.black),
          underline: SizedBox(),
          items: products.map<DropdownMenuItem<String>>((product) {
            return DropdownMenuItem<String>(
              value: product.name,
              child: Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Text(product.name ?? ''),
              ),
            );
          }).toList(),
          onChanged: isLoading
              ? null
              : (String? newValue) async {
            setState(() {
              dropdownValue = newValue;
              dropdownValue2 = null;
              exportController.clearError();
            });

            if (newValue != null) {
              final selectedProduct = products.firstWhereOrNull((p) => p.name == newValue);
              if (selectedProduct?.id != null) {
                await lubeController.getLubeList(selectedProduct!.id!.toString());
              }
            }
          },
        ),
      );
    });
  }

  Widget _buildLubeDropdown() {
    return Obx(() {
      final isLoading = lubeController.isLoading.value;
      final lubes = lubeController.getLubeModel.value.data ?? [];
      final hasError = lubeController.errorMessage.value.isNotEmpty;

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 60,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: dropdownValue2 != null ? AppColors.button : Colors.grey,
                width: 1,
              ),
            ),
            child: DropdownButton<String>(
              value: dropdownValue2,
              isExpanded: true,
              hint: Padding(
                padding: const EdgeInsets.only(left: 10),
                child: isLoading
                    ? Text('Loading lubes...', style: TextStyle(color: Colors.grey))
                    : Text(
                  'Lube Type (if Lube Selected)',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: AppColors.text),
                ),
              ),
              icon: Padding(
                padding: const EdgeInsets.only(right: 20),
                child: isLoading
                    ? SizedBox(
                  width: 16,
                  height: 16,
                  child: CircularProgressIndicator(strokeWidth: 2),
                )
                    : SvgPicture.asset(
                  'assets/images/Arrow.svg',
                  width: 11,
                  height: 15,
                ),
              ),
              style: TextStyle(fontSize: 16, color: Colors.black),
              underline: SizedBox(),
              items: lubes.map<DropdownMenuItem<String>>((lube) {
                // Create unique display name by combining name and brand
                final displayName = '${lube.name} (${lube.brand}) - ${lube.code}';
                final uniqueValue = '${lube.id}'; // Use ID as unique value

                return DropdownMenuItem<String>(
                  value: uniqueValue,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Text(displayName),
                  ),
                );
              }).toList(),
              onChanged: isLoading
                  ? null
                  : (String? newValue) {
                setState(() {
                  dropdownValue2 = newValue;
                  exportController.clearError();
                });
              },
            ),
          ),
          if (hasError)
            Padding(
              padding: const EdgeInsets.only(left: 12, top: 5),
              child: Text(
                lubeController.errorMessage.value,
                style: TextStyle(
                  color: Colors.orange,
                  fontSize: 12,
                ),
              ),
            ),
          if (lubes.isEmpty && dropdownValue != null && !isLoading && !hasError)
            Padding(
              padding: const EdgeInsets.only(left: 12, top: 5),
              child: Text(
                'No lubes available for this product',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 12,
                ),
              ),
            ),
        ],
      );
    });
  }

  Widget _buildDateInput({required String label}) {
    return GestureDetector(
      onTap: () async {
        DateTime? pickedDate;

        if (label == 'From Date') {
          pickedDate = await showDatePicker(
            context: context,
            initialDate: _fromDate ?? DateTime.now(),
            firstDate: DateTime(2000),
            lastDate: DateTime.now(),
            builder: (context, child) {
              return Theme(
                data: Theme.of(context).copyWith(
                  colorScheme: ColorScheme.light(
                    primary: AppColors.button,
                    onPrimary: AppColors.background,
                    onSurface: AppColors.secondary,
                  ),
                  textButtonTheme: TextButtonThemeData(
                    style: TextButton.styleFrom(
                      foregroundColor: AppColors.button,
                    ),
                  ),
                ),
                child: child!,
              );
            },
          );
        } else if (label == 'To Date') {
          DateTime firstSelectableDate = _fromDate ?? DateTime.now();

          pickedDate = await showDatePicker(
            context: context,
            initialDate: _toDate ?? firstSelectableDate,
            firstDate: firstSelectableDate,
            lastDate: DateTime.now(),
            builder: (context, child) {
              return Theme(
                data: Theme.of(context).copyWith(
                  colorScheme: ColorScheme.light(
                    primary: AppColors.button,
                    onPrimary: AppColors.background,
                    onSurface: AppColors.secondary,
                  ),
                  textButtonTheme: TextButtonThemeData(
                    style: TextButton.styleFrom(
                      foregroundColor: AppColors.button,
                    ),
                  ),
                ),
                child: child!,
              );
            },
          );
        }

        if (pickedDate != null) {
          setState(() {
            if (label == 'From Date') {
              _fromDate = pickedDate;
              if (_toDate != null && _toDate!.isBefore(pickedDate!)) {
                _toDate = null;
              }
            } else if (label == 'To Date') {
              _toDate = pickedDate;
            }
            exportController.clearError();
          });
        }
      },
      child: Container(
        height: 60,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: (label == 'From Date' && _fromDate != null) ||
                (label == 'To Date' && _toDate != null)
                ? AppColors.button
                : Colors.red,
            width: 1,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 10, right: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      label,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: AppColors.text,
                      ),
                    ),
                    SizedBox(height: 2),
                    Text(
                      label == 'From Date'
                          ? (_fromDate != null ? DateFormat('dd MMM yyyy').format(_fromDate!) : 'Select date')
                          : (_toDate != null ? DateFormat('dd MMM yyyy').format(_toDate!) : 'Select date'),
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: (label == 'From Date' && _fromDate != null) ||
                            (label == 'To Date' && _toDate != null)
                            ? AppColors.secondary
                            : AppColors.text,
                      ),
                    ),
                  ],
                ),
              ),
              SvgPicture.asset(
                'assets/images/Calender.svg',
                fit: BoxFit.contain,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _exportReport() async {
    // Get product category ID
    final products = productController.getProductNameModel.value.data ?? [];
    final selectedProduct = products.firstWhereOrNull((p) => (p.name ?? '') == dropdownValue);
    final productCategoryId = selectedProduct?.id?.toString() ?? '';

    // Get lube ID if selected - now using the unique value (ID)
    String? productId;
    if (dropdownValue2 != null) {
      final selectedLube = lubeController.getLubeByUniqueValue(dropdownValue2!);
      productId = selectedLube?.id?.toString();
    }

    // Format dates
    final startDate = DateFormat('yyyy-MM-dd').format(_fromDate!);
    final endDate = DateFormat('yyyy-MM-dd').format(_toDate!);

    // Call export controller - Only send one product parameter
    final success = await exportController.exportReport(
      productId: productId, // This will be null if no lube selected
      productCategoryId: productId == null ? productCategoryId : null, // Only send category ID if no lube
      startDate: startDate,
      endDate: endDate,
    );

    // Close dialog on success
    if (success) {
      Future.delayed(Duration(milliseconds: 1000), () {
        if (mounted) {
          Navigator.pop(context);
        }
      });
    }
  }


}