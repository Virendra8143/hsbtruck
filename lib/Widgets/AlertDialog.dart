import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CreateBranchDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Dialog(

      child: Stack(
        clipBehavior: Clip.none, // Allows the "X" icon to overflow the dialog container
        children: [
          // Main Dialog Content
          Container(
            height: 714,
            width: 1000,
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 40), // Space for the "X" icon
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      height: 62,
                      width: 62,
                      child: Image.asset(
                        'assets/images/Admin.png',
                        fit: BoxFit.fill, // Path to your image asset
                      ),
                    ),
                    SizedBox(width: 20),
                    Text(
                      "Create New Branch",
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Text(
                  "You can create new branches.",
                  style: TextStyle(color: Colors.grey),
                ),
                SizedBox(height: 20),
                // Branch Name TextField
                TextField(
                  decoration: InputDecoration(
                    labelText: "Branch Name",
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 20),
                // Branch Address TextField
                TextField(
                  decoration: InputDecoration(
                    labelText: "Branch Address or City",
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 20),
                // Branch Code TextField
                TextField(
                  decoration: InputDecoration(
                    labelText: "Branch Code",
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 20),
                // Save Button
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      // Handle the save logic
                      Navigator.pop(context); // Close the dialog
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Text("Save Branch"),
                  ),
                ),
              ],
            ),
          ),
          // X Icon for Dismissing the Dialog
          Positioned(
            top: -50,

            left: 150,
            child: GestureDetector(
              onTap: () {
                Navigator.pop(context); // Close the dialog
              },
              child: CircleAvatar(
                radius: 20,
                backgroundColor: Colors.black54,
                child: Icon(Icons.close, color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
