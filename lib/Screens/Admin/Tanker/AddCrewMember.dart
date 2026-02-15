
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import '../../../utils/colors.dart';

// Input formatters to remove special characters and spaces
class AlphanumericInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue,
      TextEditingValue newValue,
      ) {
    // Remove spaces and special characters, keep only alphanumeric
    String filteredText = newValue.text.replaceAll(RegExp(r'[^a-zA-Z0-9]'), '');

    return TextEditingValue(
      text: filteredText.toUpperCase(),
      selection: TextSelection.collapsed(offset: filteredText.length),
    );
  }
}

class NumericOnlyInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue,
      TextEditingValue newValue,
      ) {
    // Remove everything except numbers
    String filteredText = newValue.text.replaceAll(RegExp(r'[^0-9]'), '');

    return TextEditingValue(
      text: filteredText,
      selection: TextSelection.collapsed(offset: filteredText.length),
    );
  }
}

class AddCrewMember extends StatefulWidget {
  final String tankerId;

  const AddCrewMember({super.key, required this.tankerId});

  @override
  State<AddCrewMember> createState() => _AddCrewMemberState();
}

class _AddCrewMemberState extends State<AddCrewMember> {
  final ImagePicker _picker = ImagePicker();

  // Text editing controllers
  final TextEditingController _driverNameController = TextEditingController();
  final TextEditingController _driverLicenseController = TextEditingController();
  final TextEditingController _mobileController = TextEditingController();
  final TextEditingController _aadharController = TextEditingController();
  final TextEditingController _helperNameController = TextEditingController();
  final TextEditingController _helperMobileController = TextEditingController();
  final TextEditingController _remarkController = TextEditingController();

  // Date controllers
  final TextEditingController _licenseExpDateController = TextEditingController();
  final TextEditingController _gatePassExpDateController = TextEditingController();
  final TextEditingController _trainingCardExpDateController = TextEditingController();
  final TextEditingController _hazardousGoodsExpDateController = TextEditingController();

  // File variables for documents
  File? _aadharDocFile;
  File? _trainingCardDocFile;
  File? _gatePassDocFile;
  File? _hazardousGoodsDocFile;
  File? _helperAadharDocFile;

  bool _isLoading = false;

