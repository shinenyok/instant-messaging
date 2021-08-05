import 'package:get/get.dart';

import 'package:im/app/modules/chat/bindings/chat_binding.dart';
import 'package:im/app/modules/chat/views/chat_view.dart';
import 'package:im/app/modules/contact/bindings/contact_binding.dart';
import 'package:im/app/modules/contact/views/contact_view.dart';
import 'package:im/app/modules/conversation/bindings/conversation_binding.dart';
import 'package:im/app/modules/conversation/views/conversation_view.dart';
import 'package:im/app/modules/home/bindings/home_binding.dart';
import 'package:im/app/modules/home/views/home_view.dart';
import 'package:im/app/modules/login/bindings/login_binding.dart';
import 'package:im/app/modules/login/views/login_view.dart';
import 'package:im/app/modules/mine/bindings/mine_binding.dart';
import 'package:im/app/modules/mine/views/mine_view.dart';
import 'package:im/app/modules/video/bindings/video_binding.dart';
import 'package:im/app/modules/video/views/video_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.HOME;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.CONVERSATION,
      page: () => ConversationView(),
      binding: ConversationBinding(),
    ),
    GetPage(
      name: _Paths.CHAT,
      page: () => ChatView(),
      binding: ChatBinding(),
    ),
    GetPage(
      name: _Paths.MINE,
      page: () => MineView(),
      binding: MineBinding(),
    ),
    GetPage(
      name: _Paths.VIDEO,
      page: () => VideoView(),
      binding: VideoBinding(),
    ),
    GetPage(
      name: _Paths.CONTACT,
      page: () => ContactView(),
      binding: ContactBinding(),
    ),
  ];
}
