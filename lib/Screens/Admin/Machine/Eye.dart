import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import '../../../controllers/AdminController/GetMachineDetailController.dart';
import '../../../utils/colors.dart';

class Eye extends StatefulWidget {
  final String machineId;

  const Eye({super.key, required this.machineId});

  @override
  State<Eye> createState() => _EyeState();
}

class _EyeState extends State<Eye> {
  final GetMachineDetailController getMachineDetailController =
  Get.put(GetMachineDetailController());

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await getMachineDetailController.getMachineDetail(machineId: widget.machineId);
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

  Widget _buildNozzleDetailsSection() {
    final data = getMachineDetailController.getMachineDetailModel.value.data?[0];
    if (data == null) return SizedBox.shrink();

    // Create lists for nozzle data
    final nozzleTypes = [
      data.nozzleType1,
      data.nozzleType2,
      data.nozzleType3,
      data.nozzleType4,
    ];

    final nozzleReadings = [
      data.nozzle_reading_1,
      data.nozzle_reading_2,
      data.nozzle_reading_3,
      data.nozzle_reading_4,
    ];

    // Filter out empty nozzles
    final validNozzles = <Map<String, String?>>[];
    for (int i = 0; i < nozzleTypes.length; i++) {
      if (nozzleTypes[i] != null && nozzleTypes[i]!.trim().isNotEmpty) {
        validNozzles.add({
          'number': '${i + 1}',
          'type': nozzleTypes[i],
          'reading': nozzleReadings[i],
        });
      }
    }

    if (validNozzles.isEmpty) return SizedBox.shrink();

    return Container(
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
                    'assets/images/numver of nozzle.svg',
                    width: 20,
                    height: 20,
                    color: AppColors.primary,
                  ),
                ),
              ),
              SizedBox(width: 16),
              Text(
                'Nozzle Details',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                  color: AppColors.secondary,
                ),
              ),
            ],
          ),
          SizedBox(height: 16),
          Column(
            children: validNozzles.map((nozzle) {
              return Container(
                margin: EdgeInsets.only(bottom: 12),
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.grey.shade50,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey.shade200),
                ),
                child: Column(
                  children: [
                    // Nozzle Number Header
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: AppColors.primary.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.local_gas_station,
                            size: 16,
                            color: AppColors.primary,
                          ),
                          SizedBox(width: 6),
                          Text(
                            'Nozzle ${nozzle['number']}',
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 14,
                              color: AppColors.primary,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 12),

                    // Nozzle Type and Reading in two columns
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Type',
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 12,
                                  color: AppColors.secondary.withOpacity(0.7),
                                ),
                              ),
                              SizedBox(height: 4),
                              Text(
                                nozzle['type'] ?? 'Not Specified',
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14,
                                  color: AppColors.secondary,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Reading',
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 12,
                                  color: AppColors.secondary.withOpacity(0.7),
                                ),
                              ),
                              SizedBox(height: 4),
                              Text(
                                nozzle['reading'] ?? '0',
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14,
                                  color: Colors.green,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildNozzlePropertySection() {
    final data = getMachineDetailController.getMachineDetailModel.value.data?[0];
    if (data == null || data.nozzleProperty == null) {
      return SizedBox.shrink();
    }

    try {
      List<dynamic> nozzleProps = jsonDecode(data.nozzleProperty!);
      String displayText = nozzleProps.join(', ');

      return _buildInfoRow(
        iconPath: 'assets/images/openingreading.svg',
        title: 'Nozzle Properties',
        value: displayText,
      );
    } catch (e) {
      return _buildInfoRow(
        iconPath: 'assets/images/openingreading.svg',
        title: 'Nozzle Properties',
        value: data.nozzleProperty ?? 'Not available',
      );
    }
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
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Obx(
                () => getMachineDetailController.isLoading.value ||
                getMachineDetailController.getMachineDetailModel.value.data == null
                ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(
                    color: AppColors.primary,
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Loading Machine Details...',
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
                            'assets/images/eye.svg',
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
                              '#${getMachineDetailController.getMachineDetailModel.value.data![0].code}',
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
                              'Model Serial: ${getMachineDetailController.getMachineDetailModel.value.data![0].modalSerial}',
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
                        // MAS Serial
                        _buildInfoRow(
                          iconPath: 'assets/svg_icons/number-icon.svg',
                          title: 'MAS Serial',
                          value: '#${getMachineDetailController.getMachineDetailModel.value.data![0].masSerialNo}',
                        ),

                        // Number of Nozzles & Opening Reading in 2 columns
                        _buildTwoColumnInfo(
                          iconPath1: 'assets/images/numver of nozzle.svg',
                          title1: 'Total Nozzles',
                          value1: '${getMachineDetailController.getMachineDetailModel.value.data![0].noOfNozzle ?? '0'}',
                          valueColor1: AppColors.primary,
                          iconPath2: 'assets/images/openingreading.svg',
                          title2: 'Opening Reading',
                          value2: '${getMachineDetailController.getMachineDetailModel.value.data![0].openingReading ?? '0'}',
                          valueColor2: Colors.orange,
                        ),

                        // Nozzle Properties
                        _buildNozzlePropertySection(),

                        // Nozzle Details (Number, Type, Reading together)
                        _buildNozzleDetailsSection(),

                        // Created Date
                        _buildInfoRow(
                          iconPath: 'assets/svg_icons/date-icon.svg',
                          title: 'Created Date',
                          value: getMachineDetailController.getMachineDetailModel.value.data![0].createdDate ?? 'Not Available',
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