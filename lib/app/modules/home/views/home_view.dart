import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:im/app/modules/contact/views/contact_view.dart';
import 'package:im/app/modules/conversation/views/conversation_view.dart';
import 'package:im/app/modules/mine/views/mine_view.dart';
import 'package:im/app/modules/video/views/video_view.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
 final PageController _pageController = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        children: [
          ConversationView(),
          ContactView(),
          VideoView(),
          MineView(),
        ],
      ),
      bottomNavigationBar: Obx(
        () => BottomNavigationBar(
          onTap: (index) {
            controller.currentPage.value = index;
            _pageController.jumpToPage(index);
          },
          type: BottomNavigationBarType.fixed,
          currentIndex: controller.currentPage.value,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.chat),
              label: '会话',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.contact_page),
              label: '通讯录',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.video_collection),
              label: '短视频',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: '我的',
            ),
          ],
        ),
      ),
    );
  }
}
