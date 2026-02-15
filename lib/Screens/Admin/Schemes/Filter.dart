import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../../utils/colors.dart';


class Filter extends StatefulWidget {
  const Filter({super.key});

  @override
  State<Filter> createState() => _FilterState();
}

class _FilterState extends State<Filter> {
  @override
  Widget build(BuildContext context) {
    // Get the dimensions of the screen
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Stack(
      clipBehavior: Clip.none, // Allows the "X" icon to overflow the dialog container
      children: [
        // Main Dialog Content
        Container(
          height: screenHeight * 0.55, // Using 55% of the screen height
          width: screenWidth * 0.99, // Using 90% of the screen width
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Space for the "X" icon
              Row(
                children: [
                  Container(
                    height: 62,
                    width: 62,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: AppColors.primary,
                    ),
                    child: SvgPicture.asset('assets/images/Filter.svg',
                      fit: BoxFit.none, color: AppColors.whitebg,
                    ),
                  ),
                  SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Filters',
                        style: TextStyle(fontWeight: FontWeight.w500, fontSize: 24, color: AppColors.secondary),
                      ),
                      Text(
                        'Use these filters to view Schemes',
                        style: TextStyle(fontWeight: FontWeight.w400, fontSize: 14, color: AppColors.icon),
                      )
                    ],
                  ),
                ],
              ),
              SizedBox(height: 40),
              _buildSectionTitle('Vehicle Type'),
              SizedBox(height: 20),
              _buildHorizontalScrollView(['Car', 'Bike', 'Truck', 'Bus', 'Van']),
              SizedBox(height: 20),
              _buildSectionTitle('Product Type'),
              SizedBox(height: 20),
              _buildHorizontalScrollView(['Petrol/E20', 'Power', 'Diesel', 'Lube', ]),
              SizedBox(height: 20),
              // Save Button
              Container(
                height: 60,
                width: screenWidth * 0.90, // Using 90% of the screen width
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
                    "Filter Now",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500, color: AppColors.background),
                  ),
                ),
              ),
            ],
          ),
        ),
        // X Icon for Dismissing the Dialog
        Positioned(
          top: -80, // Adjust as necessary
          left: screenWidth * 0.45, // Center horizontally
          child: GestureDetector(
            onTap: () {
              // Close the dialog
              Navigator.pop(context);
            },
            child: CircleAvatar(
              radius: 30,
              backgroundColor: Colors.black54,
              child: Icon(Icons.close, size: 40, color: Colors.white),
            ),
          ),
        ),
      ],
    );
  }

  // Helper function to build section titles
  Text _buildSectionTitle(String title) {
    return Text(
      title,
      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: AppColors.primary),
    );
  }

  // Helper function to build horizontal scrollable selections
  SingleChildScrollView _buildHorizontalScrollView(List<String> items) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: items.map((item) {
          return Container(
            height: 41,
            width: 134,
            margin: EdgeInsets.only(right: 20), // Added margin for spacing
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              border: Border.all(color: AppColors.secondary, width: 1),
            ),
            child: Center(
              child: Text(
                item,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: AppColors.secondary),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}