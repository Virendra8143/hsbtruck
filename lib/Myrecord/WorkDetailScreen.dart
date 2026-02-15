// screens/WorkDetailsScreen.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../Utils/colors.dart';
import 'WorkDetailsController.dart';
import 'WorkRecordModel.dart';



class WorkDetailsScreen extends StatefulWidget {
  final String? employeeId;
  final String? employeeName;
  final String? date;

  const WorkDetailsScreen({
    Key? key,
    this.employeeId,
    this.employeeName,
    this.date,
  }) : super(key: key);

  @override
  State<WorkDetailsScreen> createState() => _WorkDetailsScreenState();
}

class _WorkDetailsScreenState extends State<WorkDetailsScreen> {
  final WorkRecordController workRecordController = Get.put(WorkRecordController());

  @override
  void initState() {
    super.initState();
    debugPrint('WorkDetailsScreen init with employeeId: ${widget.employeeId}, date: ${widget.date}');

    // Load work details when screen initializes
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadWorkDetails();
    });
  }

  void _loadWorkDetails() {
    if (widget.employeeId != null && widget.employeeId!.isNotEmpty) {
      workRecordController.setSelectedEmployee(
        widget.employeeId!,
        widget.employeeName ?? 'Employee',
        date: widget.date,
      );
      workRecordController.getEmployeeWorkDetails(
        widget.employeeId!,
        date: widget.date,
      );
    } else {
      debugPrint('❌ No employee ID provided');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: AppColors.primary),
          onPressed: () => Navigator.pop(context),
        ),
        title: Row(
          children: [
            Image.asset(
              'assets/images/HSB.png',
              height: 30,
            ),
            const SizedBox(width: 10),
            Text(
              'Work Details',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: AppColors.primary,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh, color: AppColors.primary),
            onPressed: () {
              if (widget.employeeId != null) {
                workRecordController.getEmployeeWorkDetails(
                  widget.employeeId!,
                  date: widget.date,
                );
              }
            },
          ),
        ],
      ),
      body: Obx(() {
        if (workRecordController.isLoading.value) {
          return _buildLoadingIndicator();
        }

        if (workRecordController.errorMessage.value.isNotEmpty) {
          return _buildErrorState();
        }

        if (!workRecordController.hasData.value) {
          return _buildNoDataState();
        }

        return _buildContent();
      }),
    );
  }

  Widget _buildContent() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Employee Info Card
          _buildEmployeeInfoCard(),

          const SizedBox(height: 16),

          // Date Info Card
          _buildDateInfoCard(),

          const SizedBox(height: 16),

          // Work Summary
          _buildWorkSummary(),

          const SizedBox(height: 16),

          // Work Records
          _buildWorkRecords(),
        ],
      ),
    );
  }

  Widget _buildEmployeeInfoCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.secondary,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            workRecordController.selectedEmployeeName ?? widget.employeeName ?? 'Employee',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Employee ID: ${widget.employeeId ?? 'N/A'}',
            style: TextStyle(
              color: Colors.white.withOpacity(0.8),
              fontSize: 14,
            ),
          ),
          if (widget.date != null) ...[
            const SizedBox(height: 4),
            Text(
              'Date: ${workRecordController.formatDate(widget.date)}',
              style: TextStyle(
                color: Colors.white.withOpacity(0.8),
                fontSize: 14,
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildDateInfoCard() {
    final data = workRecordController.workRecordData;
    if (data == null) return const SizedBox();

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.primary.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.primary.withOpacity(0.2)),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Date',
                    style: TextStyle(
                      color: AppColors.secondary,
                      fontSize: 12,
                    ),
                  ),
                  Text(
                    workRecordController.formatDate(data.date),
                    style: TextStyle(
                      color: AppColors.primary,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    'Opening Reading',
                    style: TextStyle(
                      color: AppColors.secondary,
                      fontSize: 12,
                    ),
                  ),
                  Text(
                    workRecordController.openingReadingString,
                    style: TextStyle(
                      color: AppColors.primary,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    'Closing Reading',
                    style: TextStyle(
                      color: AppColors.secondary,
                      fontSize: 12,
                    ),
                  ),
                  Text(
                    workRecordController.closingReadingString,
                    style: TextStyle(
                      color: AppColors.primary,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 12),
          Container(
            height: 1,
            color: AppColors.primary.withOpacity(0.1),
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.info_outline, color: AppColors.primary, size: 16),
              const SizedBox(width: 8),
              Text(
                'Total Products Sold: ${workRecordController.workRecords.length}',
                style: TextStyle(
                  color: AppColors.primary,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildWorkSummary() {
    final totalQty = workRecordController.getTotalQuantity();
    final totalAmount = workRecordController.getTotalAmount();

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.blue.shade50,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.blue.shade100),
      ),
      child: Column(
        children: [
          Text(
            'Daily Sales Summary',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.blue.shade800,
            ),
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildSummaryItem('Total Products', '${workRecordController.workRecords.length}', Icons.inventory_2),
              _buildSummaryItem('Total Quantity', '${totalQty.toStringAsFixed(2)} Ltr', Icons.water_drop),
              _buildSummaryItem('Total Amount', '₹${totalAmount.toStringAsFixed(2)}', Icons.currency_rupee),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryItem(String label, String value, IconData icon) {
    return Column(
      children: [
        Icon(icon, color: Colors.blue.shade700, size: 24),
        const SizedBox(height: 8),
        Text(
          value,
          style: TextStyle(
            color: Colors.blue.shade900,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            color: AppColors.secondary,
            fontSize: 12,
          ),
        ),
      ],
    );
  }

  Widget _buildWorkRecords() {
    final workRecords = workRecordController.workRecords;

    if (workRecords.isEmpty) {
      return Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.grey.shade50,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.grey.shade200),
        ),
        child: Column(
          children: [
            Icon(
              Icons.inventory_2_outlined,
              size: 60,
              color: Colors.grey.shade400,
            ),
            const SizedBox(height: 16),
            Text(
              'No sales records for this date',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.grey.shade600,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'There were no product sales recorded on this date.',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.grey.shade500,
              ),
            ),
          ],
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Product Sales Details',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: AppColors.primary,
          ),
        ),
        const SizedBox(height: 12),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: workRecords.length,
          itemBuilder: (context, index) {
            final record = workRecords[index];
            return _buildProductCard(record, index);
          },
        ),
      ],
    );
  }

  Widget _buildProductCard(WorkRecord record, int index) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    '${index + 1}. ${record.productName ?? 'Unknown Product'}',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primary,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: AppColors.secondary,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    record.productCode ?? 'N/A',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: _buildDetailItem(
                    'Product ID',
                    record.productId ?? 'N/A',
                    Icons.tag,
                  ),
                ),
                Expanded(
                  child: _buildDetailItem(
                    'Unit',
                    record.unitOfMeasure ?? 'N/A',
                    Icons.scale,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: _buildDetailItem(
                    'Quantity Sold',
                    '${record.totalQty ?? '0'} Ltr',
                    Icons.water_drop,
                    isHighlighted: true,
                    highlightColor: Colors.blue,
                  ),
                ),
                Expanded(
                  child: _buildDetailItem(
                    'Total Amount',
                    '₹${record.totalAmount ?? '0'}',
                    Icons.currency_rupee,
                    isHighlighted: true,
                    highlightColor: Colors.green,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailItem(String label, String value, IconData icon, {
    bool isHighlighted = false,
    Color? highlightColor,
  }) {
    return Row(
      children: [
        Icon(icon, size: 16, color: isHighlighted ? (highlightColor ?? AppColors.primary) : AppColors.secondary),
        const SizedBox(width: 8),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(
                  color: AppColors.secondary,
                  fontSize: 12,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                value,
                style: TextStyle(
                  color: isHighlighted ? (highlightColor ?? AppColors.primary) : AppColors.primary,
                  fontSize: 14,
                  fontWeight: isHighlighted ? FontWeight.bold : FontWeight.normal,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildLoadingIndicator() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(
            color: AppColors.primary,
          ),
          const SizedBox(height: 16),
          Text(
            'Loading work details...',
            style: TextStyle(
              color: AppColors.secondary,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 8),
          if (widget.date != null)
            Text(
              'Date: ${workRecordController.formatDate(widget.date)}',
              style: TextStyle(
                color: AppColors.secondary,
                fontSize: 14,
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildErrorState() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline,
              size: 60,
              color: Colors.red.shade400,
            ),
            const SizedBox(height: 16),
            Text(
              'Error Loading Data',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.red.shade700,
              ),
            ),
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                workRecordController.errorMessage.value,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.red.shade600,
                ),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _loadWorkDetails,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              ),
              child: const Text(
                'Try Again',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNoDataState() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.inventory_2_outlined,
              size: 60,
              color: Colors.grey.shade400,
            ),
            const SizedBox(height: 16),
            Text(
              'No Work Data Available',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.grey.shade600,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              widget.date != null
                  ? 'No work records found for ${workRecordController.formatDate(widget.date)}'
                  : 'No work records available',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.grey.shade500,
              ),
            ),
            const SizedBox(height: 20),
            if (widget.employeeId != null)
              ElevatedButton(
                onPressed: _loadWorkDetails,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                ),
                child: const Text(
                  'Refresh',
                  style: TextStyle(color: Colors.white),
                ),
              ),
          ],
        ),
      ),
    );
  }
}