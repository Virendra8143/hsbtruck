import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../Utils/Api.dart';
import '../Utils/Preference.dart';
import '../Utils/Const.dart';
import '../Utils/colors.dart';
import '../Widgets/NotificationsScreen.dart';
import '../Widgets/appbar/main_app_bar.dart';

class EmployeeProfileScreen extends StatefulWidget {
  @override
  _EmployeeProfileScreenState createState() => _EmployeeProfileScreenState();
}

class _EmployeeProfileScreenState extends State<EmployeeProfileScreen> {
  Map<String, dynamic>? profileData;
  bool isLoading = true;
  String errorMessage = '';

  @override
  void initState() {
    super.initState();
    _loadProfile();
  }

  Future<void> _loadProfile() async {
    try {
      setState(() {
        isLoading = true;
        errorMessage = '';
      });

      // 1. ID nikalo - Pehle 'id' key se try karo, phir 'user_id' se
      String? userId = await Preference.getSharedPref('id');

      if (userId == null || userId.isEmpty) {
        userId = await Preference.getSharedPref('user_id');
        print('[Employee Profile] Trying user_id key: $userId');
      }

      print('[Employee Profile] User ID: $userId');

      if (userId == null || userId.isEmpty) {
        setState(() {
          errorMessage = 'User ID not found. Please login again.';
          isLoading = false;
        });
        return;
      }

      // 2. Profile API call karo - Pehle /profile API try karo
      await _tryProfileAPI(userId);

    } catch (e) {
      print('[Employee Profile] Error: $e');
      setState(() {
        errorMessage = 'Error: $e';
        isLoading = false;
      });
    }
  }

