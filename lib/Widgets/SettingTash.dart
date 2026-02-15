import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../utils/colors.dart';
import 'Restoration Warning.dart';
import 'package:get/get.dart';
import '../controllers/AdminController/TrashController.dart';

class SettingTash extends StatefulWidget {
  const SettingTash({super.key});

  @override
  State<SettingTash> createState() => _SettingTashState();
}

class _SettingTashState extends State<SettingTash> {
  final TrashController trashController = Get.put(TrashController());
  @override
  void initState() {
    super.initState();
    trashController.getTrashList();
  }
  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: mediaQuery.height * 0.02),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: mediaQuery.width * 0.05),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: SvgPicture.asset(
                      'assets/images/backwithlogo.svg',
                      width: mediaQuery.width * 0.25,
                      height: mediaQuery.height * 0.06,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Image.asset(
                      'assets/images/Settingback.png',
                      width: mediaQuery.width * 0.08,
                      height: mediaQuery.height * 0.06,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: mediaQuery.height * 0.05),
            Padding(
              padding: EdgeInsets.only(left: mediaQuery.width * 0.05),
              child: Row(
                children: [
                  Text(
                    'Settings / Trash',
                    style: TextStyle(
                      fontSize: mediaQuery.width * 0.04,
                      fontWeight: FontWeight.w700,
                      color: AppColors.primary,
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: mediaQuery.width * 0.04, vertical: mediaQuery.height * 0.01),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'All Items (4)',
                    style: TextStyle(
                      fontSize: mediaQuery.width * 0.05,
                      fontWeight: FontWeight.w700,
                      color: AppColors.secondary,
                    ),
                  ),
                  Text(
                    'Restore all',
                    style: TextStyle(
                      fontSize: mediaQuery.width * 0.04,
                      fontWeight: FontWeight.w700,
                      color: AppColors.primary,
                    ),
                  )
                ],
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: mediaQuery.width * 0.04),
                child: Obx(() {
                  final items = trashController.trashItems;
                  if (trashController.isLoading.value) {
                    return Center(child: CircularProgressIndicator());
                  }
                  if (items.isEmpty) {
                    return Center(child: Text('No trashed items'));
                  }
                  return ListView.builder(
                    itemCount: items.length,
                    itemBuilder: (context, index) {
                      final item = items[index] as Map<String, dynamic>;
                      final title = (item['title'] ?? item['name'] ?? 'Trashed Item').toString();
                      final subtitle = (item['subtitle'] ?? item['code'] ?? '').toString();
                      final id = (item['id'] ?? '').toString();
                      final type = (item['trash_type'] ?? item['type'] ?? '').toString();
                      return Card(
                        color: AppColors.tash,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(mediaQuery.width * 0.03),
                        ),
                        margin: EdgeInsets.symmetric(vertical: mediaQuery.height * 0.01),
                        child: ListTile(
                          title: Text(
                            title,
                            style: TextStyle(
                              color: AppColors.primary,
                              fontWeight: FontWeight.w700,
                              fontSize: mediaQuery.width * 0.04,
                            ),
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              if (subtitle.isNotEmpty)
                                Text(
                                  subtitle,
                                  style: TextStyle(
                                    color: AppColors.secondary,
                                    fontWeight: FontWeight.w700,
                                    fontSize: mediaQuery.width * 0.05,
                                  ),
                                ),
                            ],
                          ),
                          trailing: IconButton(
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return RestorationWarning();
                                },
                              ).then((_) async {
                                if (id.isNotEmpty && type.isNotEmpty) {
                                  await trashController.restoreItem(id: id, trashType: type);
                                }
                              });
                            },
                            icon: SvgPicture.asset(
                              'assets/images/Restore.svg',
                              width: mediaQuery.width * 0.06,
                              height: mediaQuery.height * 0.03,
                            ),
                          ),
                        ),
                      );
                    },
                  );
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
