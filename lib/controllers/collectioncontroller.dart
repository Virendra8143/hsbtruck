import 'dart:convert';

import 'package:get/get.dart';

import '../Data/AppDialoge.dart';
import '../Utils/Api.dart';
import '../models/collection.dart';

class TodayCollectionController extends GetxController {
  var isLoading = false.obs;
  var todayCollection = TodayCollectionModel().obs;

  void getTodayCollection() async {
    isLoading.value = true;

    try {
      final response = await API.instance.get(
        endPoint: "get-collection",
        params: {},
        isHeader: true,
      );


      var data = jsonDecode(response.body);
      var status = data['status'];
      var message = data['message'];



      if (status == "success") {
        TodayCollectionResponse collectionResponse = TodayCollectionResponse.fromJson(data);



        if (collectionResponse.data != null && collectionResponse.data!.isNotEmpty) {
          todayCollection.value = collectionResponse.data!.first;

        } else {

          // Set default values
          todayCollection.value = TodayCollectionModel(
            todayCollection: '0.00',
            yesterdayCollection: '0.00',
          );
        }
      } else {
        Appdialogs.showToast(message);

      }
    } catch (e) {

    } finally {
      isLoading.value = false;
    }
  }
}