// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:get/get.dart';
// import '../../../controllers/AdminController/TankerController.dart';
// import '../../../utils/colors.dart';
// import '../../../Widgets/ManualScreen.dart';
// import '../Machine/EditingOption2.dart';
// import 'AddCrewMember.dart';
// import 'CreateTanker.dart';
// import 'TankerCrewDetails.dart';
// // Add your controller import
//
// class Tanker extends StatefulWidget {
//   const Tanker({super.key});
//
//   @override
//   State<Tanker> createState() => _TankerState();
// }
//
// class _TankerState extends State<Tanker> {
//   final TankerController tankerController = Get.put(TankerController());
//   final TextEditingController searchController = TextEditingController();
//   String selectedFilter = 'All';
//
//   @override
//   void initState() {
//     super.initState();
//     // Initialize data loading
//     tankerController.refreshAllData();
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
//         body: Container(
//           child: Column(
//             children: [
//               SizedBox(height: screenHeight * 0.08),
//               // Header Row
//               Row(
//                 children: [
//                   Padding(
//                     padding: const EdgeInsets.only(left: 10),
//                     child: GestureDetector(
//                       onTap: () {
//                         Get.back();
//                       },
//                       child: Image.asset('assets/images/back.png', fit: BoxFit.fitHeight),
//                     ),
//                   ),
//                   SizedBox(width: screenWidth * 0.3),
//                   Image.asset(
//                     'assets/images/Notification.png',
//                     width: screenWidth * 0.25,
//                     height: screenHeight * 0.06,
//                   ),
//                   GestureDetector(
//                     onTap: () {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(builder: (context) => ManualScreen()),
//                       );
//                     },
//                     child: Image.asset(
//                       'assets/images/drawer.png',
//                       width: 30,
//                       height: 45,
//                     ),
//                   ),
//                 ],
//               ),
//               SizedBox(height: 20),
//               // Tanker Details Section
//               Padding(
//                 padding: const EdgeInsets.only(left: 20),
//                 child: Row(
//                   children: [
//                     Container(
//                       height: screenHeight * 0.2,
//                       width: screenWidth * 0.45,
//                       child: SvgPicture.asset('assets/images/Tanker2.svg', fit: BoxFit.none),
//                     ),
//                     SizedBox(width: 10),
//                     Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           "Tanker Details",
//                           style: TextStyle(
//                             color: AppColors.primary,
//                             fontSize: 24,
//                             fontWeight: FontWeight.w700,
//                           ),
//                         ),
//                         // Total Tanker Count with Loading
//                         Obx(() => Container(
//                           decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(4),
//                             color: AppColors.secondary,
//                           ),
//                           height: 43,
//                           width: screenWidth * 0.4,
//                           child: Padding(
//                             padding: const EdgeInsets.all(8.0),
//                             child: Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: [
//                                 Text(
//                                   "Total Tanker",
//                                   style: TextStyle(
//                                     color: AppColors.background,
//                                     fontSize: 12,
//                                     fontWeight: FontWeight.w700,
//                                   ),
//                                 ),
//                                 tankerController.isCountLoading.value
//                                     ? SizedBox(
//                                   width: 16,
//                                   height: 16,
//                                   child: CircularProgressIndicator(
//                                     strokeWidth: 2,
//                                     valueColor: AlwaysStoppedAnimation<Color>(AppColors.background),
//                                   ),
//                                 )
//                                     : Text(
//                                   "${tankerController.tankerCountModel.value.totalTankers ?? 0}",
//                                   style: TextStyle(
//                                     color: AppColors.background,
//                                     fontSize: 12,
//                                     fontWeight: FontWeight.w700,
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         )),
//                         SizedBox(height: 5),
//                         // Tanker Type Breakdown with Loading
//                         Obx(() => Container(
//                           decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(4),
//                             color: AppColors.primary,
//                           ),
//                           height: 76,
//                           width: screenWidth * 0.4,
//                           child: Padding(
//                             padding: const EdgeInsets.all(8.0),
//                             child: tankerController.isCountLoading.value
//                                 ? Center(
//                               child: CircularProgressIndicator(
//                                 strokeWidth: 2,
//                                 valueColor: AlwaysStoppedAnimation<Color>(AppColors.background),
//                               ),
//                             )
//                                 : Column(
//                               children: [
//                                 buildRowDetail("Petrol", "${tankerController.tankerCountModel.value.petrolTankers ?? 0}"),
//                                 buildRowDetail("Diesel", "${tankerController.tankerCountModel.value.abcTankers ?? 0}"),
//                                 buildRowDetail("Power", "0"), // Add power tankers to your model if needed
//                               ],
//                             ),
//                           ),
//                         )),
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//               SizedBox(height: 20),
//               // Filter Buttons
//               SingleChildScrollView(
//                 scrollDirection: Axis.horizontal,
//                 child: Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: Row(
//                     children: [
//                       buildFilterButton('All', selectedFilter == 'All' ? AppColors.primary : AppColors.secondary, '0'),
//                       SizedBox(width: 10),
//                       buildFilterButton('Petrol', selectedFilter == 'Petrol' ? AppColors.primary : AppColors.secondary, '1'),
//                       SizedBox(width: 10),
//                       buildFilterButton('Power', selectedFilter == 'Power' ? AppColors.primary : AppColors.secondary, '2'),
//                       SizedBox(width: 10),
//                       buildFilterButton('Diesel', selectedFilter == 'Diesel' ? AppColors.primary : AppColors.secondary, '3'),
//                     ],
//                   ),
//                 ),
//               ),
//               SizedBox(height: 20),
//               // Search Field
//               Container(
//                 height: 60,
//                 width: screenWidth * 0.9,
//                 child: TextField(
//                   controller: searchController,
//                   onChanged: (value) {
//                     // Implement debounced search
//                     tankerController.searchTankers(value);
//                   },
//                   decoration: InputDecoration(
//                     prefixIcon: Icon(Icons.search, size: 30, color: AppColors.primary),
//                     hintText: 'Search Tanker',
//                     enabledBorder: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(12),
//                       borderSide: BorderSide(color: AppColors.primary, width: 1),
//                     ),
//                     focusedBorder: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(12),
//                       borderSide: BorderSide(color: AppColors.primary, width: 2),
//                     ),
//                   ),
//                 ),
//               ),
//               SizedBox(height: 10),
//               // Tanker List with Loading
//               Expanded(
//                 child: Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: Obx(() {
//                     if (tankerController.isLoading.value) {
//                       return Center(
//                         child: CircularProgressIndicator(
//                           valueColor: AlwaysStoppedAnimation<Color>(AppColors.primary),
//                         ),
//                       );
//                     }
//
//                     if (tankerController.tankers.isEmpty) {
//                       return Center(
//                         child: Column(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             Icon(
//                               Icons.local_shipping,
//                               size: 64,
//                               color: AppColors.primary.withOpacity(0.5),
//                             ),
//                             SizedBox(height: 16),
//                             Text(
//                               'No tankers found',
//                               style: TextStyle(
//                                 fontSize: 18,
//                                 color: AppColors.primary,
//                                 fontWeight: FontWeight.w600,
//                               ),
//                             ),
//                             SizedBox(height: 8),
//                             Text(
//                               'Try adjusting your search or filter',
//                               style: TextStyle(
//                                 fontSize: 14,
//                                 color: AppColors.primary.withOpacity(0.7),
//                               ),
//                             ),
//                           ],
//                         ),
//                       );
//                     }
//
//                     return RefreshIndicator(
//                       onRefresh: () async {
//                         tankerController.refreshAllData();
//                       },
//                       child: ListView.builder(
//                         itemCount: tankerController.tankers.length,
//                         itemBuilder: (context, index) {
//                           final tanker = tankerController.tankers[index];
//                           return Container(
//                             margin: EdgeInsets.only(bottom: 8),
//                             height: 94,
//                             width: screenWidth * 0.9,
//                             child: Card(
//                               color: AppColors.whitebg,
//                               elevation: 2,
//                               shape: RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.circular(10),
//                               ),
//                               child: ListTile(
//                                 title: Padding(
//                                   padding: const EdgeInsets.only(top: 10),
//                                   child: Column(
//                                     crossAxisAlignment: CrossAxisAlignment.start,
//                                     children: [
//                                       Text(
//                                         tanker.tankerType ?? 'Unknown Type',
//                                         style: TextStyle(
//                                           color: AppColors.primary,
//                                           fontWeight: FontWeight.w700,
//                                           fontSize: 14,
//                                         ),
//                                       ),
//                                       Text(
//                                         tanker.registrationNumber ?? 'No Registration',
//                                         style: TextStyle(
//                                           color: AppColors.secondary,
//                                           fontWeight: FontWeight.w700,
//                                           fontSize: 20,
//                                         ),
//                                       ),
//                                       if (tanker.status != null)
//                                         Container(
//                                           padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
//                                           decoration: BoxDecoration(
//                                             color: tanker.status == 'Active' ? Colors.green : Colors.orange,
//                                             borderRadius: BorderRadius.circular(4),
//                                           ),
//                                           child: Text(
//                                             tanker.status!,
//                                             style: TextStyle(
//                                               color: Colors.white,
//                                               fontSize: 10,
//                                               fontWeight: FontWeight.w600,
//                                             ),
//                                           ),
//                                         ),
//                                     ],
//                                   ),
//                                 ),
//                                 // trailing: buildListTileTrailing(context, tanker),
//                               ),
//                             ),
//                           );
//                         },
//                       ),
//                     );
//                   }),
//                 ),
//               ),
//               // Add Button
//               Padding(
//                 padding: EdgeInsets.only(left: screenWidth * 0.85, bottom: 10),
//                 child: IconButton(
//                   onPressed: () {
//                     showModalBottomSheet(
//                       context: context,
//                       isScrollControlled: true,
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
//                       ),
//                       builder: (context) {
//                         return CreateTanker();
//                       },
//                     ).then((_) {
//                       // Refresh data after adding new tanker
//                       tankerController.refreshAllData();
//                     });
//                   },
//                   icon: Image.asset('assets/images/Deletemessage.png', fit: BoxFit.fitHeight),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget buildRowDetail(String title, String count) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//         Text(
//           title,
//           style: TextStyle(
//             color: AppColors.background,
//             fontSize: 12,
//             fontWeight: FontWeight.w700,
//           ),
//         ),
//         Text(
//           count,
//           style: TextStyle(
//             color: AppColors.background,
//             fontSize: 12,
//             fontWeight: FontWeight.w700,
//           ),
//         ),
//       ],
//     );
//   }
//
//   Widget buildFilterButton(String title, Color color, String typeValue) {
//     return GestureDetector(
//       onTap: () {
//         setState(() {
//           selectedFilter = title;
//         });
//         tankerController.getTankersByType(typeValue);
//       },
//       child: Container(
//         height: 36,
//         width: 96,
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(100),
//           color: color,
//         ),
//         child: Center(
//           child: Text(
//             title,
//             style: TextStyle(
//               color: AppColors.whitebg,
//               fontWeight: FontWeight.w600,
//               fontSize: 16,
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
//   // Widget buildListTileTrailing(BuildContext context, TankerData tanker) {
//   //   return Row(
//   //     mainAxisSize: MainAxisSize.min,
//   //     children: [
//   //       IconButton(
//   //         onPressed: () {
//   //           showModalBottomSheet(
//   //             context: context,
//   //             isScrollControlled: true,
//   //             shape: RoundedRectangleBorder(
//   //               borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
//   //             ),
//   //             builder: (context) {
//   //               return AddCrewMember(tankerId: tanker.id);
//   //             },
//   //           ).then((_) {
//   //             // Refresh data after adding crew member
//   //             tankerController.refreshAllData();
//   //           });
//   //         },
//   //         icon: SvgPicture.asset('assets/images/Tanker1.svg'),
//   //       ),
//   //       SizedBox(width: 10),
//   //       // IconButton(
//   //       //   onPressed: () {
//   //       //     if (tanker.id != null) {
//   //       //       tankerController.getTankerDetail(tanker.id!);
//   //       //     }
//   //       //     showModalBottomSheet(
//   //       //       context: context,
//   //       //       isScrollControlled: true,
//   //       //       shape: RoundedRectangleBorder(
//   //       //         borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
//   //       //       ),
//   //       //       builder: (context) {
//   //       //         return TankerCrewDetails(tankerId: tanker.id);
//   //       //       },
//   //       //     );
//   //       //   },
//   //       //   icon: Image.asset('assets/images/View.png'),
//   //       // ),
//   //       // SizedBox(width: 10),
//   //       // IconButton(
//   //       //   onPressed: () {
//   //       //     showModalBottomSheet(
//   //       //       context: context,
//   //       //       isScrollControlled: true,
//   //       //       shape: RoundedRectangleBorder(
//   //       //         borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
//   //       //       ),
//   //       //       builder: (context) {
//   //       //         return EditingOption2(tankerData: tanker);
//   //       //       },
//   //       //     ).then((_) {
//   //       //       // Refresh data after editing
//   //       //       tankerController.refreshAllData();
//   //       //     });
//   //       //   },
//   //       //   icon: Image.asset('assets/images/Vector.png'),
//   //       // ),
//   //     ],
//   //   );
//   // }
// }
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';


