// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import '../../../controllers/AdminController/GetProductListController.dart';
// import '../../../models/AdminModels/ProductGraphModel.dart';
// import '../../../utils/colors.dart';
//
// class SalesGraph extends StatefulWidget {
//   final String productId;
//
//   const SalesGraph({super.key, required this.productId});
//
//   @override
//   State<SalesGraph> createState() => _SalesGraphState();
// }
//
// class _SalesGraphState extends State<SalesGraph> {
//   final GetProductController controller = Get.put(GetProductController());
//
//   // Use current month's date range by default
//   late String startDate;
//   late String endDate;
//
//   // For year and month selection
//   late int selectedYear;
//   late String selectedMonth;
//
//   @override
//   void initState() {
//     super.initState();
//
//     // Initialize with current month
//     final now = DateTime.now();
//     selectedYear = now.year;
//     selectedMonth = _getMonthName(now.month);
//
//     // Set date range for current month
//     _updateDateRange();
//
//     // Load graph data when screen initializes
//     _loadGraphData();
//   }
//
//   void _loadGraphData() {
//                   if (widget.productId.isNotEmpty) {
//       controller.getProductGraph(
//         productId: widget.productId,
//         startDate: startDate,
//         endDate: endDate,
//       );
//     } else {
//       // Show error if no valid product ID
//       Get.snackbar('Error', 'Invalid product selected');
//     }
//   }
//
//   String _getMonthName(int monthNumber) {
//     const months = [
//       '', 'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
//       'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
//     ];
//     return months[monthNumber];
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final mediaQuery = MediaQuery.of(context);
//     final screenHeight = mediaQuery.size.height;
//     final screenWidth = mediaQuery.size.width;
//
//     return Container(
//       height: screenHeight * 0.8,
//       child: Column(
//         children: [
//           // Handle bar
//           Container(
//             margin: EdgeInsets.symmetric(vertical: 8),
//             height: 4,
//             width: 40,
//             decoration: BoxDecoration(
//               color: Colors.grey[300],
//               borderRadius: BorderRadius.circular(2),
//             ),
//           ),
//
//           // Header
//           Padding(
//             padding: EdgeInsets.all(16),
//             child: Row(
//               children: [
//                 Icon(Icons.analytics, color: AppColors.primary, size: 32),
//                 SizedBox(width: 12),
//                 Expanded(
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         'Sales Analytics',
//                         style: TextStyle(
//                           fontSize: 24,
//                           fontWeight: FontWeight.w700,
//                           color: AppColors.secondary,
//                         ),
//                       ),
//                       Text(
//                         'Product ID: ${widget.productId}',
//                         style: TextStyle(
//                           fontSize: 14,
//                           color: AppColors.icon,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//
//           // Date selection controls
//           Padding(
//             padding: EdgeInsets.symmetric(horizontal: 16),
//             child: Row(
//               children: [
//                 Expanded(
//                   child: GestureDetector(
//                     onTap: _showYearPicker,
//                     child: Container(
//                       padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
//                       decoration: BoxDecoration(
//                         border: Border.all(color: AppColors.primary),
//                         borderRadius: BorderRadius.circular(8),
//                       ),
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Text('Year: $selectedYear'),
//                           Icon(Icons.arrow_drop_down),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),
//                 SizedBox(width: 12),
//                 Expanded(
//                   child: GestureDetector(
//                     onTap: _showMonthPicker,
//                     child: Container(
//                       padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
//                       decoration: BoxDecoration(
//                         border: Border.all(color: AppColors.primary),
//                         borderRadius: BorderRadius.circular(8),
//                       ),
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Text('Month: $selectedMonth'),
//                           Icon(Icons.arrow_drop_down),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//
//           SizedBox(height: 20),
//
//           // Graph content
//           Expanded(
//             child: Obx(() {
//               if (controller.isGraphLoading.value) {
//                 return Center(
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       CircularProgressIndicator(color: AppColors.primary),
//                       SizedBox(height: 16),
//                       Text('Loading sales data...'),
//                     ],
//                   ),
//                 );
//               }
//
//               // Check if we have valid graph data
//               if (controller.productGraphModel.value.data?.isNotEmpty == true) {
//                 return _buildGraphData(controller.productGraphModel.value.data!, screenWidth, screenHeight);
//               } else {
//                 return _buildErrorState(screenWidth, screenHeight);
//               }
//             }),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildGraphData(List<Data> graphData, double screenWidth, double screenHeight) {
//     return Padding(
//       padding: EdgeInsets.all(16),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             'Sales Data for $selectedMonth $selectedYear',
//             style: TextStyle(
//               fontSize: 18,
//               fontWeight: FontWeight.w600,
//               color: AppColors.secondary,
//             ),
//           ),
//           SizedBox(height: 16),
//           Expanded(
//             child: GridView.builder(
//               gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                 crossAxisCount: 3,
//                 crossAxisSpacing: 16,
//                 mainAxisSpacing: 16,
//                 childAspectRatio: 0.8,
//               ),
//               itemCount: graphData.length,
//               itemBuilder: (context, index) {
//                 final data = graphData[index];
//                 final date = DateTime.tryParse(data.date ?? '');
//
//                 return Container(
//                   padding: EdgeInsets.all(12),
//                   decoration: BoxDecoration(
//                     color: index == 0 ? AppColors.primary : Colors.white,
//                     borderRadius: BorderRadius.circular(12),
//                     border: Border.all(
//                       color: index == 0 ? AppColors.primary : Colors.grey.shade300,
//                     ),
//                     boxShadow: [
//                       BoxShadow(
//                         color: Colors.grey.withOpacity(0.1),
//                         spreadRadius: 1,
//                         blurRadius: 4,
//                         offset: Offset(0, 2),
//                       ),
//                     ],
//                   ),
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                                           Text(
//                       '${date?.day ?? '??'}',
//                       style: TextStyle(
//                         fontSize: 24,
//                         fontWeight: FontWeight.w700,
//                         color: index == 0 ? Colors.white : AppColors.secondary,
//                       ),
//                     ),
//                     Text(
//                       date != null ? _getMonthAbbreviation(date) : '???',
//                       style: TextStyle(
//                         fontSize: 12,
//                         color: index == 0 ? Colors.white : AppColors.icon,
//                       ),
//                     ),
//                       SizedBox(height: 8),
//                       Text(
//                         '₹${data.amount ?? 0}',
//                         style: TextStyle(
//                           fontSize: 14,
//                           fontWeight: FontWeight.w600,
//                           color: index == 0 ? Colors.white : AppColors.primary,
//                         ),
//                       ),
//                     ],
//                   ),
//                 );
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildErrorState(double screenWidth, double screenHeight) {
//     return Center(
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Icon(Icons.analytics, size: 64, color: Colors.grey),
//           SizedBox(height: 16),
//           Text(
//             'No Sales Data Available',
//             style: TextStyle(
//               fontSize: 18,
//               fontWeight: FontWeight.w600,
//               color: AppColors.text,
//             ),
//           ),
//           SizedBox(height: 8),
//           Text(
//             'No data found for the selected period.',
//             style: TextStyle(
//               fontSize: 14,
//               color: AppColors.icon,
//             ),
//           ),
//           SizedBox(height: 24),
//           ElevatedButton(
//             onPressed: _loadGraphData,
//             style: ElevatedButton.styleFrom(
//               backgroundColor: AppColors.primary,
//             ),
//             child: Text(
//               'Retry',
//               style: TextStyle(color: Colors.white),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   String _getMonthAbbreviation(DateTime date) {
//     const months = [
//       '', 'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
//       'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
//     ];
//     return months[date.month];
//   }
//
//   void _showYearPicker() {
//     showDialog(
//       context: context,
//       builder: (context) => AlertDialog(
//         title: Text('Select Year'),
//         content: Container(
//           height: 200,
//           width: 200,
//           child: ListView.builder(
//             itemCount: 10, // Last 10 years
//             itemBuilder: (context, index) {
//               int year = DateTime.now().year - index;
//               return ListTile(
//                 title: Text(year.toString()),
//                 onTap: () {
//                   setState(() {
//                     selectedYear = year;
//                   });
//                   Navigator.pop(context);
//                   _updateDateRange();
//                 },
//               );
//             },
//           ),
//         ),
//       ),
//     );
//   }
//
//   void _showMonthPicker() {
//     const months = [
//       'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
//       'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
//     ];
//
//     showDialog(
//       context: context,
//       builder: (context) => AlertDialog(
//         title: Text('Select Month'),
//         content: Container(
//           height: 200,
//           width: 200,
//           child: ListView.builder(
//             itemCount: months.length,
//             itemBuilder: (context, index) => ListTile(
//               title: Text(months[index]),
//               onTap: () {
//                 setState(() {
//                   selectedMonth = months[index];
//                 });
//                 Navigator.pop(context);
//                 _updateDateRange();
//               },
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
//   void _updateDateRange() {
//     // Update date range based on selected year and month
//     int monthNumber = [
//       'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
//       'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
//     ].indexOf(selectedMonth) + 1;
//
//     // Set start date to first day of selected month/year
//     startDate = '$selectedYear-${monthNumber.toString().padLeft(2, '0')}-01';
//
//     // Set end date to last day of selected month/year
//     int lastDay = DateTime(selectedYear, monthNumber + 1, 0).day;
//     endDate = '$selectedYear-${monthNumber.toString().padLeft(2, '0')}-$lastDay';
//
//     // Reload graph data
//     _loadGraphData();
//   }
// }
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../controllers/AdminController/GetProductListController.dart';
import '../../../models/AdminModels/ProductGraphModel.dart';
import '../../../utils/colors.dart';

class SalesGraph extends StatefulWidget {
  final String productId;

  const SalesGraph({super.key, required this.productId});

  @override
  State<SalesGraph> createState() => _SalesGraphState();
}

class _SalesGraphState extends State<SalesGraph> {
  final GetProductController controller = Get.put(GetProductController());

  // Use current month's date range by default
  late String startDate;
  late String endDate;

  // For year and month selection
  late int selectedYear;
  late String selectedMonth;

  @override
  void initState() {
    super.initState();

    // Initialize with current month
    final now = DateTime.now();
    selectedYear = now.year;
    selectedMonth = _getMonthName(now.month);

    // Set date range for current month
    _updateDateRange();

    // Load graph data when screen initializes
    _loadGraphData();
  }

  void _loadGraphData() {
    if (widget.productId.isNotEmpty) {
      controller.getProductGraph(
        productId: widget.productId,
        startDate: startDate,
        endDate: endDate,
      );
    } else {
      // Show error if no valid product ID
      Get.snackbar('Error', 'Invalid product selected');
    }
  }

  String _getMonthName(int monthNumber) {
    const months = [
      '', 'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
    ];
    return months[monthNumber];
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final screenHeight = mediaQuery.size.height;
    final screenWidth = mediaQuery.size.width;

    return Container(
      height: screenHeight * 0.8,
      child: Column(
        children: [
          // Handle bar
          Container(
            margin: EdgeInsets.symmetric(vertical: 8),
            height: 4,
            width: 40,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(2),
            ),
          ),

          // Header
          Padding(
            padding: EdgeInsets.all(16),
            child: Row(
              children: [
                Icon(Icons.analytics, color: AppColors.primary, size: 32),
                SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Sales Analytics',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w700,
                          color: AppColors.secondary,
                        ),
                      ),
                      Text(
                        'Product ID: ${widget.productId}',
                        style: TextStyle(
                          fontSize: 14,
                          color: AppColors.icon,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Date selection controls
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: _showYearPicker,
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                      decoration: BoxDecoration(
                        border: Border.all(color: AppColors.primary),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Year: $selectedYear'),
                          Icon(Icons.arrow_drop_down),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: GestureDetector(
                    onTap: _showMonthPicker,
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                      decoration: BoxDecoration(
                        border: Border.all(color: AppColors.primary),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Month: $selectedMonth'),
                          Icon(Icons.arrow_drop_down),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          SizedBox(height: 20),

          // Graph content
          Expanded(
            child: Obx(() {
              if (controller.isGraphLoading.value) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircularProgressIndicator(color: AppColors.primary),
                      SizedBox(height: 16),
                      Text('Loading sales data...'),
                    ],
                  ),
                );
              }

              // Check if we have valid graph data
              if (controller.productGraphModel.value.data?.isNotEmpty == true) {
                return _buildHorizontalGraph(controller.productGraphModel.value.data!, screenWidth, screenHeight);
              } else {
                return _buildErrorState(screenWidth, screenHeight);
              }
            }),
          ),
        ],
      ),
    );
  }

  Widget _buildHorizontalGraph(List<Data> graphData, double screenWidth, double screenHeight) {
    // Sort data by date to ensure chronological order
    graphData.sort((a, b) => (a.date ?? '').compareTo(b.date ?? ''));

    // Get max amount for calculating bar heights
    double maxAmount = graphData.map((e) => e.amount ?? 0).reduce((a, b) => a > b ? a : b).toDouble();
    if (maxAmount == 0) maxAmount = 1; // Prevent division by zero

    return Padding(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Sales Data for $selectedMonth $selectedYear',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: AppColors.secondary,
            ),
          ),
          SizedBox(height: 16),

          // Graph container
          Expanded(
            child: Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey.shade300),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    spreadRadius: 1,
                    blurRadius: 4,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                children: [
                  // Amount labels on top
                  Container(
                    height: 20,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('0', style: TextStyle(fontSize: 12, color: Colors.grey)),
                        Text('₹${maxAmount.toInt()}', style: TextStyle(fontSize: 12, color: Colors.grey)),
                      ],
                    ),
                  ),

                  SizedBox(height: 8),

                  // Graph bars area
                  Expanded(
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: graphData.length,
                      itemBuilder: (context, index) {
                        final data = graphData[index];
                        final date = DateTime.tryParse(data.date ?? '');
                        final amount = data.amount ?? 0;
                        final barHeight = (amount / maxAmount) * 150; // Max bar height

                        return Container(
                          margin: EdgeInsets.only(right: 16),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              // Amount above bar
                              Text(
                                '₹$amount',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.primary,
                                ),
                              ),
                              SizedBox(height: 4),

                              // Bar
                              Container(
                                width: 30,
                                height: barHeight,
                                decoration: BoxDecoration(
                                  color: AppColors.primary,
                                  borderRadius: BorderRadius.vertical(
                                    top: Radius.circular(4),
                                  ),
                                ),
                              ),
                              SizedBox(height: 8),

                              // Month label
                              Text(
                                '${date?.day ?? '??'}\n${date != null ? _getMonthAbbreviation(date) : '???'}',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 12,
                                  color: AppColors.text,
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),

          SizedBox(height: 16),

          // Summary section (like in your screenshot)
          Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.grey[50],
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.grey.shade300),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Total Sales',
                      style: TextStyle(
                        fontSize: 14,
                        color: AppColors.icon,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      '₹${graphData.map((e) => e.amount ?? 0).reduce((a, b) => a + b)}',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: AppColors.secondary,
                      ),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      'Highest Sale',
                      style: TextStyle(
                        fontSize: 14,
                        color: AppColors.icon,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      '₹$maxAmount',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: AppColors.primary,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildErrorState(double screenWidth, double screenHeight) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.analytics, size: 64, color: Colors.grey),
          SizedBox(height: 16),
          Text(
            'No Sales Data Available',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: AppColors.text,
            ),
          ),
          SizedBox(height: 8),
          Text(
            'No data found for the selected period.',
            style: TextStyle(
              fontSize: 14,
              color: AppColors.icon,
            ),
          ),
          SizedBox(height: 24),
          ElevatedButton(
            onPressed: _loadGraphData,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
            ),
            child: Text(
              'Retry',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  String _getMonthAbbreviation(DateTime date) {
    const months = [
      '', 'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
    ];
    return months[date.month];
  }

  void _showYearPicker() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Select Year'),
        content: Container(
          height: 200,
          width: 200,
          child: ListView.builder(
            itemCount: 10, // Last 10 years
            itemBuilder: (context, index) {
              int year = DateTime.now().year - index;
              return ListTile(
                title: Text(year.toString()),
                onTap: () {
                  setState(() {
                    selectedYear = year;
                  });
                  Navigator.pop(context);
                  _updateDateRange();
                },
              );
            },
          ),
        ),
      ),
    );
  }

  void _showMonthPicker() {
    const months = [
      'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
    ];

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Select Month'),
        content: Container(
          height: 200,
          width: 200,
          child: ListView.builder(
            itemCount: months.length,
            itemBuilder: (context, index) => ListTile(
              title: Text(months[index]),
              onTap: () {
                setState(() {
                  selectedMonth = months[index];
                });
                Navigator.pop(context);
                _updateDateRange();
              },
            ),
          ),
        ),
      ),
    );
  }

  void _updateDateRange() {
    // Update date range based on selected year and month
    int monthNumber = [
      'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
    ].indexOf(selectedMonth) + 1;

    // Set start date to first day of selected month/year
    startDate = '$selectedYear-${monthNumber.toString().padLeft(2, '0')}-01';

    // Set end date to last day of selected month/year
    int lastDay = DateTime(selectedYear, monthNumber + 1, 0).day;
    endDate = '$selectedYear-${monthNumber.toString().padLeft(2, '0')}-$lastDay';

    // Reload graph data
    _loadGraphData();
  }
}