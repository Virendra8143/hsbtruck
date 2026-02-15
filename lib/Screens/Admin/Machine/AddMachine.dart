// // import 'package:flutter/material.dart';
// // import 'package:get/get.dart';
// // import '../../../controllers/AdminController/AddMachineController.dart';
// // import '../../../utils/colors.dart'; // Update with your actual import path
// // import 'package:flutter_svg/flutter_svg.dart';
// //
// // class AddMachine extends StatefulWidget {
// //   const AddMachine({super.key});
// //
// //   @override
// //   State<AddMachine> createState() => _AddMachineState();
// // }
// //
// // class _AddMachineState extends State<AddMachine> {
// //   final AddMachineController controller = Get.put(AddMachineController());
// //   final _formKey = GlobalKey<FormState>();
// //
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     // Getting MediaQuery data
// //     final mediaQuery = MediaQuery.of(context);
// //     final screenWidth = mediaQuery.size.width;
// //     final screenHeight = mediaQuery.size.height;
// //
// //     return Container(
// //       height: screenHeight * 0.8, // Responsive height
// //       width: screenWidth * 0.99, // Responsive width
// //       child: SingleChildScrollView(
// //         child: Form(
// //           key: _formKey,
// //           child: Column(
// //             children: [
// //               SizedBox(height: 10),
// //               Container(
// //                 height: 5,
// //                 width: 53,
// //                 decoration: BoxDecoration(
// //                   borderRadius: BorderRadius.circular(5),
// //                   color: AppColors.alert,
// //                 ),
// //               ),
// //               Padding(
// //                 padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.04, vertical: 20), // Responsive padding
// //                 child: Row(
// //                   children: [
// //                     Container(
// //                       height: 62,
// //                       width: 62,
// //                       decoration: BoxDecoration(
// //                         borderRadius: BorderRadius.circular(12),
// //                         color: AppColors.primary,
// //                       ),
// //                       child: SvgPicture.asset('assets/images/AddMachine.svg', fit: BoxFit.none),
// //                     ),
// //                     SizedBox(width: 10),
// //                     Column(
// //                       crossAxisAlignment: CrossAxisAlignment.start,
// //                       children: [
// //                         Text(
// //                           'Create Machine',
// //                           style: TextStyle(fontWeight: FontWeight.w500, fontSize: screenWidth * 0.06, color: AppColors.secondary),
// //                         ),
// //                         Text(
// //                           'Machine Details and data',
// //                           style: TextStyle(fontWeight: FontWeight.w400, fontSize: screenWidth * 0.035, color: AppColors.icon),
// //                         ),
// //                       ],
// //                     ),
// //                   ],
// //                 ),
// //               ),
// //               SizedBox(height: 40),
// //               // Make Machine Type
// //               _buildTextField(
// //                 controller: controller.makeMachineTypeController,
// //                 label: "Make Machine Type",
// //                 width: screenWidth,
// //               ),
// //               SizedBox(height: 20),
// //               // Model Serial
// //               _buildTextField(
// //                 controller: controller.modelSerialController,
// //                 label: "Model Serial",
// //                 width: screenWidth,
// //               ),
// //               SizedBox(height: 20),
// //               // Mas Serial Number
// //               _buildTextField(
// //                 controller: controller.masSerialNoController,
// //                 label: "Mas Serial Number",
// //                 width: screenWidth,
// //               ),
// //               SizedBox(height: 20),
// //               // No. of Nozzles
// //               _buildTextField(
// //                 controller: controller.noOfNozzleController,
// //                 label: "Number of Nozzle",
// //                 width: screenWidth,
// //                 keyboardType: TextInputType.number,
// //               ),
// //               SizedBox(height: 20),
// //               // Nozzle Property
// //               _buildTextField(
// //                 controller: controller.nozzlePropertyController,
// //                 label: "Nozzle Property (ex: A1, A1A2)",
// //                 width: screenWidth,
// //               ),
// //               SizedBox(height: 20),
// //               // Nozzle Type 1
// //               _buildTextField(
// //                 controller: controller.nozzleType1Controller,
// //                 label: "Nozzle Type 1",
// //                 width: screenWidth,
// //               ),
// //               SizedBox(height: 20),
// //               // Nozzle Type 2
// //               _buildTextField(
// //                 controller: controller.nozzleType2Controller,
// //                 label: "Nozzle Type 2",
// //                 width: screenWidth,
// //               ),
// //               SizedBox(height: 20),
// //               // Nozzle Type 3
// //               _buildTextField(
// //                 controller: controller.nozzleType3Controller,
// //                 label: "Nozzle Type 3",
// //                 width: screenWidth,
// //               ),
// //               SizedBox(height: 20),
// //               // Opening Reading
// //               _buildTextField(
// //                 controller: controller.openingReadingController,
// //                 label: "Opening Reading",
// //                 width: screenWidth,
// //                 keyboardType: TextInputType.number,
// //               ),
// //               SizedBox(height: 20),
// //               Container(
// //                 width: screenWidth * 0.9, // Responsive width
// //                 child: Obx(() {
// //                   return ElevatedButton(
// //                     onPressed: controller.isLoading.value ? null : controller.addMachine,
// //                     style: ElevatedButton.styleFrom(
// //                       backgroundColor: AppColors.button,
// //                       shape: RoundedRectangleBorder(
// //                         borderRadius: BorderRadius.circular(10),
// //                       ),
// //                     ),
// //                     child: controller.isLoading.value
// //                         ? CircularProgressIndicator(color: AppColors.background)
// //                         : Text("Create Machine", style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500, color: AppColors.background))
// //                   );
// //                 }),
// //               ),
// //               SizedBox(height: 20),
// //
// //             ],
// //           ),
// //         ),
// //       ),
// //     );
// //   }
// //
// //   // Widget _buildTextField({required TextEditingController controller, required String label, required double width, TextInputType keyboardType = TextInputType.text}) {
// //   //   return SizedBox(
// //   //     width: width * 0.9, // Responsive width
// //   //     child: TextField(
// //   //       controller: controller,
// //   //       keyboardType: keyboardType,
// //   //       decoration: InputDecoration(
// //   //         labelText: label,
// //   //         enabledBorder: OutlineInputBorder(
// //   //           borderRadius: BorderRadius.circular(12),
// //   //           borderSide: BorderSide(color: AppColors.primary, width: 1),
// //   //         ),
// //   //       ),
// //   //     ),
// //   //   );
// //   // }
// //   Widget _buildTextField({
// //     required TextEditingController controller,
// //     required String label,
// //     required double width,
// //     TextInputType keyboardType = TextInputType.text,
// //   }) {
// //     return SizedBox(
// //       width: width * 0.9,
// //       child: TextFormField(
// //         controller: controller,
// //         keyboardType: keyboardType,
// //         decoration: InputDecoration(
// //           labelText: label,
// //           enabledBorder: OutlineInputBorder(
// //             borderRadius: BorderRadius.circular(12),
// //             borderSide: BorderSide(color: AppColors.primary, width: 1),
// //           ),
// //           focusedBorder: OutlineInputBorder(
// //             borderRadius: BorderRadius.circular(12),
// //             borderSide: BorderSide(color: AppColors.secondary, width: 1.5),
// //           ),
// //         ),
// //         validator: (value) {
// //           if (value == null || value.trim().isEmpty) {
// //             return 'Please enter $label';
// //           }
// //           return null;
// //         },
// //       ),
// //     );
// //   }
// //
// // }
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import '../../../controllers/AdminController/AddMachineController.dart';
// import '../../../utils/colors.dart';
// import 'package:flutter_svg/flutter_svg.dart';
//
// class AddMachine extends StatefulWidget {
//   const AddMachine({super.key});
//
//   @override
//   State<AddMachine> createState() => _AddMachineState();
// }
//
// class _AddMachineState extends State<AddMachine> {
//   final AddMachineController controller = Get.put(AddMachineController());
//   final _formKey = GlobalKey<FormState>();
//
//   @override
//   Widget build(BuildContext context) {
//     final mediaQuery = MediaQuery.of(context);
//     final screenWidth = mediaQuery.size.width;
//     final screenHeight = mediaQuery.size.height;
//
//     return Container(
//       height: screenHeight * 0.8,
//       width: screenWidth * 0.99,
//       child: SingleChildScrollView(
//         child: Form(
//           key: _formKey,
//           child: Column(
//             children: [
//               SizedBox(height: 10),
//               Container(
//                 height: 5,
//                 width: 53,
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(5),
//                   color: AppColors.alert,
//                 ),
//               ),
//               Padding(
//                 padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.04, vertical: 20),
//                 child: Row(
//                   children: [
//                     Container(
//                       height: 62,
//                       width: 62,
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(12),
//                         color: AppColors.primary,
//                       ),
//                       child: SvgPicture.asset('assets/images/AddMachine.svg', fit: BoxFit.none),
//                     ),
//                     SizedBox(width: 10),
//                     Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           'Create Machine',
//                           style: TextStyle(fontWeight: FontWeight.w500, fontSize: screenWidth * 0.06, color: AppColors.secondary),
//                         ),
//                         Text(
//                           'Machine Details and data',
//                           style: TextStyle(fontWeight: FontWeight.w400, fontSize: screenWidth * 0.035, color: AppColors.icon),
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//               SizedBox(height: 40),
//
//               // Required Fields
//               _buildTextField(
//                 controller: controller.makeMachineTypeController,
//                 label: "Make Machine Type",
//                 width: screenWidth,
//                 isRequired: true,
//               ),
//               SizedBox(height: 20),
//               _buildTextField(
//                 controller: controller.modelSerialController,
//                 label: "Model Serial",
//                 width: screenWidth,
//                 isRequired: true,
//               ),
//               SizedBox(height: 20),
//               _buildTextField(
//                 controller: controller.masSerialNoController,
//                 label: "Mas Serial Number",
//                 width: screenWidth,
//                 isRequired: true,
//               ),
//               SizedBox(height: 20),
//               SizedBox(
//                 width: screenWidth * 0.9,
//                 child: DropdownButtonFormField<String>(
//                   decoration: InputDecoration(
//                     labelText: "Number of Nozzle",
//                     enabledBorder: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(12),
//                       borderSide: BorderSide(color: AppColors.primary, width: 1),
//                     ),
//                     focusedBorder: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(12),
//                       borderSide: BorderSide(color: AppColors.secondary, width: 1.5),
//                     ),
//                     errorBorder: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(12),
//                       borderSide: BorderSide(color: Colors.red, width: 1.5),
//                     ),
//                     focusedErrorBorder: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(12),
//                       borderSide: BorderSide(color: Colors.red, width: 2),
//                     ),
//                   ),
//                   items: ['1', '2', '4'].map((String value) {
//                     return DropdownMenuItem<String>(
//                       value: value,
//                       child: Text(value),
//                     );
//                   }).toList(),
//                   onChanged: (String? newValue) {
//                     controller.noOfNozzleController.text = newValue ?? '';
//                   },
//                   validator: (value) {
//                     if (value == null || value.isEmpty) {
//                       return 'Please select Number of Nozzle';
//                     }
//                     return null;
//                   },
//                 ),
//               ),
//
//               SizedBox(height: 20),
//
//               // Submit Button
//               Container(
//                 width: screenWidth * 0.9,
//                 child: Obx(() {
//                   return ElevatedButton(
//                     onPressed: controller.isLoading.value
//                         ? null
//                         : () {
//                       if (_formKey.currentState!.validate()) {
//                         controller.addMachine();
//                       }
//                     },
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: AppColors.button,
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(10),
//                       ),
//                     ),
//                     child: controller.isLoading.value
//                         ? CircularProgressIndicator(color: AppColors.background)
//                         : Text(
//                       "Create Machine",
//                       style: TextStyle(
//                         fontSize: 20,
//                         fontWeight: FontWeight.w500,
//                         color: AppColors.background,
//                       ),
//                     ),
//                   );
//                 }),
//               ),
//               SizedBox(height: 20),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget _buildTextField({
//     required TextEditingController controller,
//     required String label,
//     required double width,
//     TextInputType keyboardType = TextInputType.text,
//     bool isRequired = false,
//   }) {
//     return SizedBox(
//       width: width * 0.9,
//       child: TextFormField(
//         controller: controller,
//         keyboardType: keyboardType,
//         decoration: InputDecoration(
//           labelText: label,
//           enabledBorder: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(12),
//             borderSide: BorderSide(color: AppColors.primary, width: 1),
//           ),
//           focusedBorder: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(12),
//             borderSide: BorderSide(color: AppColors.secondary, width: 1.5),
//           ),
//           errorBorder: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(12),
//             borderSide: BorderSide(color: Colors.red, width: 1.5),
//           ),
//           focusedErrorBorder: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(12),
//             borderSide: BorderSide(color: Colors.red, width: 2),
//           ),
//         ),
//         validator: isRequired
//             ? (value) {
//           if (value == null || value.trim().isEmpty) {
//             return 'Please enter $label';
//           }
//           return null;
//         }
//             : null,
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../controllers/AdminController/AddMachineController.dart';
import '../../../utils/colors.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

