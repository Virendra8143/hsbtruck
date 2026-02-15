import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../Utils/Const.dart';
import '../Utils/Preference.dart';


class DashboardController extends GetxController {
  var userName = ''.obs;
  var userId = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchUserDetails();
  }

  void fetchUserDetails() async {
    String name = await Preference.getSharedPrefString('user_name') ?? '';
    String id = await Preference.getSharedPrefString(KEY_USER_ID) ?? '';

    print('DEBUG - User Name: $name');
    print('DEBUG - User ID: $id');

    userName.value = name;
    userId.value = id;
  }
}
