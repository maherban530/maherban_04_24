import 'dart:convert';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:maherban_04_22/Models/task_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Services/task_service.dart';

class TaskController extends GetxController {
  var isLoading = false.obs;
  Rx<TaskModel> taskModel = TaskModel().obs;
  RxInt selectScroll = 0.obs;
  int count = 3;

  var taskModelLo = [].obs;

  var sizeFieldController = TextEditingController();

  @override
  Future<void> onInit() async {
    super.onInit();
    Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      if (result == ConnectivityResult.none) {
        Get.snackbar("Network", "Network Connection LOST",
            snackPosition: SnackPosition.BOTTOM);
      }
    });

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var localStore = json.decode(prefs.get('task').toString());

    if (localStore != null) {
      taskModelLo.value = localStore;
    }
  }

  fetchImageData({required int size}) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    isLoading(true);

    await TaskService().fetchData(size: size).then((value) async {
      taskModel.value = value!;
      taskModelLo.clear();
      for (var i = 0; i < taskModel.value.data!.length; i += count) {
        taskModelLo.add(taskModel.value.data!.sublist(
            i,
            i + count > taskModel.value.data!.length
                ? taskModel.value.data!.length
                : i + count));
      }

      prefs.setString("task", json.encode(taskModelLo));

      sizeFieldController.clear();
    });

    isLoading(false);
  }
}
