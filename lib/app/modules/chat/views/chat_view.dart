import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:im/app/data/conversation_model.dart';
import 'package:im/app/modules/home/controllers/home_controller.dart';
import '../controllers/chat_controller.dart';

class ChatView extends GetView<ChatController> {
  final HomeController homeController = Get.find<HomeController>();
  final FocusNode _focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('聊天'),
        centerTitle: true,
      ),
      body: GestureDetector(
        onTap: () {
          controller.showMoreAction.value = false;
          controller.showEmoji.value = false;
          _focusNode.unfocus();
        },
        child: Container(
          color: Colors.black26,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  reverse: true,
                  itemBuilder: (context, index) {
                    Recents recents;
                    if (index < controller.recents.length) {
                      recents = controller.recents[index];
                    } else {
                      recents = controller.recents.last;
                    }
                    // Recents recents = controller.recents[index];
                    return recents.fromUid == homeController.uid.value
                        ? chatFromMeWidget(context, recents)
                        : chatFromOtherWidget(context, recents);
                  },
                  itemCount: controller.recents.length + 23,
                ),
              ),
              _chatBar(context),
              Obx(() => controller.showEmoji.value
                  ? GestureDetector(
                      onTap: () {},
                      child: Stack(
                        children: [
                          Container(
                            padding: EdgeInsets.all(16),
                            color: Colors.white,
                            child: GridView.builder(
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 7,
                              ),
                              itemBuilder: (context, index) {
                                return TextButton(
                                  onPressed: () {
                                    print('------$index');
                                  },
                                  child: Image.asset(
                                    'assets/emoji/sg$index.png',
                                  ),
                                );
                              },
                              itemCount: 179,
                            ),
                            height: 300,
                          ),
                          Positioned(
                            right: 10,
                            bottom: MediaQuery.of(context).padding.bottom + 10,
                            child: Container(
                              width: 160,
                              height: 50,
                              color: Colors.white,
                            ),
                          ),
                          Positioned(
                              right: 10,
                              bottom:
                                  MediaQuery.of(context).padding.bottom + 10,
                              child: Row(
                                children: [
                                  MaterialButton(
                                    onPressed: () {},
                                    child: Container(
                                      width: 60,
                                      height: 38,
                                      color: Colors.white70,
                                      alignment: Alignment.center,
                                      child: Icon(
                                        Icons.delete_forever,
                                      ),
                                    ),
                                  ),
                                  TextButton(
                                    style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all(
                                      Colors.green,
                                    )),
                                    onPressed: () {},
                                    child: Text('发送'),
                                  ),
                                ],
                              ))
                        ],
                      ),
                    )
                  : SizedBox.shrink()),
              Obx(
                () => controller.showMoreAction.value
                    ? Container(
                        color: Colors.white,
                        child: GridView.builder(
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 4,
                          ),
                          itemBuilder: (context, index) {
                            String title = '';
                            switch (index) {
                              case 0:
                                title = '相册';
                                break;
                              case 1:
                                title = '拍照';
                                break;
                              case 2:
                                title = '文件';
                                break;
                              case 3:
                                title = '语音通话';
                                break;
                              case 4:
                                title = '视频通话';
                                break;
                            }
                            return TextButton(
                              onPressed: () {},
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(16.0),
                                    child: Icon(Icons.title),
                                  ),
                                  Expanded(child: Text(title)),
                                ],
                              ),
                            );
                          },
                          itemCount: 5,
                        ),
                        height: 240,
                      )
                    : SizedBox.shrink(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _chatBar(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(bottom: MediaQuery.of(context).padding.bottom),
      color: Colors.white70,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          IconButton(
            onPressed: () {
              controller.showMoreAction.value = false;
              controller.showEmoji.value = false;
              _focusNode.unfocus();
            },
            icon: Icon(Icons.audiotrack),
          ),
          Expanded(
            child: Container(
              margin: EdgeInsets.only(top: 5, bottom: 5),
              constraints: BoxConstraints(
                minHeight: 40,
              ),
              color: Colors.white,
              child: TextField(
                maxLines: 5,
                minLines: 1,
                textInputAction: TextInputAction.send,
                focusNode: _focusNode,
                onTap: () {
                  controller.showMoreAction.value = false;
                  controller.showEmoji.value = false;
                },
                onSubmitted: (value) async {
                  // SharedPreferences pref = await SharedPreferences.getInstance();
                  Map<String, dynamic> reqBody = {
                    "channel_id": "67267qw",
                    "channel_type": 2,
                    "from_uid": "li",
                    "subscribers": ["song", "li"],
                    "payload":
                        "${base64.encode(utf8.encode("哈哈哈哈哈哈肯定是快乐的时刻都是235345${DateTime.now()}"))}",
                  };
                  print(reqBody);
                  var response = await Dio().post(
                    'http://127.0.0.1:1516/message/send',
                    data: reqBody,
                  );
                  print('---$response');
                },
                decoration: InputDecoration(
                  isDense: true,
                  border: InputBorder.none,
                  prefix: SizedBox(
                    width: 6,
                  ),
                  suffix: SizedBox(
                    width: 6,
                  ),
                ),
              ),
            ),
          ),
          IconButton(
            onPressed: () {
              _focusNode.unfocus();
              controller.showMoreAction.value = false;
              controller.showEmoji.value = !controller.showEmoji.value;
            },
            icon: Icon(Icons.emoji_emotions),
          ),
          IconButton(
            onPressed: () {
              _focusNode.unfocus();
              controller.showEmoji.value = false;
              controller.showMoreAction.value =
                  !controller.showMoreAction.value;
            },
            icon: Icon(Icons.add_circle),
          ),
        ],
      ),
    );
  }

  Widget chatFromMeWidget(BuildContext context, Recents recents) {
    return ConstrainedBox(
      constraints: BoxConstraints(minHeight: 60),
      child: Container(
        padding: EdgeInsets.all(16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              height: 40,
              padding: EdgeInsets.symmetric(horizontal: 16),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                color: Colors.lightBlueAccent,
              ),
              child: Text(
                utf8.decode(
                  base64.decode(recents.payload ?? ''),
                ),
              ),
            ),
            CustomPaint(
              painter: TriangleCustomPainter(
                context,
                [
                  Coordinate(cx: 10, cy: 0),
                  Coordinate(cx: -2, cy: -6),
                  Coordinate(cx: -2, cy: 6)
                ],
                Colors.lightBlueAccent,
              ),
            ),
            SizedBox(
              width: 20,
            ),
            Image.network(
              'https://picsum.photos/250?image=9',
              height: 40,
              width: 40,
            ),
          ],
        ),
      ),
    );
  }

  Widget chatFromOtherWidget(BuildContext context, Recents recents) {
    return ConstrainedBox(
      constraints: BoxConstraints(minHeight: 60),
      child: Container(
        padding: EdgeInsets.all(16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Image.network(
              'https://picsum.photos/250?image=9',
              height: 40,
              width: 40,
            ),
            CustomPaint(
              painter: TriangleCustomPainter(
                context,
                [
                  Coordinate(cx: 10, cy: 0),
                  Coordinate(cx: 22, cy: -6),
                  Coordinate(cx: 22, cy: 6)
                ],
                Colors.white,
              ),
            ),
            SizedBox(
              width: 20,
            ),
            Container(
              height: 40,
              padding: EdgeInsets.symmetric(horizontal: 16),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                color: Colors.white,
              ),
              child: Text(
                utf8.decode(
                  base64.decode(recents.payload ?? ''),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Coordinate {
  final double cx;
  final double cy;

  Coordinate({required this.cx, required this.cy});
}

class TriangleCustomPainter extends CustomPainter {
  Paint _paint = new Paint(); //画笔富含各种属性方法。仔细查看源码
  final BuildContext context;
  final List spots;
  final Color color;

  TriangleCustomPainter(this.context, this.spots, this.color);

  @override
  void paint(Canvas canvas, Size size) {
    Path path = new Path()..moveTo(spots[0].cx, spots[0].cy);
    path.lineTo(spots[1].cx, spots[1].cy);
    path.lineTo(spots[2].cx, spots[2].cy);
    canvas.drawPath(
        path,
        _paint
          ..style = PaintingStyle.fill
          ..color = color);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
