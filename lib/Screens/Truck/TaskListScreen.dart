import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Utils/colors.dart';
import '../../Widgets/NotificationsScreen.dart';
import '../../Widgets/appbar/main_app_bar.dart';
import '../../controllers/Truck/TaskController.dart';

class TaskListScreen extends StatefulWidget {
  const TaskListScreen({super.key});

  @override
  State<TaskListScreen> createState() => _TaskListScreenState();
}

class _TaskListScreenState extends State<TaskListScreen> {
  final TaskListController controller = Get.put(TaskListController());
  final TextEditingController searchController = TextEditingController();

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(


            children: [
              const SizedBox(height: 40),
              MainAppBar(
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
                        MaterialPageRoute(builder: (context) => NotificationsScreen()),
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
              const Text(
                "Task List",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.red,
                ),
              ),
              const SizedBox(height: 12),
        
              // Search Box
              Container(
                height: 52,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.red, width: 1),
                  color: Colors.white,
                ),
                child: TextField(
                  controller: searchController,
                  onChanged: controller.onSearchChanged,
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.search, color: Colors.red),
                    hintText: "Search Tasks",
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(vertical: 14),
                  ),
                ),
              ),
        
              const SizedBox(height: 12),
        
              // Expanded List
              Expanded(
                child: Obx(() {
                  if (controller.isLoading.value) {
                    return const Center(child: CircularProgressIndicator());
                  }
        
                  if (controller.taskList.isEmpty) {
                    return const Center(
                      child: Text(
                        "No Tasks Found",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    );
                  }
        
                  return ListView.builder(
                    itemCount: controller.taskList.length,
                    itemBuilder: (context, index) {
                      final task = controller.taskList[index];
                      return Container(
                        margin: const EdgeInsets.only(bottom: 14),
                        padding: const EdgeInsets.all(14),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(14),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.15),
                              blurRadius: 10,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    task.taskDate ?? "",
                                    style: const TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.red,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    task.title ?? "",
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w800,
                                      color: Colors.black,
                                    ),
                                  ),
                                  const SizedBox(height: 2),
                                  Text(
                                    task.description ?? "",
                                    style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.grey.shade600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Row(
                              children: [
                                InkWell(
                                  onTap: () {},
                                  child: const Icon(
                                    Icons.reply,
                                    color: Colors.black,
                                    size: 24,
                                  ),
                                ),
                                const SizedBox(width: 16),
                                InkWell(
                                  onTap: () {},
                                  child: const Icon(
                                    Icons.check_circle,
                                    color: Colors.green,
                                    size: 26,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    },
                  );
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }

}
