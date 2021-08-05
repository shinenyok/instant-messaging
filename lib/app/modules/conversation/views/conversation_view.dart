import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:im/app/routes/app_pages.dart';

import '../controllers/conversation_controller.dart';

class ConversationView extends GetView<ConversationController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('会话'),
        centerTitle: true,
      ),
      body: Obx(
        () => ListView.builder(
          itemBuilder: (context, index) {
            return Container(
              height: 60,
              child: TextButton(
                onPressed: () {
                  Get.toNamed(Routes.CHAT,arguments: controller.conversations[index].recents);
                },
                child: Row(
                  children: [
                    Image.network('https://picsum.photos/250?image=9'),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Spacer(),
                          Text('rrr'),
                          Spacer(),
                          Text(
                              '${utf8.decode(base64.decode(controller.conversations[index].recents!.last.payload ?? ''))}')
                        ],
                      ),
                    )
                  ],
                ),
              ),
            );
          },
          itemCount: controller.conversations.length,
        ),
      ),
    );
  }
}
