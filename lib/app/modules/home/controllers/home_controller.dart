import 'package:get/get.dart';
import 'package:im/app/util/web_socket_util.dart';

import 'package:shared_preferences/shared_preferences.dart';

class HomeController extends GetxController {
  final count = 0.obs;
  RxString resp = ''.obs;
  RxInt currentPage = 0.obs;
  RxString uid = ''.obs;
  RxBool isLogin = false.obs;

  @override
  void onInit() {
    super.onInit();
    getStatus();
    // RongIMClient.init('8luwapkv8611l');
    WebSocketUtil().initWebSocket(onMessage: (message) {
      print('-----socketMessage----$message');
    }, onError: (error) {
      print('-----socketError----$error');
    });

  }

  void getStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool value = prefs.getBool('isLogin') ?? false;
    isLogin.value = value;
    uid.value = prefs.getString('uid') ?? '';
  }

  @override
  void onReady() {
    super.onReady();
  }

  void connect() {}

  @override
  void onClose() {}

  void increment() => count.value++;
}
