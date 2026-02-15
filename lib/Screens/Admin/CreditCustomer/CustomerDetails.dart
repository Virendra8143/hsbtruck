
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../controllers/AdminController/CustomerDetailController.dart';
import '../../../utils/colors.dart';

class CustomerDetails extends StatefulWidget {
  final String customerId;

  const CustomerDetails({super.key, required this.customerId});

  @override
  State<CustomerDetails> createState() => _CustomerDetailsState();
}

class _CustomerDetailsState extends State<CustomerDetails> {
  final CustomerDetailController customerController = Get.put(CustomerDetailController());

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await customerController.getCustomerDetail(customerId: widget.customerId);
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
  Widget _buildSignatureSection(String? signatureFile) {
    final String? fullUrl = (signatureFile == null || signatureFile.isEmpty)
        ? null
        : "https://hsb.bugsbon.com/assets/user-documents/$signatureFile";
    print("SIGNATURE FILE => $signatureFile");
    print("SIGNATURE URL  => $fullUrl");

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Digital Signature",
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 14,
              color: AppColors.secondary.withOpacity(0.7),
            ),
          ),
          const SizedBox(height: 10),

          if (fullUrl == null)
            Text(
              "Signature not available",
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey.shade600,
                fontWeight: FontWeight.w500,
              ),
            )
          else
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Container(
                height: 160,
                width: double.infinity,
                color: Colors.grey.shade100,
                child: Image.network(
                  fullUrl,
                  fit: BoxFit.contain,
                  errorBuilder: (context, error, stackTrace) {
                    return Center(
                      child: Text(
                        "Failed to load signature",
                        style: TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildAadharSection(String? frontFile, String? backFile) {
    final String? frontUrl = (frontFile == null || frontFile.isEmpty)
        ? null
        : "https://hsb.bugsbon.com/assets/user-documents/$frontFile";

    final String? backUrl = (backFile == null || backFile.isEmpty)
        ? null
        : "https://hsb.bugsbon.com/assets/user-documents/$backFile";

    print("AADHAR FRONT FILE => $frontFile");
    print("AADHAR FRONT URL  => $frontUrl");
    print("AADHAR BACK FILE  => $backFile");
    print("AADHAR BACK URL   => $backUrl");

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Aadhar Images",
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 14,
              color: AppColors.secondary.withOpacity(0.7),
            ),
          ),
          const SizedBox(height: 10),

          Row(
            children: [
              Expanded(
                child: _buildDocImage(
                  title: "Front",
                  url: frontUrl,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildDocImage(
                  title: "Back",
                  url: backUrl,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDocImage({required String title, required String? url}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: AppColors.secondary,
          ),
        ),
        const SizedBox(height: 8),
        ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Container(
            height: 140,
            width: double.infinity,
            color: Colors.grey.shade100,
            child: (url == null)
                ? Center(
              child: Text(
                "Not available",
                style: TextStyle(
                  color: Colors.grey.shade600,
                  fontWeight: FontWeight.w500,
                ),
              ),
            )
                : Image.network(
              url,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                print("DOC LOAD ERROR => $error");
                return Center(
                  child: Text(
                    "Failed to load",
                    style: TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ],
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
      case 'customer name':
        return Icons.person;
      case 'phone number':
        return Icons.phone;
      case 'company type':
        return Icons.business;
      case 'aadhar number':
        return Icons.credit_card;
      case 'gst number':
        return Icons.receipt;
      case 'products':
        return Icons.inventory;
      case 'time period':
        return Icons.schedule;
      case 'amount limit':
        return Icons.currency_rupee;
      case 'interest rate':
        return Icons.percent;
      case 'created date':
        return Icons.calendar_today;
      case 'status':
        return Icons.info;
      case 'customer id':
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
              if (customerController.isLoading.value ||
                  customerController.customerDetailModel.value.data == null ||
                  customerController.customerDetailModel.value.data!.isEmpty) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircularProgressIndicator(
                        color: AppColors.primary,
                      ),
                      SizedBox(height: 16),
                      Text(
                        'Loading Customer Details...',
                        style: TextStyle(
                          color: AppColors.secondary,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                );
              }
              final customer = customerController.customerDetailModel.value?.data?.first;
              // String? signatureUrl;
              //
              // if (customer?.signatureImage != null &&
              //     customer!.signatureImage!.trim().isNotEmpty) {
              //   signatureUrl =
              //   "https://hsb.bugsbon.com/uploads/credit_customer/${customer.signatureImage}";
              // }

              final data = customerController.customerDetailModel.value.data![0];

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
                              assetName: 'assets/images/Admin.svg',
                              width: 30,
                              height: 30,
                              color: Colors.white,
                              fallbackIcon: Icons.person,
                            ),
                          ),
                        ),
                        SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Customer Details',
                                style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 20,
                                  color: AppColors.secondary,
                                ),
                              ),
                              SizedBox(height: 4),
                              Text(
                                'Complete customer information overview',
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
                          // Customer Name
                          _buildInfoRow(
                            iconPath: 'assets/images/Admin.svg',
                            title: 'Customer Name',
                            value: data.name ?? 'N/A',
                          ),

                          // Phone Number
                          _buildInfoRow(
                            iconPath: 'assets/images/callicon.png',
                            title: 'Phone Number',
                            value: data.phone ?? 'N/A',
                          ),

                          // Company Type
                          _buildInfoRow(
                            iconPath: 'assets/images/Branch.png',
                            title: 'Company Type',
                            value: data.companyType ?? 'N/A',
                          ),

                          // Aadhar Number
                          _buildInfoRow(
                            iconPath: 'assets/images/aadhar number.svg',
                            title: 'Aadhar Number',
                            value: data.aadharNumber ?? 'N/A',
                          ),

                          // GST Number (if available)
                          if (data.gstNumber != null && data.gstNumber!.isNotEmpty)
                            _buildInfoRow(
                              iconPath: 'assets/images/HSB.svg',
                              title: 'GST Number',
                              value: data.gstNumber!,
                            ),

                          // Products (if available)
                          if (data.products != null && data.products!.isNotEmpty)
                            _buildInfoRow(
                              iconPath: 'assets/images/AddProducts.svg',
                              title: 'Products',
                              value: data.products!,
                            ),

                          // Time Period (if available)
                          if (data.timePeriod != null && data.timePeriod!.isNotEmpty)
                            _buildInfoRow(
                              iconPath: 'assets/images/time.svg',
                              title: 'Time Period',
                              value: data.timePeriod!,
                            ),

                          // Amount Limit (if available)
                          if (data.amountLimit != null && data.amountLimit!.isNotEmpty)
                            _buildInfoRow(
                              iconPath: 'assets/images/₹.svg',
                              title: 'Amount Limit',
                              value: '₹${data.amountLimit}',
                              valueColor: Colors.green,
                            ),

                          // Interest Rate (if available)
                          if (data.interestRate != null && data.interestRate!.isNotEmpty)
                            _buildInfoRow(
                              iconPath: 'assets/images/Sales.svg',
                              title: 'Interest Rate',
                              value: '${data.interestRate}%',
                            ),

                          // Customer ID with copy button
                          _buildInfoRow(
                            iconPath: 'assets/images/Admin.svg',
                            title: 'Customer ID',
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

                          SizedBox(height: 20),
                          // _buildSignatureSection(data.signatureImage),


                          _buildAadharSection(
                            data.aadharFrontImage,
                            data.aadharBackImage,
                          ),

                          SizedBox(height: 20),

                          _buildSignatureSection(data.signatureImage)





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