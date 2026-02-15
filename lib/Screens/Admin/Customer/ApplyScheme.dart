import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../Utils/colors.dart';


class ApplyScheme extends StatefulWidget {
  const ApplyScheme({super.key});

  @override
  State<ApplyScheme> createState() => _ApplySchemeState();
}

class _ApplySchemeState extends State<ApplyScheme> {
  String? dropdownValue;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Container(
      height: height * 0.52, // Responsive height
      width: width * 0.99, // Responsive width
      child: Column(

          children: [
            SizedBox(height: 2),
            Container(
              height: 5,
              width: 53,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: AppColors.alert,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15, right: 8, bottom: 8, top: 20),
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
                        'Apply Scheme ',
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 24,
                          color: AppColors.secondary,
                        ),
                      ),
                      Text(
                        'Manager can apply for Schemes',
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 14,
                          color: AppColors.icon,
                        ),
                      )
                    ],
                  ),
                  SizedBox(width: 20),
                ],
              ),
            ),
            SizedBox(height: 10,),
            Padding(
              padding: const EdgeInsets.only(left: 23.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text('Customer name here',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  children: [
                    SizedBox(height: height * 0.02),
                    Container(
                      height: 60,
                      width: width * 0.9, // Responsive width
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.red, width: 1),
                      ),
                      child: DropdownButton<String>(
                        value: dropdownValue,
                        isExpanded: true,
                        hint: Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Text(
                            'Product type',
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: AppColors.text),
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
                        items: <String>['Petrol ', 'Diesel ', 'Power']
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
                            dropdownValue = newValue;
                          });
                        },
                      ),
                    ),
                    SizedBox(height: 20),
                    // Responsive spacing
                    SizedBox(
                      width: width * 0.9, // Responsive width
                      child: TextField(
                        decoration: InputDecoration(
                          labelText: "Amount",
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(color: AppColors.primary, width: 1),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    SizedBox(
                      width: width * 0.9, // Responsive width
                      child: TextField(
                        decoration: InputDecoration(
                          labelText: "Manager name already filled",
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(color: AppColors.primary, width: 1),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20,),
                    Padding(
                      padding: const EdgeInsets.only(left: 28.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text('You can not  edit the manager id or name',style: TextStyle(fontSize: 12,),),
                        ],
                      ),
                    ),
                    SizedBox(height: 20,),
                    Container(
                      height: 60,
                      width: width * 0.9, // Responsive width
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context); // Pop the current screen to go back
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.button,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: Text(
                          "Send Request to admin",
                          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500, color: AppColors.background),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ]),
    );
  }
}