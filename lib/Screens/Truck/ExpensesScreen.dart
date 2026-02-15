import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../Utils/colors.dart';
import '../../Widgets/NotificationsScreen.dart';
import '../../Widgets/appbar/main_app_bar.dart';
import '../../controllers/Truck/AddExpenseController.dart';
import '../../controllers/Truck/ExpensesListcontroller.dart';
import '../../controllers/Truck/ExpensestypeController.dart';
import '../../models/Truck/ExpenseListModel.dart';
import 'AddExpenseScreen.dart';

class ExpenseDetailsScreen extends StatelessWidget {
  ExpenseDetailsScreen({super.key});

  final ExpenseListController expenseListController =
  Get.put(ExpenseListController());

  final ExpenseTypeController expenseTypeController =
  Get.put(ExpenseTypeController());

  final AddExpenseController addExpenseController =
  Get.put(AddExpenseController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                MaterialPageRoute(
                  builder: (context) => NotificationsScreen(),
                ),
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 10),

            // Heading
            const Text(
              "Expense Details",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.red,
              ),
            ),

            const SizedBox(height: 12),

            // Banner Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14),
              child: Obx(() {
                final list = expenseListController.expenseList;

                double totalAmount = 0;
                for (var e in list) {
                  totalAmount += double.tryParse(e.amount) ?? 0;
                }

                return Row(
                  children: [
                    // Truck icon placeholder
                    Container(
                      height: 110,
                      width: 120,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(18),
                        color: Colors.white,
                      ),
                      child: SvgPicture.asset('assets/images/Tanker.svg', fit: BoxFit.fill),
                    ),

                    const SizedBox(width: 12),

                    // Expense box
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(14),
                          color: const Color(0xff0B1A7A),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  "Total Amount",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  "₹${totalAmount.toStringAsFixed(0)}",
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            const Divider(color: Colors.white24),
                            const SizedBox(height: 4),
                            _ExpenseLine("Total Expenses", "${list.length}"),
                          ],
                        ),
                      ),
                    )
                  ],
                );
              }),
            ),

            const SizedBox(height: 14),

            // Filter Chips
            SizedBox(
              height: 44,
              child: Obx(() {
                final selected = expenseListController.selectedType.value;

                return ListView(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  children: [
                    _chip("All", selected == "0", () {
                      expenseListController.changeType("0");
                    }),
                    _chip("Toll", selected == "1", () {
                      expenseListController.changeType("1");
                    }),
                    _chip("Repair", selected == "2", () {
                      expenseListController.changeType("2");
                    }),
                    _chip("Misc", selected == "3", () {
                      expenseListController.changeType("3");
                    }),
                  ],
                );
              }),
            ),

            const SizedBox(height: 14),

            // Search Box
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14),
              child: TextField(
                onChanged: (val) {
                  expenseListController.searchText.value = val;
                },
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.search, color: Colors.red),
                  hintText: "Search Expenses",
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding: const EdgeInsets.symmetric(vertical: 16),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                    borderSide: const BorderSide(color: Colors.red),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                    borderSide: const BorderSide(color: Colors.red, width: 1.2),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 16),

            // List
            Obx(() {
              if (expenseListController.isLoading.value) {
                return const Padding(
                  padding: EdgeInsets.only(top: 50),
                  child: Center(child: CircularProgressIndicator()),
                );
              }

              final filtered = _filteredList(
                expenseListController.expenseList,
                expenseListController.searchText.value,
              );

              if (filtered.isEmpty) {
                return const Padding(
                  padding: EdgeInsets.only(top: 50),
                  child: Center(
                    child: Text(
                      "No Expenses Found",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.red,
                      ),
                    ),
                  ),
                );
              }

              return ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                padding: const EdgeInsets.symmetric(horizontal: 14),
                itemCount: filtered.length,
                itemBuilder: (context, index) {
                  final ExpenseListModel item = filtered[index];

                  final type = item.expenseType.isEmpty
                      ? "Unknown"
                      : item.expenseType;

                  return Container(
                    margin: const EdgeInsets.only(bottom: 12),
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(14),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 10,
                        )
                      ],
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                type,
                                style: const TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.red,
                                ),
                              ),
                              const SizedBox(height: 6),
                              Text(
                                "₹${item.amount}",
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xff0B1A7A),
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                "${item.place} • ${item.createdDate}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey.shade600,
                                ),
                              ),
                            ],
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            _showExpenseDetails(item);
                          },
                          icon: const Icon(Icons.remove_red_eye_outlined,
                              color: Color(0xff0B1A7A)),
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.more_horiz,
                              color: Color(0xff0B1A7A)),
                        ),
                      ],
                    ),
                  );
                },
              );
            }),

            const SizedBox(height: 80),
          ],
        ),
      ),

      // ✅ Blue + Button
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xff0B1A7A),
        onPressed: () async {
          // controllers already in memory, so Get.find works inside sheet
          await Get.bottomSheet(
            AddExpenseBottomSheet(),
            isScrollControlled: true,
          );

          // refresh list after adding expense
          expenseListController.getExpenseList(
            type: expenseListController.selectedType.value,
          );
        },
        child: SvgPicture.asset('assets/images/Addicon.svg', fit: BoxFit.fill),
      ),
    );
  }

  // Local search filter
  List<ExpenseListModel> _filteredList(
      List<ExpenseListModel> list, String search) {
    if (search.trim().isEmpty) return list;

    final s = search.toLowerCase();

    return list.where((e) {
      return e.expenseType.toLowerCase().contains(s) ||
          e.place.toLowerCase().contains(s) ||
          e.amount.toLowerCase().contains(s) ||
          e.status.toLowerCase().contains(s) ||
          e.createdDate.toLowerCase().contains(s);
    }).toList();
  }

  static Widget _chip(String text, bool selected, VoidCallback onTap) {
    return Container(
      margin: const EdgeInsets.only(right: 10),
      child: ChoiceChip(
        selected: selected,
        label: Text(text),
        labelStyle: TextStyle(
          color: AppColors.whitebg,
          fontWeight: FontWeight.bold,
        ),
        selectedColor: Colors.red,
        backgroundColor: const Color(0xff0B1A7A),
        onSelected: (v) => onTap(),
      ),
    );
  }

  void _showExpenseDetails(ExpenseListModel item) {
    Get.defaultDialog(
      title: "Expense Details",
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Type: ${item.expenseType.isEmpty ? "Unknown" : item.expenseType}"),
          Text("Amount: ₹${item.amount}"),
          Text("Place: ${item.place}"),
          Text("Remark: ${item.remark}"),
          Text("Status: ${item.status}"),
          Text("Date: ${item.createdDate}"),
        ],
      ),
    );
  }
}

class _ExpenseLine extends StatelessWidget {
  final String title;
  final String amount;

  const _ExpenseLine(this.title, this.amount);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: const TextStyle(color: Colors.white70)),
          Text(
            amount,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