import '../../../Widgets/CommonHeader.dart';
import '../../../Widgets/appbar/main_app_bar.dart';
import '../../../controllers/AdminController/TankerController.dart';
import '../../../utils/colors.dart';
import '../../../Widgets/ManualScreen.dart';
import '../../../Widgets/NotificationsScreen.dart';
import 'AddCrewMember.dart';
import 'CreateTanker.dart';
import 'EditTankerOption.dart';
import 'TankerDetails.dart';

class Tanker extends StatefulWidget {
  const Tanker({super.key});

  @override
  State<Tanker> createState() => _TankerState();
}

class _TankerState extends State<Tanker> {
  final TankerController tankerController = Get.put(TankerController());
  final TextEditingController searchController = TextEditingController();
  String selectedFilter = 'All';

  @override
  void initState() {
    super.initState();
    tankerController.refreshAllData();
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
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
        body: Column(
          children: [

            /// ✅ Fixed Header Row

            /// Tanker Details Section
        Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Flexible(
              flex: 1,
              child: Container(
                height: screenHeight * 0.2,
                width: screenWidth * 0.45,
                child: SvgPicture.asset(
                  'assets/images/Tanker2.svg',
                  fit: BoxFit.none,
                ),
              ),
            ),
            SizedBox(width: 10),
            Flexible(
              flex: 1,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Tanker Details",
                    style: TextStyle(
                      color: AppColors.primary,
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Obx(() => Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      color: AppColors.secondary,
                    ),
                    height: 43,
                    width: double.infinity, // ✅ takes available space
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Total Tanker",
                            style: TextStyle(
                              color: AppColors.background,
                              fontSize: 12,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          tankerController.isCountLoading.value
                              ? SizedBox(
                            width: 16,
                            height: 16,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              valueColor: AlwaysStoppedAnimation<Color>(
                                  AppColors.background),
                            ),
                          )
                              : Text(
                            "${tankerController.tankerCountModel.value.totalTankers ?? 0}",
                            style: TextStyle(
                              color: AppColors.background,
                              fontSize: 12,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                    ),
                  )),
                  SizedBox(height: 5),
                  Obx(() => Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      color: AppColors.primary,
                    ),
                    height: 76,
                    width: double.infinity, // ✅ responsive width
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: tankerController.isCountLoading.value
                          ? Center(
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          valueColor: AlwaysStoppedAnimation<Color>(
                              AppColors.background),
                        ),
                      )
                          : Column(
                        children: [
                          buildRowDetail(
                              "Petrol",
                              "${tankerController.tankerCountModel.value.petrolTankers ?? 0}"),
                          buildRowDetail(
                              "Diesel",
                              "${tankerController.tankerCountModel.value.abcTankers ?? 0}"),
                          buildRowDetail("Power", "0"),
                        ],
                      ),
                    ),
                  )),
                ],
              ),
            ),
          ],
        ),
      ),


        SizedBox(height: 20),

            /// Filter Buttons
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    buildFilterButton('All', selectedFilter == 'All' ? AppColors.primary : AppColors.secondary, '0'),
                    SizedBox(width: 10),
                    buildFilterButton('Petrol', selectedFilter == 'Petrol' ? AppColors.primary : AppColors.secondary, '1'),
                    SizedBox(width: 10),
                    buildFilterButton('Power', selectedFilter == 'Power' ? AppColors.primary : AppColors.secondary, '2'),
                    SizedBox(width: 10),
                    buildFilterButton('Diesel', selectedFilter == 'Diesel' ? AppColors.primary : AppColors.secondary, '3'),
                  ],
                ),
              ),
            ),

            SizedBox(height: 20),

            /// Search Field
            Container(
              height: 60,
              width: screenWidth * 0.9,
              child: TextField(
                controller: searchController,
                onChanged: (value) {
                  tankerController.searchTankers(value);
                },
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.search, size: 30, color: AppColors.primary),
                  hintText: 'Search Tanker',
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
            ),

            SizedBox(height: 10),

            /// Tanker List
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Obx(() {
                  if (tankerController.isLoading.value) {
                    return Center(
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(AppColors.primary),
                      ),
                    );
                  }

                  if (tankerController.tankers.isEmpty) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.local_shipping,
                            size: 64,
                            color: AppColors.primary.withOpacity(0.5),
                          ),
                          SizedBox(height: 16),
                          Text(
                            'No tankers found',
                            style: TextStyle(
                              fontSize: 18,
                              color: AppColors.primary,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            'Try adjusting your search or filter',
                            style: TextStyle(
                              fontSize: 14,
                              color: AppColors.primary.withOpacity(0.7),
                            ),
                          ),
                        ],
                      ),
                    );
                  }

                  return RefreshIndicator(
                    onRefresh: () async {
                      tankerController.refreshAllData();
                    },
                    child: ListView.builder(
                      itemCount: tankerController.tankers.length,
                      itemBuilder: (context, index) {
                        final tanker = tankerController.tankers[index];
                        final isInactive = tanker.status == "0";
                        final isActive = tanker.status == "1";

                        // return Card(
                        //   elevation: 0,
                        //   margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                        //   shape: RoundedRectangleBorder(
                        //     borderRadius: BorderRadius.circular(12),
                        //     side: BorderSide(
                        //       color: AppColors.secondary.withOpacity(0.3),
                        //       width: 1,
                        //     ),
                        //   ),
                        //   color: isInactive ? Colors.grey[100] : AppColors.whitebg,
                        //   child: Padding(
                        //     padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                        //     child: Column(
                        //       crossAxisAlignment: CrossAxisAlignment.start,
                        //       children: [
                        //         // 🔹 Row 1 — Tanker ID + Icons
                        //         Row(
                        //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //           children: [
                        //             Text(
                        //               'ID: ${tanker.id ?? 'N/A'}',
                        //               style: TextStyle(
                        //                 color: isInactive ? Colors.grey : AppColors.primary,
                        //                 fontSize: 14,
                        //                 fontWeight: FontWeight.w600,
                        //               ),
                        //             ),
                        //             Row(
                        //               children: [
                        //                 IconButton(
                        //                   onPressed: () {
                        //                     showModalBottomSheet(
                        //                       context: context,
                        //                       isScrollControlled: true,
                        //                       shape: RoundedRectangleBorder(
                        //                         borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                        //                       ),
                        //                       builder: (context) {
                        //                         return AddCrewMember();
                        //                       },
                        //                     );
                        //                   },
                        //                   icon: SvgPicture.asset('assets/images/Tanker1.svg'),
                        //
                        //                   // overflow: TextOverflow.ellipsis,
                        //                 ),
                        //                 const SizedBox(width: 20),
                        //                 IconButton(
                        //                   padding: EdgeInsets.zero,
                        //                   constraints: const BoxConstraints(),
                        //                   icon: SvgPicture.asset(
                        //                     'assets/images/View.svg',
                        //                     width: 34,
                        //                     color: isInactive ? Colors.grey : AppColors.secondary,
                        //                   ),
                        //                   onPressed: () {
                        //                     showModalBottomSheet(
                        //                       context: context,
                        //                       isScrollControlled: true,
                        //                       shape: const RoundedRectangleBorder(
                        //                         borderRadius:
                        //                         BorderRadius.vertical(top: Radius.circular(16)),
                        //                       ),
                        //                       builder: (context) {
                        //                         return TankerDetails(
                        //                           tankerId: tanker.id.toString(),
                        //                         );
                        //                       },
                        //                     );
                        //                   },
                        //                 ),
                        //                 const SizedBox(width: 20),
                        //                 IconButton(
                        //                   onPressed: () {
                        //                     showModalBottomSheet(
                        //                       context: context,
                        //                       isScrollControlled: true,
                        //                       shape: RoundedRectangleBorder(
                        //                         borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                        //                       ),
                        //                       builder: (context) => EditTankerOption(tankerId: tanker.id.toString(), currentStatus: '',),
                        //                     ).then((_) {
                        //                       tankerController.refreshAllData();
                        //                     });
                        //                   },
                        //                   icon: SvgPicture.asset('assets/images/3dots.svg'),
                        //
                        //                   // overflow: TextOverflow.ellipsis,
                        //                 ),
                        //               ],
                        //             ),
                        //           ],
                        //         ),
                        //
                        //         const SizedBox(height: 6),
                        //
                        //         // 🔹 Row 2 — Tanker Type
                        //         Text(
                        //           tanker.tankerType ?? 'Unknown Type',
                        //           style: TextStyle(
                        //             color: isInactive ? Colors.grey : AppColors.secondary,
                        //             fontSize: 18,
                        //             fontWeight: FontWeight.w700,
                        //           ),),
                        //
                        //           SizedBox(width: 10),
                        //
                        //         const SizedBox(height: 6),
                        //
                        //         // 🔹 Row 3 — Capacity or Other Info (Optional)
                        //         if ( tanker.capacity != null && tanker.capacity!.isNotEmpty)
                        //           Text(
                        //             'Capacity: ${tanker.capacity} KL',
                        //             style: TextStyle(
                        //               color: isInactive ? Colors.grey : AppColors.icon,
                        //               fontSize: 12,
                        //             ),
                        //           ),
                        //
                        //         // 🔹 Inactive Label
                        //         if (isInactive) ...[
                        //           const SizedBox(height: 6),
                        //           Container(
                        //             padding:
                        //             const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                        //             decoration: BoxDecoration(
                        //               color: Colors.grey[300],
                        //               borderRadius: BorderRadius.circular(4),
                        //             ),
                        //             child: Text(
                        //               'INACTIVE',
                        //               style: TextStyle(
                        //                 color: Colors.grey[700],
                        //                 fontSize: 10,
                        //                 fontWeight: FontWeight.w600,
                        //               ),
                        //             ),
                        //
                        //           ),
                        //         ],
                        //       ],
                        //     ),
                        //   ),
                        // );
                        // In your tanker list item builder
                        return Card(
                          elevation: 0,
                          margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                            side: BorderSide(
                              color: AppColors.secondary.withOpacity(0.3),
                              width: 1,
                            ),
                          ),
                          // ✅ Grey background for inactive, normal for active
                          color: tanker.status == "0" ? Colors.grey[100] : AppColors.whitebg,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'ID: ${tanker.id ?? 'N/A'}',
                                      style: TextStyle(
                                        // ✅ Grey text for inactive
                                        color: tanker.status == "0" ? Colors.grey : AppColors.primary,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        // In your tanker list item builder, update the AddCrewMember call:
                                        IconButton(
                                          onPressed: () {
                                            showModalBottomSheet(
                                              context: context,
                                              isScrollControlled: true,
                                              builder: (context) {
                                                return AddCrewMember(tankerId: tanker.id.toString()); // Pass tanker ID
                                              },
                                            );
                                          },
                                          icon: SvgPicture.asset('assets/images/Tanker1.svg'),
                                        ),
                                        // IconButton(
                                        //   onPressed: () {
                                        //     showModalBottomSheet(
                                        //       context: context,
                                        //       isScrollControlled: true,
                                        //       builder: (context) {
                                        //         return AddCrewMember();
                                        //       },
                                        //     );
                                        //   },
                                        //   icon: SvgPicture.asset('assets/images/Tanker1.svg'),
                                        // ),
                                        const SizedBox(width: 20),
                                        IconButton(
                                          icon: SvgPicture.asset(
                                            'assets/images/View.svg',
                                            width: 34,
                                            // ✅ Grey icon for inactive
                                            color: tanker.status == "0" ? Colors.grey : AppColors.secondary,
                                          ),
                                          onPressed: () {
                                            showModalBottomSheet(
                                              context: context,
                                              isScrollControlled: true,
                                              builder: (context) {
                                                return TankerDetails(
                                                  tankerId: tanker.id.toString(),
                                                );
                                              },
                                            );
                                          },
                                        ),
                                        const SizedBox(width: 20),
                                        IconButton(
                                          onPressed: () {
                                            showModalBottomSheet(
                                              context: context,
                                              isScrollControlled: true,
                                              builder: (context) => EditTankerOption(
                                                tankerId: tanker.id.toString(),
                                                currentStatus: tanker.status ?? "0", // Pass current status
                                              ),
                                            ).then((_) {
                                              tankerController.refreshAllData(); // Refresh after status change
                                            });
                                          },
                                          icon: SvgPicture.asset('assets/images/3dots.svg'),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),

                                const SizedBox(height: 6),

                                Text(
                                  tanker.registrationNumber ?? 'Unknown Type',
                                  style: TextStyle(
                                    // ✅ Grey text for inactive
                                    color: tanker.status == "0" ? Colors.grey : AppColors.secondary,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),

                                const SizedBox(height: 6),

                                if (tanker.capacity != null && tanker.capacity!.isNotEmpty)
                                  Text(
                                    'Capacity: ${tanker.capacity} KL',
                                    style: TextStyle(
                                      // ✅ Grey text for inactive
                                      color: tanker.status == "0" ? Colors.grey : AppColors.icon,
                                      fontSize: 12,
                                    ),
                                  ),

                                // ✅ Show inactive badge
                                if (tanker.status == "0") ...[
                                  const SizedBox(height: 6),
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
                          ),
                        );
                      },
                    ),
                  );

                }),
              ),
            ),

            /// Add Button

          ],
        ),

        floatingActionButton: GestureDetector(
          onTap: () {
            showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
              ),
              builder: (context) {
                return CreateTanker(); // 👈 your bottom sheet content
              },
            ).then((_) {
              tankerController.refreshAllData(); // 👈 refresh after closing
            });
          },
          child: SvgPicture.asset(
            'assets/images/addicon 2.svg', // 👈 your icon
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,


      ),
    );
  }

  Widget buildRowDetail(String title, String count) {
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
          count,
          style: TextStyle(
            color: AppColors.background,
            fontSize: 12,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }

  Widget buildFilterButton(String title, Color color, String typeValue) {
    final bool isSelected = selectedFilter == title;

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedFilter = title;
        });
        tankerController.getTankersByType(typeValue);
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        height: 36,
        width: 96,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          color: isSelected ? AppColors.primary : Colors.white,
          border: Border.all(
            color: isSelected ? Colors.transparent : AppColors.secondary,
            width: 1.2,
          ),
        ),
        child: Center(
          child: Text(
            title,
            style: TextStyle(
              color: isSelected ? Colors.white : AppColors.secondary,
              fontWeight: FontWeight.w600,
              fontSize: 16,
            ),
          ),
        ),
      ),
    );
  }

}