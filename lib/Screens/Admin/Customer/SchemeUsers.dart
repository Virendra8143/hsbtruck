

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';


import '../../../Utils/colors.dart';
import '../../../controllers/CustomerController.dart';
import 'AddCustomerScreen.dart';
import 'SEditingoptions.dart';
import 'SUsers.dart';

class Schemesuers extends StatelessWidget {
  const Schemesuers({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Get CustomerController
    final CustomerController customerController = Get.put(CustomerController());

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            backgroundColor: Colors.transparent,
            builder: (context) => AddCustomerScreen(),
          );
        },
        backgroundColor: AppColors.primary,
        child: Icon(Icons.add, color: Colors.white, size: 30),
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Header with logo and settings
            Padding(
              padding: const EdgeInsets.only(top: 45,left: 10,right: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image.asset(
                    'assets/images/HSB.png',
                    height: 40,
                  ),
                  IconButton(
                    onPressed: () {
                      // Settings action
                    },
                    icon: const Icon(Icons.settings, color: Color(0xFF0A1172)),
                  ),
                ],
              ),
            ),

            // Back button and title
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back),
                    onPressed: () => Navigator.pop(context),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'Customer List',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primary,
                    ),
                  ),
                  Spacer(),
                  Obx(() => Text(
                    'Total: ${customerController.customerList.length}',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[600],
                    ),
                  )),
                ],
              ),
            ),

            // Search bar
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Search Customer by name, phone or aadhar',
                  prefixIcon: const Icon(Icons.search, color: Colors.grey),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  contentPadding: const EdgeInsets.symmetric(vertical: 0.0),
                ),
                onChanged: (value) {
                  customerController.searchCustomers(value);
                },
              ),
            ),

            // Debug buttons
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Row(
                children: [
                  // ElevatedButton.icon(
                  //   onPressed: () {
                  //     customerController.refreshList();
                  //   },
                  //   icon: Icon(Icons.refresh, size: 18),
                  //   label: Text('Refresh'),
                  //   style: ElevatedButton.styleFrom(
                  //     backgroundColor: AppColors.primary,
                  //     foregroundColor: Colors.white,
                  //     padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  //   ),
                  // ),
                  SizedBox(width: 10),
                  // OutlinedButton.icon(
                  //   onPressed: () {
                  //     customerController.testCorrectEndpoint();
                  //   },
                  //   icon: Icon(Icons.verified, size: 18),
                  //   label: Text('Test API'),
                  //   style: OutlinedButton.styleFrom(
                  //     foregroundColor: Colors.green,
                  //     side: BorderSide(color: Colors.green),
                  //     padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  //   ),
                  // ),
                ],
              ),
            ),

            // Stats row
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Obx(() => Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildStatCard('Total', '${customerController.customerList.length}', AppColors.primary),
                  _buildStatCard('Active', '${customerController.getActiveCustomersCount()}', Colors.green),
                  _buildStatCard('Inactive', '${customerController.getInactiveCustomersCount()}', Colors.orange),
                ],
              )),
            ),

            SizedBox(height: 10),

            // Customer cards - Use Obx to react to changes
            Expanded(
              child: Obx(() {
                // Show loading indicator when loading
                if (customerController.isLoading.value) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircularProgressIndicator(color: AppColors.primary),
                        SizedBox(height: 16),
                        Text(
                          'Loading customers...',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  );
                }

                // Show error message if any
                if (customerController.errorMessage.value.isNotEmpty) {
                  return _buildErrorState(context, customerController);
                }

                // Check if filtered list is empty
                if (customerController.filteredCustomerList.isEmpty) {
                  return _buildEmptyState(context, customerController);
                }

                // Show customer list
                return RefreshIndicator(
                  onRefresh: () async {
                    customerController.refreshList();
                    await Future.delayed(Duration(milliseconds: 500));
                  },
                  child: ListView.builder(
                    padding: const EdgeInsets.all(16.0),
                    itemCount: customerController.filteredCustomerList.length,
                    itemBuilder: (context, index) {
                      final customer = customerController.filteredCustomerList[index];
                      return _buildCustomerCard(context, customer, customerController);
                    },
                  ),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context, CustomerController controller) {
    return Center(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.people_outline,
              size: 100,
              color: Colors.grey[300],
            ),
            SizedBox(height: 20),
            Text(
              'No Customers Found',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w700,
                color: Colors.grey[600],
              ),
            ),
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40.0),
              child: Column(
                children: [
                  Text(
                    'Your customer list is empty.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[500],
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    'API: /get-customer-list/',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey[400],
                      fontFamily: 'monospace',
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 30),
            ElevatedButton.icon(
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  backgroundColor: Colors.transparent,
                  builder: (context) => AddCustomerScreen(),
                );
              },
              icon: Icon(Icons.person_add, size: 20),
              label: Text(
                'Add First Customer',
                style: TextStyle(fontSize: 16),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            SizedBox(height: 15),
            // OutlinedButton.icon(
            //   onPressed: () {
            //     controller.refreshList();
            //   },
            //   icon: Icon(Icons.refresh, size: 20),
            //   label: Text(
            //     'Refresh',
            //     style: TextStyle(fontSize: 16),
            //   ),
            //   style: OutlinedButton.styleFrom(
            //     padding: EdgeInsets.symmetric(horizontal: 30, vertical: 16),
            //     shape: RoundedRectangleBorder(
            //       borderRadius: BorderRadius.circular(10),
            //     ),
            //     side: BorderSide(color: AppColors.primary),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }

  Widget _buildErrorState(BuildContext context, CustomerController controller) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.error_outline, size: 60, color: Colors.red[300]),
            SizedBox(height: 16),
            Text(
              'Error Loading Data',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.red[600],
              ),
            ),
            SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Text(
                controller.errorMessage.value,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[600],
                ),
              ),
            ),
            SizedBox(height: 20),
            // ElevatedButton(
            //   onPressed: () {
            //     controller.refreshList();
            //   },
            //   child: Text('Retry'),
            //   style: ElevatedButton.styleFrom(
            //     backgroundColor: AppColors.primary,
            //     foregroundColor: Colors.white,
            //   ),
            // ),
          ],
        ),
      ),
    );
  }

  Widget _buildCustomerCard(BuildContext context, customer, CustomerController controller) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Status badge and ID
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                  decoration: BoxDecoration(
                    color: controller.getStatusColor(customer.status).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: controller.getStatusColor(customer.status),
                      width: 1,
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        controller.getStatusIcon(customer.status),
                        size: 14,
                        color: controller.getStatusColor(customer.status),
                      ),
                      SizedBox(width: 4),
                      Text(
                        controller.getStatusText(customer.status),
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: controller.getStatusColor(customer.status),
                        ),
                      ),
                    ],
                  ),
                ),
                Text(
                  'ID: ${_getShortId(customer.id)}', // Fixed: Using safe method
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),

            const SizedBox(height: 12),

            // Customer details
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        customer.name ?? 'No Name',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: AppColors.secondary,
                        ),
                      ),
                      SizedBox(height: 6),
                      if (customer.phone != null && customer.phone!.isNotEmpty)
                        Row(
                          children: [
                            Icon(Icons.phone, size: 16, color: Colors.grey[600]),
                            SizedBox(width: 6),
                            Text(
                              customer.phone!,
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey[700],
                              ),
                            ),
                          ],
                        ),
                      if (customer.aadharNumber != null && customer.aadharNumber!.isNotEmpty)
                        Row(
                          children: [
                            Icon(Icons.credit_card, size: 16, color: Colors.grey[600]),
                            SizedBox(width: 6),
                            Text(
                              'Aadhar: ${customer.aadharNumber!}',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey[700],
                              ),
                            ),
                          ],
                        ),
                    ],
                  ),
                ),

                // Action buttons
                Row(
                  children: [
                    // Edit button
                    // _buildActionButton(
                    //   icon: Icons.edit,
                    //   color: Colors.blue,
                    //   onTap: () {
                    //     showModalBottomSheet(
                    //       context: context,
                    //       isScrollControlled: true,
                    //       backgroundColor: Colors.transparent,
                    //       builder: (context) {
                    //         return AddCustomerScreen(
                    //           customer: customer,
                    //           isEditMode: true,
                    //         );
                    //       },
                    //     );
                    //   },
                    // ),
                    IconButton(
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                      icon: SvgPicture.asset(
                        'assets/images/Addicon.svg',
                        width: 30,

                      ),
                      onPressed: () {
                      },
                    ),
                    SizedBox(width: 10),
                    IconButton(
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                      icon: SvgPicture.asset(
                             'assets/images/View.svg',
                             width: 30,
                            color: AppColors.secondary,
                           ),
                      onPressed: () {
                        Get.to(() => SUsers(customerId: customer.id.toString()));
                      },
                    ),
                    SizedBox(width: 10),
                    // Replace the three dots icon button with this in Schemesuers:
                    IconButton(
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                      icon: Icon(
                        Icons.more_vert,
                        color: Colors.grey[700],
                        size: 24,
                      ),
                      onPressed: () {
                        showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          backgroundColor: Colors.transparent,
                          builder: (context) {
                            return SEditingOption(
                              customer: customer, // Pass customer data
                            );
                          },
                        );
                      },
                    ),


                    // More options menu
                    // PopupMenuButton<String>(
                    //   icon: Container(
                    //     padding: const EdgeInsets.all(8),
                    //     decoration: BoxDecoration(
                    //       color: Colors.white,
                    //       shape: BoxShape.circle,
                    //       boxShadow: [
                    //         BoxShadow(
                    //           color: Colors.grey.withOpacity(0.2),
                    //           blurRadius: 4,
                    //           offset: Offset(0, 2),
                    //         ),
                    //       ],
                    //     ),
                    //     child: Icon(Icons.more_vert, size: 18, color: Colors.grey[700]),
                    //   ),
                    //   onSelected: (value) {
                    //     _handleMenuSelection(value, customer, controller, context);
                    //   },
                    //   itemBuilder: (BuildContext context) {
                    //     return [
                    //       // View Details
                    //       PopupMenuItem(
                    //         value: 'view',
                    //         child: Row(
                    //           children: [
                    //             Icon(Icons.remove_red_eye_outlined, size: 18, color: AppColors.primary),
                    //             SizedBox(width: 8),
                    //             Text('View Details'),
                    //           ],
                    //         ),
                    //       ),
                    //
                    //       // WhatsApp
                    //       PopupMenuItem(
                    //         value: 'whatsapp',
                    //         child: Row(
                    //           children: [
                    //             Icon(Icons.chat, size: 18, color: Colors.green),
                    //             SizedBox(width: 8),
                    //             Text('Send WhatsApp'),
                    //           ],
                    //         ),
                    //       ),
                    //
                    //       // Status change options
                    //       if (customer.status?.toLowerCase() != 'trash')
                    //         PopupMenuItem(
                    //           value: 'trash',
                    //           child: Row(
                    //             children: [
                    //               Icon(Icons.delete_outline, size: 18, color: Colors.red),
                    //               SizedBox(width: 8),
                    //               Text('Move to Trash'),
                    //             ],
                    //           ),
                    //         ),
                    //
                    //       if (customer.status?.toLowerCase() == 'trash')
                    //         PopupMenuItem(
                    //           value: 'restore',
                    //           child: Row(
                    //             children: [
                    //               Icon(Icons.restore, size: 18, color: Colors.green),
                    //               SizedBox(width: 8),
                    //               Text('Restore'),
                    //             ],
                    //           ),
                    //         ),
                    //
                    //       if (customer.status?.toLowerCase() == 'active')
                    //         PopupMenuItem(
                    //           value: 'inactive',
                    //           child: Row(
                    //             children: [
                    //               Icon(Icons.pause_circle, size: 18, color: Colors.orange),
                    //               SizedBox(width: 8),
                    //               Text('Mark Inactive'),
                    //             ],
                    //           ),
                    //         ),
                    //
                    //       if (customer.status?.toLowerCase() == 'inactive')
                    //         PopupMenuItem(
                    //           value: 'active',
                    //           child: Row(
                    //             children: [
                    //               Icon(Icons.check_circle, size: 18, color: Colors.green),
                    //               SizedBox(width: 8),
                    //               Text('Mark Active'),
                    //             ],
                    //           ),
                    //         ),
                    //     ];
                    //   },
                    // ),
                  ],
                ),
              ],
            ),

            const SizedBox(height: 12),

            // Products and date - SIMPLIFIED VERSION
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Note: Products field might not be in list response, only in detail
                if (customer.products != null && customer.products!.isNotEmpty)
                  Flexible(
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: AppColors.primary.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        'Products: ${customer.products}',
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 12,
                          color: AppColors.primary,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                Spacer(),
                // Just show createdAt if it exists - don't try to access createdDate
                if (customer.createdAt != null)
                  Text(
                    'Added: ${_formatDate(customer.createdAt!)}',
                    style: TextStyle(
                      fontSize: 11,
                      color: Colors.grey[500],
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatCard(String title, String count, Color color) {
    return Expanded(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 4),
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: color.withOpacity(0.3)),
        ),
        child: Column(
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey[600],
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: 4),
            Text(
              count,
              style: TextStyle(
                fontSize: 18,
                color: color,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              blurRadius: 4,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Icon(
          icon,
          color: color,
          size: 18,
        ),
      ),
    );
  }

  void _handleMenuSelection(String value, customer, CustomerController controller, BuildContext context) {
    switch (value) {
      case 'view':
        _showCustomerDetails(context, customer);
        break;
      case 'whatsapp':
        _shareViaWhatsApp(customer);
        break;
      case 'trash':
        _confirmDelete(customer, controller);
        break;
      case 'restore':
        _confirmRestore(customer, controller);
        break;
      case 'active':
        _confirmStatusChange(customer, controller, 'active');
        break;
      case 'inactive':
        _confirmStatusChange(customer, controller, 'inactive');
        break;
    }
  }

  void _showCustomerDetails(BuildContext context, customer) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Customer Details', style: TextStyle(color: AppColors.primary)),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildDetailItem('Name', customer.name ?? 'N/A'),
              _buildDetailItem('Phone', customer.phone ?? 'N/A'),
              _buildDetailItem('Aadhar Number', customer.aadharNumber ?? 'N/A'),
              _buildDetailItem('Status', customer.status ?? 'N/A'),
              _buildDetailItem('Created Date', customer.createdAt ?? 'N/A'),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Close', style: TextStyle(color: AppColors.primary)),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailItem(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey[600],
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 2),
          Text(
            value,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[800],
            ),
          ),
        ],
      ),
    );
  }

  void _shareViaWhatsApp(customer) {
    Get.snackbar(
      'WhatsApp',
      'Sharing functionality will be implemented soon',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.green,
      colorText: Colors.white,
    );
  }

  void _confirmDelete(customer, CustomerController controller) {
    Get.defaultDialog(
      title: 'Move to Trash',
      middleText: 'Are you sure you want to move ${customer.name} to trash?',
      textConfirm: 'Move to Trash',
      textCancel: 'Cancel',
      confirmTextColor: Colors.white,
      onConfirm: () {
        Get.back();
        controller.deleteCustomer(customer.id ?? '');
      },
    );
  }

  void _confirmRestore(customer, CustomerController controller) {
    Get.defaultDialog(
      title: 'Restore Customer',
      middleText: 'Are you sure you want to restore ${customer.name}?',
      textConfirm: 'Restore',
      textCancel: 'Cancel',
      confirmTextColor: Colors.white,
      onConfirm: () {
        Get.back();
        controller.restoreCustomer(customer.id ?? '');
      },
    );
  }

  void _confirmStatusChange(customer, CustomerController controller, String status) {
    String action = status == 'active' ? 'activate' : 'deactivate';
    Get.defaultDialog(
      title: status == 'active' ? 'Activate Customer' : 'Deactivate Customer',
      middleText: 'Are you sure you want to $action ${customer.name}?',
      textConfirm: status == 'active' ? 'Activate' : 'Deactivate',
      textCancel: 'Cancel',
      confirmTextColor: Colors.white,
      onConfirm: () {
        Get.back();
        controller.updateCustomerStatus(customer.id ?? '', status);
      },
    );
  }

  String _formatDate(String dateString) {
    try {
      DateTime date = DateTime.parse(dateString);
      return '${date.day}/${date.month}/${date.year}';
    } catch (e) {
      // If parsing fails, try to extract date from the string
      if (dateString.contains(' ')) {
        return dateString.split(' ')[0].replaceAll('-', '/');
      }
      return dateString;
    }
  }

  String _getShortId(String? id) {
    if (id == null || id.isEmpty) return 'N/A';
    return id.length > 8 ? '${id.substring(0, 8)}...' : id;
  }
}