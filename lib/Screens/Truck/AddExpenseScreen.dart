import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/Truck/AddExpenseController.dart';
import '../../controllers/Truck/ExpensestypeController.dart';

class AddExpenseBottomSheet extends StatelessWidget {
  AddExpenseBottomSheet({super.key});

  final ExpenseTypeController expenseTypeController = Get.find();
  final AddExpenseController addExpenseController = Get.find();


  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      height: MediaQuery.of(context).size.height * 0.72,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(26),
        ),
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                height: 5,
                width: 55,
                decoration: BoxDecoration(
                  color: Colors.black12,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            const SizedBox(height: 14),

            Row(
              children: [
                Container(
                  height: 45,
                  width: 45,
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: const Icon(Icons.wallet, color: Colors.white),
                ),
                const SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      "Add Expenses Records",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(0xff0B1A7A),
                      ),
                    ),
                    SizedBox(height: 2),
                    Text(
                      "Add Every expense records",
                      style: TextStyle(color: Colors.black45),
                    ),
                  ],
                )
              ],
            ),

            const SizedBox(height: 18),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text("Driver Name",
                    style:
                    TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                Text("Vehicle Number",
                    style:
                    TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
              ],
            ),

            const SizedBox(height: 14),

            // ✅ Expense Type Dropdown (API)
            Obx(() {
              if (expenseTypeController.isLoading.value) {
                return Container(
                  height: 55,
                  alignment: Alignment.center,
                  child: const CircularProgressIndicator(),
                );
              }

              return DropdownButtonFormField<String>(
                value: expenseTypeController.selectedExpenseTypeId.value.isEmpty
                    ? null
                    : expenseTypeController.selectedExpenseTypeId.value,
                items: expenseTypeController.expenseTypeList.map((e) {
                  return DropdownMenuItem(
                    value: e.id,
                    child: Text(e.title),
                  );
                }).toList(),
                onChanged: (val) {
                  final selected = expenseTypeController.expenseTypeList
                      .firstWhere((e) => e.id == val);

                  expenseTypeController.selectedExpenseTypeId.value =
                      selected.id;
                  expenseTypeController.selectedExpenseTypeTitle.value =
                      selected.title;
                },
                decoration: _inputDecoration("Choose a Expense Type"),
                icon: const Icon(Icons.keyboard_arrow_down_rounded),
              );
            }),

            const SizedBox(height: 14),

            // ✅ Place
            TextField(
              controller: addExpenseController.placeController,
              decoration: _inputDecoration("Place"),
            ),

            const SizedBox(height: 14),

            // ✅ Amount
            TextField(
              controller: addExpenseController.amountController,
              keyboardType: TextInputType.number,
              decoration: _inputDecoration("Amount"),
            ),

            const SizedBox(height: 14),

            // ✅ Remark
            TextField(
              controller: addExpenseController.remarkController,
              maxLines: 3,
              decoration: _inputDecoration("Remark"),
            ),

            const SizedBox(height: 6),
            const Text(
              "Add why you spend money",
              style: TextStyle(color: Colors.black38, fontSize: 12),
            ),

            const SizedBox(height: 16),

            // ✅ Submit Button
            SizedBox(
              width: double.infinity,
              height: 52,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                onPressed: () async {
                  bool ok = await addExpenseController.addExpense(
                    expenseTypeController: expenseTypeController,
                  );

                  if (ok) {
                    Get.back();
                  }
                },
                child: Obx(() {
                  if (addExpenseController.isSubmitting.value) {
                    return const SizedBox(
                      height: 22,
                      width: 22,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: Colors.white,
                      ),
                    );
                  }

                  return const Text(
                    "Send Request to admin",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  );
                }),
              ),
            )
          ],
        ),
      ),
    );
  }

  InputDecoration _inputDecoration(String hint) {
    return InputDecoration(
      hintText: hint,
      filled: true,
      fillColor: Colors.white,
      contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 16),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(color: Colors.red),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(color: Colors.red, width: 1.2),
      ),
    );
  }
}
