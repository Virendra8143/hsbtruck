// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:get/get.dart';
// import 'package:petrolpump/Screens/Admin/Schemes/Gift/AddGift.dart';
// import '../../../Widgets/CommonHeader.dart';
// import '../../../Widgets/ManualScreen.dart';
// import '../../../Widgets/appbar/main_app_bar.dart';
// import '../../../controllers/AdminController/AddSchemeController.dart';
// import '../../../utils/colors.dart';
// import 'EditSchemeOption.dart';
// import '../../../Widgets/NotificationsScreen.dart';
//
// import 'SchemeDetails.dart';
//
// import 'AddSchemes.dart';
// import 'Filter.dart';
//
// class Scheme extends StatefulWidget {
//   const Scheme({super.key});
//
//   @override
//   State<Scheme> createState() => _SchemeState();
// }
//
// class _SchemeState extends State<Scheme> {
//   final AddSchemeController controller = Get.put(AddSchemeController());
//   final TextEditingController searchController = TextEditingController();
//
//   @override
//   void initState() {
//     super.initState();
//     controller.getSchemeList();
//   }
//
//   @override
//   void dispose() {
//     searchController.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final screenWidth = MediaQuery.of(context).size.width;
//     final screenHeight = MediaQuery.of(context).size.height;
//
//     return SafeArea(
//       child: Scaffold(
//         appBar: MainAppBar(
//           logoPath: 'assets/images/HSB.png',
//           showBack: true,
//           backgroundColor: AppColors.background,
//           iconColor: AppColors.text,
//           actions: [
//             AppBarActionItem(
//               imagePath: 'assets/svg_icons/notification.svg',
//               color: AppColors.secondary, // optional override
//               onTap: () {
//                 Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                         builder: (context) => NotificationsScreen()));
//               },
//             ),
//             AppBarActionItem(
//               imagePath: 'assets/svg_icons/appbar-settings.svg',
//               color: AppColors.secondary, // optional override
//               onTap: () {},
//             ),
//           ],
//         ),
//         body: Column(
//           children: [
//             // Fixed Header Section (Never shows loading)
//             Container(
//               color: Colors.white,
//               child: Padding(
//                 padding: const EdgeInsets.only(top: 10),
//                 child: Column(
//                   children: [
//
//                     // Header Row
//                     Padding(
//                       padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
//                       child: Row(
//                         children: [
//                           // 🟦 Left side (70%) — Text section
//                           Expanded(
//                             flex: 7,
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Text(
//                                   'Create or Add Schemes',
//                                   style: TextStyle(
//                                     fontWeight: FontWeight.w700,
//                                     fontSize: 24,
//                                     color: AppColors.primary,
//                                   ),
//                                 ),
//                                 const SizedBox(height: 4),
//                                 Text(
//                                   'Manage all the schemes and registered \nusers details.',
//                                   style: TextStyle(
//                                     fontWeight: FontWeight.w400,
//                                     fontSize: 14,
//                                     color: AppColors.alert,
//                                   ),
//                                 ),
//                                  SizedBox(height: 20,),
//                                  GestureDetector(
//                                     onTap: () {
//                                       showModalBottomSheet(
//                                         context: context,
//                                         isScrollControlled: true,
//                                         shape: const RoundedRectangleBorder(
//                                           borderRadius: BorderRadius.vertical(
//                                             top: Radius.circular(16),
//                                           ),
//                                         ),
//                                         builder: (context) => const AddGift(),
//                                       );
//                                     },
//                                     child: Container(
//
//                                       decoration: BoxDecoration(
//
//                                         borderRadius: BorderRadius.circular(12),
//
//                                       ),
//                                       child: SvgPicture.asset(
//                                         'assets/images/AddGift.svg',
//                                         width: 50,
//                                         height: 50,
//
//                                       ),
//                                     ),
//                                   ),
//                                 SizedBox(height: 10,),
//                                 Text(
//                                   'Add Gift',
//                                   style: TextStyle(
//                                     fontWeight: FontWeight.w400,
//                                     fontSize: 14,
//                                     color: AppColors.primary,
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//
//                           // 🟨 Right side (30%) — Icon button
//                           Align(
//                             alignment: Alignment.centerRight,
//                             child: SizedBox(
//                               width: 80, // ⬆️ force container size
//                               height: 80,
//                               child: IconButton(
//                                 onPressed: () {
//                                   showModalBottomSheet(
//                                     context: context,
//                                     isScrollControlled: true,
//                                     shape: const RoundedRectangleBorder(
//                                       borderRadius: BorderRadius.vertical(
//                                         top: Radius.circular(16),
//                                       ),
//                                     ),
//                                     builder: (context) => const AddSchemes(),
//                                   );
//                                 },
//                                 icon: SvgPicture.asset(
//                                   'assets/images/addicon 2.svg',
//                                   fit: BoxFit.contain, // 🔥 ensures scaling inside box
//                                 ),
//                               ),
//                             ),
//                           ),
//
//                         ],
//                       ),
//                     ),
//
//
//
//                     SizedBox(height: screenHeight * 0.02),
//                     // Search Bar and Filter
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       crossAxisAlignment: CrossAxisAlignment.center,
//                       children: [
//                         // 🔍 Search Bar (80%)
//                         Expanded(
//                           flex: 8, // 80%
//                           child: Padding(
//                             padding: const EdgeInsets.only(left: 20, right: 5),
//                             child: TextField(
//                               controller: searchController,
//                               onChanged: (value) {
//                                 controller.searchSchemes(value);
//                               },
//                               style: const TextStyle(height: 1.2), // helps center text vertically
//                               decoration: InputDecoration(
//                                 isDense: true, // reduces extra vertical padding
//                                 contentPadding: const EdgeInsets.symmetric(vertical: 14, horizontal: 12),
//                                 prefixIcon: Icon(
//                                   Icons.search_outlined,
//                                   size: 24,
//                                   color: AppColors.primary,
//                                 ),
//                                 labelText: "Search Schemes",
//                                 labelStyle: const TextStyle(fontSize: 16,color: AppColors.grey),
//                                 enabledBorder: OutlineInputBorder(
//                                   borderRadius: BorderRadius.circular(12),
//                                   borderSide: BorderSide(
//                                     color: AppColors.primary,
//                                     width: 1,
//                                   ),
//                                 ),
//                                 focusedBorder: OutlineInputBorder(
//                                   borderRadius: BorderRadius.circular(12),
//                                   borderSide: BorderSide(
//                                     color: AppColors.primary,
//                                     width: 2,
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ),
//
//                         // ⚙️ Filter Button (20%)
//                         Expanded(
//                           flex: 2, // 20%
//                           child: Center(
//                             child: GestureDetector(
//                               onTap: () {
//                                 showModalBottomSheet(
//                                   context: context,
//                                   isScrollControlled: true,
//                                   shape: const RoundedRectangleBorder(
//                                     borderRadius: BorderRadius.vertical(
//                                       top: Radius.circular(16),
//                                     ),
//                                   ),
//                                   builder: (context) => const Filter(),
//                                 );
//                               },
//                               child: Container(
//                                 width: 50,
//                                 height: 50,
//                                 decoration: BoxDecoration(
//                                   color: AppColors.primary,
//                                   borderRadius: BorderRadius.circular(12),
//                                   boxShadow: [
//                                     BoxShadow(
//                                       color: Colors.black.withOpacity(0.1),
//                                       blurRadius: 4,
//                                       offset: const Offset(0, 2),
//                                     ),
//                                   ],
//                                 ),
//                                 child: Center(
//                                   child: SvgPicture.asset(
//                                     'assets/images/Filter.svg',
//                                     width: 24,
//                                     height: 24,
//                                     colorFilter: const ColorFilter.mode(
//                                       Colors.white,
//                                       BlendMode.srcIn,
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//
//
//
//                     SizedBox(height: screenHeight * 0.02),
//                   ],
//                 ),
//               ),
//             ),
//
//             // Expandable List Section (Shows loading only for list)
//             Expanded(
//               child: Obx(() {
//                 if (controller.isSchemeListLoading.value) {
//                   return Center(
//                     child: CircularProgressIndicator(
//                       valueColor:
//                       AlwaysStoppedAnimation<Color>(AppColors.primary),
//                     ),
//                   );
//                 }
//
//                 final dataList = controller.getSchemeListModel.value.data ?? [];
//
//                 if (dataList.isEmpty) {
//                   return Center(
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         Icon(
//                           Icons.inbox_outlined,
//                           size: 64,
//                           color: AppColors.alert,
//                         ),
//                         SizedBox(height: 16),
//                         Text(
//                           'No schemes found',
//                           style: TextStyle(
//                             fontSize: 18,
//                             fontWeight: FontWeight.w500,
//                             color: AppColors.alert,
//                           ),
//                         ),
//                         if (searchController.text.isNotEmpty) ...[
//                           SizedBox(height: 8),
//                           Text(
//                             'Try adjusting your search',
//                             style: TextStyle(
//                               fontSize: 14,
//                               color: AppColors.alert,
//                             ),
//                           ),
//                         ],
//                       ],
//                     ),
//                   );
//                 }
//
//
//
//
//                 return ListView.builder(
//                   itemCount: dataList.length,
//                   padding: const EdgeInsets.symmetric(
//                       vertical: 8, horizontal: 16),
//                   itemBuilder: (context, index) {
//                     final item = dataList[index];
//                     final schemeId = item.id?.toString();
//                     final isActive = item.status == "1";
//                     final isInactive = item.status == "0";
//
//                     return Card(
//                       elevation: 0,
//                       margin: const EdgeInsets.symmetric(vertical: 8),
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(12),
//                         side: BorderSide(
//                           color: AppColors.secondary.withOpacity(0.3),
//                           width: 1,
//                         ),
//                       ),
//                       color: isInactive ? Colors.grey[100] : Colors.white,
//                       child: Padding(
//                         padding: const EdgeInsets.symmetric(
//                             horizontal: 16, vertical: 12),
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             // 🔹 Row 1 — Scheme name + icons
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: [
//                                 Expanded(
//                                   child: Text(
//                                     item.name ?? "No Scheme Name",
//                                     style: TextStyle(
//                                       color: isInactive
//                                           ? Colors.grey
//                                           : AppColors.primary,
//                                       fontSize: 16,
//                                       fontWeight: FontWeight.w700,
//                                     ),
//                                     overflow: TextOverflow.ellipsis,
//                                   ),
//                                 ),
//                                 Row(
//                                   children: [
//                                     IconButton(
//                                       padding: EdgeInsets.zero,
//                                       constraints: const BoxConstraints(),
//                                       icon: SvgPicture.asset(
//                                         'assets/images/View.svg',
//                                         width: 32,
//                                         colorFilter: ColorFilter.mode(
//                                           isInactive ? Colors.grey : AppColors
//                                               .secondary,
//                                           BlendMode.srcIn,
//                                         ),
//                                       ),
//                                       onPressed: () {
//                                         showModalBottomSheet(
//                                           context: context,
//                                           isScrollControlled: true,
//                                           shape: const RoundedRectangleBorder(
//                                             borderRadius: BorderRadius.vertical(
//                                               top: Radius.circular(16),
//                                             ),
//                                           ),
//                                           builder: (context) =>
//                                               SchemeDetails(
//                                                 schemeId: schemeId!,
//                                               ),
//                                         );
//                                       },
//                                     ),
//                                     const SizedBox(width: 20),
//                                     IconButton(
//                                       padding: EdgeInsets.zero,
//                                       constraints: const BoxConstraints(),
//                                       icon: SvgPicture.asset(
//                                         'assets/images/3dots.svg',
//                                         width: 30,
//                                         colorFilter: ColorFilter.mode(
//                                           isInactive ? Colors.grey : AppColors
//                                               .secondary,
//                                           BlendMode.srcIn,
//                                         ),
//                                       ),
//                                       onPressed: () {
//                                         showModalBottomSheet(
//                                           context: context,
//                                           isScrollControlled: true,
//                                           shape: const RoundedRectangleBorder(
//                                             borderRadius: BorderRadius.vertical(
//                                               top: Radius.circular(16),
//                                             ),
//                                           ),
//                                           builder: (context) =>
//                                               EditSchemeOption(
//                                                 schemeId: schemeId!,
//                                               ),
//                                         );
//                                       },
//                                     ),
//                                   ],
//                                 ),
//                               ],
//                             ),
//
//                             const SizedBox(height: 6),
//
//                             // 🔹 Row 2 — Vehicle Type + Icon
//                             Row(
//                               children: [
//                                 SvgPicture.asset(
//                                   'assets/images/Scheme2.svg',
//                                   width: 32,
//                                   colorFilter: ColorFilter.mode(
//                                     isInactive ? Colors.grey : AppColors
//                                         .secondary,
//                                     BlendMode.srcIn,
//                                   ),
//                                 ),
//                                 const SizedBox(width: 10),
//                                 Expanded(
//                                   child: Text(
//                                     item.vehicleType ?? "No Vehicle Type",
//                                     style: TextStyle(
//                                       color: isInactive
//                                           ? Colors.grey
//                                           : AppColors.secondary,
//                                       fontSize: 18,
//                                       fontWeight: FontWeight.w600,
//                                     ),
//                                     overflow: TextOverflow.ellipsis,
//                                   ),
//                                 ),
//                               ],
//                             ),
//
//                             const SizedBox(height: 6),
//
//                             // 🔹 Optional: Inactive tag
//                             if (isInactive)
//                               Container(
//                                 margin: const EdgeInsets.only(top: 4),
//                                 padding: const EdgeInsets.symmetric(
//                                     horizontal: 8, vertical: 2),
//                                 decoration: BoxDecoration(
//                                   color: Colors.grey[300],
//                                   borderRadius: BorderRadius.circular(4),
//                                 ),
//                                 child: Text(
//                                   'INACTIVE',
//                                   style: TextStyle(
//                                     color: Colors.grey[700],
//                                     fontSize: 10,
//                                     fontWeight: FontWeight.w600,
//                                   ),
//                                 ),
//                               ),
//                           ],
//                         ),
//                       ),
//                     );
//                   },
//                 );
//               }),
//   )
//
//
//           ],
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../Widgets/CustomAlertDialog.dart';
import '../../../Widgets/ManualScreen.dart';
import '../../../Widgets/appbar/main_app_bar.dart';
import '../../../controllers/AdminController/AddSchemeController.dart';
import '../../../controllers/AdminController/GiftController.dart';
import '../../../models/AdminModels/GiftModel.dart';
import '../../../utils/colors.dart';
import 'EditSchemeOption.dart';
import '../../../Widgets/NotificationsScreen.dart';
import 'Gift/AddGift.dart';
import 'SchemeDetails.dart';
import 'AddSchemes.dart';
import 'Filter.dart';

class Scheme extends StatefulWidget {
  const Scheme({super.key});

  @override
  State<Scheme> createState() => _SchemeState();
}

class _SchemeState extends State<Scheme> with SingleTickerProviderStateMixin {
  final AddSchemeController controller = Get.put(AddSchemeController());
  final GiftController giftController = Get.put(GiftController());
  final TextEditingController searchController = TextEditingController();

  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    controller.getSchemeList();
  }

  @override
  void dispose() {
    searchController.dispose();
    _tabController.dispose();
    super.dispose();
  }

  // Build option method for delete (similar to your scheme delete)
  Widget _buildOption({
    required BuildContext context,
    required String iconPath,
    required String title,
    required VoidCallback onTap,
    Color? iconColor,
  }) {
    return ListTile(
      leading: Image.asset(
        iconPath,
        width: 24,
        height: 24,
        color: iconColor,
      ),
      title: Text(
        title,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: Colors.black,
        ),
      ),
      onTap: onTap,
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return SafeArea(
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
                  MaterialPageRoute(builder: (context) => NotificationsScreen()),
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
        body: Column(
          children: [
            // Fixed Header Section (Never shows loading)
            Container(
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Column(
                  children: [
                    // Header Row
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                      child: Row(
                        children: [
                          // 🟦 Left side (70%) — Text section
                          Expanded(
                            flex: 7,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Create or Add Schemes',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 24,
                                    color: AppColors.primary,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  'Manage all the schemes and registered \nusers details.',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 14,
                                    color: AppColors.alert,
                                  ),
                                ),
                                // Original Add Gift Button - Always visible like before
                                SizedBox(height: 20,),
                                GestureDetector(
                                  onTap: () {
                                    giftController.prepareForAdd();
                                    showModalBottomSheet(
                                      context: context,
                                      isScrollControlled: true,
                                      shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.vertical(
                                          top: Radius.circular(16),
                                        ),
                                      ),
                                      builder: (context) => AddGift(),
                                    );
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: SvgPicture.asset(
                                      'assets/images/AddGift.svg',
                                      width: 50,
                                      height: 50,
                                    ),
                                  ),
                                ),
                                SizedBox(height: 10,),
                                Text(
                                  'Add Gift',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 14,
                                    color: AppColors.primary,
                                  ),
                                ),
                              ],
                            ),
                          ),

                          // 🟨 Right side (30%) — Icon button
                          Align(
                            alignment: Alignment.centerRight,
                            child: SizedBox(
                              width: 80, // ⬆️ force container size
                              height: 80,
                              child: IconButton(
                                onPressed: () {
                                  showModalBottomSheet(
                                    context: context,
                                    isScrollControlled: true,
                                    shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.vertical(
                                        top: Radius.circular(16),
                                      ),
                                    ),
                                    builder: (context) => const AddSchemes(),
                                  );
                                },
                                icon: SvgPicture.asset(
                                  'assets/images/addicon 2.svg',
                                  fit: BoxFit.contain, // 🔥 ensures scaling inside box
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: screenHeight * 0.02),

                    // Tabs - Added below the header
                    Container(
                      width: double.infinity,
                      child: TabBar(
                        controller: _tabController,
                        labelColor: AppColors.primary,
                        unselectedLabelColor: AppColors.grey,
                        indicatorColor: AppColors.primary,
                        indicatorWeight: 3,
                        tabs: [
                          Tab(text: 'Schemes'),
                          Tab(text: 'Gifts'),
                        ],
                      ),
                    ),

                    SizedBox(height: screenHeight * 0.02),

                    // Search Bar and Filter
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // 🔍 Search Bar (80%)
                        Expanded(
                          flex: 8, // 80%
                          child: Padding(
                            padding: const EdgeInsets.only(left: 20, right: 5),
                            child: TextField(
                              controller: searchController,
                              onChanged: (value) {
                                if (_tabController.index == 0) {
                                  controller.searchSchemes(value);
                                } else {
                                  giftController.onSearchChanged(value);
                                }
                              },
                              style: const TextStyle(height: 1.2), // helps center text vertically
                              decoration: InputDecoration(
                                isDense: true, // reduces extra vertical padding
                                contentPadding: const EdgeInsets.symmetric(vertical: 14, horizontal: 12),
                                prefixIcon: Icon(
                                  Icons.search_outlined,
                                  size: 24,
                                  color: AppColors.primary,
                                ),
                                labelText: _tabController.index == 0 ? "Search Schemes" : "Search Gifts",
                                labelStyle: const TextStyle(fontSize: 16,color: AppColors.grey),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: BorderSide(
                                    color: AppColors.primary,
                                    width: 1,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: BorderSide(
                                    color: AppColors.primary,
                                    width: 2,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),

                        // ⚙️ Filter Button (20%)
                        Expanded(
                          flex: 2, // 20%
                          child: Center(
                            child: GestureDetector(
                              onTap: () {
                                showModalBottomSheet(
                                  context: context,
                                  isScrollControlled: true,
                                  shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.vertical(
                                      top: Radius.circular(16),
                                    ),
                                  ),
                                  builder: (context) => const Filter(),
                                );
                              },
                              child: Container(
                                width: 50,
                                height: 50,
                                decoration: BoxDecoration(
                                  color: AppColors.primary,
                                  borderRadius: BorderRadius.circular(12),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.1),
                                      blurRadius: 4,
                                      offset: const Offset(0, 2),
                                    ),
                                  ],
                                ),
                                child: Center(
                                  child: SvgPicture.asset(
                                    'assets/images/Filter.svg',
                                    width: 24,
                                    height: 24,
                                    colorFilter: const ColorFilter.mode(
                                      Colors.white,
                                      BlendMode.srcIn,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: screenHeight * 0.02),
                  ],
                ),
              ),
            ),

            // Tab Content
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  // Schemes Tab
                  _buildSchemesTab(),

                  // Gifts Tab
                  _buildGiftsTab(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSchemesTab() {
    return Obx(() {
      if (controller.isSchemeListLoading.value) {
        return Center(
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(AppColors.primary),
          ),
        );
      }

      final dataList = controller.getSchemeListModel.value.data ?? [];

      if (dataList.isEmpty) {
        return _buildEmptyState('No schemes found', searchController.text.isNotEmpty);
      }

      return ListView.builder(
        itemCount: dataList.length,
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        itemBuilder: (context, index) {
          final item = dataList[index];
          final schemeId = item.id?.toString();
          final isActive = item.status == "1";
          final isInactive = item.status == "0";

          return Card(
            elevation: 0,
            margin: const EdgeInsets.symmetric(vertical: 8),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
              side: BorderSide(
                color: AppColors.secondary.withOpacity(0.3),
                width: 1,
              ),
            ),
            color: isInactive ? Colors.grey[100] : Colors.white,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 🔹 Row 1 — Scheme name + icons
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          item.name ?? "No Scheme Name",
                          style: TextStyle(
                            color: isInactive ? Colors.grey : AppColors.primary,
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Row(
                        children: [
                          IconButton(
                            padding: EdgeInsets.zero,
                            constraints: const BoxConstraints(),
                            icon: SvgPicture.asset(
                              'assets/images/View.svg',
                              width: 32,
                              colorFilter: ColorFilter.mode(
                                isInactive ? Colors.grey : AppColors.secondary,
                                BlendMode.srcIn,
                              ),
                            ),
                            onPressed: () {
                              showModalBottomSheet(
                                context: context,
                                isScrollControlled: true,
                                shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.vertical(
                                    top: Radius.circular(16),
                                  ),
                                ),
                                builder: (context) => SchemeDetails(schemeId: schemeId!),
                              );
                            },
                          ),
                          const SizedBox(width: 20),
                          IconButton(
                            padding: EdgeInsets.zero,
                            constraints: const BoxConstraints(),
                            icon: SvgPicture.asset(
                              'assets/images/3dots.svg',
                              width: 30,
                              colorFilter: ColorFilter.mode(
                                isInactive ? Colors.grey : AppColors.secondary,
                                BlendMode.srcIn,
                              ),
                            ),
                            onPressed: () {
                              showModalBottomSheet(
                                context: context,
                                isScrollControlled: true,
                                shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.vertical(
                                    top: Radius.circular(16),
                                  ),
                                ),
                                builder: (context) => EditSchemeOption(schemeId: schemeId!),
                              );
                            },
                          ),
                        ],
                      ),
                    ],
                  ),

                  const SizedBox(height: 6),

                  // 🔹 Row 2 — Vehicle Type + Icon
                  Row(
                    children: [
                      SvgPicture.asset(
                        'assets/images/Scheme2.svg',
                        width: 32,
                        colorFilter: ColorFilter.mode(
                          isInactive ? Colors.grey : AppColors.secondary,
                          BlendMode.srcIn,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          item.vehicleType ?? "No Vehicle Type",
                          style: TextStyle(
                            color: isInactive ? Colors.grey : AppColors.secondary,
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 6),

                  // 🔹 Optional: Inactive tag
                  if (isInactive)
                    Container(
                      margin: const EdgeInsets.only(top: 4),
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        'INACTIVE',
                        style: TextStyle(
                          color: Colors.grey[700],
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                ],
              ),
            ),
          );
        },
      );
    });
  }

  Widget _buildGiftsTab() {
    return Obx(() {
      if (giftController.isLoading.value) {
        return Center(
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(AppColors.primary),
          ),
        );
      }

      final gifts = giftController.gifts;

      if (gifts.isEmpty) {
        return _buildEmptyState('No gifts found', searchController.text.isNotEmpty);
      }

      return ListView.builder(
        itemCount: gifts.length,
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        itemBuilder: (context, index) {
          final gift = gifts[index];
          final isActive = gift.status == "1";
          final isInactive = gift.status == "0";

          return Card(
            elevation: 0,
            margin: const EdgeInsets.symmetric(vertical: 8),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
              side: BorderSide(
                color: AppColors.secondary.withOpacity(0.3),
                width: 1,
              ),
            ),
            color: isInactive ? Colors.grey[100] : Colors.white,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Row 1 — Gift name + icons
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          gift.name ?? "No Gift Name",
                          style: TextStyle(
                            color: isInactive ? Colors.grey : AppColors.primary,
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Row(
                        children: [
                          // Edit Icon
                          // IconButton(
                          //   padding: EdgeInsets.zero,
                          //   constraints: const BoxConstraints(),
                          //   icon: SvgPicture.asset(
                          //     'assets/images/edit.svg',
                          //     width: 24,
                          //     colorFilter: ColorFilter.mode(
                          //       isInactive ? Colors.grey : AppColors.secondary,
                          //       BlendMode.srcIn,
                          //     ),
                          //   ),
                          //   onPressed: () {
                          //     giftController.prepareForEdit(gift.id!);
                          //     showModalBottomSheet(
                          //       context: context,
                          //       isScrollControlled: true,
                          //       shape: const RoundedRectangleBorder(
                          //         borderRadius: BorderRadius.vertical(
                          //           top: Radius.circular(16),
                          //         ),
                          //       ),
                          //       builder: (context) => AddGift(),
                          //     );
                          //   },
                          // ),
                          const SizedBox(width: 10),
                          // Options Icon (with delete option)
                          IconButton(
                            padding: EdgeInsets.zero,
                            constraints: const BoxConstraints(),
                            icon: SvgPicture.asset(
                              'assets/images/3dots.svg',
                              width: 30,
                              colorFilter: ColorFilter.mode(
                                isInactive ? Colors.grey : AppColors.secondary,
                                BlendMode.srcIn,
                              ),
                            ),
                            onPressed: () {
                              _showGiftOptionsBottomSheet(context, gift);
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  // Row 2 — Gift Type + Quantity
                  Row(
                    children: [
                      SvgPicture.asset(
                        'assets/images/gift.svg',
                        width: 24,
                        colorFilter: ColorFilter.mode(
                          isInactive ? Colors.grey : AppColors.secondary,
                          BlendMode.srcIn,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          '${giftController.getGiftTypeDisplayName(gift.type)} • Qty: ${gift.quantity ?? "0"}',
                          style: TextStyle(
                            color: isInactive ? Colors.grey : AppColors.secondary,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  // Status and Inactive tag
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: giftController.getStatusColor(gift.status),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          giftController.getStatusDisplayText(gift.status),
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      if (isInactive) ...[
                        const SizedBox(width: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                          decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            'INACTIVE',
                            style: TextStyle(
                              color: Colors.grey[700],
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      );
    });
  }

  void _showGiftOptionsBottomSheet(BuildContext context, GiftData gift) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(16),
        ),
      ),
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Status Toggle Option
              // _buildOption(
              //   context: context,
              //   iconPath: gift.status == "1"
              //       ? 'assets/images/disableicon.png'
              //       : 'assets/images/enableicon.png',
              //   title: gift.status == "1" ? "Deactivate Gift" : "Activate Gift",
              //   onTap: () {
              //     Navigator.pop(context);
              //     if (gift.status == "1") {
              //       giftController.deactivateGift(gift.id!);
              //     } else {
              //       giftController.activateGift(gift.id!);
              //     }
              //   },
              // ),
              const Divider(),
              // Delete Option
              _buildOption(
                context: context,
                iconPath: 'assets/images/deleteicon.png',
                title: "Delete Permanently",
                iconColor: Colors.red,
                onTap: () {
                  Navigator.pop(context);
                  _showDeleteConfirmationDialog(context, gift);
                },
              ),
              const SizedBox(height: 16),
              // Cancel Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    'Cancel',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _showDeleteConfirmationDialog(BuildContext context, GiftData gift) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return CustomAlertDialog(
          title: 'Permanent Deletion Warning',
          message: "Deleting this gift will permanently remove all associated data from the database, "
              "including its details, as well as any configurations or activities linked to this gift. "
              "This action is irreversible.",
          iconAsset: 'assets/images/Delete.svg',
          iconBackgroundColor: Colors.red,
          onConfirm: () {
            Navigator.pop(context);
            giftController.deleteGiftPermanently(gift.id!);
          },
        );
      },
    );
  }

  Widget _buildEmptyState(String message, bool isSearching) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.inbox_outlined,
            size: 64,
            color: AppColors.alert,
          ),
          SizedBox(height: 16),
          Text(
            message,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: AppColors.alert,
            ),
          ),
          if (isSearching) ...[
            SizedBox(height: 8),
            Text(
              'Try adjusting your search',
              style: TextStyle(
                fontSize: 14,
                color: AppColors.alert,
              ),
            ),
          ],
        ],
      ),
    );
  }
}