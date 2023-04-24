import 'dart:async';

import 'package:get/get.dart';

class SecondController extends GetxController {
  RxBool toggler = true.obs;
  RxString initText = "A".obs;
  RxString prevtext = "".obs;

  @override
  Future<void> onInit() async {
    Timer.periodic(const Duration(seconds: 2), (Timer t) {
      toggler.value = !toggler.value;
      if (initText.value == "A") {
        prevtext.value = "A";
        initText.value = "B";
      } else if (initText.value == "B") {
        if (prevtext.value == "A") {
          initText.value = "C";
        } else {
          initText.value = "A";
        }
      } else if (initText.value == "C") {
        prevtext.value = "C";
        initText.value = "B";
      }
    });

    super.onInit();
  }
}