  Future<void> _tryProfileAPI(String userId) async {
    try {
      print('[Employee Profile] Trying /profile/$userId API...');

      final response = await API.instance.get(
        endPoint: "/profile/$userId",
        isHeader: true,
      );

      print('[Employee Profile] Profile API status: ${response.statusCode}');

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        print('[Employee Profile] Profile API response: ${json.encode(data)}');

        if (data['status'] == 'success') {
          if (data['data'] is List && data['data'].isNotEmpty) {
            // Format: {"data": [{...}]}
            setState(() {
              profileData = data['data'][0];
              isLoading = false;
            });
            print('[Employee Profile] Profile loaded successfully (List format)');
          } else if (data['data'] is Map) {
            // Format: {"data": {...}}
            setState(() {
              profileData = data['data'];
              isLoading = false;
            });
            print('[Employee Profile] Profile loaded successfully (Map format)');
          } else {
            print('[Employee Profile] Invalid data format, trying staff API...');
            await _tryStaffAPI(userId);
          }
        } else {
          print('[Employee Profile] Profile API failed, trying staff API...');
          await _tryStaffAPI(userId);
        }
      } else {
        print('[Employee Profile] Profile API returned ${response.statusCode}, trying staff API...');
        await _tryStaffAPI(userId);
      }
    } catch (e) {
      print('[Employee Profile] Profile API error: $e');
      await _tryStaffAPI(userId);
    }
  }

  Future<void> _tryStaffAPI(String userId) async {
    try {
      print('[Employee Profile] Trying /get-staff/$userId API...');

      final response = await API.instance.get(
        endPoint: "/get-staff/$userId",
        isHeader: true,
      );

      print('[Employee Profile] Staff API status: ${response.statusCode}');

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        print('[Employee Profile] Staff API response: ${json.encode(data)}');

        if (data['status'] == 'success') {
          if (data['data'] is List && data['data'].isNotEmpty) {
            setState(() {
              profileData = data['data'][0];
              isLoading = false;
            });
            print('[Employee Profile] Profile loaded from staff API');
          } else {
            setState(() {
              errorMessage = 'No profile data found';
              isLoading = false;
            });
          }
        } else {
          setState(() {
            errorMessage = data['message'] ?? 'Failed to load profile';
            isLoading = false;
          });
        }
      } else {
        setState(() {
          errorMessage = 'Cannot connect to server';
          isLoading = false;
        });
      }
    } catch (e) {
      print('[Employee Profile] Staff API error: $e');
      setState(() {
        errorMessage = 'Network error: $e';
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20.0),
      child: Scaffold(
        appBar: MainAppBar(
          logoPath: 'assets/images/HSB.png',
          showBack: true,
          backgroundColor: AppColors.background,
          iconColor: AppColors.text,
          actions: [
            AppBarActionItem(
              imagePath: 'assets/svg_icons/notification.svg',
              color: AppColors.secondary,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => NotificationsScreen(),
                  ),
                );
              },
            ),
            AppBarActionItem(
              imagePath: 'assets/svg_icons/appbar-settings.svg',
              color: AppColors.secondary,
              onTap: () {},
            ),
          ],
        ),
        body: isLoading
            ? Center(child: CircularProgressIndicator())
            : errorMessage.isNotEmpty
            ? Center(child: Text(errorMessage))
            : profileData == null
            ? Center(child: Text('No profile data available'))
            : _buildProfileUI(),
      ),
    );
  }

  Widget _buildProfileUI() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Profile Header
          Center(
            child: Column(
              children: [
                Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.primary,
                    border: Border.all(color: AppColors.background, width: 2),
                  ),
                  child: Center(
                    child: Text(
                      profileData!['name']?[0]?.toUpperCase() ?? 'E',
                      style: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                        color: AppColors.background,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 16),
                Text(
                  profileData!['name'] ?? 'No Name',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  profileData!['work_id'] ?? 'No ID',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey.shade600,
                  ),
                ),
              ],
            ),
          ),

          SizedBox(height: 24),

          // Personal Information
          Card(
            elevation: 2,
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Personal Information',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primary,
                    ),
                  ),
                  SizedBox(height: 12),
                  _buildInfoRow('Employee ID', profileData!['work_id'] ?? 'N/A'),
                  if (profileData!['branch'] != null && profileData!['branch'].toString().isNotEmpty)
                    _buildInfoRow('Branch', profileData!['branch'].toString()),
                  if (profileData!['phone'] != null && profileData!['phone'].toString().isNotEmpty)
                    _buildInfoRow('Phone', profileData!['phone'].toString()),
                  if (profileData!['address'] != null && profileData!['address'].toString().isNotEmpty)
                    _buildInfoRow('Address', profileData!['address'].toString()),
                ],
              ),
            ),
          ),

          SizedBox(height: 16),

          // Employment Details
          Card(
            elevation: 2,
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Employment Details',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primary,
                    ),
                  ),
                  SizedBox(height: 12),
                  if (profileData!['shift'] != null && profileData!['shift'].toString().isNotEmpty)
                    _buildInfoRow('Shift', profileData!['shift'].toString()),
                  if (profileData!['salary'] != null && profileData!['salary'].toString().isNotEmpty)
                    _buildInfoRow('Salary', '₹${profileData!['salary']}'),
                  if (profileData!['role'] != null && profileData!['role'].toString().isNotEmpty)
                    _buildInfoRow('Role', profileData!['role'].toString()),
                  if (profileData!['created_date'] != null)
                    _buildInfoRow('Joined Date', _formatDate(profileData!['created_date'].toString())),
                  if (profileData!['status'] != null && profileData!['status'].toString().isNotEmpty)
                    _buildInfoRow('Status', profileData!['status'].toString()),
                ],
              ),
            ),
          ),

          // Aadhar Details (if available)
          if (profileData!['aadhar_number'] != null && profileData!['aadhar_number'].toString().isNotEmpty)
            Column(
              children: [
                SizedBox(height: 16),
                Card(
                  elevation: 2,
                  child: Padding(
                    padding: EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Aadhar Details',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: AppColors.primary,
                          ),
                        ),
                        SizedBox(height: 12),
                        _buildInfoRow('Aadhar Number', profileData!['aadhar_number'].toString()),
                      ],
                    ),
                  ),
                ),
              ],
            ),

          // Access Details (if available)
          if (profileData!['access'] != null && profileData!['access'].toString().isNotEmpty)
            Column(
              children: [
                SizedBox(height: 16),
                Card(
                  elevation: 2,
                  child: Padding(
                    padding: EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Access Permissions',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: AppColors.primary,
                          ),
                        ),
                        SizedBox(height: 12),
                        _buildInfoRow('Access', profileData!['access'].toString()),
                      ],
                    ),
                  ),
                ),
              ],
            ),

          // Refresh Button
          SizedBox(height: 24),
          // Center(
          //   child: ElevatedButton.icon(
          //     icon: Icon(Icons.refresh),
          //     label: Text('Refresh Profile'),
          //     onPressed: () {
          //       setState(() {
          //         isLoading = true;
          //         errorMessage = '';
          //       });
          //       _loadProfile();
          //     },
          //     style: ElevatedButton.styleFrom(
          //       backgroundColor: AppColors.primary,
          //       foregroundColor: Colors.white,
          //     ),
          //   ),
          // ),
          SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: Text(
              '$label:',
              style: TextStyle(
                fontWeight: FontWeight.w500,
                color: Colors.grey.shade700,
              ),
            ),
          ),
          SizedBox(width: 8),
          Expanded(
            flex: 3,
            child: Text(
              value,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _formatDate(String dateString) {
    try {
      final date = DateTime.parse(dateString);
      return '${date.day}/${date.month}/${date.year}';
    } catch (e) {
      return dateString;
    }
  }
}