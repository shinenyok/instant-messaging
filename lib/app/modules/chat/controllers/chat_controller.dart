import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:im/app/data/conversation_model.dart';

class ChatController extends GetxController {
  RxList<Recents> recents = RxList<Recents>([]);
  TextEditingController editingController = TextEditingController();
  RxBool showMoreAction = false.obs;
  RxBool showEmoji = false.obs;
  @override
  void onInit() {
    super.onInit();
    recents.value = Get.arguments ?? [];
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
}