  // API Service Method
  Future<void> _addCrewMember() async {
    // Validate required fields
    if (_driverNameController.text.isEmpty ||
        _driverLicenseController.text.isEmpty ||
        _mobileController.text.isEmpty ||
        _aadharController.text.isEmpty ||
        _licenseExpDateController.text.isEmpty) {
      _showSnackBar('Please fill all required fields');
      return;
    }

    // Validate mobile number
    if (_mobileController.text.length != 10) {
      _showSnackBar('Please enter a valid 10-digit mobile number');
      return;
    }

    // Validate Aadhaar number
    if (_aadharController.text.length != 12) {
      _showSnackBar('Please enter a valid 12-digit Aadhaar number');
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      // Create multipart request
      final String url = 'https://hsb.bugsbon.com/api/add-crew-member';
      var request = http.MultipartRequest('POST', Uri.parse(url));

      // Add headers
      request.headers['access_token'] = 'MTE2OjI6SFNCMDgzNzp2aXJlbmRyYQ==';

      // Add required fields
      request.fields['tanker_id'] = widget.tankerId;
      request.fields['driver_name'] = _driverNameController.text;
      request.fields['driver_license_no'] = _driverLicenseController.text;
      request.fields['mobile'] = _mobileController.text;
      request.fields['aadhar_number'] = _aadharController.text;
      request.fields['license_exp_date'] = _licenseExpDateController.text;

      // Add optional fields if they have values
      if (_helperNameController.text.isNotEmpty) {
        request.fields['helper_name'] = _helperNameController.text;
      }
      if (_helperMobileController.text.isNotEmpty) {
        request.fields['helper_mobile'] = _helperMobileController.text;
      }
      if (_remarkController.text.isNotEmpty) {
        request.fields['remark'] = _remarkController.text;
      }
      if (_gatePassExpDateController.text.isNotEmpty) {
        request.fields['gate_pass_exp_date'] = _gatePassExpDateController.text;
      }
      if (_trainingCardExpDateController.text.isNotEmpty) {
        request.fields['traning_card_exp_date'] = _trainingCardExpDateController.text;
      }
      if (_hazardousGoodsExpDateController.text.isNotEmpty) {
        request.fields['hazardous_goods_exp_date'] = _hazardousGoodsExpDateController.text;
      }

      // Add files if they are selected
      if (_aadharDocFile != null) {
        request.files.add(await http.MultipartFile.fromPath(
          'aadhar_doc',
          _aadharDocFile!.path,
        ));
      }
      if (_trainingCardDocFile != null) {
        request.files.add(await http.MultipartFile.fromPath(
          'traning_card_doc',
          _trainingCardDocFile!.path,
        ));
      }
      if (_gatePassDocFile != null) {
        request.files.add(await http.MultipartFile.fromPath(
          'gate_pass_doc',
          _gatePassDocFile!.path,
        ));
      }
      if (_hazardousGoodsDocFile != null) {
        request.files.add(await http.MultipartFile.fromPath(
          'hazardous_goods_doc',
          _hazardousGoodsDocFile!.path,
        ));
      }
      if (_helperAadharDocFile != null) {
        request.files.add(await http.MultipartFile.fromPath(
          'helper_aadhar_doc',
          _helperAadharDocFile!.path,
        ));
      }

      print('Sending request to add crew member with tanker ID: ${widget.tankerId}');
      print('Total files: ${request.files.length}');

      // Send the request
      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);

      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);

