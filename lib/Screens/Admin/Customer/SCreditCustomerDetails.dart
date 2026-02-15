import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../utils/colors.dart';


class SCreditCustomerDetails extends StatefulWidget {
  const SCreditCustomerDetails({super.key});

  @override
  State<SCreditCustomerDetails> createState() => _SCreditCustomerDetailsState();
}

class _SCreditCustomerDetailsState extends State<SCreditCustomerDetails> {
  @override
  Widget build(BuildContext context) {
    // Get the dimensions of the screen
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Container(
      height: height * 0.8, // Responsive height
      width: width * 0.99, // Responsive width

      child: ListView(
        children: [
          Column(
            children: [
              SizedBox(height: height * 0.02), // Responsive margin
              Container(
                height: 5,
                width: 53,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: AppColors.alert
                ),
              ),
              Wrap(
                runSpacing: 20.0,
                children: [
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
                          child: SvgPicture.asset(
                            'assets/images/worker staff.svg',
                            fit: BoxFit.none,
                          ),
                        ),
                        SizedBox(width: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Credit Customer Details',
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 24,
                                  color: AppColors.secondary),
                            ),
                            Text(
                              'View Customer Details',
                              style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14,
                                  color: AppColors.icon),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Row(
                      children: [
                        SvgPicture.asset('assets/images/aadhar number.svg'),
                        SizedBox(width: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Company Type',
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 20,
                                  color: AppColors.text),
                            ),
                            Text(
                              'Private Limited',
                              style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14,
                                  color: AppColors.primary),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Row(
                      children: [
                        SvgPicture.asset('assets/images/aadhar number.svg'),
                        SizedBox(width: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              ' Name of Customer here',
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 20,
                                  color: AppColors.text),
                            ),
                            Text(
                              '+91 9003314141',
                              style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14,
                                  color: AppColors.primary),
                            )
                          ],
                        ),

                        Padding(
                          padding: const EdgeInsets.only(left: 40,bottom: 20),
                          child: SvgPicture.asset('assets/images/call.svg'),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Row(
                      children: [
                        SvgPicture.asset('assets/images/aadhar number.svg'),
                        SizedBox(width: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Aadhaar Number',
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 20,
                                  color: AppColors.text),
                            ),
                            Text(
                              '79875878799800',
                              style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14,
                                  color: AppColors.primary),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Stack(
                              clipBehavior: Clip.none,
                              children: [
                                SvgPicture.asset('assets/images/aadhar.svg'),
                                Positioned(
                                  top: 75,
                                  left: 130,
                                  child: SvgPicture.asset('assets/images/download.svg'),
                                ),
                              ],
                            ),
                            Text(
                              '(Aadhaar Front)',
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: AppColors.text),
                            )
                          ],
                        ),
                        Spacer(),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Stack(
                              clipBehavior: Clip.none,
                              children: [
                                SvgPicture.asset('assets/images/aadhar.svg'),
                                Positioned(
                                  top: 75,
                                  left: 130,
                                  child: SvgPicture.asset('assets/images/download.svg'),
                                ),
                              ],
                            ),
                            Text(
                              '(Aadhaar Back)',
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: AppColors.text),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Row(
                      children: [
                        SvgPicture.asset('assets/images/time.svg'),
                        SizedBox(width: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Product Type',
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 20,
                                  color: AppColors.text),
                            ),
                            Text(
                              'Power ',
                              style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14,
                                  color: AppColors.primary),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Row(
                      children: [
                        SvgPicture.asset('assets/images/lock.svg'),
                        SizedBox(width: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Grace Period',
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 20,
                                  color: AppColors.text),
                            ),
                            Text(
                              'Bill to Bill ',
                              style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14,
                                  color: AppColors.primary),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Row(
                      children: [
                        SvgPicture.asset('assets/images/StaffRole.svg'),
                        SizedBox(width: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Amount Limit',
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 20,
                                  color: AppColors.text),
                            ),
                            Text(
                              '5000',
                              style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14,
                                  color: AppColors.primary),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Row(
                      children: [
                        SvgPicture.asset('assets/images/StaffRole.svg'),
                        SizedBox(width: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Rate of Interest',
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 20,
                                  color: AppColors.text),
                            ),
                            Text(
                              '18%',
                              style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14,
                                  color: AppColors.primary),
                            )
                          ],
                        ),
                        SizedBox(width: 10), // Responsive spacing
                        SvgPicture.asset('assets/images/whatsappicon.png'),
                        SizedBox(width: 5),
                        SvgPicture.asset('assets/images/Copy.png'),
                      ],
                    ),
                  ),
                  SizedBox(height: 20), // Bottom margin
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}