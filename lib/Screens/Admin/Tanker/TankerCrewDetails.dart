import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../utils/colors.dart';


class TankerCrewDetails extends StatefulWidget {
  const TankerCrewDetails({super.key});

  @override
  State<TankerCrewDetails> createState() => _TankerCrewDetailsState();
}

class _TankerCrewDetailsState extends State<TankerCrewDetails> {
  @override
  Widget build(BuildContext context) {
    // Get the dimensions of the screen
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Container(
      height: screenHeight * 0.78, // Adjusted height based on the screen height
      width: screenWidth * 0.99, // Adjusted width based on the screen width
      child: Column(
        children: [
          SizedBox(height: 10),
          Container(
            height: 5,
            width: 53,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: AppColors.alert,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20, top: 30),
            child: Row(
              children: [
                Container(
                  height: 62,
                  width: 62,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: AppColors.primary,
                  ),
                  child: SvgPicture.asset('assets/images/worker staff.svg', fit: BoxFit.none),
                ),
                SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Tanker and Crew Details',
                      style: TextStyle(fontWeight: FontWeight.w500, fontSize: 24, color: AppColors.secondary),
                    ),
                    Text(
                      'View Tanker and Crew Details',
                      style: TextStyle(fontWeight: FontWeight.w400, fontSize: 14, color: AppColors.icon),
                    )
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: 10),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Wrap(
                    runSpacing: 20.0,
                    children: [
                      // Use the MediaQuery to dynamically set padding
                      Padding(
                        padding: EdgeInsets.only(left: 20, right: 20),
                        child: buildDetailRow('Registration Number', 'Mh436636', 'assets/images/StaffRole.svg'),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 20, right: 20),
                        child: buildContactRow('Driver Contact', '+91 9009611093', 'assets/images/aadhar number.svg'),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 20, right: 20),
                        child: buildDetailRow('Aadhaar Number', '79875878799800', 'assets/images/aadhar number.svg'),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 20,right: 20),
                        child: Row(

                          children: [

                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Stack(
                                  clipBehavior: Clip.none,
                                  children: [
                                    SvgPicture.asset('assets/images/Aadhar1.svg'),
                                    Positioned(
                                        top: 75,
                                        left: 300
                                        ,
                                        child
                                            : SvgPicture.asset('assets/images/download.svg')),
                                  ],
                                ),
                                Text('(Driver Aadhaar Download)',style: TextStyle(fontSize: 14,fontWeight: FontWeight.w400,color: AppColors.text),)
                              ],
                            ),

                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 20, right: 20),
                        child: buildDetailRow('Tank Type', 'Power', 'assets/images/Tanker.svg'),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 20, right: 20),
                        child: buildDetailRow('Grace Period', 'Bill to Bill', 'assets/images/Tanker3.svg'),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 20, right: 20),
                        child: buildDetailRow('Date of Manufacture', 'DD-MM-YYYY', 'assets/images/Calender1.svg'),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 20, right: 20),
                        child: buildDetailRow('Last Maintenance Date', 'DD-MM-YYYY', 'assets/images/Calender1.svg'),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 20, right: 20),
                        child: buildDetailRow('Fitness Certificate Expiry Date', 'DD-MM-YYYY', 'assets/images/Calender1.svg'),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 20, right: 20),
                        child: buildDetailRow('Pollution Control Certificate Number', '5654646545454', 'assets/images/Tanker3.svg'),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 20, right: 20),
                        child: buildDetailRow('Pollution Certificate Expiry Date', 'DD-MM-YYYY', 'assets/images/Tanker3.svg'),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 20, right: 20),
                        child: buildDetailRow('Insurance Policy Number', '5654646545454', 'assets/images/Tanker3.svg'),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 20, right: 20),
                        child: buildDetailRow('Insurance Expiry Date', 'DD-MM-YYYY', 'assets/images/Tanker3.svg'),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 20, right: 20),
                        child: buildDetailRow('Driver License Number', '79875878799800', 'assets/images/Tanker3.svg'),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 20, right: 20),
                        child: buildDetailRow('License Expiry Date', 'DD-MM-YYYY', 'assets/images/Tanker3.svg'),
                      ),
                      SizedBox(height: 20),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildDetailRow(String title, String detail, String iconPath) {
    return Row(
      children: [
        SvgPicture.asset(iconPath),
        SizedBox(width: 10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20, color: AppColors.text),
            ),
            Text(
              detail,
              style: TextStyle(fontWeight: FontWeight.w400, fontSize: 14, color: AppColors.primary),
            ),
          ],
        ),
      ],
    );
  }

  Widget buildContactRow(String title, String detail, String iconPath) {
    return Row(
      children: [
        SvgPicture.asset(iconPath),
        SizedBox(width: 10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20, color: AppColors.text),
            ),
            Text(
              detail,
              style: TextStyle(fontWeight: FontWeight.w400, fontSize: 14, color: AppColors.primary),
            ),
            SizedBox(width: 110),
            SvgPicture.asset('assets/images/call.svg'), // Call icon
          ],
        ),
      ],
    );
  }

  Widget buildDownloadRow(String title, String iconPath, String downloadIconPath) {
    return Row(
      children: [
        SvgPicture.asset(iconPath),
        SizedBox(width: 10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: AppColors.text),
            ),
            Stack(
              clipBehavior: Clip.none,
              children: [
                SvgPicture.asset('assets/images/Aadhar1.svg'),
                Positioned(
                  top: 75,
                  left: 300,
                  child: SvgPicture.asset(downloadIconPath),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}