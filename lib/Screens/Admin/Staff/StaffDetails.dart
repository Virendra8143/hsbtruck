import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'dart:io';

import '../../../Utils/Api.dart';
import '../../../controllers/AdminController/StaffController.dart';
import '../../../utils/colors.dart';
import 'dart:developer' as developer;

class StaffDetails extends StatefulWidget {
  final String staffId;

  const StaffDetails({super.key, required this.staffId});

  @override
  State<StaffDetails> createState() => _StaffDetailsState();
}

class _StaffDetailsState extends State<StaffDetails> {
  final StaffController staffController = Get.put(StaffController());

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await staffController.getStaffDetail(staffId: widget.staffId);
    });
    super.initState();
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

  // Download function (keep your existing download logic)
  Future<void> _downloadImage(String imageUrl, String fileName) async {
    try {
      bool permissionGranted = false;
      if (Platform.isAndroid) {
        final androidInfo = await DeviceInfoPlugin().androidInfo;
        if (androidInfo.version.sdkInt >= 33) {
          var status = await Permission.photos.request();
          permissionGranted = status == PermissionStatus.granted;
        } else if (androidInfo.version.sdkInt >= 30) {
          var status = await Permission.manageExternalStorage.request();
          if (status != PermissionStatus.granted) {
            status = await Permission.storage.request();
          }
          permissionGranted = status == PermissionStatus.granted;
        } else {
          var status = await Permission.storage.request();
          permissionGranted = status == PermissionStatus.granted;
        }
      } else {
        var status = await Permission.photos.request();
        permissionGranted = status == PermissionStatus.granted;
      }

      if (!permissionGranted) {
        Get.snackbar(
          'Permission Required',
          'Storage permission is required to download images',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.orange,
          colorText: Colors.white,
          duration: Duration(seconds: 3),
          margin: EdgeInsets.all(16),
          borderRadius: 8,
        );
        return;
      }

      Get.snackbar(
        'Downloading',
        'Please wait...',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.blue,
        colorText: Colors.white,
        duration: Duration(seconds: 2),
        margin: EdgeInsets.all(16),
        borderRadius: 8,
        icon: Icon(Icons.download, color: Colors.white),
      );

      String savePath;
      if (Platform.isAndroid) {
        final androidInfo = await DeviceInfoPlugin().androidInfo;
        if (androidInfo.version.sdkInt >= 29) {
          savePath = await _downloadViaPublicDirectory(imageUrl, fileName);
        } else {
          final directory = await getExternalStorageDirectory();
          final downloadDir = Directory("${directory!.path}/HSB_Documents");
          if (!await downloadDir.exists()) {
            await downloadDir.create(recursive: true);
          }
          savePath = "${downloadDir.path}/$fileName";
          Dio dio = Dio();
          await dio.download(imageUrl, savePath);
        }
      } else {
        final directory = await getApplicationDocumentsDirectory();
        savePath = "${directory.path}/$fileName";
        Dio dio = Dio();
        await dio.download(imageUrl, savePath);
      }

      Get.snackbar(
        'Success',
        'Image saved successfully!',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
        duration: Duration(seconds: 3),
        margin: EdgeInsets.all(16),
        borderRadius: 8,
        icon: Icon(Icons.check_circle, color: Colors.white),
      );
    } catch (e) {
      developer.log('Download error: $e');
      Get.snackbar(
        'Error',
        'Failed to download image: ${e.toString()}',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
        duration: Duration(seconds: 3),
        margin: EdgeInsets.all(16),
        borderRadius: 8,
        icon: Icon(Icons.error, color: Colors.white),
      );
    }
  }

  Future<String> _downloadViaPublicDirectory(String imageUrl, String fileName) async {
    try {
      final publicDownloadDir = Directory('/storage/emulated/0/Download/HSB_Documents');
      if (!await publicDownloadDir.exists()) {
        await publicDownloadDir.create(recursive: true);
      }
      final savePath = "${publicDownloadDir.path}/$fileName";
      Dio dio = Dio();
      await dio.download(imageUrl, savePath);
      return savePath;
    } catch (e) {
      final directory = await getExternalStorageDirectory();
      final downloadDir = Directory("${directory!.path}/HSB_Downloads");
      if (!await downloadDir.exists()) {
        await downloadDir.create(recursive: true);
      }
      final savePath = "${downloadDir.path}/$fileName";
      Dio dio = Dio();
      await dio.download(imageUrl, savePath);
      return savePath;
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

  Widget _buildContactSection() {
    final data = staffController.staffDetailModel.value.data![0];
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
                'assets/images/aadhar number.svg',
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
                  'Contact Information',
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                    color: AppColors.secondary.withOpacity(0.7),
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  data.name!,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                    color: AppColors.secondary,
                  ),
                ),
                SizedBox(height: 2),
                Text(
                  '+91 ${data.phone}',
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                    color: AppColors.primary,
                  ),
                ),
              ],
            ),
          ),
          InkWell(
            onTap: () {
              _copyToClipboard(data.phone!, 'Phone Number');
            },
            borderRadius: BorderRadius.circular(20),
            child: Container(
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppColors.primary.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: SvgPicture.asset(
                'assets/images/call.svg',
                width: 24,
                height: 24,
                color: AppColors.primary,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAadhaarImages() {
    final data = staffController.staffDetailModel.value.data![0];
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8),
      padding: EdgeInsets.all(12), // Reduced padding
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
                    'assets/images/aadhar number.svg',
                    width: 20,
                    height: 20,
                    color: AppColors.primary,
                  ),
                ),
              ),
              SizedBox(width: 12),
              Text(
                'Aadhaar Documents',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                  color: AppColors.secondary,
                ),
              ),
            ],
          ),
          SizedBox(height: 12),
          LayoutBuilder(
            builder: (context, constraints) {
              double availableWidth = constraints.maxWidth;
              double cardWidth = (availableWidth - 12) / 2; // 12px gap between cards

              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildAadhaarImageCard('Aadhaar Front', data.aadharFrontImage, 'front', cardWidth),
                  _buildAadhaarImageCard('Aadhaar Back', data.aadharBackImage, 'back', cardWidth),
                ],
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildAadhaarImageCard(String label, String? imageName, String type, double cardWidth) {
    String baseUrl = API.instance.documentsUrl;
    String? imageUrl;

    if (imageName != null && imageName.isNotEmpty) {
      imageUrl = baseUrl + imageName;
    }

    return Container(
      width: cardWidth,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: cardWidth,
            height: cardWidth * 0.7,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.grey.shade300),
              color: Colors.grey.shade50,
            ),
            child: Stack(
              children: [
                if (imageUrl != null)
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(
                      imageUrl,
                      width: cardWidth,
                      height: cardWidth * 0.7,
                      fit: BoxFit.cover,
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) return child;
                        return Center(
                          child: CircularProgressIndicator(
                            color: AppColors.primary,
                          ),
                        );
                      },
                      errorBuilder: (context, error, stackTrace) {
                        return _buildImagePlaceholder();
                      },
                    ),
                  )
                else
                  _buildImagePlaceholder(),

                if (imageUrl != null)
                  Positioned(
                    bottom: 6,
                    right: 6,
                    child: InkWell(
                      onTap: () {
                        final staffData = staffController.staffDetailModel.value.data![0];
                        String fileName = '${staffData.name}_${staffData.workId}_aadhaar_$type.jpg';
                        _downloadImage(imageUrl!, fileName);
                      },
                      borderRadius: BorderRadius.circular(20),
                      child: Container(
                        padding: EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 4,
                              offset: Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Icon(
                          Icons.download,
                          size: 18,
                          color: AppColors.primary,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
          SizedBox(height: 6),
          Padding(
            padding: EdgeInsets.only(left: 4),
            child: Text(
              label,
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w500,
                color: AppColors.secondary.withOpacity(0.8),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildImagePlaceholder() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.image_not_supported_outlined,
            color: Colors.grey,
            size: 35,
          ),
          SizedBox(height: 6),
          Text(
            'No image\navailable',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.grey,
              fontSize: 11,
            ),
          ),
        ],
      ),
    );
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
                () => staffController.isLoading.value ||
                staffController.staffDetailModel.value.data == null ||
                staffController.staffDetailModel.value.data![0] == null
                ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(
                    color: AppColors.primary,
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Loading Staff Details...',
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
                          child: SvgPicture.asset(
                            'assets/images/worker staff.svg',
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
                              'Staff Details',
                              style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 20,
                                color: AppColors.secondary,
                              ),
                            ),
                            SizedBox(height: 4),
                            Text(
                              'Complete staff information overview',
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
                        // Contact Information
                        _buildContactSection(),

                        // Staff Role
                        _buildInfoRow(
                          iconPath: 'assets/images/StaffRole.svg',
                          title: 'Staff Role',
                          value: staffController.staffDetailModel.value.data![0].role!,
                        ),

                        // Salary
                        _buildInfoRow(
                          iconPath: 'assets/images/Salary.svg',
                          title: 'Staff Salary',
                          value: '₹${staffController.staffDetailModel.value.data![0].salary}',
                          valueColor: Colors.green,
                        ),

                        // Aadhaar Number
                        _buildInfoRow(
                          iconPath: 'assets/images/aadhar number.svg',
                          title: 'Aadhaar Number',
                          value: staffController.staffDetailModel.value.data![0].aadharNumber!,
                        ),

                        // Aadhaar Images
                        _buildAadhaarImages(),

                        // Staff Timing
                        _buildInfoRow(
                          iconPath: 'assets/images/time.svg',
                          title: 'Staff Timing',
                          value: staffController.staffDetailModel.value.data![0].shift!,
                        ),

                        // Access
                        // _buildInfoRow(
                        //   iconPath: 'assets/images/lock.svg',
                        //   title: 'Access Level',
                        //   value: staffController.staffDetailModel.value.data![0].access!,
                        // ),
// Access
                        _buildInfoRow(
                          iconPath: 'assets/images/lock.svg',
                          title: 'Access Level',
                          value: staffController.staffDetailModel.value.data![0].access?.toString() ?? 'No Access',
                        ),
                        // Address
                        if (staffController.staffDetailModel.value.data![0].address != null &&
                            staffController.staffDetailModel.value.data![0].address!.isNotEmpty)
                          _buildInfoRow(
                            iconPath: 'assets/images/StaffRole.svg',
                            title: 'Address',
                            value: staffController.staffDetailModel.value.data![0].address!,
                          ),

                        // Staff ID with copy
                        _buildInfoRow(
                          iconPath: 'assets/images/StaffRole.svg',
                          title: 'Staff ID',
                          value: staffController.staffDetailModel.value.data![0].workId ?? 'N/A',
                          showCopyButton: true,
                          copyText: staffController.staffDetailModel.value.data![0].workId,
                        ),

                        // Password with copy
                        _buildInfoRow(
                          iconPath: 'assets/images/lock.svg',
                          title: 'Password',
                          value: staffController.staffDetailModel.value.data![0].encPassword ?? 'N/A',
                          showCopyButton: true,
                          copyText: staffController.staffDetailModel.value.data![0].encPassword,
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