class AddMachine extends StatefulWidget {
  const AddMachine({super.key});

  @override
  State<AddMachine> createState() => _AddMachineState();
}

class _AddMachineState extends State<AddMachine> {
  final AddMachineController controller = Get.put(AddMachineController());
  final _formKey = GlobalKey<FormState>();

  final List<String> nozzleLabels = ['A1', 'A2', 'B1', 'B2'];

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final screenWidth = mediaQuery.size.width;
    final screenHeight = mediaQuery.size.height;

    return Container(
      height: screenHeight * 0.8,
      width: screenWidth * 0.99,
      child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              const SizedBox(height: 10),
              Container(
                height: 5,
                width: 53,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: AppColors.alert,
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.04, vertical: 20),
                child: Row(
                  children: [
                    Container(
                      height: 62,
                      width: 62,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: AppColors.primary,
                      ),
                      child: SvgPicture.asset('assets/images/AddMachine.svg', fit: BoxFit.none),
                    ),
                    const SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Create Machine',
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: screenWidth * 0.06,
                            color: AppColors.secondary,
                          ),
                        ),
                        Text(
                          'Machine Details and data',
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: screenWidth * 0.035,
                            color: AppColors.icon,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 40),

              // Fields
              _buildTextField(
                controller: controller.makeMachineTypeController,
                label: "Make Machine Type",
                width: screenWidth,
                isRequired: true,
              ),
              const SizedBox(height: 20),
              _buildTextField(
                controller: controller.modelSerialController,
                label: "Model Serial",
                width: screenWidth,
                isRequired: true,
              ),
              const SizedBox(height: 20),
              _buildTextField(
                controller: controller.masSerialNoController,
                label: "Mas Serial Number",
                width: screenWidth,
                isRequired: true,
              ),
              const SizedBox(height: 20),

