import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../Utils/Api.dart';
import '../../models/AdminModels/Export report.dart';


class ExportReportController extends GetxController {
  var isLoading = false.obs;
  var errorMessage = ''.obs;
  var exportReportModel = ExportReportModel().obs;

  Future<bool> exportReport({
    required String? productId,
    required String? productCategoryId,
    required String startDate,
    required String endDate,
  }) async {
    isLoading.value = true;
    errorMessage.value = '';

    try {
      // Prepare request body
      final Map<String, dynamic> body = {
        'sdate': startDate,
        'edate': endDate,
      };

      // Add only one product parameter based on what's provided
      if (productId != null && productId.isNotEmpty) {
        body['product_id'] = productId;
      } else if (productCategoryId != null && productCategoryId.isNotEmpty) {
        body['product_category_id'] = productCategoryId;
      }

      debugPrint('=== Export Report API Request ===');
      debugPrint('Endpoint: ${APIEndPoints.exportReports}');
      debugPrint('Body: $body');

      final response = await API.instance.post(
        endPoint: APIEndPoints.exportReports,
        params: body,
        isHeader: true,
      );

      isLoading.value = false;

      debugPrint('=== Export Report API Response ===');
      debugPrint('Status Code: ${response.statusCode}');
      debugPrint('Response Body: ${response.body}');

      if (response.body.trim().startsWith('<!DOCTYPE') ||
          response.body.trim().startsWith('<html>')) {
        errorMessage.value = 'Server error occurred. Please try again.';
        return false;
      }

      final data = jsonDecode(response.body);
      final status = data['status'];
      final message = data['message'] ?? 'Export completed';
      final fileUrl = data['data'];

      if (status == "success" && fileUrl is String && fileUrl.isNotEmpty) {
        exportReportModel.value = ExportReportModel.fromJson(data);

        // Show download options dialog
        await _showDownloadOptions(fileUrl, message);
        return true;
      } else {
        errorMessage.value = message;
        Get.snackbar(
          'Error',
          message,
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
        return false;
      }
    } catch (e, stackTrace) {
      isLoading.value = false;
      errorMessage.value = 'Failed to export report: ${e.toString()}';

      debugPrint('Error in exportReport: $e');
      debugPrint('StackTrace: $stackTrace');

      Get.snackbar(
        'Error',
        'Failed to export report. Please try again.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return false;
    }
  }

  Future<void> _showDownloadOptions(String fileUrl, String message) async {
    await Get.dialog(
      AlertDialog(
        title: Row(
          children: [
            Icon(Icons.check_circle, color: Colors.green, size: 24),
            SizedBox(width: 8),
            Text(
              'Report Ready',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Your CSV report has been generated successfully.',
              style: TextStyle(fontSize: 14),
            ),
            SizedBox(height: 12),
            Container(
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.grey[300]!),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Download Link:',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 12,
                    ),
                  ),
                  SizedBox(height: 4),
                  GestureDetector(
                    onTap: () {
                      // You can add copy to clipboard functionality here
                    },
                    child: Text(
                      fileUrl,
                      style: TextStyle(
                        fontSize: 10,
                        color: Colors.blue,
                        decoration: TextDecoration.underline,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 16),
            Text(
              'Choose download method:',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 14,
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Get.back();
              _openInBrowserWithFeedback(fileUrl);
            },
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.open_in_browser, size: 18),
                SizedBox(width: 4),
                Text('Open in Browser'),
              ],
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Get.back();
              _downloadWithProgress(fileUrl);
            },
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.download, size: 18),
                SizedBox(width: 4),
                Text('Download Now'),
              ],
            ),
          ),
        ],
      ),
      barrierDismissible: false,
    );
  }

  Future<void> _openInBrowserWithFeedback(String fileUrl) async {
    // Show preparing message
    Get.dialog(
      Center(
        child: Container(
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircularProgressIndicator(),
              SizedBox(height: 16),
              Text('Opening browser...'),
            ],
          ),
        ),
      ),
      barrierDismissible: false,
    );

    await Future.delayed(Duration(milliseconds: 500));

    try {
      final uri = Uri.parse(fileUrl);

      if (await canLaunchUrl(uri)) {
        // Close the loading dialog
        Get.back();

        await launchUrl(
          uri,
          mode: LaunchMode.externalApplication,
        );

        // Show instructions
        Get.snackbar(
          'Check Your Browser',
          'The CSV file should open in your browser. Check your downloads folder if it doesn\'t open automatically.',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.blue,
          colorText: Colors.white,
          duration: Duration(seconds: 5),
          icon: Icon(Icons.info, color: Colors.white),
        );
      } else {
        Get.back();
        _showManualInstructions(fileUrl);
      }
    } catch (e) {
      Get.back();
      _showManualInstructions(fileUrl);
    }
  }

  Future<void> _downloadWithProgress(String fileUrl) async {
    // Show download progress
    Get.dialog(
      Center(
        child: Container(
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircularProgressIndicator(),
              SizedBox(height: 16),
              Text('Starting download...'),
              SizedBox(height: 8),
              Text(
                'Please wait',
                style: TextStyle(fontSize: 12, color: Colors.grey),
              ),
            ],
          ),
        ),
      ),
      barrierDismissible: false,
    );

    await Future.delayed(Duration(seconds: 2));

    try {
      // Try to force download with content-disposition
      final downloadUrl = '$fileUrl?force_download=true';
      final uri = Uri.parse(downloadUrl);

      if (await canLaunchUrl(uri)) {
        Get.back();
        await launchUrl(
          uri,
          mode: LaunchMode.externalApplication,
        );

        // Show completion message
        Get.snackbar(
          'Download Started',
          'Your CSV file is being downloaded. Check your notification bar or downloads folder.',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: Colors.white,
          duration: Duration(seconds: 4),
          icon: Icon(Icons.download_done, color: Colors.white),
        );
      } else {
        Get.back();
        _openInBrowserWithFeedback(fileUrl);
      }
    } catch (e) {
      Get.back();
      _openInBrowserWithFeedback(fileUrl);
    }
  }

  void _showManualInstructions(String fileUrl) {
    Get.dialog(
      AlertDialog(
        title: Text('Manual Download Required'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('To download your report:'),
              SizedBox(height: 16),
              _buildStep(1, 'Copy this link:'),
              SizedBox(height: 8),
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: SelectableText(
                  fileUrl,
                  style: TextStyle(fontSize: 12, fontFamily: 'monospace'),
                ),
              ),
              SizedBox(height: 16),
              _buildStep(2, 'Open your web browser'),
              SizedBox(height: 8),
              _buildStep(3, 'Paste the link and press Enter'),
              SizedBox(height: 8),
              _buildStep(4, 'The download should start automatically'),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: Text('Close'),
          ),
        ],
      ),
    );
  }

  Widget _buildStep(int number, String text) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 24,
          height: 24,
          decoration: BoxDecoration(
            color: Colors.blue,
            shape: BoxShape.circle,
          ),
          child: Center(
            child: Text(
              number.toString(),
              style: TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        SizedBox(width: 8),
        Expanded(
          child: Text(
            text,
            style: TextStyle(fontSize: 14),
          ),
        ),
      ],
    );
  }

  void clearError() {
    errorMessage.value = '';
  }

  @override
  void onClose() {
    isLoading.value = false;
    errorMessage.value = '';
    super.onClose();
  }
}