        if (responseData['status'] == 'success') {
          _showSnackBar('Crew member added successfully');
          Navigator.pop(context, true);
        } else {
          _showSnackBar(responseData['message'] ?? 'Failed to add crew member');
        }
      } else {
        _showSnackBar('Server error: ${response.statusCode}');
      }
    } catch (e) {
      print('Error adding crew member: $e');
      _showSnackBar('Network error: $e');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: message.toLowerCase().contains('success')
            ? Colors.green
            : Colors.red,
      ),
    );
  }

  // Method to handle image/document picking
  Future<void> _pickDocument(String type) async {
    try {
      final XFile? pickedFile = await _picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 80,
        maxWidth: 800,
        maxHeight: 800,
      );

      if (pickedFile != null) {
        final file = File(pickedFile.path);
        setState(() {
          switch (type) {
            case 'aadhar':
              _aadharDocFile = file;
              break;
            case 'training_card':
              _trainingCardDocFile = file;
              break;
            case 'gate_pass':
              _gatePassDocFile = file;
              break;
            case 'hazardous_goods':
              _hazardousGoodsDocFile = file;
              break;
            case 'helper_aadhar':
              _helperAadharDocFile = file;
              break;
          }
        });
        _showSnackBar('Document selected successfully');
      }
    } catch (e) {
      _showSnackBar('Error selecting document: $e');
    }
  }

  // Method to handle date selection
  Future<void> _selectDate(TextEditingController controller) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: AppColors.primary,
              onPrimary: Colors.white,
              surface: Colors.white,
              onSurface: Colors.black,
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      controller.text = DateFormat('yyyy-MM-dd').format(picked);
    }
  }

  Widget _buildDateField(String label, TextEditingController controller, {bool isRequired = false}) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, top: 20),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 5),
                child: Text(
                  isRequired ? '$label *' : label,
                  style: TextStyle(fontWeight: FontWeight.w400, fontSize: 12, color: AppColors.text),
                ),
              ),
              SizedBox(height: 5),
              GestureDetector(
                onTap: () => _selectDate(controller),
                child: Container(
                  height: 60,
                  width: MediaQuery.of(context).size.width * 0.9,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: AppColors.primary, width: 1),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10, right: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          controller.text.isEmpty ? 'DD-MM-YYYY' : controller.text,
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              color: controller.text.isEmpty ? AppColors.text.withOpacity(0.5) : AppColors.text
                          ),
                        ),
                        SvgPicture.asset(
                          'assets/images/Calender1.svg',
                          fit: BoxFit.contain,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Widget _buildDocumentUpload(String label, File? file, String type, {bool isRequired = false}) {
  //   final hasFile = file != null;
  //   final fileName = hasFile ? file.path.split('/').last : 'No file selected';
  //
  //   return Padding(
  //     padding: const EdgeInsets.only(left: 20, top: 20),
  //     child: Row(
  //       children: [
  //         Column(
  //           crossAxisAlignment: CrossAxisAlignment.start,
  //           children: [
  //             Padding(
  //               padding: const EdgeInsets.only(left: 5),
  //               child: Text(
  //                 isRequired ? '$label *' : label,
  //                 style: TextStyle(fontWeight: FontWeight.w400, fontSize: 12, color: AppColors.text),
  //               ),
  //             ),
  //             SizedBox(height: 5),
  //             GestureDetector(
  //               onTap: () => _pickDocument(type),
  //               child: Container(
  //                 height: 60,
  //                 width: MediaQuery.of(context).size.width * 0.9,
  //                 decoration: BoxDecoration(
  //                   borderRadius: BorderRadius.circular(12),
  //                   border: Border.all(
  //                       color: hasFile ? Colors.green : AppColors.primary,
  //                       width: hasFile ? 2 : 1
  //                   ),
  //                 ),
  //                 child: Padding(
  //                   padding: const EdgeInsets.only(left: 10, right: 20),
  //                   child: Row(
  //                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                     children: [
  //                       Expanded(
  //                         child: Column(
  //                           mainAxisAlignment: MainAxisAlignment.center,
  //                           crossAxisAlignment: CrossAxisAlignment.start,
  //                           children: [
  //                             Text(
  //                               hasFile ? 'Selected: $fileName' : 'Tap to upload document',
  //                               style: TextStyle(
  //                                 fontSize: 14,
  //                                 fontWeight: FontWeight.w400,
  //                                 color: hasFile ? Colors.green : AppColors.text,
  //                               ),
  //                               overflow: TextOverflow.ellipsis,
  //                             ),
  //                             if (hasFile)
  //                               Text(
  //                                 'Tap to change',
  //                                 style: TextStyle(
  //                                   fontSize: 12,
  //                                   color: Colors.green.withOpacity(0.7),
  //                                 ),
  //                               ),
  //                           ],
  //                         ),
  //                       ),
  //                       Row(
  //                         children: [
  //                           if (!hasFile)
  //                             SvgPicture.asset(
  //                               'assets/images/Camera.svg',
  //                               fit: BoxFit.contain,
  //                             ),
  //                           SizedBox(width: 10),
  //                           Icon(
  //                             hasFile ? Icons.check_circle : Icons.upload,
  //                             color: hasFile ? Colors.green : AppColors.primary,
  //                             size: 24,
  //                           ),
  //                         ],
  //                       ),
  //                     ],
  //                   ),
  //                 ),
  //               ),
  //             ),
  //             if (isRequired && !hasFile)
  //               Padding(
  //                 padding: const EdgeInsets.only(left: 5, top: 4),
  //                 child: Text(
  //                   'This document is required',
  //                   style: TextStyle(
  //                     fontSize: 12,
  //                     color: Colors.red,
  //                   ),
  //                 ),
  //               ),
  //           ],
  //         ),
  //       ],
  //     ),
  //   );
  // }
  Widget _buildDocumentUpload(String label, File? file, String type, {bool isRequired = false}) {
    final hasFile = file != null;
    final fileName = hasFile ? file.path.split('/').last : 'No file selected';

    return Padding(
      padding: const EdgeInsets.only(left: 20, top: 20),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 5),
                child: Text(
                  isRequired ? '$label *' : label,
                  style: TextStyle(fontWeight: FontWeight.w400, fontSize: 12, color: AppColors.text),
                ),
              ),
              SizedBox(height: 5),
              GestureDetector(
                onTap: () => _pickDocument(type),
                child: Container(
                  height: 60,
                  width: MediaQuery.of(context).size.width * 0.9,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                        color: hasFile ? Colors.green : AppColors.primary,
                        width: hasFile ? 2 : 1
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10, right: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                hasFile ? 'Selected: $fileName' : 'Tap to upload document',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: hasFile ? Colors.green : AppColors.text,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                              if (hasFile)
                                Text(
                                  'Tap to change',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.green.withOpacity(0.7),
                                  ),
                                ),
                            ],
                          ),
                        ),
                        Row(
                          children: [
                            if (!hasFile)
                              SvgPicture.asset(
                                'assets/images/Camera.svg',
                                fit: BoxFit.contain,
                              ),
                            SizedBox(width: 10),
                            // Only show check icon when file is selected, no upload icon when no file
                            if (hasFile)
                              Icon(
                                Icons.check_circle,
                                color: Colors.green,
                                size: 24,
                              ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              if (isRequired && !hasFile)
                Padding(
                  padding: const EdgeInsets.only(left: 5, top: 4),
                  // child: Text(
                  //   'This document is required',
                  //   style: TextStyle(
                  //     fontSize: 12,
                  //     color: Colors.red,
                  //   ),
                  // ),
                ),
            ],
          ),
        ],
      ),
    );
  }
  @override
  void dispose() {
    // Dispose all controllers
    _driverNameController.dispose();
    _driverLicenseController.dispose();
    _mobileController.dispose();
    _aadharController.dispose();
    _helperNameController.dispose();
    _helperMobileController.dispose();
    _remarkController.dispose();
    _licenseExpDateController.dispose();
    _gatePassExpDateController.dispose();
    _trainingCardExpDateController.dispose();
    _hazardousGoodsExpDateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Container(
      height: screenHeight * 0.9,
      width: screenWidth * 0.99,
      child: Column(
        children: [
          SizedBox(height: 2),
          Container(
            height: 5,
            width: 53,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: AppColors.alert,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 15, right: 8, bottom: 8, top: 20),
            child: Row(
              children: [
                Container(
                  height: screenHeight * 0.06,
                  width: screenHeight * 0.06,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: AppColors.primary,
                  ),
                  child: SvgPicture.asset(
                    'assets/images/Credit.svg',
                    fit: BoxFit.none,
                    color: AppColors.background,
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Add Crew Member',
                        style: TextStyle(fontWeight: FontWeight.w500, fontSize: 24, color: AppColors.secondary),
                      ),
                      Text(
                        'Tanker ID: ${widget.tankerId}',
                        style: TextStyle(fontWeight: FontWeight.w400, fontSize: 14, color: AppColors.icon),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 20),
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                children: [
                  SizedBox(height: 20),

                  // Driver Name
                  SizedBox(
                    width: screenWidth * 0.9,
                    child: TextField(
                      controller: _driverNameController,
                      decoration: InputDecoration(
                        labelText: "Driver Name *",
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: AppColors.primary, width: 1),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),

                  // Driver License Number
                  SizedBox(
                    width: screenWidth * 0.9,
                    child: TextField(
                      controller: _driverLicenseController,
                      inputFormatters: [
                        AlphanumericInputFormatter(),
                        LengthLimitingTextInputFormatter(20),
                      ],
                      decoration: InputDecoration(
                        labelText: "Driver License Number *",
                        hintText: "e.g. DL1420110012345",
                        helperText: "Only letters and numbers allowed (no spaces)",
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

                  // License Expiry Date
                  _buildDateField('License Expiry Date', _licenseExpDateController, isRequired: true),
                  SizedBox(height: 20),

                  // Mobile Number
                  SizedBox(
                    width: screenWidth * 0.9,
                    child: TextField(
                      controller: _mobileController,
                      keyboardType: TextInputType.phone,
                      inputFormatters: [
                        NumericOnlyInputFormatter(),
                        LengthLimitingTextInputFormatter(10),
                      ],
                      decoration: InputDecoration(
                        labelText: "Mobile Number *",
                        hintText: "e.g. 9876543210",
                        helperText: "Only numbers allowed (10 digits)",
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
                  SizedBox(height: 20),

                  // Aadhaar Number
                  SizedBox(
                    width: screenWidth * 0.9,
                    child: TextField(
                      controller: _aadharController,
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        NumericOnlyInputFormatter(),
                        LengthLimitingTextInputFormatter(12),
                      ],
                      decoration: InputDecoration(
                        labelText: "Aadhaar Number *",
                        hintText: "e.g. 123456789012",
                        helperText: "Only numbers allowed (12 digits)",
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

                  // Aadhar Document
                  _buildDocumentUpload('Driver Aadhar Card PDF', _aadharDocFile, 'aadhar', isRequired: true),
                  SizedBox(height: 20),

                  // Training Card Document
                  _buildDocumentUpload('Training Card Document', _trainingCardDocFile, 'training_card', isRequired: true),

                  // Training Card Expiry Date
                  _buildDateField('Training Card Expiry Date', _trainingCardExpDateController),
                  SizedBox(height: 20),

                  // Gate Pass Document
                  _buildDocumentUpload('Gate Pass Document', _gatePassDocFile, 'gate_pass', isRequired: true),

                  // Gate Pass Expiry Date
                  _buildDateField('Gate Pass Expiry Date', _gatePassExpDateController),
                  SizedBox(height: 20),

                  // Hazardous Goods Document
                  _buildDocumentUpload('Hazardous Goods Document', _hazardousGoodsDocFile, 'hazardous_goods', isRequired: true),

                  // Hazardous Goods Expiry Date
                  _buildDateField('Hazardous Goods Expiry Date', _hazardousGoodsExpDateController),
                  SizedBox(height: 20),

                  // Helper Details Section
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              'Assistant/Helper Details (Optional)',
                              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: AppColors.text),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 5),
                      SizedBox(
                        width: screenWidth * 0.9,
                        child: TextField(
                          controller: _helperNameController,
                          decoration: InputDecoration(
                            labelText: "Helper Name",
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(color: AppColors.primary, width: 1),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),

                  // Helper Mobile Number
                  SizedBox(
                    width: screenWidth * 0.9,
                    child: TextField(
                      controller: _helperMobileController,
                      keyboardType: TextInputType.phone,
                      inputFormatters: [
                        NumericOnlyInputFormatter(),
                        LengthLimitingTextInputFormatter(10),
                      ],
                      decoration: InputDecoration(
                        labelText: "Helper Mobile Number",
                        hintText: "e.g. 9876543210",
                        helperText: "Only numbers allowed (10 digits)",
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

                  // Helper Aadhar Document
                  _buildDocumentUpload('Helper Aadhar Card PDF', _helperAadharDocFile, 'helper_aadhar'),
                  SizedBox(height: 20),

                  // Remark
                  SizedBox(
                    height: 117,
                    width: screenWidth * 0.9,
                    child: TextField(
                      controller: _remarkController,
                      maxLines: 4,
                      decoration: InputDecoration(
                        labelText: "Remark",
                        labelStyle: TextStyle(color: AppColors.text),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: AppColors.primary, width: 1),
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: 20),
                  Container(
                    height: 60,
                    width: screenWidth * 0.9,
                    child: ElevatedButton(
                      onPressed: _isLoading ? null : _addCrewMember,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.button,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: _isLoading
                          ? CircularProgressIndicator(color: AppColors.background)
                          : Text(
                        "Add Crew Member",
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500, color: AppColors.background),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}