import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../Utils/Preference.dart';
import '../Utils/Const.dart';

class EmployeeTestScreen extends StatefulWidget {
  @override
  _EmployeeTestScreenState createState() => _EmployeeTestScreenState();
}

class _EmployeeTestScreenState extends State<EmployeeTestScreen> {
  String? userId;
  String? userName;
  String? workId;
  String? token;

  @override
  void initState() {
    super.initState();
    loadSavedData();
  }

  Future<void> loadSavedData() async {
    // Sab saved data nikalo
    userId = await Preference.getSharedPref('id');
    userName = await Preference.getSharedPref('user_name');
    workId = await Preference.getSharedPref('work_id');
    token = await Preference.getSharedPref(KEY_TOKEN);

    print('[Employee Test] ID: $userId');
    print('[Employee Test] Name: $userName');
    print('[Employee Test] Work ID: $workId');
    print('[Employee Test] Token: $token');

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Employee Test Screen"),
        backgroundColor: Colors.green, // Alag color employee ke liye
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Employee Saved Data:",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            _buildRow("User ID", userId ?? "Not saved"),
            _buildRow("Name", userName ?? "Not saved"),
            _buildRow("Work ID", workId ?? "Not saved"),
            _buildRow("Token", token?.substring(0, 20) ?? "Not saved"),
            SizedBox(height: 30),
            ElevatedButton(
              onPressed: loadSavedData,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
              ),
              child: Text("Refresh Data"),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                _checkAllKeys();
              },
              child: Text("Check All Keys"),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRow(String label, String value) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8),
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey[300]!),
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              "$label:",
              style: TextStyle(fontWeight: FontWeight.bold, color: Colors.green[800]),
            ),
          ),
          SizedBox(width: 10),
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                color: value == "Not saved" ? Colors.red : Colors.black,
                fontWeight: value == "Not saved" ? FontWeight.normal : FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _checkAllKeys() async {
    print('=== CHECKING ALL POSSIBLE KEYS ===');

    // Check all possible ID keys
    final id1 = await Preference.getSharedPref('id');
    final id2 = await Preference.getSharedPref('user_id');
    final id3 = await Preference.getSharedPref('ID');
    final id4 = await Preference.getSharedPref('userId');

    print('1. "id": $id1');
    print('2. "user_id": $id2');
    print('3. "ID": $id3');
    print('4. "userId": $id4');

    // Show in dialog
    Get.dialog(
      AlertDialog(
        title: Text("All ID Keys"),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildKeyRow('"id" key:', id1),
              _buildKeyRow('"user_id" key:', id2),
              _buildKeyRow('"ID" key:', id3),
              _buildKeyRow('"userId" key:', id4),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: Text('OK'),
          ),
        ],
      ),
    );
  }

  Widget _buildKeyRow(String label, String? value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Text('$label', style: TextStyle(fontWeight: FontWeight.bold)),
          SizedBox(width: 10),
          Text(value ?? 'NULL', style: TextStyle(
            color: value == null ? Colors.red : Colors.green,
            fontWeight: FontWeight.bold,
          )),
        ],
      ),
    );
  }
}