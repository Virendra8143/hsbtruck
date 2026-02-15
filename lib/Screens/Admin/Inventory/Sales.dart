import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:intl/intl.dart';
import '../../../controllers/AdminController/GetProductListController.dart';
import '../../../models/AdminModels/ProductGraphModel.dart';
import '../../../utils/colors.dart';

class Sales extends StatefulWidget {
  final String? productId;
  
  const Sales({super.key, this.productId});

  @override
  State<Sales> createState() => _SalesState();
}

class _SalesState extends State<Sales> {
  final GetProductController controller = Get.put(GetProductController());

  // Dynamic date range based on current month
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
    final productId = widget.productId ?? "31"; // Default if no productId provided
    controller.getProductGraph(
      productId: productId,
      startDate: startDate,
      endDate: endDate,
    );
  }

  String _getMonthName(int monthNumber) {
    const months = [
      '', 'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
    ];
    return months[monthNumber];
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
    
    // Reload data when date range changes
    _loadGraphData();
  }

  // // Method to get ProductGraphModel from controller data
  // ProductGraphModel? get graphModel {
  //   if (controller.productGraphModel.value.isNotEmpty) {
  //     return ProductGraphModel.fromJson(controller.productGraphData.value);
  //   }
  //   return null;
  // }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final screenHeight = mediaQuery.size.height;
    final screenWidth = mediaQuery.size.width;

    return Container(
      height: screenHeight * 0.7,
      width: screenWidth * 0.99,
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(top: screenHeight * 0.01), // Reduced padding
            child: Container(
              height: 5,
              width: 53,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: AppColors.alert,
              ),
            ),
          ),
          SizedBox(height: screenHeight * 0.02), // Reduced spacing
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '#56425896',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: AppColors.primary,
                        ),
                      ),
                      Text(
                        'MSE20',
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 20,
                          color: AppColors.secondary,
                        ),
                      ),
                      Text(
                        'ST: 9KL',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: AppColors.icon,
                        ),
                      )
                    ],
                  ),
                ),
                Column(
                  children: [
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            // Functional year picker
                            _showYearPicker();
                          },
                          child: Container(
                            height: 33,
                            width: 92,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                              color: AppColors.tash,
                            ),
                            child: Center(
                              child: Text(
                                '$selectedYear',
                                style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 20,
                                  color: AppColors.secondary,
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: screenWidth * 0.02),
                        GestureDetector(
                          onTap: () {
                            // Functional month picker
                            _showMonthPicker();
                          },
                          child: Container(
                            height: 33,
                            width: 92,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                              color: AppColors.tash,
                            ),
                            child: Center(
                              child: Text(
                                selectedMonth,
                                style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 20,
                                  color: AppColors.secondary,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Click Year & Month to change analytics',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: AppColors.text,
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
          Expanded( // Wrap with Expanded to take available space
            child: Obx(() {
              if (controller.isGraphLoading.value) {
                return Padding(
                  padding: EdgeInsets.symmetric(vertical: screenHeight * 0.02), // Reduced padding
                  child: Column(
                    children: [
                      CircularProgressIndicator(color: AppColors.primary),
                      SizedBox(height: 16),
                      Text(
                        'Loading sales data...',
                        style: TextStyle(
                          fontSize: 16,
                          color: AppColors.text,
                        ),
                      ),
                    ],
                  ),
                );
              }

              // Check if we have valid graph data
              final data = controller.productGraphModel.value.data;
              if (data != null && data.isNotEmpty) {
                return _buildGraphData(data, screenWidth, screenHeight);
              } else {
                // Show error state or default data
                return _buildErrorState(screenWidth, screenHeight);
              }
            }),
          ),
        ],
      ),
    );
  }

  Widget _buildGraphData(List<Data> graphData, double screenWidth, double screenHeight) {
    return Padding(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Text(
            'Sales Analytics for $selectedMonth $selectedYear',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: AppColors.secondary,
            ),
          ),
          SizedBox(height: 8),
          Text(
            'Total Sales: ₹${_calculateTotalSales(graphData)}',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: AppColors.primary,
            ),
          ),
          SizedBox(height: 20),
          
          // Chart - Horizontally Scrollable
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    spreadRadius: 2,
                    blurRadius: 8,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              padding: EdgeInsets.all(16),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Container(
                    width: _calculateChartWidth(graphData, screenWidth),
                    height: _calculateChartHeight(graphData, screenHeight),
                    child: BarChart(
                    BarChartData(
                      alignment: BarChartAlignment.spaceEvenly,
                      maxY: _getMaxAmount(graphData),
                      barTouchData: BarTouchData(
                        enabled: true,
                        touchTooltipData: BarTouchTooltipData(
                          getTooltipColor: (group) => AppColors.primary.withOpacity(0.8),
                          getTooltipItem: (group, groupIndex, rod, rodIndex) {
                            final data = graphData[group.x.toInt()];
                            final date = DateTime.tryParse(data.date ?? '');
                            return BarTooltipItem(
                              '${date?.day ?? '??'} ${_getMonthAbbreviation(date ?? DateTime.now())}\n₹${data.amount ?? 0}',
                              TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                              ),
                            );
                          },
                        ),
                      ),
                      titlesData: FlTitlesData(
                        show: true,
                        bottomTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: true,
                            getTitlesWidget: (value, meta) {
                              if (value.toInt() < graphData.length) {
                                final data = graphData[value.toInt()];
                                final date = DateTime.tryParse(data.date ?? '');
                                return Padding(
                                  padding: EdgeInsets.only(top: 8),
                                  child: Text(
                                    '${date?.day ?? '??'}',
                                    style: TextStyle(
                                      color: AppColors.text,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 11,
                                    ),
                                  ),
                                );
                              }
                              return Text('');
                            },
                            reservedSize: 35,
                          ),
                        ),
                        leftTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: true,
                            getTitlesWidget: (value, meta) {
                              return Text(
                                '₹${_formatAmount(value)}',
                                style: TextStyle(
                                  color: AppColors.text,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 10,
                                ),
                              );
                            },
                            reservedSize: 50,
                            interval: _getSafeInterval(graphData),
                          ),
                        ),
                        topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                        rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                      ),
                      borderData: FlBorderData(
                        show: true,
                        border: Border(
                          bottom: BorderSide(color: Colors.grey.shade300, width: 1),
                          left: BorderSide(color: Colors.grey.shade300, width: 1),
                        ),
                      ),
                      barGroups: _createBarGroups(graphData),
                      gridData: FlGridData(
                        show: true,
                        drawVerticalLine: false,
                        horizontalInterval: _getSafeInterval(graphData),
                        getDrawingHorizontalLine: (value) {
                          return FlLine(
                            color: Colors.grey.shade200,
                            strokeWidth: 1,
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Calculate chart width to prevent overlapping
  double _calculateChartWidth(List<Data> graphData, double screenWidth) {
    // Minimum width per bar to prevent overlapping
    const double minBarWidth = 60.0;
    final calculatedWidth = graphData.length * minBarWidth;
    
    // Use calculated width if it's larger than screen width, otherwise use screen width
    return calculatedWidth > screenWidth ? calculatedWidth : screenWidth - 32; // 32 for padding
  }

  // Calculate chart height for Y-axis scrolling
  double _calculateChartHeight(List<Data> graphData, double screenHeight) {
    final maxAmount = _getMaxAmount(graphData);
    
    // Minimum height for small amounts, larger height for big amounts
    if (maxAmount > 500000) {
      return screenHeight * 1.2; // 120% of screen height for large amounts
    } else if (maxAmount > 100000) {
      return screenHeight * 0.8; // 80% of screen height for medium amounts
    } else {
      return screenHeight * 0.5; // 50% of screen height for small amounts
    }
  }

  // Helper methods for chart
  List<BarChartGroupData> _createBarGroups(List<Data> graphData) {
    return graphData.asMap().entries.map((entry) {
      final index = entry.key;
      final data = entry.value;
      return BarChartGroupData(
        x: index,
        barRods: [
          BarChartRodData(
            toY: (data.amount ?? 0).toDouble(),
            color: AppColors.primary,
            width: 24, // Slightly wider bars for better visibility
            borderRadius: BorderRadius.circular(4),
            gradient: LinearGradient(
              colors: [
                AppColors.primary,
                AppColors.primary.withOpacity(0.7),
              ],
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
            ),
          ),
        ],
      );
    }).toList();
  }

  double _getMaxAmount(List<Data> graphData) {
    if (graphData.isEmpty) return 100.0;
    final maxAmount = graphData.map((e) => e.amount ?? 0).reduce((a, b) => a > b ? a : b);
    // Ensure minimum value to avoid zero intervals
    final adjustedMax = maxAmount == 0 ? 100.0 : maxAmount.toDouble();
    return adjustedMax * 1.2; // Add 20% padding
  }

  String _calculateTotalSales(List<Data> graphData) {
    final total = graphData.fold(0, (sum, data) => sum + (data.amount ?? 0));
    return NumberFormat('#,##,###').format(total);
  }

  // Safe interval calculation to avoid zero division
  double _getSafeInterval(List<Data> graphData) {
    final maxAmount = _getMaxAmount(graphData);
    final interval = maxAmount / 5;
    return interval > 0 ? interval : 20.0; // Minimum interval of 20
  }

  String _formatAmount(double amount) {
    if (amount >= 100000) {
      return '${(amount / 100000).toStringAsFixed(1)}L';
    } else if (amount >= 1000) {
      return '${(amount / 1000).toStringAsFixed(1)}K';
    } else {
      return amount.toInt().toString();
    }
  }



  Widget _buildErrorState(double screenWidth, double screenHeight) {
    return Padding(
      padding: EdgeInsets.all(16),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 2,
              blurRadius: 8,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.bar_chart_outlined,
                  size: 48,
                  color: Colors.grey.shade400,
                ),
              ),
              SizedBox(height: 24),
              Text(
                'No Sales Data Available',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: AppColors.secondary,
                ),
              ),
              SizedBox(height: 8),
              Text(
                'No sales found for $selectedMonth $selectedYear.',
                style: TextStyle(
                  fontSize: 14,
                  color: AppColors.text,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 8),
              Text(
                'Try selecting a different time period.',
                style: TextStyle(
                  fontSize: 12,
                  color: AppColors.icon,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 32),
              ElevatedButton.icon(
                onPressed: _loadGraphData,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                icon: Icon(Icons.refresh, color: Colors.white, size: 20),
                label: Text(
                  'Retry',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _getMonthAbbreviation(DateTime date) {
    const months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec'
    ];
    return months[date.month - 1];
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
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec'
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


}
