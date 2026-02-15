import 'package:flutter/material.dart';

class CustomDropdownExample extends StatefulWidget {
  const CustomDropdownExample({super.key});

  @override
  _CustomDropdownExampleState createState() => _CustomDropdownExampleState();
}

class _CustomDropdownExampleState extends State<CustomDropdownExample> {
  String? selectedValue;
  final List<String> optionsList = ['MSE20', 'Power', 'Diesel', 'Lube'];

  @override
  Widget build(BuildContext context) {
    // Get the size of the screen
    final Size size = MediaQuery.of(context).size;

    return SizedBox(
      height: size.height * 0.07, // 7% of screen height
      child: DropdownButtonFormField<String>(
        value: selectedValue,
        hint: Text(
          'Select Product',
          style: TextStyle(fontSize: size.width * 0.04), // Font responsive to screen width
        ),
        onChanged: (String? newValue) {
          setState(() {
            selectedValue = newValue;
          });
        },
        validator: (String? value) {
          if (value == null) {
            return 'Please select an option';
          }
          return null;
        },
        items: optionsList.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(
              value,
              style: TextStyle(fontSize: size.width * 0.04), // Font responsive to screen width
            ),
          );
        }).toList(),
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(vertical: size.height * 0.015, horizontal: size.width * 0.03), // Responsive padding
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12), // Fixed border radius, generally acceptable for a circle
            borderSide: const BorderSide(color: Colors.red, width: 2),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12), // Fixed border radius
            borderSide: const BorderSide(color: Colors.red, width: 2),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12), // Fixed border radius
            borderSide: const BorderSide(color: Colors.red, width: 2),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12), // Fixed border radius
            borderSide: const BorderSide(color: Colors.red, width: 2),
          ),
        ),
      ),
    );
  }
}