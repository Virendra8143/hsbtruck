import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'SplashScreen.dart';
import 'Utils/Preference.dart';
import 'controllers/AdminController/EditMachineController.dart';
import 'controllers/AdminController/EditProductController.dart';


void main() async {

  WidgetsFlutterBinding.ensureInitialized();
  await Preference.init();
  Get.put(EditProductController());
  Get.put(EditMachineController());
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData(useMaterial3: false),
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}
