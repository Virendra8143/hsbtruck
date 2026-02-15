// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import '../../../controllers/AdminController/AddMachineController.dart';
// import '../../../utils/colors.dart';
// import '../../../Widgets/CommonHeader.dart';
// import 'AddMachine.dart';
// import 'EditMachineOption.dart';
// import 'Eye.dart';
//
//
// class CreateMachine extends StatefulWidget {
//   const CreateMachine({Key? key}) : super(key: key);
//
//   @override
//   State<CreateMachine> createState() => _CreateMachineState();
// }
//
// class _CreateMachineState extends State<CreateMachine> {
//   final AddMachineController getMachineListController =
//   Get.put(AddMachineController());
//
//   @override
//   void initState() {
//     super.initState();
//     getMachineListController.getMachine();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final width = MediaQuery.of(context).size.width;
//     final height = MediaQuery.of(context).size.height;
//
//     return Scaffold(
//       body: SafeArea(
//         child: Obx(
//               () => getMachineListController.isLoading.value
//               ? Container(
//             height: height,
//             width: width,
//             alignment: Alignment.center,
//             child: CircularProgressIndicator(
//               color: AppColors.primary,
//             ),
//           )
//               : getMachineListController.getMachineModel.value.data == null ||
//               getMachineListController
//                   .getMachineModel.value.data!.isEmpty
//               ? Column(
//             children: [
//               SizedBox(height: 30,),
//               // Header section
//               CommonHeader(
//                 title: 'Machine Management',
//                 showBackButton: true,
//                 showNotificationIcon: true,
//                 showDrawerIcon: true,
//               ),
//               Expanded(
//                 child: Center(
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Icon(
//                         Icons.engineering,
//                         size: 80,
//                         color: AppColors.primary.withOpacity(0.5),
//                       ),
//                       SizedBox(height: 20),
//                       Text(
//                         "No machines found",
//                         style: TextStyle(
//                           fontSize: 18,
//                           fontWeight: FontWeight.w500,
//                           color: AppColors.primary,
//                         ),
//                       ),
//                       SizedBox(height: 10),
//                       Text(
//                         "Tap the + button to add your first machine",
//                         style: TextStyle(
//                           fontSize: 14,
//                           color: AppColors.icon,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ],
//           )
//               : Column(
//             children: [
//               SizedBox(height: 30,),
//               // Header section
//               CommonHeader(
//                 title: 'Machine Management',
//                 showBackButton: true,
//                 showNotificationIcon: true,
//                 showDrawerIcon: true,
//               ),
//
//               // Top info section
//               Padding(
//                 padding: const EdgeInsets.only(left: 20, top: 10),
//                 child: Row(
//                   children: [
//                     Container(
//                       height: height * 0.2,
//                       width: width * 0.4,
//                       child: Image.asset(
//                         'assets/images/2pp.png',
//                         fit: BoxFit.fitHeight,
//                       ),
//                     ),
//                     SizedBox(width: width * 0.03),
//                     Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           "Create Machine",
//                           style: TextStyle(
//                             color: AppColors.primary,
//                             fontSize: 24,
//                             fontWeight: FontWeight.w700,
//                           ),
//                         ),
//                         Container(
//                           decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(4),
//                             color: AppColors.secondary,
//                           ),
//                           height: height * 0.06,
//                           width: width * 0.4,
//                           child: Padding(
//                             padding: const EdgeInsets.all(8.0),
//                             child: Row(
//                               mainAxisAlignment:
//                               MainAxisAlignment.spaceBetween,
//                               children: [
//                                 Text(
//                                   "Total Machines",
//                                   style: TextStyle(
//                                     color: AppColors.background,
//                                     fontSize: 12,
//                                     fontWeight: FontWeight.w700,
//                                   ),
//                                 ),
//                                 Text(
//                                   getMachineListController
//                                       .getMachineModel
//                                       .value
//                                       .data!
//                                       .length
//                                       .toString(),
//                                   style: TextStyle(
//                                     color: AppColors.background,
//                                     fontSize: 12,
//                                     fontWeight: FontWeight.w700,
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ),
//                         SizedBox(height: height * 0.012),
//                         Container(
//                           decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(4),
//                             color: AppColors.primary,
//                           ),
//                           width: width * 0.4,
//                           child: Padding(
//                             padding: const EdgeInsets.all(8.0),
//                             child: Column(
//                               children: [
//                                 Row(
//                                   mainAxisAlignment:
//                                   MainAxisAlignment.spaceBetween,
//                                   children: [
//                                     Text(
//                                       "Petrol",
//                                       style: TextStyle(
//                                         color: AppColors.background,
//                                         fontSize: 12,
//                                         fontWeight: FontWeight.w700,
//                                       ),
//                                     ),
//                                     Text(
//                                       _countMachinesByType("Petrol"),
//                                       style: TextStyle(
//                                         color: AppColors.background,
//                                         fontSize: 12,
//                                         fontWeight: FontWeight.w700,
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                                 Row(
//                                   mainAxisAlignment:
//                                   MainAxisAlignment.spaceBetween,
//                                   children: [
//                                     Text(
//                                       "Power",
//                                       style: TextStyle(
//                                         color: AppColors.background,
//                                         fontSize: 12,
//                                         fontWeight: FontWeight.w700,
//                                       ),
//                                     ),
//                                     Text(
//                                       _countMachinesByType("Power"),
//                                       style: TextStyle(
//                                         color: AppColors.background,
//                                         fontSize: 12,
//                                         fontWeight: FontWeight.w700,
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                                 Row(
//                                   mainAxisAlignment:
//                                   MainAxisAlignment.spaceBetween,
//                                   children: [
//                                     Text(
//                                       "Diesel",
//                                       style: TextStyle(
//                                         color: AppColors.background,
//                                         fontSize: 12,
//                                         fontWeight: FontWeight.w700,
//                                       ),
//                                     ),
//                                     Text(
//                                       _countMachinesByType("Diesel"),
//                                       style: TextStyle(
//                                         color: AppColors.background,
//                                         fontSize: 12,
//                                         fontWeight: FontWeight.w700,
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//
//               // List section - Using Expanded to fill remaining space
//               Expanded(
//                 child: Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: ListView.builder(
//                     physics: const AlwaysScrollableScrollPhysics(),
//                     itemCount: getMachineListController
//                         .getMachineModel.value.data!.length,
//                     itemBuilder: (context, index) {
//                       final machine = getMachineListController
//                           .getMachineModel.value.data![index];
//                       return Container(
//                         height: height * 0.12,
//                         width: width * 0.9,
//                         child: Card(
//                           color: AppColors.whitebg,
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(10),
//                           ),
//                           child: Row(
//                             children: [
//                               IconButton(
//                                 onPressed: () {},
//                                 icon: Image.asset(
//                                   'assets/images/Group.png',
//                                   fit: BoxFit.fitHeight,
//                                 ),
//                               ),
//                               Expanded(
//                                 child: Column(
//                                   crossAxisAlignment:
//                                   CrossAxisAlignment.start,
//                                   mainAxisAlignment:
//                                   MainAxisAlignment.center,
//                                   children: [
//                                     Text(
//                                       "#${machine.code ?? 'N/A'}",
//                                       style: TextStyle(
//                                         color: AppColors.primary,
//                                         fontSize: 14,
//                                         fontWeight: FontWeight.w700,
//                                       ),
//                                     ),
//                                     Text(
//                                       machine.makeMachineType ??
//                                           'Unknown Type',
//                                       style: TextStyle(
//                                         color: AppColors.secondary,
//                                         fontSize: 20,
//                                         fontWeight: FontWeight.w700,
//                                       ),
//                                     ),
//                                     Text(
//                                       "Nozzles: ${machine.noOfNozzle ?? '0'}",
//                                       style: TextStyle(
//                                         color: AppColors.icon,
//                                         fontSize: 12,
//                                         fontWeight: FontWeight.w400,
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                               IconButton(
//                                 onPressed: () {
//                                   showModalBottomSheet(
//                                     context: context,
//                                     isScrollControlled: true,
//                                     shape: RoundedRectangleBorder(
//                                       borderRadius:
//                                       BorderRadius.vertical(
//                                           top: Radius.circular(
//                                               16)),
//                                     ),
//                                     builder: (context) {
//                                       return Eye(
//                                           machineId:
//                                           machine.id ?? '');
//                                     },
//                                   );
//                                 },
//                                 icon: Image.asset(
//                                   'assets/images/View.png',
//                                   fit: BoxFit.fitHeight,
//                                 ),
//                               ),
//
//                               IconButton(
//                                 onPressed: () {
//                                   showModalBottomSheet(
//                                     context: context,
//                                     isScrollControlled: true,
//                                     shape: RoundedRectangleBorder(
//                                       borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
//                                     ),
//                                     builder: (context) {
//                                       return EditMachineOption(
//                                         machineId: machine.id ?? '',
//                                         machineData: _prepareMachineDataForEditing(machine), // Add this line
//                                       );
//                                     },
//                                   );
//                                 },
//                                 icon: Image.asset(
//                                   'assets/images/Vector.png',
//                                   fit: BoxFit.fitHeight,
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       );
//                     },
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//       floatingActionButton: Obx(
//             () => !getMachineListController.isLoading.value
//             ? FloatingActionButton(
//           onPressed: () {
//             showModalBottomSheet(
//               context: context,
//               isScrollControlled: true,
//               shape: RoundedRectangleBorder(
//                 borderRadius:
//                 BorderRadius.vertical(top: Radius.circular(16)),
//               ),
//               builder: (context) {
//                 return AddMachine();
//               },
//             );
//           },
//           backgroundColor: AppColors.primary,
//           child: Icon(
//             Icons.add,
//             color: AppColors.background,
//           ),
//         )
//             : SizedBox(),
//       ),
//     );
//   }
//
//   String _countMachinesByType(String type) {
//     if (getMachineListController.getMachineModel.value.data == null) {
//       return "0";
//     }
//
//     int count = getMachineListController.getMachineModel.value.data!
//         .where((machine) =>
//     machine.makeMachineType?.toLowerCase() == type.toLowerCase() ||
//         machine.nozzleType1?.toLowerCase() == type.toLowerCase() ||
//         machine.nozzleType2?.toLowerCase() == type.toLowerCase() ||
//         machine.nozzleType3?.toLowerCase() == type.toLowerCase() ||
//         machine.nozzleType4?.toLowerCase() == type.toLowerCase())
//         .length;
//
//     return count.toString();
//   }
//
// // In your CreateMachine screen, update the _prepareMachineDataForEditing method:
//
//   Map<String, dynamic> _prepareMachineDataForEditing(dynamic machine) {
//     // Use direct property access with the new field names
//     return {
//       'id': machine.id,
//       'make_machine_type': machine.makeMachineType,
//       'modal_serial': machine.modalSerial,
//       'mas_serial_no': machine.masSerialNo,
//       'no_of_nozzle': machine.noOfNozzle,
//
//       // Use the new property names
//       'stumping_start_date': machine.stumpingStartDate,
//       'stumping_end_date': machine.stumpingEndDate,
//
//       'nozzle_number_1': machine.nozzleNumber1,
//       'nozzle_type_1': machine.nozzleType1,
//       'nozzle_reading_1': machine.nozzleReading1,
//
//       'nozzle_number_2': machine.nozzleNumber2,
//       'nozzle_type_2': machine.nozzleType2,
//       'nozzle_reading_2': machine.nozzleReading2,
//
//       'nozzle_number_3': machine.nozzleNumber3,
//       'nozzle_type_3': machine.nozzleType3,
//       'nozzle_reading_3': machine.nozzleReading3,
//
//       'nozzle_number_4': machine.nozzleNumber4,
//       'nozzle_type_4': machine.nozzleType4,
//       'nozzle_reading_4': machine.nozzleReading4,
//     };
//   }
// }
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import '../../../Widgets/NotificationsScreen.dart';
import '../../../Widgets/appbar/main_app_bar.dart';
import '../../../controllers/AdminController/AddMachineController.dart';
import '../../../helpers/machine_states.dart';
import '../../../utils/colors.dart';
import '../../../Widgets/CommonHeader.dart';
import 'AddMachine.dart';
import 'EditMachineOption.dart';
import 'Eye.dart';

class CreateMachine extends StatefulWidget {
  const CreateMachine({Key? key}) : super(key: key);

  @override
  State<CreateMachine> createState() => _CreateMachineState();
}

class _CreateMachineState extends State<CreateMachine> {
  final AddMachineController getMachineListController =
  Get.put(AddMachineController());

  @override
  void initState() {
    super.initState();
    getMachineListController.getMachine();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

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
      body: SafeArea(
        child: Obx(
              () => getMachineListController.isLoading.value
              ? Container(
            height: height,
            width: width,
            alignment: Alignment.center,
            child: CircularProgressIndicator(
              color: AppColors.primary,
            ),
          )
              : getMachineListController.getMachineModel.value.data == null ||
              getMachineListController
                  .getMachineModel.value.data!.isEmpty
              ? Column(
            children: [
              Expanded(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.engineering,
                        size: 80,
                        color: AppColors.primary.withOpacity(0.5),
                      ),
                      SizedBox(height: 20),
                      Text(
                        "No machines found",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: AppColors.primary,
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        "Tap the + button to add your first machine",
                        style: TextStyle(
                          fontSize: 14,
                          color: AppColors.icon,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          )
              : Column(
            children: [
              // Top info section
              Padding(
                padding: const EdgeInsets.only(left: 20, top: 10, right: 20),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // 🖼️ Image Section
                    Expanded(
                      flex: 1,
                      child: AspectRatio(
                        aspectRatio: 1.2, // Keeps image proportional
                        child: Image.asset(
                          'assets/images/2pp.png',
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),

                    const SizedBox(width: 16),

                    // 📊 Text + Stats Section
                    Expanded(
                      flex: 1,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Create Machine",
                            style: TextStyle(
                              color: AppColors.primary,
                              fontSize: 24,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const SizedBox(height: 8),

                          // Total Machines
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4),
                              color: AppColors.secondary,
                            ),
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Total Machines",
                                  style: TextStyle(
                                    color: AppColors.background,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                Text(
                                  getMachineListController
                                      .getMachineModel.value.data!.length
                                      .toString(),
                                  style: TextStyle(
                                    color: AppColors.background,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 10),

                          // Fuel Stats
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4),
                              color: AppColors.primary,
                            ),
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                            child: Column(
                              children: [
                                buildStatRow("Petrol", _countMachinesByType("Petrol")),
                                buildStatRow("Power", _countMachinesByType("Power")),
                                buildStatRow("Diesel", _countMachinesByType("Diesel")),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),




              // List section - Using Expanded to fill remaining space
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListView.builder(
                    physics: const AlwaysScrollableScrollPhysics(),
                    itemCount: getMachineListController.getMachineModel.value.data!.length,
                    itemBuilder: (context, index) {
                      final machine = getMachineListController.getMachineModel.value.data![index];
                      final bool isDeactivated = machine.status == "0" || machine.status == "9";

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
                        color: isDeactivated ? Colors.grey[100] : Colors.white,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // 🔹 Row 1 — Machine Code + Icons
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "#${machine.code ?? 'N/A'}",
                                    style: TextStyle(
                                      color: isDeactivated ? Colors.grey : AppColors.primary,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      IconButton(
                                        padding: EdgeInsets.zero,
                                        constraints: const BoxConstraints(),
                                        icon: Image.asset(
                                          'assets/images/View.png',
                                          width: 28,
                                          color: isDeactivated ? Colors.grey : AppColors.secondary,
                                        ),
                                        onPressed: () {
                                          if (isDeactivated) {
                                            ScaffoldMessenger.of(context).showSnackBar(
                                              SnackBar(
                                                content: const Text("Deactivated machines cannot be viewed"),
                                                backgroundColor: Colors.grey[700],
                                              ),
                                            );
                                            return;
                                          }
                                          showModalBottomSheet(
                                            context: context,
                                            isScrollControlled: true,
                                            shape: const RoundedRectangleBorder(
                                              borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                                            ),
                                            builder: (context) => Eye(machineId: machine.id ?? ''),
                                          );
                                        },
                                      ),
                                      const SizedBox(width: 20),
                                      IconButton(
                                        padding: EdgeInsets.zero,
                                        constraints: const BoxConstraints(),
                                        icon: Image.asset(
                                          'assets/images/Vector.png',
                                          width: 28,
                                          color: isDeactivated ? Colors.grey : AppColors.secondary,
                                        ),
                                        onPressed: () {
                                          showModalBottomSheet(
                                            context: context,
                                            isScrollControlled: true,
                                            shape: const RoundedRectangleBorder(
                                              borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
                                            ),
                                            builder: (context) => EditMachineOption(
                                              machineId: machine.id ?? '',
                                              machineData: _prepareMachineDataForEditing(machine),
                                              currentStatus: machine.status ?? '1',
                                            ),
                                          );
                                        },
                                      ),
                                    ],
                                  ),
                                ],
                              ),

                              const SizedBox(height: 6),

                              // 🔹 Row 2 — Machine Type + Nozzles
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Text(
                                      machine.makeMachineType ?? 'Unknown Machine Type',
                                      style: TextStyle(
                                        color: isDeactivated ? Colors.grey : AppColors.secondary,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w700,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  Text(
                                    "Nozzles: ${machine.noOfNozzle ?? '0'}",
                                    style: TextStyle(
                                      color: isDeactivated ? Colors.grey : AppColors.icon,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ],
                              ),

                              const SizedBox(height: 6),

                              // 🔹 Status Badge
                              if (isDeactivated)
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                                  decoration: BoxDecoration(
                                    color: Colors.grey[300],
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  child: Text(
                                    'DEACTIVATED',
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
                  ),
                ),
              ),

            ],
          ),
        ),
      ),
      floatingActionButton: Obx(
            () => !getMachineListController.isLoading.value
            ? GestureDetector(
          onTap: () {
            showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              backgroundColor: Colors.transparent, // Transparent background
              builder: (context) {
                return ClipRRect(
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
                  child: Container(
                    color: Colors.white, // Bottom sheet background
                    child: AddMachine(), // Your Add Machine widget
                  ),
                );
              },
            );
          },
          child: SvgPicture.asset(
            'assets/images/addicon 2.svg',
            width: 56,
            height: 56,
          ),
        )
            : const SizedBox(),
      ),



    );
  }

  String _countMachinesByType(String type) {
    if (getMachineListController.getMachineModel.value.data == null) {
      return "0";
    }

    int count = getMachineListController.getMachineModel.value.data!
        .where((machine) =>
    machine.makeMachineType?.toLowerCase() == type.toLowerCase() ||
        machine.nozzleType1?.toLowerCase() == type.toLowerCase() ||
        machine.nozzleType2?.toLowerCase() == type.toLowerCase() ||
        machine.nozzleType3?.toLowerCase() == type.toLowerCase() ||
        machine.nozzleType4?.toLowerCase() == type.toLowerCase())
        .length;

    return count.toString();
  }

  Map<String, dynamic> _prepareMachineDataForEditing(dynamic machine) {
    return {
      'id': machine.id,
      'make_machine_type': machine.makeMachineType,
      'modal_serial': machine.modalSerial,
      'mas_serial_no': machine.masSerialNo,
      'no_of_nozzle': machine.noOfNozzle,
      'status': machine.status ?? '1',
      'stumping_start_date': machine.stumpingStartDate,
      'stumping_end_date': machine.stumpingEndDate,

      'nozzle_number_1': machine.nozzleNumber1,
      'nozzle_type_1': machine.nozzleType1,
      'nozzle_reading_1': machine.nozzleReading1,

      'nozzle_number_2': machine.nozzleNumber2,
      'nozzle_type_2': machine.nozzleType2,
      'nozzle_reading_2': machine.nozzleReading2,

      'nozzle_number_3': machine.nozzleNumber3,
      'nozzle_type_3': machine.nozzleType3,
      'nozzle_reading_3': machine.nozzleReading3,

      'nozzle_number_4': machine.nozzleNumber4,
      'nozzle_type_4': machine.nozzleType4,
      'nozzle_reading_4': machine.nozzleReading4,
    };
  }
}