              // Nozzle count dropdown
              SizedBox(
                width: screenWidth * 0.9,
                child: DropdownButtonFormField<String>(
                  decoration: _inputDecoration("Number of Nozzle"),
                  items: ['1', '2', '4'].map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    controller.noOfNozzleController.text = newValue ?? '';
                    int count = int.tryParse(newValue ?? '') ?? 0;
                    controller.updateNozzles(count);
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please select Number of Nozzle';
                    }
                    return null;
                  },
                ),
              ),

              const SizedBox(height: 20),

              // Nozzle input rows
              Obx(() {
                if (controller.nozzles.isEmpty) return SizedBox();
                return Column(
                  children: List.generate(controller.nozzles.length, (index) {
                    final nozzle = controller.nozzles[index];
                    final label = index < nozzleLabels.length ? nozzleLabels[index] : "N${index + 1}";

                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 16),
                      child: Row(
                        children: [
                          Text(
                            label,
                            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                          const SizedBox(width: 10),

                          // Nozzle Number
                          Expanded(
                            flex: 2,
                            child: TextFormField(
                              controller: nozzle.nozzleNumberController,
                              decoration: _inputDecoration("Nozzle Number"),
                              validator: (value) => value == null || value.isEmpty
                                  ? 'Enter nozzle number'
                                  : null,
                            ),
                          ),
                          const SizedBox(width: 10),

                          // Fuel Type Dropdown
                          Expanded(
                            flex: 2,
                            child: Obx(() => DropdownButtonFormField<String>(
                              value: nozzle.selectedType.value.isEmpty ? null : nozzle.selectedType.value,
                              items: ['Petrol', 'Diesel', 'Power']
                                  .map((type) => DropdownMenuItem<String>(
                                value: type,
                                child: Text(type),
                              ))
                                  .toList(),
                              onChanged: (value) {
                                nozzle.selectedType.value = value ?? '';
                              },
                              decoration: _inputDecoration("Type"),
                              validator: (value) =>
                              value == null || value.isEmpty ? 'Select fuel type' : null,
                            )),
                          ),
                          const SizedBox(width: 10),

                          // Reading
                          Expanded(
                            flex: 2,
                            child: TextFormField(
                              controller: nozzle.readingController,
                              keyboardType: TextInputType.number,
                              decoration: _inputDecoration("Reading"),
                              validator: (value) => value == null || value.isEmpty
                                  ? 'Enter reading'
                                  : null,
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
                );
              }),

              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "* Stumping Date",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
              // Opening Reading
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: controller.startDateController,

                        readOnly: true,
                        onTap: () async {
                          final picked = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(2020),
                            lastDate: DateTime(2100),
                          );
                          if (picked != null) {
                            controller.startDateController.text = DateFormat('yyyy-MM-dd').format(picked);
                          }
                        },
                        decoration: _inputDecoration("Start date"),
                      ),
                    ),
                    SizedBox(width: 16),
                    Expanded(
                      child: TextFormField(
                        controller: controller.endDateController,
                        readOnly: true,
                        onTap: () async {
                          final picked = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(2020),
                            lastDate: DateTime(2100),
                          );
                          if (picked != null) {
                            controller.endDateController.text = DateFormat('yyyy-MM-dd').format(picked);
                          }
                        },
                        decoration: _inputDecoration("End date"),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 30),

              // Submit Button
              SizedBox(
                width: screenWidth * 0.9,
                height: screenHeight * 0.05,
                child: Obx(() {
                  return ElevatedButton(
                    onPressed: controller.isLoading.value
                        ? null
                        : () {
                      if (_formKey.currentState!.validate()) {
                        controller.addMachine();
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.button,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: controller.isLoading.value
                        ? CircularProgressIndicator(color: AppColors.background)
                        : const Text(
                      "Create Machine",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                    ),
                  );
                }),
              ),

              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }

  // Text Field Builder
  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required double width,
    TextInputType keyboardType = TextInputType.text,
    bool isRequired = false,
  }) {
    return SizedBox(
      width: width * 0.9,
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        decoration: _inputDecoration(label),
        validator: isRequired
            ? (value) {
          if (value == null || value.trim().isEmpty) {
            return 'Please enter $label';
          }
          return null;
        }
            : null,
      ),
    );
  }

  // Input decoration
  InputDecoration _inputDecoration(String label) {
    return InputDecoration(
      labelText: label,
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: AppColors.primary, width: 1),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: AppColors.secondary, width: 1.5),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Colors.red, width: 1.5),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Colors.red, width: 2),
      ),
    );
  }

  // Dropdown decoration
  InputDecoration _dropdownDecoration(String label) {
    return InputDecoration(
      labelText: label,
      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 18),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: AppColors.primary),
      ),
    );
  }
}
