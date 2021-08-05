import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:im/app/modules/home/controllers/home_controller.dart';
import 'package:im/app/routes/app_pages.dart';

import '../controllers/mine_controller.dart';

class MineView extends GetView<MineController> {
  final HomeController homeController = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('我的'),
        centerTitle: true,
      ),
      body: Center(
        child: Obx(
          () => homeController.isLogin.value
              ? Text('已登陆')
              : TextButton(
                  onPressed: () {
                    Get.toNamed(Routes.LOGIN);
                  },
                  child: Text('login'),
                ),
        ),
      ),
    );
  }
}
