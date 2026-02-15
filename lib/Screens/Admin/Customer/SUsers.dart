import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../controllers/AdminController/CustomerDetailController.dart';
import '../../../utils/colors.dart';

class SUsers extends StatefulWidget {
  final String customerId;

  const SUsers({super.key, required this.customerId});

  @override
  State<SUsers> createState() => _SUsersState();
}

class _SUsersState extends State<SUsers> {
  final CustomerDetailController customerController =
  Get.put(CustomerDetailController());

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await customerController.getCustomerDetail(customerId: widget.customerId);
    });
    super.initState();
  }

  String _formatDate(String? dateString) {
    if (dateString == null || dateString.isEmpty) return 'N/A';

    try {
      DateTime date = DateTime.parse(dateString);
      return DateFormat('dd/MM/yyyy').format(date);
    } catch (e) {
      if (dateString.contains(' ')) {
        return dateString.split(' ')[0];
      }
      return dateString;
    }
  }

  void _copyToClipboard(String text, String type) async {
    try {
      await Clipboard.setData(ClipboardData(text: text));
      Get.snackbar(
        'Success',
        '$type copied successfully!',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
        duration: const Duration(seconds: 2),
        margin: const EdgeInsets.all(16),
        borderRadius: 8,
        icon: const Icon(Icons.check_circle, color: Colors.white),
      );
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to copy $type',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
        duration: const Duration(seconds: 2),
        margin: const EdgeInsets.all(16),
        borderRadius: 8,
        icon: const Icon(Icons.error, color: Colors.white),
      );
    }
  }

  Widget _buildIconWithFallback({
    required String assetName,
    double? width,
    double? height,
    required IconData fallbackIcon,
    Color? color,
  }) {
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

  Widget _buildInfoRow({
    required String iconPath,
    required String title,
    required String value,
    Color valueColor = AppColors.primary,
    bool showCopyButton = false,
    String? copyText,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.all(16),
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
          const SizedBox(width: 16),
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
                const SizedBox(height: 4),
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
                    return const Center(
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
                child: _buildDocImage(title: "Front", url: frontUrl),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildDocImage(title: "Back", url: backUrl),
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
                return const Center(
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

  // -------------------- BOTTOM SHEET (YOUR DETAILS) --------------------

  Widget _buildDetailItem(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 110,
            child: Text(
              label,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: AppColors.secondary.withOpacity(0.7),
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: AppColors.primary,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showCustomerDetailsBottomSheet(BuildContext context, customer) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(16),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    height: 5,
                    width: 50,
                    margin: const EdgeInsets.only(bottom: 15),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                Text(
                  "Customer Details",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primary,
                  ),
                ),
                const SizedBox(height: 15),
                _buildDetailItem('Name', customer.name ?? 'N/A'),
                _buildDetailItem('Phone', customer.phone ?? 'N/A'),
                _buildDetailItem('Aadhar Number', customer.aadharNumber ?? 'N/A'),
                _buildDetailItem('Status', customer.status ?? 'N/A'),
                _buildDetailItem('Created Date', customer.createdDate ?? 'N/A'),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: () => Navigator.pop(context),
                    child: const Text(
                      "Close",
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  // -------------------- UI --------------------

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Get.back(),
        ),
        title: Text(
          "Customer Details",
          style: TextStyle(
            color: AppColors.secondary,
            fontWeight: FontWeight.w700,
          ),
        ),
        actions: [
          Obx(() {
            if (customerController.customerDetailModel.value.data == null ||
                customerController.customerDetailModel.value.data!.isEmpty) {
              return const SizedBox();
            }

            final customer =
                customerController.customerDetailModel.value.data!.first;

            return IconButton(
              onPressed: () {
                _showCustomerDetailsBottomSheet(context, customer);
              },
              icon: Icon(Icons.info_outline, color: AppColors.primary),
            );
          }),
        ],
      ),
      body: Obx(() {
        if (customerController.isLoading.value ||
            customerController.customerDetailModel.value.data == null ||
            customerController.customerDetailModel.value.data!.isEmpty) {
          return Center(
            child: CircularProgressIndicator(color: AppColors.primary),
          );
        }

        final data = customerController.customerDetailModel.value.data!.first;

        return SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              _buildInfoRow(
                iconPath: 'assets/images/Admin.svg',
                title: 'Customer Name',
                value: data.name ?? 'N/A',
              ),
              _buildInfoRow(
                iconPath: 'assets/images/callicon.png',
                title: 'Phone Number',
                value: data.phone ?? 'N/A',
              ),
              // _buildInfoRow(
              //   iconPath: 'assets/images/Branch.png',
              //   title: 'Company Type',
              //   value: data.companyType ?? 'N/A',
              // ),
              _buildInfoRow(
                iconPath: 'assets/images/aadhar number.svg',
                title: 'Aadhar Number',
                value: data.aadharNumber ?? 'N/A',
              ),
              if (data.gstNumber != null && data.gstNumber!.isNotEmpty)
                _buildInfoRow(
                  iconPath: 'assets/images/HSB.svg',
                  title: 'GST Number',
                  value: data.gstNumber!,
                ),
              if (data.products != null && data.products!.isNotEmpty)
                _buildInfoRow(
                  iconPath: 'assets/images/AddProducts.svg',
                  title: 'Products',
                  value: data.products!,
                ),
              if (data.timePeriod != null && data.timePeriod!.isNotEmpty)
                _buildInfoRow(
                  iconPath: 'assets/images/time.svg',
                  title: 'Time Period',
                  value: data.timePeriod!,
                ),
              if (data.amountLimit != null && data.amountLimit!.isNotEmpty)
                _buildInfoRow(
                  iconPath: 'assets/images/₹.svg',
                  title: 'Amount Limit',
                  value: '₹${data.amountLimit}',
                  valueColor: Colors.green,
                ),
              if (data.interestRate != null && data.interestRate!.isNotEmpty)
                _buildInfoRow(
                  iconPath: 'assets/images/Sales.svg',
                  title: 'Interest Rate',
                  value: '${data.interestRate}%',
                ),
              _buildInfoRow(
                iconPath: 'assets/images/Admin.svg',
                title: 'Customer ID',
                value: data.id?.toString() ?? 'N/A',
                showCopyButton: data.id?.toString().isNotEmpty == true,
                copyText: data.id?.toString(),
              ),
              _buildInfoRow(
                iconPath: 'assets/images/Calender.svg',
                title: 'Created Date',
                value: _formatDate(data.createdDate),
              ),
              const SizedBox(height: 10),
              _buildAadharSection(data.aadharFrontImage, data.aadharBackImage),
              const SizedBox(height: 10),
              // _buildSignatureSection(data.signatureImage),
              // const SizedBox(height: 20),
            ],
          ),
        );
      }),
    );
  }
}
