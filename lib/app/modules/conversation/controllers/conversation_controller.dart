import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:im/app/data/conversation_model.dart';
import 'package:im/app/modules/home/controllers/home_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ConversationController extends GetxController {
  //TODO: Implement ConversationController
  RxList<conversationMode> conversations = RxList<conversationMode>([]);
  final HomeController homeController = Get.find<HomeController>();

  @override
  void onInit() {
    super.onInit();
    getConversations();
  }

  getConversations() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Map<String,dynamic> params = {
      "uid": prefs.getString('uid'),
      "version": 0,
      //客户端所有会话的最后一条消息序列号 格式： channelID:channelType:last_msg_seq|channelID:channelType:last_msg_seq 比如 c1234:1:2|c3245:1:10
      // "last_msg_seqs": "string",
      "msg_count": 20
    };
    try {
      conversations.clear();
      var response = await Dio().post<List>(
        'http://192.168.121.15:1516/conversation/sync',
        data: params,
      );
      response.data!.forEach((element) {
        conversations.add(conversationMode.fromJson(element));
      });
      print('1111$params----${response.data}');
    } catch (error) {
      print('0000--$params--$error----');

    }
  }

  @override
  void onReady() {
    super.onReady();
    print('ready');
  }

  @override
  void onClose() {}
}
