import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../Utils/Preference.dart';
import '../Utils/colors.dart';
import '../Widgets/NotificationsScreen.dart';
import '../Widgets/appbar/main_app_bar.dart';
import '../controllers/AdminController/StaffController.dart';
import 'Attendance.dart';
import 'AttendanceController.dart';
import 'WorkDetailScreen.dart';

class NameDetailsScreen extends StatefulWidget {
  final String? employeeId;  // For manager: passed employeeId, For employee: null
  final String? employeeName; // For manager: passed employeeName, For employee: null
  final String? date;  // Optional: specific date to view

  const NameDetailsScreen({
    Key? key,
    this.employeeId,
    this.employeeName,
    this.date,
  }) : super(key: key);

  @override
  State<NameDetailsScreen> createState() => _NameDetailsScreenState();
}

class _NameDetailsScreenState extends State<NameDetailsScreen> {
  final AttendanceController attendanceController = Get.put(AttendanceController());
  final StaffController staffController = Get.put(StaffController());
  var isLoadingDetails = false.obs;

  String? actualEmployeeId;  // This will hold the actual ID to use
  String? actualEmployeeName; // This will hold the actual name to use

  @override
  void initState() {
    super.initState();

    // Determine if this is for manager or employee view
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _determineEmployeeAndLoadData();
    });
  }

  Future<void> _determineEmployeeAndLoadData() async {
    // CASE 1: Manager viewing specific employee (employeeId is provided)
    if (widget.employeeId != null && widget.employeeId!.isNotEmpty) {
      actualEmployeeId = widget.employeeId!;
      actualEmployeeName = widget.employeeName ?? 'Employee';
      print('[NameDetailsScreen] 👨‍💼 Manager view: Employee ID = $actualEmployeeId');
    }
    // CASE 2: Employee viewing themselves (no employeeId provided)
    else {
      // Get logged-in employee's ID from SharedPreferences
      final loggedInId = await Preference.getUserId();
      final loggedInName = await Preference.getSharedPref('user_name');

      if (loggedInId != null && loggedInId.isNotEmpty) {
        actualEmployeeId = loggedInId;
        actualEmployeeName = loggedInName ?? 'Employee';
        print('[NameDetailsScreen] 👤 Employee self-view: My ID = $actualEmployeeId');
      } else {
        print('[NameDetailsScreen] ❌ ERROR: No employee ID found');
        Get.snackbar(
          'Error',
          'Unable to load employee details',
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
        return;
      }
    }

    // Load data with the determined employee ID
    await _loadEmployeeData();
  }

  Future<void> _loadEmployeeData() async {
    if (actualEmployeeId == null) return;

    isLoadingDetails.value = true;

    try {
      // Load attendance data
      attendanceController.setSelectedEmployee(
        actualEmployeeId!,
        actualEmployeeName ?? 'Employee',
      );

      // If specific date is provided, load for that date
      if (widget.date != null) {
        print('[NameDetailsScreen] 📅 Loading for specific date: ${widget.date}');
        // You'll need to add a method in AttendanceController to load for specific date
        attendanceController.getEmployeeAttendance(actualEmployeeId!, date: widget.date);
      } else {
        attendanceController.getEmployeeAttendance(actualEmployeeId!);
      }

      // Load staff details
      await _loadStaffDetails();
    } catch (e) {
      debugPrint('Error loading employee data: $e');
      Get.snackbar(
        'Error',
        'Failed to load employee data',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoadingDetails.value = false;
    }
  }

  Future<void> _loadStaffDetails() async {
    if (actualEmployeeId == null) return;

    try {
      await staffController.getStaffDetail(staffId: actualEmployeeId!);
    } catch (e) {
      debugPrint('Error loading staff details: $e');
    }
  }

  // Helper method to get shift display name
  String _getShiftDisplay(String? shiftValue) {
    if (shiftValue == null) return 'Not Set';

    switch (shiftValue) {
      case '0':
        return '24 Hour Shift';
      case '1':
        return 'Day Shift';
      case '2':
        return 'Night Shift';
      default:
        return shiftValue;
    }
  }

  // Helper method to get status display
  String _getStatusDisplay(String? status) {
    if (status == null) return 'Active';
    return status == '0' ? 'In-active' : 'Active';
  }

  // Helper method to get role display
  String _getRoleDisplay(String? roleValue) {
    if (roleValue == null) return 'Employee';

    switch (roleValue) {
      case '3':
        return 'Manager';
      case '4':
        return 'Employee';
      case '5':
        return 'Truck Driver';
      default:
        return roleValue;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  MainAppBar(
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
                    builder: (context) => NotificationsScreen()
                ),
              );
            },
          ),
        ],
      ),
      body: Obx(() {
        if (isLoadingDetails.value) {
          return _buildLoadingScreen();
        }

        return SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                const SizedBox(height: 16),

                // Profile Card with dynamic data
                _buildProfileCard(),

                const SizedBox(height: 16),

                // Action Buttons
                _buildActionButtons(),

                const SizedBox(height: 16),

                // Month/Year Dropdown
                _buildMonthYearDropdown(),

                const SizedBox(height: 16),

                // Attendance Summary
                _buildAttendanceSummary(),

                const SizedBox(height: 8),

                // Loading Indicator or Calendar Grid
                attendanceController.isLoading.value
                    ? _buildLoadingIndicator()
                    : _buildCalendarGrid(),
              ],
            ),
          ),
        );
      }),
    );
  }

  Widget _buildLoadingScreen() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(
            color: AppColors.primary,
          ),
          const SizedBox(height: 16),
          Text(
            actualEmployeeId == widget.employeeId
                ? 'Loading employee details...'
                : 'Loading my details...',
            style: TextStyle(
              color: AppColors.secondary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileCard() {
    return Obx(() {
      final staffDetail = staffController.staffDetailModel.value.data;
      final hasData = staffDetail != null && staffDetail.isNotEmpty;

      return Container(
        height: 300,
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.secondary,
          borderRadius: BorderRadius.circular(8),
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Title - Show "My Details" for employee, employee name for manager
              Text(
                actualEmployeeId == widget.employeeId
                    ? actualEmployeeName ?? widget.employeeName ?? 'Employee'
                    : 'My Details',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),

              if (hasData)
                _buildDynamicProfileInfo(staffDetail!.first)
              else
                _buildStaticProfileInfo(),
            ],
          ),
        ),
      );
    });
  }

  Widget _buildDynamicProfileInfo(dynamic data) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Row 1: Phone and Current Status
        _InfoRow(
          label: 'Phone',
          value: data.phone ?? 'N/A',
          label2: 'Current Status',
          value2: _getStatusDisplay(data.status),
          value2Color: data.status == '1' ? Colors.green : Colors.orange,
        ),

        // Row 2: Salary and Access
        _InfoRow(
          label: 'Salary',
          value: data.salary != null && data.salary!.isNotEmpty
              ? '₹${data.salary}'
              : 'N/A',
          label2: 'Access',
          value2: data.access ?? 'Standard',
        ),

        // Row 3: Aadhaar and Shift
        _InfoRow(
          label: 'Aadhaar',
          value: data.aadharNumber != null && data.aadharNumber!.isNotEmpty
              ? '${data.aadharNumber!.substring(0, 4)}********${data.aadharNumber!.substring(data.aadharNumber!.length - 4)}'
              : 'N/A',
          label2: 'Current Shift',
          value2: _getShiftDisplay(data.shift),
        ),

        // Row 4: Employee ID and Role
        _InfoRow(
          label: 'Employee ID',
          value: data.workId ?? actualEmployeeId ?? 'N/A',
          label2: 'Role',
          value2: _getRoleDisplay(data.role),
        ),
      ],
    );
  }

  Widget _buildStaticProfileInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _InfoRow(
          label: 'Phone',
          value: 'Loading...',
          label2: 'Current Status',
          value2: 'Loading...',
        ),
        _InfoRow(
          label: 'Salary',
          value: 'Loading...',
          label2: 'Access',
          value2: 'Loading...',
        ),
        _InfoRow(
          label: 'Aadhaar',
          value: 'Loading...',
          label2: 'Current Shift',
          value2: 'Loading...',
        ),
        _InfoRow(
          label: 'Employee ID',
          value: actualEmployeeId ?? 'N/A',
          label2: 'Role',
          value2: 'Loading...',
        ),
      ],
    );
  }

  Widget _buildActionButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildAttendanceButton(),
        const SizedBox(width: 16),
        // _buildWorkRecordButton(),
      ],
    );
  }

  Widget _buildAttendanceButton() {
    return Expanded(
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.secondary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          padding: const EdgeInsets.symmetric(vertical: 14),
        ),
        onPressed: () {
          if (actualEmployeeId != null) {
            attendanceController.getEmployeeAttendance(actualEmployeeId!);
          }
        },
        child: Text(
          'Attendance',
          style: TextStyle(color: AppColors.background),
        ),
      ),
    );
  }

  // Widget _buildWorkRecordButton() {
  //   return Expanded(
  //     child: ElevatedButton(
  //       style: ElevatedButton.styleFrom(
  //         backgroundColor: AppColors.primary,
  //         shape: RoundedRectangleBorder(
  //           borderRadius: BorderRadius.circular(30),
  //         ),
  //         padding: const EdgeInsets.symmetric(vertical: 14),
  //       ),
  //       onPressed: () {
  //         if (actualEmployeeId != null) {
  //           Navigator.push(
  //             context,
  //             MaterialPageRoute(
  //               builder: (context) => WorkDetailsScreen(
  //                 employeeId: actualEmployeeId,
  //                 employeeName: actualEmployeeName,
  //                 date: widget.date,
  //               ),
  //             ),
  //           );
  //         }
  //       },
  //       child: Text(
  //         actualEmployeeId == widget.employeeId ? 'Work Record' : 'My Work Record',
  //         style: TextStyle(color: AppColors.background),
  //       ),
  //     ),
  //   );
  // }

  Widget _buildMonthYearDropdown() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.primary),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Obx(() {
        return DropdownButtonHideUnderline(
          child: DropdownButton<String>(
            value: attendanceController.selectedMonthYear.value,
            icon: const Icon(Icons.arrow_drop_down),
            isExpanded: true,
            style: TextStyle(
              color: AppColors.primary,
              fontSize: 16,
            ),
            onChanged: (String? newValue) {
              if (newValue != null) {
                attendanceController.selectedMonthYear.value = newValue;
                _handleMonthChange(newValue);
              }
            },
            items: attendanceController.getMonthYearList().map((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
        );
      }),
    );
  }

  void _handleMonthChange(String monthYear) {
    if (actualEmployeeId != null) {
      attendanceController.getEmployeeAttendance(actualEmployeeId!);
    }
  }

  Widget _buildAttendanceSummary() {
    return Obx(() {
      final data = attendanceController.attendanceData;
      return Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.primary.withOpacity(0.1),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: AppColors.primary.withOpacity(0.2)),
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildSummaryItem(
                  'Total Days',
                  '${data?.totalDays ?? 0}',
                  Icons.calendar_today,
                  AppColors.primary,
                ),
                _buildSummaryItem(
                  'Present',
                  '${data?.totalPresent ?? 0}',
                  Icons.check_circle,
                  Colors.green.shade600,
                ),
                _buildSummaryItem(
                  'Absent',
                  '${data?.totalAbsent ?? 0}',
                  Icons.cancel,
                  Colors.red.shade400,
                ),
                _buildSummaryItem(
                  'Leaves',
                  '${data?.totalLeaves ?? 0}',
                  Icons.airline_seat_individual_suite,
                  Colors.orange.shade400,
                ),
              ],
            ),
            const SizedBox(height: 8),
            if (data?.totalFutureDays != null && data!.totalFutureDays! > 0)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.calendar_today,
                    size: 14,
                    color: Colors.grey.shade600,
                  ),
                  const SizedBox(width: 6),
                  Text(
                    '${data.totalFutureDays} future days',
                    style: TextStyle(
                      color: Colors.grey.shade600,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
          ],
        ),
      );
    });
  }

  Widget _buildSummaryItem(String label, String value, IconData icon, Color color) {
    return Column(
      children: [
        Icon(icon, color: color, size: 20),
        const SizedBox(height: 6),
        Text(
          value,
          style: TextStyle(
            color: color,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            color: AppColors.secondary,
            fontSize: 12,
          ),
        ),
      ],
    );
  }

  Widget _buildLoadingIndicator() {
    return Container(
      height: 300,
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(
            color: AppColors.primary,
          ),
          const SizedBox(height: 16),
          Text(
            'Loading attendance data...',
            style: TextStyle(
              color: AppColors.secondary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCalendarGrid() {
    return Obx(() {
      final attendanceList = attendanceController.attendanceList;

      if (attendanceList.isEmpty) {
        return Container(
          height: 300,
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.calendar_today,
                size: 50,
                color: AppColors.secondary,
              ),
              const SizedBox(height: 10),
              Text(
                'No attendance data available',
                style: TextStyle(
                  color: AppColors.secondary,
                  fontSize: 16,
                ),
              ),
              if (attendanceController.errorMessage.value.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Text(
                    'Error: ${attendanceController.errorMessage.value}',
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: 12,
                    ),
                  ),
                ),
            ],
          ),
        );
      }

      return Column(
        children: [
          const SizedBox(height: 8),
          Text(
            attendanceController.selectedMonthYear.value,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppColors.primary,
            ),
          ),
          const SizedBox(height: 16),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: attendanceList.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 7,
              mainAxisSpacing: 8,
              crossAxisSpacing: 8,
            ),
            itemBuilder: (context, index) {
              final attendanceDay = attendanceList[index];

              return GestureDetector(
                onTap: () {
                  _showAttendanceDetails(context, attendanceDay);
                },
                child: Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: attendanceController.getAttendanceColor(attendanceDay.isPresent),
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 2,
                        offset: const Offset(0, 1),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        attendanceDay.day?.toString() ?? '${index + 1}',
                        style: TextStyle(
                          color: attendanceController.getAttendanceTextColor(attendanceDay.isPresent),
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(height: 2),
                      if (attendanceDay.isPresent != null)
                        Icon(
                          attendanceController.getAttendanceIcon(attendanceDay.isPresent),
                          size: 10,
                          color: attendanceController.getAttendanceIconColor(attendanceDay.isPresent),
                        ),
                    ],
                  ),
                ),
              );
            },
          ),
          const SizedBox(height: 16),
          _buildLegend(),
        ],
      );
    });
  }

  Widget _buildLegend() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildLegendItem('Present', Colors.green.shade600),
        const SizedBox(width: 16),
        _buildLegendItem('Absent', Colors.red.shade400),
        const SizedBox(width: 16),
        _buildLegendItem('Future', Colors.grey.shade300),
      ],
    );
  }

  // Widget _buildLegend() {
  //   return Row(
  //     mainAxisAlignment: MainAxisAlignment.center,
  //     children: [
  //       _buildLegendItem('Present', Colors.blue.shade900),
  //       const SizedBox(width: 16),
  //       _buildLegendItem('Absent', Colors.red.shade400),
  //       const SizedBox(width: 16),
  //       _buildLegendItem('Future', Colors.grey.shade300),
  //     ],
  //   );
  // }

  Widget _buildLegendItem(String text, Color color) {
    return Row(
      children: [
        Container(
          width: 16,
          height: 16,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 6),
        Text(
          text,
          style: TextStyle(
            fontSize: 12,
            color: AppColors.secondary,
          ),
        ),
      ],
    );
  }

  void _showAttendanceDetails(BuildContext context, AttendanceDay attendanceDay) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Attendance Details',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primary,
                ),
              ),
              const SizedBox(height: 20),
              ListTile(
                leading: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: attendanceController.getAttendanceColor(attendanceDay.isPresent),
                    shape: BoxShape.circle,
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    attendanceDay.day?.toString() ?? '',
                    style: TextStyle(
                      color: attendanceController.getAttendanceTextColor(attendanceDay.isPresent),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                title: Text(
                  'Date: ${attendanceDay.currentDate ?? "N/A"}',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                subtitle: Text(
                  'Status: ${attendanceController.getAttendanceStatusText(attendanceDay.isPresent)}',
                  style: TextStyle(
                    fontSize: 14,
                    color: AppColors.secondary,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () => Navigator.pop(context),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey.shade300,
                        minimumSize: const Size(0, 50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: Text(
                        'Close',
                        style: TextStyle(
                          color: AppColors.secondary,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => WorkDetailsScreen(
                              employeeId: actualEmployeeId,
                              employeeName: actualEmployeeName,
                              date: attendanceDay.currentDate,
                            ),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        minimumSize: const Size(0, 50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: Text(
                        'View Work Details',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
            ],
          ),
        );
      },
    );
  }
}

class _InfoRow extends StatelessWidget {
  final String label;
  final String value;
  final String label2;
  final String value2;
  final Color? value2Color;

  const _InfoRow({
    required this.label,
    required this.value,
    required this.label2,
    required this.value2,
    this.value2Color = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  value,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label2,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  value2,
                  style: TextStyle(
                    color: value2Color,
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}