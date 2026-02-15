import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../../../Widgets/appbar/main_app_bar.dart';
import '../../../controllers/AdminController/StaffController.dart';
import '../../../helpers/build_info_staff.dart';
import '../../../utils/colors.dart';
import '../../../Widgets/ManualScreen.dart';
import '../../../Widgets/NotificationsScreen.dart';
import '../../../Widgets/CommonHeader.dart';
import 'EditStaffOption.dart';
import 'Addstaff.dart';
import 'StaffDetails.dart';

class Staff extends StatefulWidget {
  const Staff({super.key});

  @override
  State<Staff> createState() => _StaffState();
}

class _StaffState extends State<Staff> {
  final StaffController staffController = Get.put(StaffController());
  final TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {

      staffController.getTotalStaff();
      // Instead of calling getStaffList() which defaults to "0"
      // Call it with the employee filter directly
      staffController.getStaffList(type: "4");

      // Also update the controller state
      staffController.staffType.value = "4";
      staffController.selectedFilter.value = "Employees";

    });

    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // Getting MediaQuery data
    final mediaQuery = MediaQuery.of(context);
    final screenWidth = mediaQuery.size.width;
    final screenHeight = mediaQuery.size.height;

    return Scaffold(
      appBar: MainAppBar(
        logoPath: 'assets/images/HSB.png',
        showBack: true,
        backgroundColor: AppColors.background,
        iconColor: AppColors.text,
        actions: [
          AppBarActionItem(
            imagePath: 'assets/svg_icons/notification.svg',
            color: AppColors.secondary, // optional override
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => NotificationsScreen()));
            },
          ),
          AppBarActionItem(
            imagePath: 'assets/svg_icons/appbar-settings.svg',
            color: AppColors.secondary, // optional override
            onTap: () {},
          ),
        ],
      ),
      resizeToAvoidBottomInset: false,
      body: Obx(
        () => (staffController.isLoading.value &&
                staffController.staffListModel.value.data == null) ||
                staffController.getTotalStaffModel.value.data == null
            ? Container(
                height: Get.height,
                width: Get.width,
                alignment: Alignment.center,
                child: CircularProgressIndicator(
                  color: AppColors.primary,
                ),
              )
            : SafeArea(
                child: Column(
                  children: [
                    // Always show the main content structure
                    Expanded(
                      child: _buildMainContent(screenWidth, screenHeight),
                    ),
                  ],
                ),
              ),
      ),
    );
  }

  Widget _buildMainContent(double screenWidth, double screenHeight) {
    return Column(
      children: [
        // Header content - always shown
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 5),
          child: Column(
            children: [
              SizedBox(height: screenHeight * 0.02),
              // Staff logo and information section - always shown
              _buildStaffInfoSection(screenWidth, screenHeight),
              SizedBox(height: screenHeight * 0.02),
              // Filter buttons - always shown
              _buildFilterButtons(screenWidth),
              SizedBox(height: screenHeight * 0.02),
              // Search bar - always shown
              _buildSearchBar(screenWidth),
              SizedBox(height: 8),
            ],
          ),
        ),

        // Staff List or Empty State - scrollable
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: staffController.staffListModel.value.data?.isEmpty ?? true
              ? _buildConditionalEmptyState(screenWidth, screenHeight)
              : _buildStaffList(screenWidth, screenHeight),
          ),
        ),

        // Add Staff Button (bottom right) - always shown
        _buildAddStaffButton(),
      ],
    );
  }

  Widget _buildStaffInfoSection(double screenWidth, double screenHeight) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 🧍 Staff Illustration — Flex 1
          Expanded(
            flex: 1,
            child: AspectRatio(
              aspectRatio: 1,
              child: SvgPicture.asset(
                'assets/images/worker staff.svg',
                fit: BoxFit.contain,
              ),
            ),
          ),

          SizedBox(width: screenWidth * 0.02),

          // 📊 Staff Info — Flex 1
          Expanded(
            flex: 1,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Staff",
                  style: TextStyle(
                    color: AppColors.primary,
                    fontSize: screenWidth * 0.06,
                    fontWeight: FontWeight.w700,
                  ),
                ),

                const SizedBox(height: 6),

                // 🔹 Total Manager & Employee
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                    color: AppColors.secondary,
                  ),
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    children: [
                      // buildInfoRow(
                      //   "Total Manager",
                      //   staffController.getTotalStaffModel.value.data![0].totalManager.toString(),
                      //   color: AppColors.background,
                      // ),
                      buildInfoRow(
                        "Total Employee",
                        staffController.getTotalStaffModel.value.data![0].totalEmployee.toString(),
                        color: AppColors.background,
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 8),

                // 🔹 Active/Inactive Details
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                    color: AppColors.primary,
                  ),
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    children: [
                      // buildInfoRow("Active Manager", "${staffController.getTotalStaffModel.value.data![0].activeManager}"),
                      // buildInfoRow("Inactive Manager", "${staffController.getTotalStaffModel.value.data![0].inactiveManager}"),
                      buildInfoRow("Active Employee", "${staffController.getTotalStaffModel.value.data![0].activeEmployee}"),
                      buildInfoRow("Inactive Employee", "${staffController.getTotalStaffModel.value.data![0].inactiveEmployee}"),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }




  Widget _buildFilterButtons(double screenWidth) {
    return Padding(
      padding: const EdgeInsets.all(1.0),
      child: Obx(() => Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          // _buildFilterButton(screenWidth, 'All Staff', '0'),
          // _buildFilterButton(screenWidth, 'Managers', '3'),
          _buildFilterButton(screenWidth, 'Employees', '4'),

        ],
      )),
    );
  }

  Widget _buildSearchBar(double screenWidth) {
    return Container(
      height: 60,
      width: screenWidth * 0.9,
      child: TextField(
        controller: searchController,
        onChanged: (value) {
          staffController.searchStaff(value);
        },
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.search, size: 30, color: AppColors.primary),
          hintText: 'Search Staff',
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: AppColors.primary, width: 1),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: AppColors.primary, width: 2),
          ),
        ),
      ),
    );
  }

  Widget _buildConditionalEmptyState(double screenWidth, double screenHeight) {
    // Check if this is "All Staff" tab and list is empty
    String currentFilter = staffController.selectedFilter.value;

    if (currentFilter == "All Staff") {
      // Show full empty state with add button
      return _buildEmptyState(screenWidth, screenHeight);
    } else {
      // Show simple message for specific tabs
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.people_outline,
              size: 80,
              color: AppColors.secondary,
            ),
            SizedBox(height: 20),
            Text(
              'No ${currentFilter} Found',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: AppColors.primary,
              ),
            ),
          ],
        ),
      );
    }
  }

  Widget _buildStaffList(double screenWidth, double screenHeight) {
    final staffList = staffController.staffListModel.value.data ?? [];

    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      itemCount: staffList.length,
      itemBuilder: (context, index) {
        final staff = staffList[index];
        final isInactive = staff.status == "0" || staff.status?.toLowerCase() == "in-active";

        return Container(
          margin: const EdgeInsets.symmetric(vertical:2, horizontal: 6),
          child: Card(
            color: isInactive ? Colors.grey[100] : AppColors.whitebg,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
              side: BorderSide(
                color: AppColors.secondary.withOpacity(0.2),
                width: 1,
              ),
            ),
            elevation: 0,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
              child: Row(
                children: [
                  // 🔹 Profile Avatar
                  Container(
                    width: 42,
                    height: 42,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: AppColors.secondary.withOpacity(0.3),
                        width: 1,
                      ),
                      image: DecorationImage(
                        image: AssetImage('assets/images/Circularavatar.png'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),

                  // 🔹 Staff Info
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 6),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            staff.role ?? "Role Not Available",
                            style: TextStyle(
                              color: isInactive
                                  ? Colors.grey
                                  : AppColors.primary,
                              fontWeight: FontWeight.w700,
                              fontSize: screenWidth * 0.035,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 4),
                          Text(
                            staff.name ?? "Name Not Available",
                            style: TextStyle(
                              color: isInactive
                                  ? Colors.grey
                                  : AppColors.secondary,
                              fontWeight: FontWeight.w700,
                              fontSize: screenWidth * 0.045,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  ),

                  // 🔹 Action Icons
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        onPressed: () {
                          // showModalBottomSheet(
                          //   context: context,
                          //   isScrollControlled: true,
                          //   shape: const RoundedRectangleBorder(
                          //     borderRadius: BorderRadius.vertical(
                          //       top: Radius.circular(16),
                          //     ),
                          //   ),
                          //   builder: (context) =>
                          //       // StaffDetails(staffId: staff.id.toString()),
                          //   NameDetailsScreen(),
                          // );
                        },
                        icon: SvgPicture.asset(
                          'assets/images/View.svg',
                          width: 28,
                          color:
                          isInactive ? Colors.grey : AppColors.secondary,
                        ),
                      ),
                      const SizedBox(width: 8),
                      IconButton(
                        onPressed: () {
                          showModalBottomSheet(
                            context: context,
                            isScrollControlled: true,
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.vertical(
                                top: Radius.circular(16),
                              ),
                            ),
                            builder: (context) =>
                                EditStaffOption(staffId: staff.id.toString()),
                          );
                        },
                        icon: SvgPicture.asset(
                          'assets/images/3dots.svg',
                          width: 28,
                          color:
                          isInactive ? Colors.grey : AppColors.secondary,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }


  Widget _buildAddStaffButton() {
    return Align(
      alignment: Alignment.bottomRight,
      child: Padding(
        padding: const EdgeInsets.only(right: 16.0, bottom: 16.0),
        child: GestureDetector(
          onTap: () {
            showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              backgroundColor: Colors.transparent, // 👈 Transparent background
              builder: (context) {
                return ClipRRect(
                  borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(24)), // 👈 Rounded top
                  child: Container(
                    color: Colors.white, // 👈 Bottom sheet background
                    child: Addstaff(), // 👈 Your Add Staff form widget
                  ),
                );
              },
            );
          },
          child: SvgPicture.asset(
            'assets/images/addicon 2.svg', // 👈 Your custom SVG icon
            width: 56,
            height: 56,
          ),
        ),
      ),
    );
  }

  Widget _buildDetailRow(String title, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(
            color: AppColors.background,
            fontSize: 12,
            fontWeight: FontWeight.w700,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            color: AppColors.background,
            fontSize: 12,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }

  Widget _buildButton(double screenWidth, String title, Color color) {
    return Container(
      height: 36,
      width: screenWidth * 0.25,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100),
        color: color,
      ),
      child: Center(
        child: Text(
          title,
          style: TextStyle(
            color: AppColors.whitebg,
            fontWeight: FontWeight.w600,
            fontSize: 16,
          ),
        ),
      ),
    );
  }

  Widget _buildFilterButton(double screenWidth, String title, String filterType) {
    bool isSelected = staffController.selectedFilter.value == title;

    return GestureDetector(
      onTap: () {
        staffController.updateStaffFilter(filterType, title);
        searchController.clear();
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        margin: const EdgeInsets.symmetric(horizontal: 2),
        padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 10),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primary : Colors.transparent,
          borderRadius: BorderRadius.circular(100),
          border: Border.all(
            color: isSelected ? Colors.transparent : AppColors.secondary,
            width: 0.8,
          ),
        ),
        alignment: Alignment.center,
        child: Text(
          title,
          style: TextStyle(
            color: isSelected ? AppColors.whitebg : AppColors.secondary,
            fontWeight: FontWeight.w600,
            fontSize: 14,
          ),
        ),
      ),
    );
  }


  Widget _buildEmptyState(double screenWidth, double screenHeight) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/images/Staff.png',
            width: screenWidth * 0.4,
            height: screenHeight * 0.2,
          ),
          SizedBox(height: 20),
          Text(
            'No Staff Found',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: AppColors.primary,
            ),
          ),
          SizedBox(height: 10),
          Text(
            'Start by adding your first staff member',
            style: TextStyle(
              fontSize: 16,
              color: AppColors.secondary,
            ),
          ),
          SizedBox(height: 30),
          ElevatedButton(
            onPressed: () {
              showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                ),
                builder: (context) {
                  return Addstaff();
                },
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              foregroundColor: Colors.white,
              padding: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.add),
                SizedBox(width: 8),
                Text(
                  'Add Staff',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
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
