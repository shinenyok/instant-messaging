import 'package:get/get.dart';
import 'package:im/app/modules/conversation/controllers/conversation_controller.dart';
import 'package:im/app/modules/video/controllers/video_controller.dart';

import '../controllers/home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(
      () => HomeController(),
    );
    Get.lazyPut<ConversationController>(
            () => ConversationController());
    // Get.lazyPut<VideoController>(
    //         () => VideoController());
  }
}
