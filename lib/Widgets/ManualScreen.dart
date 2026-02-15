// import 'package:flutter/material.dart';
// import '../utils/colors.dart';
//
// class ManualScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     // Get the size of the screen
//     final Size size = MediaQuery.of(context).size;
//     final double width = size.width;
//     final double height = size.height;
//
//     return Scaffold(
//       body: Padding(
//         padding: EdgeInsets.all(16),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             SizedBox(height: 45),
//             Row(
//               children: [
//                 GestureDetector(
//                   onTap: () => Navigator.pop(context),
//                   child: Image.asset(
//                     'assets/images/back.png',
//                     width: width * 0.3, // 30% of screen width
//                     height: height * 0.05, // 5% of screen height
//                   ),
//                 ),
//               ],
//             ),
//             SizedBox(height: 40),
//             Container(
//               height: height * 0.05, // 5% of screen height
//               width: width * 0.95, // 95% of screen width
//               child: Text(
//                 "Read the manual",
//                 style: TextStyle(
//                   fontSize: 32, // Adjust if needed
//                   fontWeight: FontWeight.w600,
//                   color: AppColors.secondary,
//                 ),
//               ),
//             ),
//             SizedBox(height: 10),
//             Text(
//               "Read carefully to understand the work of the app",
//               style: TextStyle(fontSize: 16, color: AppColors.icon),
//             ),
//             SizedBox(height: 40),
//             ...List.generate(4, (index) {
//               return Padding(
//                 padding: EdgeInsets.only(bottom: 20),
//                 child: ManualStep(
//                   number: index + 1,
//                   text: [
//                     "Login in the application using your work ID or password.",
//                     "Track your daily record and work, get your account details.",
//                     "Manage your data with the help of your dashboard.",
//                     "Send request for advance approval."
//                   ][index],
//                 ),
//               );
//             }),
//             SizedBox(height: 90),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Expanded(
//                   child: Text(
//                     "Feel free to call us for any assistance or support you need.",
//                     style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
//                   ),
//                 ),
//                 SizedBox(width: 20),
//                 SizedBox(
//                   height: height * 0.07, // 7% of screen height
//                   width: width * 0.35, // 35% of screen width
//                   child: ElevatedButton(
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: Colors.red,
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(8),
//                       ),
//                     ),
//                     onPressed: () {},
//                     child: Text(
//                       "Call Now",
//                       style: TextStyle(
//                         color: Colors.white,
//                         fontSize: 16,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
// class ManualStep extends StatelessWidget {
//   final int number;
//   final String text;
//
//   const ManualStep({required this.number, required this.text});
//
//   @override
//   Widget build(BuildContext context) {
//     // Get the size of the screen
//     final Size size = MediaQuery.of(context).size;
//
//     return Row(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         CircleAvatar(
//           backgroundColor: Colors.red,
//           radius: 28, // Use fixed radius as it is generally good for a circle
//           child: Text(
//             "$number",
//             style: TextStyle(
//               color: Colors.white,
//               fontWeight: FontWeight.bold,
//               fontSize: 16,
//             ),
//           ),
//         ),
//         SizedBox(width: 12),
//         Expanded(
//           child: Padding(
//             padding: EdgeInsets.only(left: 10, top: 10),
//             child: Text(
//               text,
//               style: TextStyle(
//                 fontSize: 20,
//                 color: Colors.black,
//                 fontWeight: FontWeight.w400,
//               ),
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../utils/colors.dart'; // Your AppColors

// Import your logout dialog file - !! ADJUST THE PATH AS NEEDED !!
// Example: If logout_dialog.dart is in 'lib/Utils/logout_dialog.dart'
// and ManualScreen.dart is in 'lib/Widgets/ManualScreen.dart',
// the import might be:
import '../Utils/logout_dialog.dart'; // Or the correct relative path

class ManualScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Get the size of the screen
    final Size size = MediaQuery.of(context).size;
    final double width = size.width;
    final double height = size.height;

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.fromLTRB(16, 16, 16, 0), // Adjust bottom padding if needed later
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 45), // Consider using SafeArea for top spacing
            Row(
              children: [
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: SvgPicture.asset(
                    'assets/images/backwithlogo.svg', // Ensure this asset exists
                    width: width * 0.3,
                    height: height * 0.05,
                  ),
                ),
              ],
            ),
            SizedBox(height: 40),
            Container(
              // No need for height and width if text style controls size adequately
              child: Text(
                "Read the manual",
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.w600,
                  color: AppColors.secondary,
                ),
              ),
            ),
            SizedBox(height: 10),
            Text(
              "Read carefully to understand the work of the app",
              style: TextStyle(fontSize: 16, color: AppColors.icon),
            ),
            SizedBox(height: 40),
            // Use Expanded for the list if you want the logout button at the very bottom
            // Otherwise, if the content is short, it might not push the logout button down.
            // For now, let's assume content might not be too long.
            ...List.generate(4, (index) {
              return Padding(
                padding: EdgeInsets.only(bottom: 20),
                child: ManualStep(
                  number: index + 1,
                  text: [
                    "Login in the application using your work ID or password.",
                    "Track your daily record and work, get your account details.",
                    "Manage your data with the help of your dashboard.",
                    "Send request for advance approval."
                  ][index],
                ),
              );
            }),
            // Spacer will push the following widgets to the bottom

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center, // Align items vertically
              children: [
                Expanded(
                  flex: 3, // Give more space to the text
                  child: Text(
                    "Feel free to call us for any assistance or support you need.",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                    overflow: TextOverflow.ellipsis, // Handle potential overflow
                    maxLines: 2,
                  ),
                ),
                SizedBox(width: 10), // Reduced spacing a bit
                SizedBox(
                  height: height * 0.06, // Adjusted height slightly
                  width: width * 0.30,   // Adjusted width slightly
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8), // Add some padding
                    ),
                    onPressed: () {
                      // Add your call functionality here
                      print("Call Now Tapped");
                    },
                    child: Text(
                      "Call Now",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14, // Adjusted font size
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20), // Spacing before the logout button
            // Logout Button
            Align(
              alignment: Alignment.bottomLeft,
              child: ElevatedButton.icon(
                icon: Icon(Icons.logout_rounded, color: Colors.white),
                label: Text(
                  "Logout",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red.shade600, // Consistent red color
                  minimumSize: Size(width * 0.3, height * 0.06), // Make it reasonably sized
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onPressed: () {
                  showLogoutDialog(context); // Call your existing logout dialog
                },
              ),
            ),
            SizedBox(height: 20), // Bottom padding
          ],
        ),
      ),
    );
  }
}

class ManualStep extends StatelessWidget {
  final int number;
  final String text;

  const ManualStep({Key? key, required this.number, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CircleAvatar(
          backgroundColor: Colors.red,
          radius: 20, // Slightly reduced radius for a tighter look
          child: Text(
            "$number",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 14, // Adjusted font size
            ),
          ),
        ),
        SizedBox(width: 12),
        Expanded(
          child: Padding(
            padding: EdgeInsets.only(top: 2), // Adjust top padding to align better with circle center
            child: Text(
              text,
              style: TextStyle(
                fontSize: 16, // Adjusted font size
                color: Colors.black87, // Slightly softer black
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
