import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:im/app/modules/home/controllers/home_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginController extends GetxController {
  //TODO: Implement LoginController
  RxString uid = ''.obs;
  RxString token = ''.obs;

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  void login() async {
    try {
      Map<String, dynamic> reqBody = {
        'uid': uid.value,
        'token': token.value,
        'device_flag': 0,
        'device_level': 1
      };
      print(reqBody);
      var response = await Dio().post(
        'http://127.0.0.1:1516/user/token',
        data: reqBody,
      );
      print('---$response');
      SharedPreferences pref = await SharedPreferences.getInstance();
      HomeController homeController = Get.find<HomeController>();
      homeController.isLogin.value = true;
      pref.setBool('isLogin', true);
      pref.setString('uid', uid.value);
      pref.setString('token', token.value);
      print('llooodllfl-----${pref.getBool('isLogin')}');
      Get.back();
    } catch (err) {
      print('$runtimeType----$err');
    }
  }

  @override
  void onClose() {}
}
