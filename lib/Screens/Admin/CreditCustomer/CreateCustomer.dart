import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../../../Widgets/CommonHeader.dart';
import '../../../Widgets/appbar/main_app_bar.dart';
import '../../../controllers/AdminController/CreditCoustomerController.dart';
import '../../../utils/colors.dart';
import '../../../Widgets/ManualScreen.dart';
import '../../../Widgets/NotificationsScreen.dart';
import 'AddCustomer.dart';
import 'CustomerDetails.dart';
import 'EditCustomerOption.dart';

class CreditCustomer extends StatefulWidget {
  const CreditCustomer({super.key});

  @override
  State<CreditCustomer> createState() => _CreditCustomerState();
}

class _CreditCustomerState extends State<CreditCustomer> {
  final CreditCoustomerController creditCoustomerController =
      Get.put(CreditCoustomerController());

  String _selectedFilter = 'All Customers';
  String _searchText = '';
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    creditCoustomerController.getCreditCustomerList();
  }

  void _onSearchChanged(String value) {
    setState(() {
      _searchText = value;
    });
    creditCoustomerController.getCreditCustomerList(searchText: value);
  }

  void _onFilterChanged(String filter) {
    setState(() {
      _selectedFilter = filter;
    });
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

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
        body: Obx(() => SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.all(16),
                child: Column(
                  children: [


                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center, // 👈 vertical center
                        children: [
                          Expanded(
                            flex: 1, // 👈 1 part (around 33%)
                            child: SvgPicture.asset(
                              'assets/images/worker staff.svg',
                              height: height * 0.18,
                              fit: BoxFit.contain,
                            ),
                          ),
                          SizedBox(width: 10),
                          Expanded(
                            flex: 2, // 👈 2 parts (around 67%)
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center, // 👈 vertically center text
                              children: [
                                Text(
                                  "Credit Customer",
                                  style: TextStyle(
                                    color: AppColors.primary,
                                    fontSize: 22,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                SizedBox(height: 5),
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(4),
                                    color: AppColors.secondary,
                                  ),
                                  padding: EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Total Credit Customer",
                                        style: TextStyle(
                                          color: AppColors.background,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                      Text(
                                        "${creditCoustomerController.getTotalCustomersCount()}",
                                        style: TextStyle(
                                          color: AppColors.background,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(height: 5),
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(4),
                                    color: AppColors.primary,
                                  ),
                                  padding: EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "Active",
                                            style: TextStyle(
                                              color: AppColors.background,
                                              fontSize: 12,
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                          Text(
                                            "${creditCoustomerController.getActiveCustomersCount()}",
                                            style: TextStyle(
                                              color: AppColors.background,
                                              fontSize: 12,
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 4),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "Inactive",
                                            style: TextStyle(
                                              color: AppColors.background,
                                              fontSize: 12,
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                          Text(
                                            "${creditCoustomerController.getInactiveCustomersCount()}",
                                            style: TextStyle(
                                              color: AppColors.background,
                                              fontSize: 12,
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: height * 0.02),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          _buildFilterTab('All Customers'),
                          SizedBox(width: 8),
                          _buildFilterTab('Active'),
                          SizedBox(width: 8),
                          _buildFilterTab('Inactive'),
                        ],
                      ),
                    ),
                    SizedBox(height: height * 0.02),
                    TextField(
                      controller: _searchController,
                      onChanged: _onSearchChanged,
                      decoration: InputDecoration(
                        prefixIcon: Icon(
                          Icons.search,
                          size: 28,
                          color: AppColors.primary,
                        ),
                        hintText: 'Search Customer',
                        contentPadding: const EdgeInsets.symmetric(vertical: 12),
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
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(
                            color: AppColors.primary,
                            width: 1,
                          ),
                        ),
                      ),
                    ),

                    SizedBox(height: 10),
                    _buildCustomerList(),
                    SizedBox(height: 16),
                  ],
                ),
              ),
            )),

        floatingActionButton: GestureDetector(
          onTap: () {
            showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              backgroundColor: Colors.transparent, // 👈 Important: make background transparent
              builder: (context) {
                return ClipRRect(
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(24)), // 👈 Round corners here
                  child: Container(
                    color: Colors.white, // 👈 Your bottom sheet background color
                    child: AddCustomer(), // 👈 Your content widget
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
        ),

      ),
    );
  }
  // Widget _buildCustomerList() {
  //   final allData = creditCoustomerController.customerList.value?.data ?? [];
  //   final filteredData = allData.where((customer) {
  //     if (_selectedFilter == 'Active') {
  //       return customer.status?.toLowerCase() == 'active';
  //     } else if (_selectedFilter == 'Inactive') {
  //       return customer.status?.toLowerCase() == 'in-active';
  //     }
  //     return true;
  //   }).toList();
  //
  //   if (filteredData.isEmpty) {
  //     return Padding(
  //       padding: const EdgeInsets.all(40),
  //       child: Column(
  //         children: [
  //           Icon(Icons.people_outline,
  //               size: 80, color: AppColors.secondary.withOpacity(0.5)),
  //           SizedBox(height: 16),
  //           Text("No customers found",
  //               style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
  //           Text("Try changing filters or search",
  //               style: TextStyle(fontSize: 14)),
  //         ],
  //       ));
  //     }
  //
  //
  //       return ListView.builder(
  //       shrinkWrap: true,
  //       physics: NeverScrollableScrollPhysics(),
  //       itemCount: filteredData.length,
  //       itemBuilder: (context, index) {
  //         final customer = filteredData[index];
  //         final isInactive = customer.status?.toLowerCase() == 'in-active';
  //
  //         return Card(
  //           margin: EdgeInsets.symmetric(vertical: 6),
  //           shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
  //           color: isInactive ? Colors.grey[100] : Colors.white,
  //           child: ListTile(
  //             contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
  //             leading: CircleAvatar(
  //               backgroundColor: isInactive
  //                   ? Colors.grey
  //                   : AppColors.primary.withOpacity(0.1),
  //               child: Text(
  //                   customer.name?.isNotEmpty == true
  //                       ? customer.name![0].toUpperCase()
  //                       : 'C',
  //                   style: TextStyle(
  //                       color: isInactive
  //                           ? Colors.white
  //                           : AppColors.primary,
  //                       fontWeight: FontWeight.bold)),
  //             ),
  //             title: Column(
  //               crossAxisAlignment: CrossAxisAlignment.start,
  //               children: [
  //                 Text(customer.companyType ?? 'N/A',
  //                     style: TextStyle(
  //                         fontSize: 14,
  //                         color: isInactive
  //                             ? Colors.grey
  //                             : AppColors.primary,
  //                         fontWeight: FontWeight.w700)),
  //                 Text(customer.name ?? 'No Name',
  //                     style: TextStyle(
  //                         fontSize: 18,
  //                         fontWeight: FontWeight.w700,
  //                         color: isInactive
  //                             ? Colors.grey
  //                             : Colors.black)),
  //                 if (customer.phone?.isNotEmpty == true)
  //                   Text(customer.phone!,
  //                       style: TextStyle(
  //                           fontSize: 12,
  //                           color: isInactive
  //                               ? Colors.grey
  //                               : AppColors.secondary)),
  //                 if (customer.gstNumber?.isNotEmpty == true)
  //                   Text('GST: ${customer.gstNumber}',
  //                       style: TextStyle(
  //                           fontSize: 12,
  //                           color: isInactive
  //                               ? Colors.grey
  //                               : AppColors.secondary)),
  //               ],
  //             ),
  //             // REMOVED the subtitle section that showed active/inactive text
  //             trailing: Row(
  //               mainAxisSize: MainAxisSize.min,
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
  //                         return CustomerDetails(
  //                           customerId: customer.id.toString(),
  //                         );
  //                       },
  //                     );
  //                   },
  //                   icon: SvgPicture.asset(
  //                     'assets/images/View.svg',
  //                     color: isInactive ? Colors.grey : null,
  //                   ),
  //                 ),
  //                 SizedBox(width: 10),
  //                 IconButton(
  //                   onPressed: () => showModalBottomSheet(
  //                     context: context,
  //                     isScrollControlled: true,
  //                     shape: RoundedRectangleBorder(
  //                       borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
  //                     ),
  //                     builder: (context) => EditCustomerOption(
  //                       customerId: customer.id.toString(),
  //                     ),
  //                   ),
  //                   icon: SvgPicture.asset(
  //                     'assets/images/3dots.svg',
  //                     color: isInactive ? Colors.grey : null,
  //                   ),
  //                 ),
  //               ],
  //             ),
  //           ),
  //         );
  //       },
  //     );
  //   }
  Widget _buildCustomerList() {
    final allData = creditCoustomerController.customerList.value?.data ?? [];
    final filteredData = allData.where((customer) {
      if (_selectedFilter == 'Active') {
        return customer.status?.toLowerCase() == 'active';
      } else if (_selectedFilter == 'Inactive') {
        return customer.status?.toLowerCase() == 'inactive';
      }
      return true;
    }).toList();

    if (filteredData.isEmpty) {
      return Padding(
        padding: const EdgeInsets.all(40),
        child: Column(
          children: [
            Icon(Icons.people_outline,
                size: 80, color: AppColors.secondary.withOpacity(0.5)),
            SizedBox(height: 16),
            Text("No customers found",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
            Text("Try changing filters or search",
                style: TextStyle(fontSize: 14)),
          ],
        ),
      );
    }
  //
  //   return ListView.builder(
  //     shrinkWrap: true,
  //     physics: NeverScrollableScrollPhysics(),
  //     itemCount: filteredData.length,
  //     itemBuilder: (context, index) {
  //       final customer = filteredData[index];
  //       return Card(
  //         margin: EdgeInsets.symmetric(vertical: 6),
  //         shape:
  //             RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
  //
  //         child: ListTile(
  //           contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
  //           leading: CircleAvatar(
  //             backgroundColor: AppColors.primary.withOpacity(0.1),
  //             child: Text(
  //                 customer.name?.isNotEmpty == true
  //                     ? customer.name![0].toUpperCase()
  //                     : 'C',
  //                 style: TextStyle(
  //                     color: AppColors.primary, fontWeight: FontWeight.bold)),
  //           ),
  //           title: Column(
  //             crossAxisAlignment: CrossAxisAlignment.start,
  //             children: [
  //               Text(customer.companyType ?? 'N/A',
  //                   style: TextStyle(
  //                       fontSize: 14,
  //                       color: AppColors.primary,
  //                       fontWeight: FontWeight.w700)),
  //               Text(customer.name ?? 'No Name',
  //                   style:
  //                       TextStyle(fontSize: 18, fontWeight: FontWeight.w700)),
  //               if (customer.phone?.isNotEmpty == true)
  //                 Text(customer.phone!,
  //                     style:
  //                         TextStyle(fontSize: 12, color: AppColors.secondary)),
  //               if (customer.gstNumber?.isNotEmpty == true)
  //                 Text('GST: ${customer.gstNumber}',
  //                     style:
  //                         TextStyle(fontSize: 12, color: AppColors.secondary)),
  //             ],
  //           ),
  //           subtitle: Container(
  //             margin: EdgeInsets.only(top: 4),
  //             padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
  //             decoration: BoxDecoration(
  //               color: customer.status?.toLowerCase() == 'active'
  //                   ? Colors.green.withOpacity(0.1)
  //                   : Colors.red.withOpacity(0.1),
  //               borderRadius: BorderRadius.circular(12),
  //             ),
  //             child: Text(customer.status ?? 'Unknown',
  //                 style: TextStyle(
  //                     color: customer.status?.toLowerCase() == 'active'
  //                         ? Colors.green
  //                         : Colors.red,
  //                     fontSize: 10,
  //                     fontWeight: FontWeight.w600)),
  //           ),
  //           trailing: Row(
  //             mainAxisSize: MainAxisSize.min,
  //             children: [
  //               IconButton(
  //                 onPressed: () {
  //                   showModalBottomSheet(
  //                     context: context,
  //                     isScrollControlled: true,
  //                     shape: RoundedRectangleBorder(
  //                       borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
  //                     ),
  //                     builder: (context) {
  //                       return CustomerDetails(
  //                         customerId: customer.id.toString(),
  //                       );
  //                     },
  //                   );
  //                 },
  //                 icon: SvgPicture.asset('assets/images/View.svg'),
  //               ),
  //               SizedBox(width: 10),
  //               IconButton(
  //                 onPressed: () => showModalBottomSheet(
  //                   context: context,
  //                   isScrollControlled: true,
  //                   shape: RoundedRectangleBorder(
  //                     borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
  //                   ),
  //                   builder: (context) => EditCustomerOption(
  //                     customerId: customer.id.toString(),
  //                   ),
  //                 ),
  //                 icon: SvgPicture.asset('assets/images/3dots.svg'),
  //               ),
  //             ],
  //           ),
  //         ),
  //       );
  //     },
  //   );
  // }

    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: filteredData.length,
      itemBuilder: (context, index) {
        final customer = filteredData[index];
        final isActive = customer.status?.toLowerCase() == 'active';
        final isInactive = customer.status?.toLowerCase() == 'inactive';

        return Card(
          elevation: 0,
          margin: const EdgeInsets.symmetric(vertical:6, horizontal: 4),
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
                // 🔹 Row 1 — Company Type + Icons
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        customer.companyType ?? 'N/A',
                        style: TextStyle(
                          color: isInactive ? Colors.grey : AppColors.primary,
                          fontSize: 18,
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
                                borderRadius:
                                BorderRadius.vertical(top: Radius.circular(16)),
                              ),
                              builder: (context) => CustomerDetails(
                                customerId: customer.id.toString(),
                              ),
                            );
                          },
                        ),
                        const SizedBox(width: 20),
                        IconButton(
                          padding: EdgeInsets.zero,
                          constraints: const BoxConstraints(),
                          icon: SvgPicture.asset(
                            'assets/images/3dots.svg',
                            width: 28,
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
                                borderRadius:
                                BorderRadius.vertical(top: Radius.circular(16)),
                              ),
                              builder: (context) => EditCustomerOption(
                                customerId: customer.id.toString(),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ],
                ),

                const SizedBox(height: 10),

                // 🔹 Row 2 — Avatar + Name + Number + GST
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      radius: 20,
                      backgroundColor: AppColors.primary.withOpacity(0.1),
                      child: Text(
                        customer.name?.isNotEmpty == true
                            ? customer.name![0].toUpperCase()
                            : 'C',
                        style: TextStyle(
                          color: AppColors.primary,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            customer.name ?? 'No Name',
                            style: TextStyle(
                              color: isInactive ? Colors.grey : AppColors.secondary,
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 4),
                          if (customer.phone?.isNotEmpty == true)
                            Text(
                              customer.phone!,
                              style: TextStyle(
                                color: AppColors.icon,
                                fontSize: 13,
                              ),
                            ),
                          const SizedBox(height: 4),
                          if (customer.gstNumber?.isNotEmpty == true)
                            Text(
                              'GST: ${customer.gstNumber}',
                              style: TextStyle(
                                color: AppColors.icon,
                                fontSize: 13,
                              ),
                            ),
                        ],
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 8),

                // 🔹 Status Tag
                Align(
                  alignment: Alignment.centerRight,
                  child: Container(
                    padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                    decoration: BoxDecoration(
                      color: isActive
                          ? Colors.green.withOpacity(0.1)
                          : Colors.red.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      customer.status ?? 'Unknown',
                      style: TextStyle(
                        color: isActive ? Colors.green : Colors.red,
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );

  }


  Widget _buildFilterTab(String title) {
    final bool isSelected = _selectedFilter == title;

    return GestureDetector(
      onTap: () => _onFilterChanged(title),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        height: 36,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primary : Colors.transparent,
          borderRadius: BorderRadius.circular(100),
          border: isSelected
              ? null
              : Border.all(
            color: AppColors.secondary,
            width: 0.8,
          ),
        ),
        child: Center(
          child: Text(
            title,
            style: TextStyle(
              color: isSelected ? Colors.white : AppColors.secondary,
              fontWeight: FontWeight.w600,
              fontSize: 14,
            ),
          ),
        ),
      ),
    );
  }

}
